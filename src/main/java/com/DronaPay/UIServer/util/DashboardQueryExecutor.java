package com.DronaPay.UIServer.util;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.Enum.DatabaseType;
import com.DronaPay.UIServer.exception.ForbiddenException;
import com.DronaPay.UIServer.model.DashboardQuery;
import com.DronaPay.UIServer.model.DashboardQueryParameters;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.requests.DashboardQueryRequest;
import com.DronaPay.UIServer.response.ResultSetResponse;
import com.DronaPay.UIServer.service.ControllerService.Dashboards.DataAnalyzerControllerService;
import com.DronaPay.UIServer.service.DashboardStatusService;
import com.DronaPay.UIServer.service.RepositoryService.ActivityLogService;
import com.DronaPay.UIServer.service.RepositoryService.DashboardQueryParmeterService;
import com.DronaPay.UIServer.service.RepositoryService.DashboardQueryService;
import com.DronaPay.UIServer.service.RepositoryService.TransactionClassesUiService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAccessor;
import java.util.*;
import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicReference;
import java.util.function.Function;
import java.util.stream.Collectors;


import java.time.Duration;

@Service
@Slf4j
public class DashboardQueryExecutor {

    @Value("${execution.cache.timeout}")
    Integer exececution_ttl;

    @Autowired
    private DashboardStatusService dashboardStatusService;

    @Autowired
    private DashboardErrorUtil dashboardErrorUtil;

    private final Map<Long, SseEmitter> clients = new ConcurrentHashMap<>();


    @Autowired
    ThreadPoolTaskScheduler taskScheduler;

    @Async
    public void getResultSetDataServiceAsync(DashboardQueryRequest dashboardQueryRequest,
                                             DashboardQueryService dashboardQueryService,
                                             DashboardQueryParmeterService dashboardQueryParmeterService,
                                             LoggerEncoderUtil loggerEncoderUtil,
                                             ActivityLogService activityLogService,
                                             Map<DatabaseType, JdbcTemplate> jdbcTemplateMap,
                                             TransactionClassesUiService transactionClassesUiService
    ) {

        DashboardDataService temp = new DashboardDataService(dashboardQueryService, dashboardQueryParmeterService,
                loggerEncoderUtil,
                activityLogService, jdbcTemplateMap, transactionClassesUiService, dashboardErrorUtil);

        ResultSetResponse resultSetResponse = new ResultSetResponse(null, null, null, null, "IN_PROGRESS", dashboardQueryRequest.getExecutionID(), dashboardQueryRequest.getIuserid(), dashboardQueryRequest.getIorgid());
        updateExecutionStatus(dashboardQueryRequest.getExecutionID(), resultSetResponse);
        ResponseEntity<?> result = temp.getResultSetDataService(dashboardQueryRequest);

        if (result.getBody() instanceof ResultSetResponse) {
            resultSetResponse = (ResultSetResponse) result.getBody();
        }

        taskScheduler.schedule(() -> {
                    dashboardStatusService.clearStatus(dashboardQueryRequest.getExecutionID());
                    SseEmitter emitter = clients.get(dashboardQueryRequest.getExecutionID());
                    if (emitter != null) emitter.complete();
                }, Instant.now().plusSeconds(exececution_ttl)
        );

        updateExecutionStatus(dashboardQueryRequest.getExecutionID(), resultSetResponse);

        resultSetResponse = null ;
        result = null;
        temp = null;
    }

    public void updateExecutionStatus(Long executionid, ResultSetResponse resultSetResponse)
    {

        String status = resultSetResponse.Status();
        resultSetResponse = dashboardStatusService.updateStatus(executionid, resultSetResponse);
        // Notify SSE client if connected
        SseEmitter emitter = clients.get(executionid);
        if (emitter != null) {
            try {
                emitter.send(SseEmitter.event().name("execution-status").data(status));
                if ("COMPLETED".equals(status) || "FAILED".equals(status) || "NOT_FOUND".equals(status)) {
                    emitter.complete();
//                    clients.remove(executionid);
                }
            } catch (IOException e) {
                emitter.completeWithError(e);
//                clients.remove(executionid);
            }
        }
        resultSetResponse = null;

    }

