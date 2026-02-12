package com.DronaPay.UIServer.service.ControllerService.EmailReportController;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.Enum.WebuserMappingType;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.ResponseVO.AvailableReportsVO;
import com.DronaPay.UIServer.ResponseVO.ScheduledReportsVO;
import com.DronaPay.UIServer.controller.EmailServiceController.EmailController;
import com.DronaPay.UIServer.exception.NotFoundException;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.requests.*;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.DashboardFiltersResponse;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.response.ResultSetResponse;
import com.DronaPay.UIServer.service.ControllerService.Dashboards.DataAnalyzerControllerService;
import com.DronaPay.UIServer.service.HelperServices.ExcelHelperService;
import com.DronaPay.UIServer.service.KafkaServices.EmailRequestPublisherService;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.DronaPay.UIServer.util.UserMapping;
import com.DronaPay.UIServer.util.WebuserMappingUtil;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.JsonNodeType;
import com.fasterxml.jackson.databind.node.ObjectNode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
public class EmailReportServiceImpl implements EmailReportService {

    final String menu_name = MenuNames.emailReport;
    @Autowired
    private DashboardService dashboardService;
    @Autowired
    private DataAnalyzerControllerService dataAnalyzerControllerService;
    @Autowired
    private EmailReportRepoService emailReportRepoService;
    @Autowired
    private EmailReportLogService emailReportLogService;
    @Autowired
    private ActivityLogService activityLogService;
    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;
    @Autowired
    private EmailRequestPublisherService emailPublisherService;
    @Autowired
    private WebUserService webUserService;
    @Autowired
    private EmailController emailController;

    @Autowired
    WebuserMappingUtil webuserMappingUtil;
    @Autowired
    private WebuserMappingService webuserMappingService;

    @Autowired
    private TenantRepositoryService tenantRepositoryService;

    @Autowired
    private DashboardFiltersService dashboardFiltersService;

    @Autowired
    private DashboardResultSetService dashboardResultSetService;