    public SseEmitter streamExecutionStatus(Integer tenantid, Long executionid, Authentication pr) {

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();
        WebUser user = loggedUser.getWebUser();
        ResultSetResponse status = dashboardStatusService.getStatus(executionid);

        if (!Objects.equals(status.iuserid(), user.getIuserID()) &&
                !Objects.equals(status.iorgid(), user.getIorgId().getIorgid())) {
            throw new ForbiddenException("unauthorized to get execution status", user, String.valueOf(executionid), "INFO");
        }

        // Set reasonable timeout (30 minutes)
        SseEmitter emitter = new SseEmitter(1800000L);

        // Clean up existing emitter if present
        SseEmitter existingEmitter = clients.put(executionid, emitter);
        if (existingEmitter != null) {
            try {
                existingEmitter.complete();
            } catch (Exception e) {
                log.debug("Error completing existing emitter for executionId {}: {}", executionid, e.getMessage());
            }
        }

        // Track connection state
        AtomicBoolean isActive = new AtomicBoolean(true);
        AtomicReference<ScheduledFuture<?>> scheduledTaskRef = new AtomicReference<>();
        AtomicBoolean cleanupExecuted = new AtomicBoolean(false);

        // Cleanup action - runs only once
        Runnable cleanup = () -> {
            if (cleanupExecuted.compareAndSet(false, true)) {
                isActive.set(false);
                ScheduledFuture<?> task = scheduledTaskRef.get();
                if (task != null) {
                    task.cancel(false);
                }
                clients.remove(executionid);
                log.info("SSE cleaned up for executionId: {}", executionid);
            }
        };

        // Register cleanup callbacks BEFORE starting the scheduled task
        emitter.onCompletion(() -> {
            log.info("SSE completed normally for executionId: {}", executionid);
            cleanup.run();
        });

        emitter.onTimeout(() -> {
            log.info("SSE timeout for executionId: {}", executionid);
            cleanup.run();
        });

        emitter.onError(e -> {
            log.info("SSE error for executionId {}: {}", executionid, e.getMessage());
            cleanup.run();
        });

        // Schedule periodic status updates
        ScheduledFuture<?> scheduledTask = taskScheduler.scheduleAtFixedRate(() -> {
            // Check if connection is still active
            if (!isActive.get()) {
                return;
            }

            try {
                ResultSetResponse latestStatus = dashboardStatusService.getStatus(executionid);

                // Try to send - will throw IOException if client disconnected
                emitter.send(SseEmitter.event()
                        .name("execution-status")
                        .data(latestStatus.Status()));

                // Complete only if execution finished AND connection still active
                if (("COMPLETED".equalsIgnoreCase(latestStatus.Status()) ||
                        "FAILED".equalsIgnoreCase(latestStatus.Status())) && isActive.get()) {
                    isActive.set(false);
                    cleanup.run();
                    emitter.complete(); // Safe to complete here since send succeeded
                }

            } catch (IOException e) {
                // Client disconnected - stop trying to send
                isActive.set(false);
                log.debug("Client disconnected for executionId {}: {}", executionid, e.getMessage());
                cleanup.run();
                // DON'T call emitter.complete() - onError callback will handle it

            } catch (IllegalStateException e) {
                // Emitter already completed/errored
                isActive.set(false);
                log.debug("Emitter already completed for executionId {}", executionid);
                cleanup.run();

            } catch (Exception ex) {
                isActive.set(false);
                log.error("SSE unexpected error for executionId {}: {}", executionid, ex.getMessage());
                cleanup.run();
                // DON'T call emitter.complete() - onError callback will handle it
            }

        }, Duration.ofSeconds(15));

        scheduledTaskRef.set(scheduledTask);

        return emitter;
    }



    public ResponseEntity<ResultSetResponse> streamExecutionResult(Integer tenantid, Long executionid, Authentication pr){
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();
        WebUser user = loggedUser.getWebUser();
        ResultSetResponse status = dashboardStatusService.getStatus(executionid);
        if(Objects.equals(status.iuserid(), user.getIuserID()) && Objects.equals(status.iorgid(), user.getIorgId().getIorgid())) {
            dashboardStatusService.clearStatus(executionid);
            return ResponseEntity.ok(status);
        }
        else
        {
            status = null;
            throw new ForbiddenException("unauthorized to get execution result", user, String.valueOf(executionid), "INFO");
        }
    }
}