    @Override
    public ResponseEntity<?> sendReport(Integer reportId, Integer tenantid) {
        log.info("Entered sendReport method of class " + EmailReportServiceImpl.class);

        ZonedDateTime curTimestamp = ZonedDateTime.now();

        EmailReport emailReport = null;
        try {
            emailReport = emailReportRepoService.findByReportId(reportId, tenantid);
        } catch (Exception e) {
            log.error("Error " + e + " \nParam " + loggerEncoderUtil.encode(reportId.toString()));
            // activityLogService.addActivity(loggedInUser, "Failed to get report
            // configuration", reportId.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        if (emailReport == null) {
            log.error("Exiting sendReport method of class " + EmailReportServiceImpl.class + " no report found for "
                    + loggerEncoderUtil.encode(reportId.toString()));
            // activityLogService.addActivity("No report found for requested id", reportId);
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "No report found for requested id"),
                    HttpStatus.BAD_REQUEST);
        }

        DashboardQueryRequest dashboardRequest = new DashboardQueryRequest();

        List<DashboardResultSet> resultSets = dashboardResultSetService.findAllByDashboardID(
                emailReport.getIdashboardID(), emailReport.getItenantId().getItenantid());

        dashboardRequest.setQueryID(resultSets.get(0).getDashboardQuery());

        JsonNode parametersJson = emailReport.getDashboardQueryParams();

        // date range: start = (current date - |period|) 00:00 IST converted to UTC, end
        // = current date, 23:59 IST converted to UTC
        // date: current date - |period| 00:00 UTC
        if (parametersJson != null) {
            ObjectNode params = (ObjectNode) parametersJson;
            if (parametersJson.get("period") != null) {
                Integer period = -1 * parametersJson.get("period").asInt();
                LocalDateTime startdate = LocalDate.now().minusDays(period).atTime(LocalTime.MIN);
                LocalDateTime enddate = LocalDate.now().atTime(LocalTime.MAX);

                DateTimeFormatter sdf = DateTimeFormatter.ofPattern("YYYY-MM-dd'T'HH:mm:ss.SSS'Z'");

                String stext = startdate.atZone(ZoneId.systemDefault()).withZoneSameInstant(ZoneOffset.UTC).format(sdf);
                String etext = enddate.atZone(ZoneId.systemDefault()).withZoneSameInstant(ZoneOffset.UTC).format(sdf);
                ArrayNode dateArray = params.putArray("DateRange");
                dateArray.add(stext);
                dateArray.add(etext);

                String dtext = startdate.atZone(ZoneOffset.UTC).format(sdf);
                params.put("Date", dtext);
                dashboardRequest.setTimeZone(ZoneId.systemDefault().getId());
                System.out.println("parametersJson: " + parametersJson.toPrettyString());
                dashboardRequest.setParametersJson(parametersJson.toPrettyString());
                params.remove("Date");
                params.remove("DateRange");
            } else {
                dashboardRequest.setParametersJson(parametersJson.toPrettyString());
            }
        }

        log.info("Dashboard query request body: " + loggerEncoderUtil.encode(dashboardRequest.toString()));
        EmailReportLog emailReportLog = new EmailReportLog();
        emailReportLog.setIreportId(emailReport.getReportId());
        emailReportLog.setTimestamp(curTimestamp);
        emailReportLog.setItenantId(emailReport.getItenantId().getItenantid());
        ObjectMapper mapper = new ObjectMapper();
        ObjectNode emailReportParams = mapper.createObjectNode();
        emailReportParams.put("frequency", emailReport.getFrequency());
        emailReportParams.put("day", emailReport.getDay());
        emailReportParams.put("reportTime", emailReport.getReportTime());
        emailReportParams.put("toEmailList", emailReport.getEmailList());
        // emailReportParams.put("vcusernameList", String.join(",",
        //         emailReport.getReportUsers().stream().map(rp -> rp.getVcUserName()).collect(Collectors.toList())));
        emailReportParams.put("dashboardqueryparams", dashboardRequest.getParametersJson());
        emailReportLog.setReportParams(emailReportParams);
        WebUser user = webUserService.findByUserOrgId(emailReport.getIuserId(), emailReport.getIorgId());


        List<WebuserMapping> webuserMappings = webuserMappingService.findByIDsWebuserIDandOrgID(user.getIuserID(),
                user.getIorgId().getIorgid());

        UserMapping classIds = webuserMappingUtil.mappingHelper(webuserMappings, String.valueOf(WebuserMappingType.TransactionClass));

        dashboardRequest.setIuserid(user.getIuserID());
        dashboardRequest.setIorgid(user.getIorgId().getIorgid());
        dashboardRequest.setClassIds(classIds);
        dashboardRequest.setItenantID(tenantid);

        ResponseEntity<?> dashboardRes = dataAnalyzerControllerService.getResultSetDataService(dashboardRequest);
        if (dashboardRes.getStatusCode() != HttpStatus.OK) {
            emailReportLog.setStatus("Report generation failed with error status code " + dashboardRes.getStatusCode());
            emailReportLogService.save(emailReportLog);
            log.error("Report generation failed with response status " + dashboardRes.getStatusCode());
            log.error("Report generation failed with response body "
                    + ((dashboardRes.getBody() != null) ? dashboardRes.getBody().toString() : ""));
            return dashboardRes;
        }

        List<String> headers = new ArrayList<>();
        List<List<Object>> rowData = new ArrayList<>();
        ResultSetResponse res = (ResultSetResponse) dashboardRes.getBody();
        List<Map<String, Object>> reportDataAll = (List<Map<String, Object>>) res.data();
        if (reportDataAll == null || reportDataAll.size() == 0) {
            log.info("No data found for report " + loggerEncoderUtil.encode(reportId.toString()));
            headers.add("No data present for this scheduled report");
        } else {

            for (String param : reportDataAll.get(0).keySet()) {
                headers.add(param);
            }
            for (Map<String, Object> rowRep : reportDataAll) {
                List<Object> row = new ArrayList<>();
                for (String param : headers) {
                    row.add(rowRep.get(param));
                }
                rowData.add(row);
            }

        }

        System.out.println("Report headers display names size " + headers.size());
        System.out.println("Report output row data size " + rowData.size());
        Dashboard dashboard = dashboardService.findById(emailReport.getIdashboardID(), emailReport.getItenantId().getItenantid());
        EmailAttachment attachment = new EmailAttachment();
        attachment.setFilename(dashboard.getVcDashboardName() + ".xlsx");
        String filecontet = Base64.getEncoder().encodeToString(
                ExcelHelperService.analyzerReportToExcel(dashboard.getVcDashboardName(), headers,
                        rowData));
        attachment.setFilecontent(filecontet);

        EmailRequest emailRequest = new EmailRequest();
        emailRequest.setTemplateid(10);
        emailRequest.setToEmail(Arrays.asList(emailReport.getEmailList().split(",")));
        Map<String, Object> subParams = new HashMap<>();
        subParams.put("name", dashboard.getVcDashboardName());
        subParams.put("frequency", emailReport.getFrequency());
        emailRequest.setSubjectParams(subParams);

        // Map<String, Object> bodyParams = new HashMap<>();
        // bodyParams.put("headers", headers);
        // bodyParams.put("rows", rowData);
        // emailRequest.setBodyParams(bodyParams);
        List<EmailAttachment> listAttach = new ArrayList<>();
        listAttach.add(attachment);
        emailRequest.setAttachments(listAttach);

        try {
            String emailRequestString = mapper.writeValueAsString(emailRequest);

            emailController.sendEmail(emailRequestString, emailReport.getItenantId().getItenantid());
        } catch (Exception e) {
            // activityLogService.addActivity("Failed to send report ", e.toString());
            log.error("Error with exception " + e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        // log.info("Email request body : " + emailRequest);
        // emailControllerService.sendEmail(emailRequest);

        emailReportLog.setStatus("Report generated and email sent");
        emailReportLogService.save(emailReportLog);
        emailReport.setLatestSentTimestamp(curTimestamp);
        try {
            emailReportRepoService.save(emailReport);
        } catch (Exception e) {
            // activityLogService.addActivity(loggedInUser, "failed to save report ",
            // e.toString());
            log.error("Error with exception " + e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
        log.debug("Existing sendReport method of class " + EmailReportServiceImpl.class);
        return ResponseEntity.ok(new ApiResponse(true, "Report " + emailReport.getReportId() + " sent"));
    }

    @Override
    public ResponseEntity<?> getAvailableReports(Authentication pr, Integer tenantid) {
        log.debug("Entering getAvailableReports method of class " + EmailReportServiceImpl.class);
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (!mp.isView()) {
            activityLogService.addActivity(loggedInUser, "unauthorized to access Email Report Scheduler");
            log.debug("Exiting getAvailableReports Method in " + EmailReportServiceImpl.class
                    + " class with response  : unauthorized to access Email Report Scheduler ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access Email Report Scheduler"),
                    HttpStatus.FORBIDDEN);
        }
        AvailableReportsVO response = new AvailableReportsVO();
        List<WebUser> usersDB = null;
        log.info("t1");
        try {
            usersDB = webUserService.findAllActiveUsersTenant(tenantid, loggedInUser.getIorgId().getIorgid());
        } catch (Exception e) {
            log.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
        log.info("t2");
        List<Map<String, Object>> userInfo = new ArrayList<>();
        usersDB.stream().map(wb -> {
            Map<String, Object> user_details = new HashMap<>();
            user_details.put("label", wb.getVcUserName());
            user_details.put("value", wb.getVcEmailID());
            userInfo.add(user_details);
            return wb;
        }).collect(Collectors.toList());
        response.setUserInfo(userInfo);
        log.info("t3");
        List<Dashboard> dashboardList = null;
        try {
            dashboardList = dashboardService.findAllActiveAndNotDeleted(tenantid);
        } catch (Exception e) {
            log.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
        log.info("t4");

        dashboardList = dashboardList.stream().filter(rp -> rp.getImenuStructureDesc() != null)
                .collect(Collectors.toList());

        // generate hierarcy of menu->submenu->reports
        Map<String, Map<String, List<Map<String, Object>>>> dashIdMap = new HashMap<>();
        for (Dashboard dash : dashboardList) {

            String subMenu = dash.getImenuStructureDesc().getVcMenuName();
            String menu = dash.getImenuStructureDesc().getIParentMenu().getVcMenuName();
            Map<String, Object> dashEntry = new HashMap<>();
            dashEntry.put("value", dash.getIDashboardID());
            dashEntry.put("label", dash.getVcDashboardName());

            if (dashIdMap.containsKey(menu)) {
                Map<String, List<Map<String, Object>>> subIdMap = dashIdMap.get(menu);
                if (subIdMap.containsKey(subMenu)) {
                    subIdMap.get(subMenu).add(dashEntry);
                } else {
                    List<Map<String, Object>> list = new ArrayList<>();
                    list.add(dashEntry);
                    subIdMap.put(subMenu, list);
                }
            } else {
                Map<String, List<Map<String, Object>>> subIdMap = new HashMap<>();
                List<Map<String, Object>> list = new ArrayList<>();
                list.add(dashEntry);
                subIdMap.put(subMenu, list);
                dashIdMap.put(menu, subIdMap);
            }
        }

        // convert hierarchy into label-value nested format
        List<Map<String, Object>> dashAllRep = new ArrayList<>();
        for (Map.Entry<String, Map<String, List<Map<String, Object>>>> menuId : dashIdMap.entrySet()) {
            Map<String, Object> menu = new HashMap<>();
            menu.put("label", menuId.getKey());
            List<Map<String, Object>> subMenuList = new ArrayList<>();
            for (Map.Entry<String, List<Map<String, Object>>> subMenuId : menuId.getValue().entrySet()) {
                Map<String, Object> subMenu = new HashMap<>();
                subMenu.put("label", subMenuId.getKey());
                subMenu.put("value", subMenuId.getValue());
                subMenuList.add(subMenu);
            }
            subMenuList.sort((n1, n2) -> ((String) n1.get("label")).compareTo((String) n2.get("label")));
            menu.put("value", subMenuList);
            dashAllRep.add(menu);
        }

        dashAllRep.sort((n1, n2) -> ((String) n1.get("label")).compareTo((String) n2.get("label")));
        log.info("t5");
        response.setAvailableReports(dashAllRep);
        log.debug("Exiting getAvailableReports method of class " + EmailReportServiceImpl.class);
        return ResponseEntity.ok(response);

    }

    @Override
    public ResponseEntity<?> addEmailReport(EmailReportAdd request, Authentication pr) {
        log.debug("Entering addEmailReport method of class " + EmailReportServiceImpl.class);
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (!mp.isAdd()) {
            activityLogService.addActivity(loggedInUser, "unauthorized to access Email Report Scheduler");
            log.debug("Exiting getAvailableReports Method in " + EmailReportServiceImpl.class
                    + " class with response  : unauthorized to access Email Report Scheduler ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access Email Report Scheduler"),
                    HttpStatus.FORBIDDEN);
        }
        EmailReport newReport = new EmailReport();
        newReport.setBactive(true);
        newReport.setBdelete(false);
        JsonNode period = request.getFilterConfig().get("period");
        if (period != null) {
            Integer p = null;
            try {
                p = Integer.parseInt(period.asText());
            } catch (NumberFormatException e) {
                activityLogService.addActivity(loggedInUser,
                        "invalid period :" + request.toString());
                log.debug("Exiting getAvailableReports Method in " + EmailReportServiceImpl.class
                        + " class with response  : input period is invalid");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Period should be <= 0"),
                        HttpStatus.BAD_REQUEST);
            }
            if (p > 0) {
                activityLogService.addActivity(loggedInUser,
                        "invalid period :" + request.toString());
                log.debug("Exiting getAvailableReports Method in " + EmailReportServiceImpl.class
                        + " class with response  : input period is invalid");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Period should be <= 0"),
                        HttpStatus.BAD_REQUEST);
            }
        }

        Boolean dayValid = true;
        String msg = "";
        if (request.getFrequency().equals("Daily") || request.getFrequency().equals("Weekly")
                || request.getFrequency().equals("Monthly")) {
            dayValid = true;
        } else {
            dayValid = false;
            msg = "Expected Frequency is Daily, Weekly or Monthly";
        }

        if (request.getFrequency().equals("Daily") && request.getDay() != 0) {
            dayValid = false;
            msg = "Expected day for Daily frequency is 0";
        } else if (request.getFrequency().equals("Weekly")
                && !(request.getDay() >= 1 && request.getDay() <= 7)) {
            dayValid = false;
            msg = "Expected day for Weekly frequency is between 1 and 7";
        } else if (request.getFrequency().equals("Monthly")
                && !(request.getDay() >= 1 && request.getDay() <= 31)) {
            dayValid = false;
            msg = "Expected day for Monthly frequency is between 1 and 31";
        }

        if (!dayValid) {
            activityLogService.addActivity(loggedInUser,
                    "day and frequency combination is invalid: " + request.toString());
            log.debug("Exiting getAvailableReports Method in " + EmailReportServiceImpl.class
                    + " class with response " + msg);
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, msg), HttpStatus.BAD_REQUEST);
        }

        newReport.setFrequency(request.getFrequency());
        newReport.setDay(request.getDay());
        try {
            DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm");
            LocalTime localTime = LocalTime.parse(request.getTime(), dateTimeFormatter);
            if (localTime.getMinute() % 10 != 0) {
                log.info("Exiting addEmailReport Method in " + EmailReportServiceImpl.class
                        + " class with response  : minutes should be in multiples of 10");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Minutes should be in multiples of 10"),
                        HttpStatus.BAD_REQUEST);
            }
        } catch (Exception e) {
            activityLogService.addActivity(loggedInUser,
                    "time entered invalid " + request.toString());
            log.info("Exiting addEmailReport Method in " + EmailReportServiceImpl.class
                    + " class with response  : day and frequency combination is invalid");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Time format is invalid, Please enter in HH:mm format"),
                    HttpStatus.BAD_REQUEST);
        }
        newReport.setReportTime(request.getTime());
        System.out.println("node type " + request.getFilterConfig().getNodeType());
        if (request.getFilterConfig().getNodeType() != JsonNodeType.NULL) {
            newReport.setDashboardQueryParams(request.getFilterConfig());
        }
        // if (request.getVcusername().size() > 0) {
        //     List<WebUser> users = null;
        //     try {
        //         users = webUserService.findAllByUsername(request.getVcusername());
        //     } catch (Exception e) {
        //         log.error("Error " + e + " \nParam " + loggerEncoderUtil.encode(pr.toString()));
        //         activityLogService.addActivity(loggedInUser, "Failed to get list of web users ", request.getEmailList().toString());
        //         return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
        //                 HttpStatus.INTERNAL_SERVER_ERROR);
        //     }
        //      newReport.setReportUsers(users);
        // }
        newReport.setEmailList(String.join(",", request.getEmailList()));
        Dashboard dashboard = null;
        try {
            dashboard = dashboardService.findById(request.getId(), request.getItenantId());
        } catch (NotFoundException e) {
            String mesg = "Mandatory fields cannot be empty";
            activityLogService.addActivity(loggedInUser,
                    "Dashboard id not found : " + request.toString());
            log.debug("Exiting addEmailReport Method in " + EmailReportServiceImpl.class
                    + " class with response " + mesg);
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, mesg), HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            log.error("Error " + e + " \nParam " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "Failed to get dashboard report ", request.getId().toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
        newReport.setIdashboardID(dashboard.getIDashboardID());
        newReport.setItenantId(tenantRepositoryService.findByItenantId(request.getItenantId()));
        newReport.setIuserId(loggedInUser.getIuserID());
        newReport.setIorgId(loggedInUser.getIorgId().getIorgid());
        try {
            emailReportRepoService.save(newReport);
        } catch (Exception e) {
            log.error("Error " + e + " \nParam " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "Unable to add new report ", request.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        log.debug("Exiting addEmailReport method of class " + EmailReportServiceImpl.class);
        return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Report added in the scheduler"),
                HttpStatus.OK);
    }

    private List<ScheduledReportsVO> getScheduledReportService(LoggedUser loggedUser, List<Integer> itenantId) {
        log.debug("Entering getScheduledReportService method of class " + EmailReportServiceImpl.class);
        List<EmailReport> scheduledReps = null;

        try {
            scheduledReps = emailReportRepoService.findAllNondeletedReportsTenant(itenantId);
        } catch (Exception e) {
            log.error("Error : Exception " + e);
            // activityLogService.addActivity(loggedinUser, "exception when querying active reports");
            return null;
        }
        scheduledReps.sort((r1, r2) -> r1.getReportId() - r2.getReportId());
        List<ScheduledReportsVO> response = new ArrayList<>();
        for (EmailReport repDB : scheduledReps) {
            ScheduledReportsVO schedRepRes = new ScheduledReportsVO();
            Dashboard dashboard = dashboardService.findById(repDB.getIdashboardID(), repDB.getItenantId().getItenantid());
            schedRepRes.setDay(repDB.getDay());
            schedRepRes.setEmailList(Arrays.asList(repDB.getEmailList().split(",")));
            JsonNode queryParams = repDB.getDashboardQueryParams();
            List<Map<String, Object>> filtersList = new ArrayList<>();

            if (loggedUser != null) {// invoked by UI
                List<DashboardFilters> filters = null;
                try {
                    filters = dashboardFiltersService.getAllByIDashboardID(repDB.getIdashboardID(),
                            repDB.getItenantId().getItenantid());
                } catch (Exception e) {
                    log.error("Error : Exception " + e);
                    // activityLogService.addActivity(loggedUser, "exception when querying active reports");
                    return null;
                }
                for (DashboardFilters filter : filters) {
                    String type = filter.getVcDashboardFilterType();
                    Map<String, Object> filterRes = new HashMap<>();
                    if (type.equalsIgnoreCase("daterangepicker") || type.equalsIgnoreCase("datepicker")) {
                        filterRes.put("displayName", "Period");
                        filterRes.put("name", "period");
                        filterRes.put("value",
                                (queryParams != null && queryParams.get("period") != null)
                                        ? queryParams.get("period").asText()
                                        : "");
                    } else {
                        filterRes.put("displayName", filter.getVcDashboardFilterDisplayName());
                        filterRes.put("name", filter.getVcDashboardFilterName());
                        String name = filter.getVcDashboardFilterName();
                        filterRes.put("value",
                                (queryParams != null && queryParams.get(name) != null) ? queryParams.get(name).asText()
                                        : "");
                    }
                    filtersList.add(filterRes);
                }
            }
            schedRepRes.setFilters(filtersList);
            schedRepRes.setFrequency(repDB.getFrequency());
            schedRepRes.setName(dashboard.getVcDashboardName());
            schedRepRes.setReportId(repDB.getReportId());
            schedRepRes.setTime(repDB.getReportTime());
            schedRepRes.setItenantId(repDB.getItenantId() != null ? repDB.getItenantId().getItenantid() : null);
            schedRepRes.setTenantName(repDB.getItenantId() != null ? repDB.getItenantId().getTenantName() : null);
            schedRepRes.setAvailableReportId(dashboard.getIDashboardID());
            schedRepRes.setSubMenuName(dashboard.getImenuStructureDesc().getVcMenuName());
            schedRepRes.setMenuName(dashboard.getImenuStructureDesc().getIParentMenu().getVcMenuName());
            System.out.println("Time from db is " + repDB.getLatestSentTimestamp());

            if (repDB.getLatestSentTimestamp() != null) {
                schedRepRes.setLatestSentTimestamp(
                        LocalDateTime.ofInstant(repDB.getLatestSentTimestamp().toInstant(), ZoneId.systemDefault()));
            }

            schedRepRes.setActive(repDB.getBactive());
            schedRepRes.setVcusername(schedRepRes.getEmailList());
            response.add(schedRepRes);
        }
        log.debug("Exiting getScheduledReportService method of class " + EmailReportServiceImpl.class);
        return response;
    }

    @Override
    public ResponseEntity<?> getScheduledReportServiceUI(Authentication pr) {
        log.debug("Entering getScheduledReportServiceUI method of class " + EmailReportServiceImpl.class);
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);
        if (!mp.isView()) {
            activityLogService.addActivity(loggedInUser, "unauthorized to access Email Report Scheduler");
            log.debug("Exiting getScheduledReportServiceUI Method in " + EmailReportServiceImpl.class
                    + " class with response  : unauthorized to access Email Report Scheduler ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access Email Report Scheduler"),
                    HttpStatus.FORBIDDEN);
        }
        List<ScheduledReportsVO> response = getScheduledReportService(loggedUser, loggedUser.getUserTenant());
        response = response.stream().filter(rep -> loggedUser.getUserTenant().contains(rep.getItenantId())).toList();
        log.debug("Exiting getScheduledReportServiceUI method of class " + EmailReportServiceImpl.class);
        if (response != null) {
            return ResponseEntity.ok(response);
        } else {
            log.error("Error : response is null \nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "response is null", "");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @Override
    public ResponseEntity<?> getScheduledReportServiceCron(Integer tenantid) {
        log.debug("Entering getScheduledReportServiceCron method of class " + EmailReportServiceImpl.class);
        List<ScheduledReportsVO> response = getScheduledReportService(null, Arrays.asList(tenantid));
        if (response == null) {
            log.error("Error : response is null \nParam : "+tenantid);
            // activityLogService.addActivity(loggedInUser, "response is null", "");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
        response = response.stream().filter(report -> (report.getItenantId().equals(tenantid)) && report.getActive()).collect(Collectors.toList());

        log.debug("Exiting getScheduledReportServiceCron method of class " + EmailReportServiceImpl.class);

        return ResponseEntity.ok(response);
    }

    @Override
    public ResponseEntity<?> editEmailReport(EmailReportEdit request, Authentication pr) {
        log.debug("Entering editEmailReport method of class " + EmailReportServiceImpl.class);
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (!mp.isEdit()) {
            activityLogService.addActivity(loggedInUser, "unauthorized to access Email Report Scheduler");
            log.debug("Exiting getAvailableReports Method in " + EmailReportServiceImpl.class
                    + " class with response  : unauthorized to access Email Report Scheduler ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access Email Report Scheduler"),
                    HttpStatus.FORBIDDEN);
        }
        EmailReport newReport = null;
        try {
            newReport = emailReportRepoService.findByReportId(request.getReportId(), request.getItenantId());
        } catch (Exception e) {
            log.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
        if (newReport == null) {
            activityLogService.addActivity(loggedInUser,
                    "scheduled report not found :" + request.toString());
            log.debug("Exiting editEmailReport Method in " + EmailReportServiceImpl.class
                    + " class with response  : scheduled report not found");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Scheduled report not found"),
                    HttpStatus.BAD_REQUEST);
        }
        newReport.setBactive(request.getActive());
        newReport.setBdelete(false);
        JsonNode period = request.getFilterConfig().get("period");
        if (period != null) {
            Integer p = null;
            try {
                p = Integer.parseInt(period.asText());
            } catch (NumberFormatException e) {
                activityLogService.addActivity(loggedInUser,
                        "invalid period :" + request.toString());
                log.debug("Exiting getAvailableReports Method in " + EmailReportServiceImpl.class
                        + " class with response  : input period is invalid");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Period should be <= 0"),
                        HttpStatus.BAD_REQUEST);
            }
            if (p > 0) {
                activityLogService.addActivity(loggedInUser,
                        "invalid period :" + request.toString());
                log.debug("Exiting getAvailableReports Method in " + EmailReportServiceImpl.class
                        + " class with response  : input period is invalid");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Period should be <= 0"),
                        HttpStatus.BAD_REQUEST);
            }
        }

        Boolean dayValid = true;
        String msg = "";
        if (request.getFrequency().equals("Daily") || request.getFrequency().equals("Weekly")
                || request.getFrequency().equals("Monthly")) {
            dayValid = true;
        } else {
            dayValid = false;
            msg = "Expected Frequency is Daily, Weekly or Monthly";
        }

        if (request.getFrequency().equals("Daily") && request.getDay() != 0) {
            dayValid = false;
            msg = "Expected day for Daily frequency is 0";
        } else if (request.getFrequency().equals("Weekly")
                && !(request.getDay() >= 1 && request.getDay() <= 7)) {
            dayValid = false;
            msg = "Expected day for Weekly frequency is between 1 and 7";
        } else if (request.getFrequency().equals("Monthly")
                && !(request.getDay() >= 1 && request.getDay() <= 31)) {
            dayValid = false;
            msg = "Expected day for Monthly frequency is between 1 and 31";
        }

        if (!dayValid) {
            activityLogService.addActivity(loggedInUser,
                    "day and frequency combination is invalid: " + request.toString());
            log.debug("Exiting getAvailableReports Method in " + EmailReportServiceImpl.class
                    + " class with response " + msg);
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, msg), HttpStatus.BAD_REQUEST);
        }

        newReport.setFrequency(request.getFrequency());
        newReport.setDay(request.getDay());
        try {
            DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm");
            LocalTime localTime = LocalTime.parse(request.getTime(), dateTimeFormatter);
            if (localTime.getMinute() % 10 != 0) {
                log.info("Exiting addEmailReport Method in " + EmailReportServiceImpl.class
                        + " class with response  : minutes should be in multiples of 10");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Minutes should be in multiples of 10"),
                        HttpStatus.BAD_REQUEST);
            }
        } catch (Exception e) {
            activityLogService.addActivity(loggedInUser,
                    "time entered invalid " + request.toString());
            log.info("Exiting addEmailReport Method in " + EmailReportServiceImpl.class
                    + " class with response  : day and frequency combination is invalid");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Time format is invalid, Please enter in HH:mm format"),
                    HttpStatus.BAD_REQUEST);
        }
        newReport.setReportTime(request.getTime());
        System.out.println("node type " + request.getFilterConfig().getNodeType());
        if (request.getFilterConfig().getNodeType() != JsonNodeType.NULL) {
            newReport.setDashboardQueryParams(request.getFilterConfig());
        }
        // if (request.getVcusername().size() > 0) {
        //     List<WebUser> users = null;
        //     try {
        //         users = webUserService.findAllByUsername(request.getVcusername());
        //     } catch (Exception e) {
        //         log.error("Error " + e + " \nParam " + loggerEncoderUtil.encode(pr.toString()));
        //         activityLogService.addActivity(loggedInUser, "Failed to get list of web users ", request.getEmailList().toString());
        //         return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
        //                 HttpStatus.INTERNAL_SERVER_ERROR);
        //     }
        //     newReport.setReportUsers(users);
        // }
        newReport.setEmailList(String.join(",", request.getEmailList()));

        try {
            emailReportRepoService.save(newReport);
        } catch (Exception e) {
            log.error("Error " + e + " \nParam " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "Unable to edit report ", request.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        log.debug("Exiting editEmailReport method of class " + EmailReportServiceImpl.class);
        return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Report edited in the scheduler"),
                HttpStatus.OK);

    }

    @Override
    public ResponseEntity<?> deleteEmailReport(Integer reportId, Integer tenantid, Authentication pr) {
        log.debug("Entering deleteEmailReport method of class " + EmailReportServiceImpl.class);
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (!mp.isDelete()) {
            activityLogService.addActivity(loggedInUser, "unauthorized to access Email Report Scheduler");
            log.debug("Exiting deleteEmailReport Method in " + EmailReportServiceImpl.class
                    + " class with response  : unauthorized to access Email Report Scheduler ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access Email Report Scheduler"),
                    HttpStatus.FORBIDDEN);
        }

        try {
            EmailReport emailReport = emailReportRepoService.findByReportId(reportId, tenantid);
            if (emailReport == null) {
                log.debug("Report not found with request reportid " + reportId);
                activityLogService.addActivity(loggedInUser, "Report with input id not found ", reportId.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Report with id not found"),
                        HttpStatus.BAD_REQUEST);
            }

            emailReport.setBactive(false);
            emailReport.setBdelete(true);
            emailReportRepoService.save(emailReport);
        } catch (Exception e) {
            log.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to execute db queries", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        log.debug("Exiting deleteEmailReport Method in " + EmailReportServiceImpl.class);

        return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Report deleted"), HttpStatus.OK);
    }

    @Override
    public ResponseEntity<?> getFiltersAvailableReports(Integer dashboardId, Integer tenantid, Authentication pr) {
        log.debug("Entering getFiltersAvailable method of class " + EmailReportServiceImpl.class);
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (!mp.isView()) {
            activityLogService.addActivity(loggedInUser, "unauthorized to access Email Report Scheduler");
            log.debug("Exiting getAvailableReports Method in " + EmailReportServiceImpl.class
                    + " class with response  : unauthorized to access Email Report Scheduler ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access Email Report Scheduler"),
                    HttpStatus.FORBIDDEN);
        }

        Map<String, DashboardFiltersResponse> filtersData;
        try {
            //// to change later to use tenantid from API input
            filtersData = dataAnalyzerControllerService.getFiltersService(dashboardId, loggedInUser, tenantid);
        } catch (Exception e) {
            log.error("Error : " + e + "\nParam : " + dashboardId);
            activityLogService.addActivity(loggedInUser, "failed to access dashboard filters",
                    "Error : " + e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        LinkedHashMap<String, DashboardFiltersResponse> returnFilters = new LinkedHashMap<>();

        Iterator<Map.Entry<String, DashboardFiltersResponse>> iterator = filtersData.entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry<String, DashboardFiltersResponse> entry = iterator.next();
            DashboardFiltersResponse filterInfo = entry.getValue();
            String filterKey = entry.getKey();
            if (filterInfo.getFilterType().equalsIgnoreCase("daterangepicker") ||
                    filterInfo.getFilterType().equalsIgnoreCase("datepicker")) {
                DashboardFiltersResponse temp = new DashboardFiltersResponse();
                temp.setDiplayName("Period");
                temp.setFilterType("Input");
                returnFilters.put("period", temp);
            } else if (filterInfo.getFilterType().equalsIgnoreCase("formfilter")) {
                filterInfo.setFilterType("Input");
            } else {
                returnFilters.put(filterKey, filterInfo);
            }
        }
        return ResponseEntity.ok(returnFilters);
    }

}
