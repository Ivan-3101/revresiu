package com.DronaPay.UIServer.service.ControllerService.WindowManagement;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.ResponseVO.DropdownWithObject;
import com.DronaPay.UIServer.model.ObservationWindows;
import com.DronaPay.UIServer.model.ObservationWindowsAudit;
import com.DronaPay.UIServer.model.ObservationsUi;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.requests.AddWindowApiRequest;
import com.DronaPay.UIServer.requests.AddWindowRequest;
import com.DronaPay.UIServer.response.*;
import com.DronaPay.UIServer.service.ApiServices.WindowApiService;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import java.net.http.HttpResponse;
import java.time.Duration;
import java.time.ZonedDateTime;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Service
public class WindowManagementServiceImpl implements WindowManagementService {

    private static final Logger LOGGER = LoggerFactory.getLogger(WindowManagementServiceImpl.class);
    final String menu_name = MenuNames.Window;
    @Autowired
    private ActivityLogService activityLogService;
    @Autowired
    private TenantRepositoryService tenantRepositoryService;
    @Autowired
    private WebUserService webUserService;
    @Autowired
    private StatusCodeService statusCodeService;
    @Autowired
    private ObservationWindowsAuditService observationWindowsAuditService;
    @Autowired
    private ObservationWindowsService observationWindowsService;
    @Autowired
    private WindowApiService windowApiService;
    @Autowired
    private ObservationsUiService observationsUiService;
    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Override
    public ResponseEntity<?> getListOfWindows(Authentication pr) {
        LOGGER.debug("entered in class " + WindowManagementServiceImpl.class + " in method getListOfWindows");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        WindowListView listView = new WindowListView();
        listView.setAdd(mp.isAdd());
        listView.setApprove(mp.isApprove());
        listView.setDelete(mp.isDelete());
        listView.setEdit(mp.isEdit());
        listView.setView(mp.isView());
        listView.setPublish(mp.isPublish());

        if (mp.isView()) {

            List<ObservationWindows> observationWindows = new ArrayList<>();

            try {
                observationWindows = observationWindowsService.findAllNonDeletedTenant(loggedUser.getUserTenant());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to find all deleted entries", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            List<ObservationWindowsAudit> observationWindowsAudits = new ArrayList<>();

            try {
                observationWindowsAudits = observationWindowsAuditService.findAllPendingEntriesTenant(loggedUser.getUserTenant());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            List<WindowResponse> responses = new ArrayList<>();

            for (int i = 0; i < observationWindows.size(); i++) {
                responses.add(WindowResponse.builder().auditEntry(false).auditExist(false)
                        .lastStatus(observationWindows.get(i).getLastStatus())
                        .lastUpdate(observationWindows.get(i).getDtApproverStamp())
                        .latestRemark(observationWindows.get(i).getLatestRemark())
                        .makerChecker("M")
                        .wId(observationWindows.get(i).getWid())
                        .windowCount(observationWindows.get(i).getWCount())
                        .windowDuration(observationWindows.get(i).getWDuration())
                        .windowName(observationWindows.get(i).getWname())
                        .itenantId(observationWindows.get(i).getItenantId())
                        .tenantName(tenantRepositoryService.findByItenantId(observationWindows.get(i).getItenantId()).getTenantName())
                        .wdesc(observationWindows.get(i).getWdesc()).build());

            }

            for (int j = 0; j < responses.size(); j++) {
                for (int k = 0; k < observationWindowsAudits.size(); k++) {

                    if (responses.get(j).getWId().equals(observationWindowsAudits.get(k)
                            .getWid())) {
                        responses.get(j).setAuditExist(true);
                    }

                }
            }

            for (int h = 0; h < observationWindowsAudits.size(); h++) {
                responses.add(WindowResponse.builder().auditEntry(true).auditExist(false)
                        .lastStatus("Pending")
                        .lastUpdate(observationWindowsAudits.get(h).getDtEntryStamp())
                        .latestRemark(observationWindowsAudits.get(h).getVcRemark())
                        .makerChecker(observationWindowsAudits.get(h).getIEntryUserID().equals(loggedInUser
                                .getIuserID()) ? "M" : "C")
                        .wId(observationWindowsAudits.get(h).getWid() != null
                                ? observationWindowsAudits.get(h).getWid()
                                : null)
                        .windowCount(observationWindowsAudits.get(h).getWCount())
                        .wAuditId(observationWindowsAudits.get(h).getWauditId())
                        .windowDuration(observationWindowsAudits.get(h).getWDuration())
                        .windowName(observationWindowsAudits.get(h).getWname())
                        .action(observationWindowsAudits.get(h).getVcAction())
                        .itenantId(observationWindowsAudits.get(h).getItenantId())
                        .tenantName(tenantRepositoryService.findByItenantId(observationWindowsAudits.get(h).getItenantId()).getTenantName())
                        .wdesc(observationWindowsAudits.get(h).getWdesc()).build());
            }

            listView.setWindowResponses(responses);

            LOGGER.debug("Exiting getListOfWindows Method in "
                    + WindowManagementServiceImpl.class
                    + " class with response  : with parameters list of RT windows");
            activityLogService.addActivity(loggedInUser, "List of RT windows accessed");

            return ResponseEntity.ok(listView);

        } else {

            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access RT windows list");
            LOGGER.debug("Exiting getListOfWindows Method in " + WindowManagementServiceImpl.class
                    + " class with response  : unauthorized to access list of RT windows");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access list of RT windows"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> getWindowDetails(Integer wId, Boolean audit, Integer tenantid, Authentication pr) {

        LOGGER.debug("entered in class " + WindowManagementServiceImpl.class + " in method getWindowDetails");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        if (mp.isView()) {

            if (audit == false) {
                ObservationWindows observationWindows = null;

                try {
                    observationWindows = observationWindowsService.findByWId(wId, tenantid);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to find window by id",
                            e.toString());
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (observationWindows != null) {

                    WindowDetailResponse windowDetailResponse = WindowDetailResponse.builder()
                            .groupByExpr(observationWindows.getGroupbyExperession())
                            .remark(observationWindows.getLatestRemark())
                            .selectExpr(observationWindows.getSelectExperession())
                            .wCount(observationWindows.getWCount())
                            .wDuration(observationWindows.getWDuration())
                            .wId(observationWindows.getWid())
                            .wName(observationWindows.getWname())
                            .orgId(observationWindows.getWid())
                            .whereExpr(observationWindows.getWhereExperession())
                            .itenantId(observationWindows.getItenantId())
                            .tenantName(tenantRepositoryService.findByItenantId(observationWindows.getItenantId()).getTenantName())
                            .wdesc(observationWindows.getWdesc())
                            .idexpr(observationWindows.getIdexpr())
                            .tsexpr(observationWindows.getTsexpr())
                            .build();
                    LOGGER.debug("Exiting getWindowDetails Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : with parameters window details");
                    activityLogService.addActivity(loggedInUser,
                            "Observation window details accessed");
                    return ResponseEntity.ok(windowDetailResponse);

                } else {
                    LOGGER.debug("Exiting getWindowDetails Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : No RT windows details found with id :"
                            + wId);
                    activityLogService.addActivity(loggedInUser, "Failed to access window details");
                    return new ResponseEntity<>(
                            new ApiResponse(false, "No Observation window found"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                ObservationWindowsAudit observationWindowsAudit = null;

                try {
                    observationWindowsAudit = observationWindowsAuditService.findByWAuditId(wId, tenantid);

                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to find window audit entry by id",
                            e.toString());
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (observationWindowsAudit != null) {

                    WindowDetailResponse windowDetailResponse = WindowDetailResponse.builder()
                            .groupByExpr(observationWindowsAudit.getGroupbyExperession())
                            .remark(observationWindowsAudit.getVcRemark())
                            .selectExpr(observationWindowsAudit.getSelectExperession())
                            .wCount(observationWindowsAudit.getWCount())
                            .wDuration(observationWindowsAudit.getWDuration())
                            .wId(observationWindowsAudit.getWauditId())
                            .wName(observationWindowsAudit.getWname())
                            .whereExpr(observationWindowsAudit.getWhereExperession())
                            .orgId(observationWindowsAudit.getWid())
                            .wdesc(observationWindowsAudit.getWdesc())
                            .itenantId(observationWindowsAudit.getItenantId())
                            .tenantName(tenantRepositoryService.findByItenantId(observationWindowsAudit.getItenantId()).getTenantName())
                            .idexpr(observationWindowsAudit.getIdexpr())
                            .tsexpr(observationWindowsAudit.getTsexpr())
                            .build();

                    LOGGER.debug("Exiting getWindowDetails Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : with parameters window details");
                    activityLogService.addActivity(loggedInUser,
                            "Observation window details accessed");
                    return ResponseEntity.ok(windowDetailResponse);

                } else {
                    LOGGER.debug("Exiting getWindowDetails Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : No RT windows details found with id :"
                            + wId);
                    activityLogService.addActivity(loggedInUser, "Failed to access window details");
                    return new ResponseEntity<>(
                            new ApiResponse(false, "No Observation window found"),
                            HttpStatus.BAD_REQUEST);
                }
            }
        } else {

            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access RT windows details");
            LOGGER.debug("Exiting getWindowDetails Method in " + WindowManagementServiceImpl.class
                    + " class with response  : unauthorized to access RT windows details");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access RT windows details"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> addObservationWindow(AddWindowRequest addWindowRequest, Authentication pr) {

        LOGGER.debug("entered in class " + WindowManagementServiceImpl.class
                + " in method addObservationWindow");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        if (mp.isAdd() && loggedUser.allowTenants(Arrays.asList(addWindowRequest.getItenantId()))) {

            if (addWindowRequest.getWindowName() != null) {
                if (addWindowRequest.getWindowName().isEmpty()
                        || addWindowRequest.getWindowName().isBlank()) {
                    LOGGER.debug("Exiting  addObservationWindow Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : with parameter add window request");
                    activityLogService.addActivity(loggedInUser, "failed to save new window",
                            addWindowRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Name cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                } else {
                    if (addWindowRequest.getWindowName().length() > 101) {
                        LOGGER.debug("Exiting  addObservationWindow Method in "
                                + WindowManagementServiceImpl.class
                                + " class with response  : with parameter add window request");
                        activityLogService.addActivity(loggedInUser, "failed to save new window",
                                addWindowRequest.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Name cannot be more than 100 characters"),
                                HttpStatus.BAD_REQUEST);
                    }

                    Pattern pattern = Pattern.compile("\\s");
                    Matcher matcher = pattern.matcher(addWindowRequest.getWindowName());
                    if (matcher.find()) {
                        LOGGER.debug("Exiting  addObservationWindow Method in "
                                + WindowManagementServiceImpl.class
                                + " class with response  : with parameter add window request");
                        activityLogService.addActivity(loggedInUser, "failed to save new window",
                                addWindowRequest.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Name cannot have spaces"),
                                HttpStatus.BAD_REQUEST);
                    }
                }
            } else {
                LOGGER.debug("Exiting  addObservationWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter add window request");
                activityLogService.addActivity(loggedInUser, "failed to save new window",
                        addWindowRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Name cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addWindowRequest.getMakerRemark() != null) {
                if (addWindowRequest.getMakerRemark().isEmpty()
                        || addWindowRequest.getMakerRemark().isBlank()) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to add window ");
                    LOGGER.debug("Exiting addObservationWindow Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : failed to add  window details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Maker remark cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                activityLogService.addActivity(loggedInUser,
                        "Failed to add window");
                LOGGER.debug("Exiting addObservationWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : failed to add window details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Maker remark cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addWindowRequest.getGroupByExpr() == null || addWindowRequest.getGroupByExpr().isNull()
                    || addWindowRequest.getGroupByExpr().isEmpty()) {
                LOGGER.debug("Exiting  addObservationWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter add window request");
                activityLogService.addActivity(loggedInUser, "failed to save new window",
                        addWindowRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Group by expression cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addWindowRequest.getSelectExpr() == null || addWindowRequest.getSelectExpr().isNull()
                    || addWindowRequest.getSelectExpr().isEmpty()) {
                LOGGER.debug("Exiting  addObservationWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter add window request");
                activityLogService.addActivity(loggedInUser, "failed to save new window",
                        addWindowRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Select expression cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addWindowRequest.getWhereExpr() == null || addWindowRequest.getWhereExpr().isNull()
                    || addWindowRequest.getWhereExpr().isEmpty()) {
                LOGGER.debug("Exiting  addObservationWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter add window request");
                activityLogService.addActivity(loggedInUser, "failed to save new window",
                        addWindowRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Where expression cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addWindowRequest.getWindowDuration() != null) {

                if (addWindowRequest.getWindowDuration().isBlank()
                        || addWindowRequest.getWindowDuration().isEmpty()) {
                    LOGGER.debug("Exiting  addObservationWindow Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : with parameter add window request");
                    activityLogService.addActivity(loggedInUser, "failed to save new window",
                            addWindowRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Window duration cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }

                try {
                    Duration d = Duration.parse(addWindowRequest.getWindowDuration());
                } catch (DateTimeParseException e) {
                    LOGGER.error("Exiting  addObservationWindow Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : with parameter add window request");
                    activityLogService.addActivity(loggedInUser, "failed to save new window",
                            addWindowRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Window duration is invalid,Please enter in ISO Temporal format"),
                            HttpStatus.BAD_REQUEST);
                }

            } else {
                LOGGER.debug("Exiting  addObservationWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter add window request");
                activityLogService.addActivity(loggedInUser, "failed to save new window",
                        addWindowRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Window duration cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addWindowRequest.getWindowId() == null || addWindowRequest.getWindowId() == 0) {
                LOGGER.debug("Exiting  addObservationWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter add window request");
                activityLogService.addActivity(loggedInUser, "failed to save new window",
                        addWindowRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Window id cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            ObservationWindows exist = null;

            try {
                exist = observationWindowsService.findByWId(addWindowRequest.getWindowId(), addWindowRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Exiting  addObservationWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter add window request");
                activityLogService.addActivity(loggedInUser, "failed to save new window",
                        addWindowRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            ObservationWindowsAudit existAudit = null;

            try {
                existAudit = observationWindowsAuditService.findbyWId(addWindowRequest.getWindowId(), addWindowRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (exist != null) {

                Integer maxId = null;

                try {
                    maxId = observationWindowsService.findMaxId();
                } catch (Exception e) {
                    LOGGER.error("Exiting  addObservationWindow Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : with parameter add window request");
                    activityLogService.addActivity(loggedInUser, "failed to save new window",
                            addWindowRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                LOGGER.debug("Exiting  addObservationWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter add window request");
                activityLogService.addActivity(loggedInUser, "failed to save new window",
                        addWindowRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Window Id already exists .Please enter a unique window id above "
                                        + maxId),
                        HttpStatus.CONFLICT);
            }

            if (existAudit != null) {

                Integer maxId = null;

                try {
                    maxId = observationWindowsService.findMaxId();
                } catch (Exception e) {
                    LOGGER.error("Exiting  addObservationWindow Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : with parameter add window request");
                    activityLogService.addActivity(loggedInUser, "failed to save new window",
                            addWindowRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                LOGGER.debug("Exiting  addObservationWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter add window request");
                activityLogService.addActivity(loggedInUser, "failed to save new window",
                        addWindowRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Window Id already exists in audit.Please enter a unique window id above "
                                        + maxId),
                        HttpStatus.CONFLICT);
            }

            ObservationWindows existName = null;

            try {
                existName = observationWindowsService.findByWidowName(addWindowRequest.getWindowName(), addWindowRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Exiting  addObservationWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter add window request");
                activityLogService.addActivity(loggedInUser, "failed to save new window",
                        addWindowRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (existName != null) {
                LOGGER.debug("Exiting  addObservationWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter add window request");
                activityLogService.addActivity(loggedInUser, "failed to save new window",
                        addWindowRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Window name already exists"),
                        HttpStatus.CONFLICT);
            }

            ObservationWindowsAudit existAuditName = null;

            try {
                existAuditName = observationWindowsAuditService
                        .findBywName(addWindowRequest.getWindowName(), addWindowRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Exiting  addObservationWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter add window request");
                activityLogService.addActivity(loggedInUser, "failed to save new window",
                        addWindowRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (existAuditName != null) {
                LOGGER.debug("Exiting  addObservationWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter add window request");
                activityLogService.addActivity(loggedInUser, "failed to save new window",
                        addWindowRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Window name already exists in audit"),
                        HttpStatus.CONFLICT);
            }

            ObservationWindowsAudit observationWindowsAudit = new ObservationWindowsAudit();
            observationWindowsAudit.setBclosed(false);
            observationWindowsAudit.setDtEntryDateTime(ZonedDateTime.now());
            observationWindowsAudit.setDtEntryStamp(ZonedDateTime.now());
            observationWindowsAudit.setGroupbyExperession(addWindowRequest.getGroupByExpr());
            observationWindowsAudit.setIEntryUserID(loggedInUser.getIuserID());
            observationWindowsAudit.setIorgId(loggedInUser.getIorgId());
            observationWindowsAudit.setIRecordStatus(0);
            observationWindowsAudit.setSelectExperession(addWindowRequest.getSelectExpr());
            observationWindowsAudit.setVcAction("A");
            observationWindowsAudit.setWhereExperession(addWindowRequest.getWhereExpr());
            observationWindowsAudit.setVcRemark(addWindowRequest.getMakerRemark());
            observationWindowsAudit.setWDuration(addWindowRequest.getWindowDuration());
            observationWindowsAudit.setWCount(addWindowRequest.getWindowCount());
            observationWindowsAudit.setWname(addWindowRequest.getWindowName());
            observationWindowsAudit.setWid(addWindowRequest.getWindowId());
            observationWindowsAudit.setWdesc(addWindowRequest.getWdesc());
            observationWindowsAudit.setItenantId(addWindowRequest.getItenantId());
            observationWindowsAudit.setIdexpr(addWindowRequest.getIdexpr());
            observationWindowsAudit.setTsexpr(addWindowRequest.getTsexpr());

            try {
                observationWindowsAudit = observationWindowsAuditService
                        .saveObservationWindowAudit(observationWindowsAudit);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            LOGGER.debug("Exiting addObservationWindow Method in " + WindowManagementServiceImpl.class
                    + " class with response  : with parameter add new decision");
            activityLogService.addActivity(loggedInUser, "RT Window addition sent for approval",
                    "Parameters : " + addWindowRequest.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(true, "RT Window addition sent for approval"),
                    HttpStatus.OK);

        } else {

            activityLogService.addActivity(loggedInUser,
                    "unauthorized to add RT windows");
            LOGGER.debug("Exiting getWindowDetails Method in " + WindowManagementServiceImpl.class
                    + " class with response  : unauthorized to add RT windows ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to add RT windows"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> editObservationWidow(AddWindowRequest addWindowRequest, Integer wId, Boolean audit,
                                                  Authentication pr) {
        LOGGER.debug("entered in class " + WindowManagementServiceImpl.class
                + " in method addObservationWindow");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isEdit() && loggedUser.allowTenants(Arrays.asList(addWindowRequest.getItenantId()))) {

            if (addWindowRequest.getWindowName() != null) {
                if (addWindowRequest.getWindowName().isEmpty()
                        || addWindowRequest.getWindowName().isBlank()) {
                    LOGGER.debug("Exiting  addObservationWindow Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : with parameter add window request");
                    activityLogService.addActivity(loggedInUser, "failed to save new window",
                            addWindowRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Name cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                } else {
                    if (addWindowRequest.getWindowName().length() > 101) {
                        LOGGER.debug("Exiting  addObservationWindow Method in "
                                + WindowManagementServiceImpl.class
                                + " class with response  : with parameter add window request");
                        activityLogService.addActivity(loggedInUser, "failed to save new window",
                                addWindowRequest.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Name cannot be more than 100 characters"),
                                HttpStatus.BAD_REQUEST);
                    }

                    Pattern pattern = Pattern.compile("\\s");
                    Matcher matcher = pattern.matcher(addWindowRequest.getWindowName());
                    if (matcher.find()) {
                        LOGGER.debug("Exiting  addObservationWindow Method in "
                                + WindowManagementServiceImpl.class
                                + " class with response  : with parameter add window request");
                        activityLogService.addActivity(loggedInUser, "failed to save new window",
                                addWindowRequest.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Name cannot have spaces"),
                                HttpStatus.BAD_REQUEST);
                    }
                }
            } else {
                LOGGER.debug("Exiting  addObservationWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter add window request");
                activityLogService.addActivity(loggedInUser, "failed to save new window",
                        addWindowRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Name cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addWindowRequest.getGroupByExpr() == null || addWindowRequest.getGroupByExpr().isNull()
                    || addWindowRequest.getGroupByExpr().isEmpty()) {
                LOGGER.debug("Exiting   editObservationWidow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter edit window request");
                activityLogService.addActivity(loggedInUser, "failed to edit window",
                        addWindowRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Group by expression cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addWindowRequest.getMakerRemark() != null) {
                if (addWindowRequest.getMakerRemark().isEmpty()
                        || addWindowRequest.getMakerRemark().isBlank()) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to edit window ");
                    LOGGER.debug("Exiting editObservationWidow Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : failed to edit  window details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Maker remark cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                activityLogService.addActivity(loggedInUser,
                        "Failed to edit window");
                LOGGER.debug("Exiting editObservationWidow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : failed to edit window details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Maker remark cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addWindowRequest.getSelectExpr() == null || addWindowRequest.getSelectExpr().isNull()
                    || addWindowRequest.getSelectExpr().isEmpty()) {
                LOGGER.debug("Exiting  editObservationWidow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter edit window request");
                activityLogService.addActivity(loggedInUser, "failed to edit window",
                        addWindowRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Select expression cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addWindowRequest.getWhereExpr() == null || addWindowRequest.getWhereExpr().isNull()
                    || addWindowRequest.getWhereExpr().isEmpty()) {
                LOGGER.debug("Exiting  editObservationWidow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter edit window request");
                activityLogService.addActivity(loggedInUser, "failed to edit window",
                        addWindowRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Where expression cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addWindowRequest.getWindowDuration() != null) {

                if (addWindowRequest.getWindowDuration().isBlank()
                        || addWindowRequest.getWindowDuration().isEmpty()) {
                    LOGGER.debug("Exiting   editObservationWidow Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : with parameter edit window request");
                    activityLogService.addActivity(loggedInUser, "failed to edit window",
                            addWindowRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Window duration cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }

                try {
                    Duration d = Duration.parse(addWindowRequest.getWindowDuration());
                } catch (DateTimeParseException e) {
                    LOGGER.error("Exiting  addObservationWindow Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : with parameter add window request");
                    activityLogService.addActivity(loggedInUser, "failed to save new window",
                            addWindowRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Window duration is invalid,Please enter in ISO Temporal format"),
                            HttpStatus.BAD_REQUEST);
                }

            } else {
                LOGGER.debug("Exiting  editObservationWidow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter edit window request");
                activityLogService.addActivity(loggedInUser, "failed to edit window",
                        addWindowRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Window duration cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (audit) {

                ObservationWindowsAudit observationWindowsAudit = null;
                try {
                    observationWindowsAudit = observationWindowsAuditService.findByWAuditId(wId, addWindowRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (observationWindowsAudit != null) {

                    if (observationWindowsAudit.getIEntryUserID() != loggedInUser
                            .getIuserID()) {
                        LOGGER.debug("Exiting  editObservationWidow Method in "
                                + WindowManagementServiceImpl.class
                                + " class with response  : with parameter edit window request");
                        activityLogService.addActivity(loggedInUser, "failed to edit window",
                                addWindowRequest.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Only maker can edit this entry"),
                                HttpStatus.BAD_REQUEST);
                    }

                    observationWindowsAudit.setDtEntryDateTime(ZonedDateTime.now());
                    observationWindowsAudit.setDtEntryStamp(ZonedDateTime.now());
                    observationWindowsAudit
                            .setGroupbyExperession(addWindowRequest.getGroupByExpr());
                    observationWindowsAudit.setSelectExperession(addWindowRequest.getSelectExpr());
                    observationWindowsAudit.setWhereExperession(addWindowRequest.getWhereExpr());
                    observationWindowsAudit.setVcRemark(addWindowRequest.getMakerRemark());
                    observationWindowsAudit.setWDuration(addWindowRequest.getWindowDuration());
                    if (observationWindowsAudit.getVcAction().equals("A")) {
                        observationWindowsAudit.setItenantId(addWindowRequest.getItenantId());
                    }
                    observationWindowsAudit.setWCount(addWindowRequest.getWindowCount());
                    observationWindowsAudit.setWname(addWindowRequest.getWindowName());
                    observationWindowsAudit.setVcRemark(addWindowRequest.getMakerRemark());
                    observationWindowsAudit.setWdesc(addWindowRequest.getWdesc());
                    observationWindowsAudit.setIdexpr(addWindowRequest.getIdexpr());
                    observationWindowsAudit.setTsexpr(addWindowRequest.getTsexpr());
                    try {
                        observationWindowsAudit = observationWindowsAuditService
                                .saveObservationWindowAudit(observationWindowsAudit);
                    } catch (Exception e) {
                        LOGGER.error(loggerEncoderUtil
                                .encode("Error : " + e + "\nParam : " + pr));
                        activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                                e.toString());
                        return new ResponseEntity<>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    LOGGER.debug("Exiting editObservationWidow Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : with parameter edit window request");
                    activityLogService.addActivity(loggedInUser, "RT Window edition sent for approval",
                            "Parameters : " + addWindowRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(true, "RT Window edition sent for approval"),
                            HttpStatus.OK);

                } else {
                    LOGGER.debug("Exiting  editObservationWidow Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : with parameter edit window request");
                    activityLogService.addActivity(loggedInUser, "failed to edit window",
                            addWindowRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "No window details found for id :" + wId),
                            HttpStatus.BAD_REQUEST);
                }
            } else {

                ObservationWindows observationWindows = null;

                ObservationWindowsAudit observationWindowsAudit = null;

                try {
                    observationWindowsAudit = observationWindowsAuditService.findbyWId(wId, addWindowRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                if (observationWindowsAudit != null) {
                    LOGGER.debug("Exiting  editObservationWidow Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : with parameter edit window request");
                    activityLogService.addActivity(loggedInUser, "failed to edit window",
                            addWindowRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Entry is already pending for an action"),
                            HttpStatus.BAD_REQUEST);
                }

                try {
                    observationWindows = observationWindowsService.findByWId(wId, addWindowRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (observationWindows != null) {
                    ObservationWindowsAudit observationWindowsAuditEdit = new ObservationWindowsAudit();
                    observationWindowsAuditEdit.setBclosed(false);
                    observationWindowsAuditEdit.setDtEntryDateTime(ZonedDateTime.now());
                    observationWindowsAuditEdit.setDtEntryStamp(ZonedDateTime.now());
                    observationWindowsAuditEdit
                            .setGroupbyExperession(addWindowRequest.getGroupByExpr());
                    observationWindowsAuditEdit.setIEntryUserID(loggedInUser.getIuserID());
                    observationWindowsAuditEdit.setIorgId(loggedInUser.getIorgId());
                    observationWindowsAuditEdit.setIRecordStatus(0);
                    observationWindowsAuditEdit
                            .setSelectExperession(addWindowRequest.getSelectExpr());
                    observationWindowsAuditEdit.setVcAction("M");
                    observationWindowsAuditEdit
                            .setWhereExperession(addWindowRequest.getWhereExpr());
                    observationWindowsAuditEdit.setVcRemark(addWindowRequest.getMakerRemark());
                    observationWindowsAuditEdit.setWDuration(addWindowRequest.getWindowDuration());
                    observationWindowsAuditEdit.setWCount(addWindowRequest.getWindowCount());
                    observationWindowsAuditEdit.setWname(addWindowRequest.getWindowName());
                    observationWindowsAuditEdit.setIRecordStatus(0);
                    observationWindowsAuditEdit.setVcRemark(addWindowRequest.getMakerRemark());
                    observationWindowsAuditEdit.setWid(observationWindows.getWid());
                    observationWindowsAuditEdit.setWdesc(observationWindows.getWdesc());
                    observationWindowsAuditEdit.setIdexpr(observationWindows.getIdexpr());
                    observationWindowsAuditEdit.setTsexpr(observationWindows.getTsexpr());
                    try {
                        observationWindowsAuditEdit = observationWindowsAuditService
                                .saveObservationWindowAudit(
                                        observationWindowsAuditEdit);
                    } catch (Exception e) {
                        LOGGER.error(loggerEncoderUtil
                                .encode("Error : " + e + "\nParam : " + pr));
                        activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                                e.toString());
                        return new ResponseEntity<>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    LOGGER.debug("Exiting editObservationWidow Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : with parameter edit window request");
                    activityLogService.addActivity(loggedInUser, "RT Window edition sent for approval",
                            "Parameters : " + addWindowRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(true, "RT Window edition sent for approval"),
                            HttpStatus.OK);
                } else {
                    LOGGER.debug("Exiting  editObservationWidow Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : with parameter edit window request");
                    activityLogService.addActivity(loggedInUser, "failed to edit window",
                            addWindowRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "No window details found for id :" + wId),
                            HttpStatus.BAD_REQUEST);
                }
            }
        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to edit RT windows");
            LOGGER.debug("Exiting editObservationWidow Method in " + WindowManagementServiceImpl.class
                    + " class with response  : unauthorized to edit Rt windows ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to edit RT windows"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> deleteObservationWindow(Integer wId, String remark, Integer tenantid, Authentication pr) {
        LOGGER.debug("entered in class " + WindowManagementServiceImpl.class
                + " in method deleteObservationWindow");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        if (mp.isDelete()) {

            if (remark != null) {
                if (remark.isBlank() || remark.isEmpty()) {
                    LOGGER.debug("Exiting  deleteObservationWindow Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : Invalid Maker remark format");
                    activityLogService.addActivity(loggedInUser, "failed to delete window",
                            wId.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Maker remark cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                LOGGER.debug("Exiting deleteObservationWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : Invalid Maker remark format");
                activityLogService.addActivity(loggedInUser, "failed to delete window",
                        wId.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Maker remark cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            Pattern pattern = Pattern.compile("^[a-zA-Z0-9 ,_@*#%'/\\\\&.-]+$");
            Matcher matcher = pattern.matcher(remark);

            if (!matcher.matches()) {
                LOGGER.debug("Exiting deleteObservationWindow Method in " + WindowManagementServiceImpl.class
                        + " class with response: Invalid Maker remark format");
                activityLogService.addActivity(loggedInUser, "failed to delete window due to invalid remark", remark);
                return new ResponseEntity<>(
                        new ApiResponse(false, "Maker remark can only contain alphabets, numbers, " +
                                "hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), " +
                                "percentage (%), single quotation ('), forward and backward slash (/ , \\), " +
                                "ampersand (&) and dot (.)"),
                        HttpStatus.BAD_REQUEST);
            }

            ObservationWindows observationWindows = null;

            List<ObservationsUi> observations = new ArrayList<>();

            try {
                observations = observationsUiService.findByWid(wId, tenantid);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }


            if (observations.size() > 0) {
                LOGGER.debug("Exiting  deleteObservationWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter edit window request");
                activityLogService.addActivity(loggedInUser, "failed to Delete window",
                        wId.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Window cannot be deleted,window is used by observations"),
                        HttpStatus.BAD_REQUEST);
            }

            try {
                observationWindows = observationWindowsService.findByWId(wId, tenantid);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (observationWindows != null) {
                ObservationWindowsAudit observationWindowsAuditEdit = new ObservationWindowsAudit();
                observationWindowsAuditEdit.setBclosed(false);
                observationWindowsAuditEdit.setDtEntryDateTime(ZonedDateTime.now());
                observationWindowsAuditEdit.setDtEntryStamp(ZonedDateTime.now());
                observationWindowsAuditEdit
                        .setGroupbyExperession(observationWindows.getGroupbyExperession());
                observationWindowsAuditEdit.setIEntryUserID(loggedInUser.getIuserID());
                observationWindowsAuditEdit.setIorgId(loggedInUser.getIorgId());
                observationWindowsAuditEdit
                        .setSelectExperession(observationWindows.getSelectExperession());
                observationWindowsAuditEdit.setVcAction("X");
                observationWindowsAuditEdit
                        .setWhereExperession(observationWindows.getWhereExperession());
                observationWindowsAuditEdit.setVcRemark(remark);
                observationWindowsAuditEdit.setWDuration(observationWindows.getWDuration());
                observationWindowsAuditEdit.setWCount(observationWindows.getWCount());
                observationWindowsAuditEdit.setWname(observationWindows.getWname());
                observationWindowsAuditEdit.setIRecordStatus(1);
                observationWindowsAuditEdit.setWid(observationWindows.getWid());
                observationWindowsAuditEdit.setWdesc(observationWindows.getWdesc());
                observationWindowsAuditEdit.setItenantId(observationWindows.getItenantId());
                observationWindowsAuditEdit.setIdexpr(observationWindows.getIdexpr());
                observationWindowsAuditEdit.setTsexpr(observationWindows.getTsexpr());

                try {
                    observationWindowsAuditEdit = observationWindowsAuditService
                            .saveObservationWindowAudit(observationWindowsAuditEdit);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                LOGGER.debug("Exiting deleteObservationWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter delete window request");
                activityLogService.addActivity(loggedInUser, "RT Window deletion sent for approval",
                        "Parameters : " + wId);
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(true, "RT Window deletion sent for approval"),
                        HttpStatus.OK);
            } else {
                LOGGER.debug("Exiting  deleteObservationWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter edit window request");
                activityLogService.addActivity(loggedInUser, "failed to Delete window",
                        wId.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "No window details found for id :" + wId),
                        HttpStatus.BAD_REQUEST);
            }
        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to delete RT windows");
            LOGGER.debug("Exiting editObservationWidow Method in " + WindowManagementServiceImpl.class
                    + " class with response  : unauthorized to delete RT windows ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to delete RT windows"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> getWindowDropDowns(Integer tenantid, Authentication pr) {
        LOGGER.debug("entered in class " + WindowManagementServiceImpl.class
                + " in method deleteObservationWindow");

        List<Integer> tenants = Arrays.asList(tenantid);
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        if (mp.isView()) {
            List<ObservationWindows> observationWindows = new ArrayList<>();

            try {
                observationWindows = observationWindowsService.findAllNonDeletedTenant(tenants);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            List<DropdownWithObject> dropDowns = new ArrayList<>();

            observationWindows.stream().map(c -> dropDowns.add(
                            DropdownWithObject.builder().value(c.getWid()).label(c.getWname()).build()))
                    .collect(Collectors.toList());
            LOGGER.debug("Exiting getWindowDropDowns Method in " + WindowManagementServiceImpl.class
                    + " class with response  : unauthorized to  get window dropdowms");
            activityLogService.addActivity(loggedInUser, "unauthorized to get window dropdowms");
            return ResponseEntity.ok(dropDowns);

        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to get window dropdowms");
            LOGGER.debug("Exiting getWindowDropDowns Method in " + WindowManagementServiceImpl.class
                    + " class with response  : unauthorized to  get window dropdowms");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to  get window dropdowms"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public ResponseEntity<?> approveWindow(Integer wAuditId, String remark, Boolean approve, Integer tenantId, Authentication pr) {
        LOGGER.debug("entered in class " + WindowManagementServiceImpl.class
                + " in method approveWindow");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        if (mp.isApprove()) {

            if (remark != null) {
                if (remark.isBlank() || remark.isEmpty()) {
                    LOGGER.debug("Exiting  approveWindow Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : with parameter approve window request");
                    activityLogService.addActivity(loggedInUser, "failed to approve window",
                            wAuditId.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Checker remark cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                LOGGER.debug("Exiting  approveWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter approve window request");
                activityLogService.addActivity(loggedInUser, "failed to approve window",
                        wAuditId.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Checker remark cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            Pattern pattern = Pattern.compile("^[a-zA-Z0-9 ,_@*#%'/\\\\&.-]+$");
            Matcher matcher = pattern.matcher(remark);

            if (!matcher.matches()) {
                LOGGER.debug("Exiting approveWindow Method in " + WindowManagementServiceImpl.class
                        + " class with response: Invalid Checker remark format");
                activityLogService.addActivity(loggedInUser, "failed to approve window due to invalid remark", remark);
                return new ResponseEntity<>(
                        new ApiResponse(false, "Checker remark can only contain alphabets, numbers, " +
                                "hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), " +
                                "percentage (%), single quotation ('), forward and backward slash (/ , \\), " +
                                "ampersand (&) and dot (.)"),
                        HttpStatus.BAD_REQUEST);
            }

            ObservationWindowsAudit observationWindowsAudit = null;

            try {
                observationWindowsAudit = observationWindowsAuditService.findByWAuditId(wAuditId, tenantId);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                        e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (observationWindowsAudit != null) {

                if (observationWindowsAudit.getIEntryUserID() == loggedInUser
                        .getIuserID()) {
                    LOGGER.debug("Exiting  approveWindow Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : with parameter approve window request");
                    activityLogService.addActivity(loggedInUser, "failed to approve window",
                            wAuditId.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Maker cannot be checker"),
                            HttpStatus.BAD_REQUEST);
                }

                observationWindowsAudit.setDtApproverStamp(ZonedDateTime.now());

                observationWindowsAudit.setIApproverUserID(loggedInUser.getIuserID());
                observationWindowsAudit.setIorgId(loggedInUser.getIorgId());
                observationWindowsAudit.setVcRemark("{ " + observationWindowsAudit.getVcRemark()
                        + " } " + " { " + remark + " } ");

                observationWindowsAudit.setBclosed(true);

                if (approve) {
                    if (observationWindowsAudit.getVcAction().equals("A")) {
                        observationWindowsAudit
                                .setIstatus(statusCodeService.findByIStatusId(2));
                    } else if (observationWindowsAudit.getVcAction().equals("M")) {
                        observationWindowsAudit
                                .setIstatus(statusCodeService.findByIStatusId(3));
                    } else {
                        observationWindowsAudit
                                .setIstatus(statusCodeService.findByIStatusId(4));
                    }

                    try {
                        observationWindowsAudit = observationWindowsAuditService
                                .saveObservationWindowAudit(observationWindowsAudit);
                    } catch (Exception e) {
                        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                        LOGGER.error(loggerEncoderUtil
                                .encode("Error : " + e + "\nParam : " + pr));
                        activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                                e.toString());
                        return new ResponseEntity<>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    ObservationWindows observationWindows = observationWindowsAudit
                            .parseAudit(observationWindowsAudit);
                    observationWindows.setLastStatus("Approved");
                    observationWindows.setLatestRemark(remark);
                    observationWindows.setDtApproverStamp(ZonedDateTime.now());

                    try {
                        observationWindows = observationWindowsService
                                .saveObservationWindows(observationWindows);
                    } catch (Exception e) {
                        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                        LOGGER.error(loggerEncoderUtil
                                .encode("Error : " + e + "\nParam : " + pr));
                        activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                                e.toString());
                        return new ResponseEntity<>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    if (observationWindowsAudit.getVcAction().equals("A")) {
                        AddWindowApiRequest addWindowApiRequest = AddWindowApiRequest
                                .parseTOAddWindowApiRequest(observationWindows);
                        ResponseEntity<String> addwindowApi = null;
                        try {
                            addwindowApi = windowApiService
                                    .addWindowApi(tenantRepositoryService.findAPIKeyTenant(observationWindowsAudit.getItenantId()), addWindowApiRequest);
                        } catch (Exception e) {
                            TransactionAspectSupport.currentTransactionStatus()
                                    .setRollbackOnly();
                            LOGGER.error(loggerEncoderUtil
                                    .encode("Error : " + e + "\nParam : " + pr));
                            activityLogService.addActivity(loggedInUser,
                                    "failed to get user and permissions",
                                    e.toString());
                            return new ResponseEntity<>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                        System.out.println(addwindowApi.getBody());

                        if (addwindowApi.getStatusCode() != HttpStatus.OK) {
                            TransactionAspectSupport.currentTransactionStatus()
                                    .setRollbackOnly();
                            LOGGER.error(loggerEncoderUtil
                                    .encode("Error : " + addWindowApiRequest));
                            activityLogService.addActivity(loggedInUser,
                                    "failed to approve window",
                                    addwindowApi.getBody());
                            return new ResponseEntity<>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                    } else {
                        ResponseEntity<String> res = null;
                        try {
                            res = windowApiService
                                    .deactivateWindow(tenantRepositoryService.findAPIKeyTenant(observationWindows.getItenantId()), observationWindows.getWid());
                        } catch (Exception e) {
                            TransactionAspectSupport.currentTransactionStatus()
                                    .setRollbackOnly();
                            LOGGER.error(loggerEncoderUtil
                                    .encode("Error : " + e + "\nParam : " + pr));
                            activityLogService.addActivity(loggedInUser,
                                    "failed to get user and permissions",
                                    e.toString());
                            return new ResponseEntity<>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }

                        System.out.println(res.getBody());

                        if (res.getStatusCode() != HttpStatus.OK) {
                            TransactionAspectSupport.currentTransactionStatus()
                                    .setRollbackOnly();
                            LOGGER.error("Error : " + (res.getBody() == null ? "Body is null"
                                    : loggerEncoderUtil.encode(res.getBody())));
                            activityLogService.addActivity(loggedInUser,
                                    "failed to approve window",
                                    res.getBody());
                            return new ResponseEntity<>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }

                    }

                    String resMessag = "";

                    if (observationWindowsAudit.getVcAction().equals("A")) {
                        resMessag = "RT Window addition approved successfully";
                    } else if (observationWindowsAudit.getVcAction().equals("M")) {
                        resMessag = "RT Window edition approved successfully";
                    } else {
                        resMessag = "RT Window deletion approved successfully";
                    }
                    System.out.println(resMessag);

                    LOGGER.debug("Exiting  approveWindow Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : with parameter approve window request");
                    activityLogService.addActivity(loggedInUser, "failed to approve window",
                            wAuditId.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(true, resMessag),
                            HttpStatus.ACCEPTED);

                } else {
                    observationWindowsAudit.setIstatus(statusCodeService.findByIStatusId(5));
                    try {
                        observationWindowsAudit = observationWindowsAuditService
                                .saveObservationWindowAudit(observationWindowsAudit);
                    } catch (Exception e) {
                        TransactionAspectSupport.currentTransactionStatus()
                                .setRollbackOnly();
                        LOGGER.error(loggerEncoderUtil
                                .encode("Error : " + e + "\nParam : " + pr));
                        activityLogService.addActivity(loggedInUser,
                                "failed to get user and permissions",
                                e.toString());
                        return new ResponseEntity<>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    if (!observationWindowsAudit.getVcAction().equals("A")) {
                        ObservationWindows observationWindows = null;

                        try {
                            observationWindows = observationWindowsService.findByWId(observationWindowsAudit.getWid(), observationWindowsAudit.getItenantId());
                        } catch (Exception e) {
                            TransactionAspectSupport.currentTransactionStatus()
                                    .setRollbackOnly();
                            LOGGER.error(loggerEncoderUtil
                                    .encode("Error : " + e + "\nParam : " + pr));
                            activityLogService.addActivity(loggedInUser,
                                    "failed to get user and permissions",
                                    e.toString());
                            return new ResponseEntity<>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }

                        observationWindows.setLastStatus("Rejected");
                        observationWindows.setLatestRemark(remark);
                        observationWindows.setDtApproverStamp(ZonedDateTime.now());

                        try {
                            observationWindows = observationWindowsService
                                    .saveObservationWindows(observationWindows);
                        } catch (Exception e) {
                            TransactionAspectSupport.currentTransactionStatus()
                                    .setRollbackOnly();
                            LOGGER.error(loggerEncoderUtil
                                    .encode("Error : " + e + "\nParam : " + pr));
                            activityLogService.addActivity(loggedInUser,
                                    "failed to get user and permissions",
                                    e.toString());
                            return new ResponseEntity<>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                    }

                    String resMessag = "";

                    if (observationWindowsAudit.getVcAction().equals("A")) {
                        resMessag = "RT Window addition rejected successfully";
                    } else if (observationWindowsAudit.getVcAction().equals("M")) {
                        resMessag = "RT Window edition rejected successfully";
                    } else {
                        resMessag = "RT Window deletion rejected successfully";
                    }

                    LOGGER.debug("Exiting  approveWindow Method in "
                            + WindowManagementServiceImpl.class
                            + " class with response  : with parameter approve window request");
                    activityLogService.addActivity(loggedInUser, "failed to reject window",
                            wAuditId.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(true, resMessag),
                            HttpStatus.ACCEPTED);
                }

            } else {
                LOGGER.debug("Exiting  approveWindow Method in "
                        + WindowManagementServiceImpl.class
                        + " class with response  : with parameter approve window request");
                activityLogService.addActivity(loggedInUser, "failed to approve window",
                        wAuditId.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "No window details found for id :" + wAuditId),
                        HttpStatus.BAD_REQUEST);
            }
        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to approve window");
            LOGGER.debug("Exiting getWindowDropDowns Method in " + WindowManagementServiceImpl.class
                    + " class with response  : unauthorized to  approve window");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to approve window"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> autoSuggestId(Authentication pr) {
        LOGGER.debug("entered in class " + WindowManagementServiceImpl.class + " in method autoSuggestIds");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        if (mp.isAdd()) {

            Integer maxId = null;
            Integer maxAuditId = null;

            try {
                maxId = observationWindowsService.findMaxId();
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get max id", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            try {
                maxAuditId = observationWindowsAuditService.findMaxId();
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get max id", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);

            }

            if (maxAuditId != null) {
                if (maxId > maxAuditId) {
                    return ResponseEntity.ok(maxId + 1);
                } else if (maxId < maxAuditId) {
                    return ResponseEntity.ok(maxAuditId + 1);
                } else {
                    return ResponseEntity.ok(maxId + 1);
                }
            } else {
                return ResponseEntity.ok(maxId + 1);
            }

        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to add RT windows");
            LOGGER.debug("Exiting getWindowDetails Method in " + WindowManagementServiceImpl.class
                    + " class with response  : unauthorized to add RT windows ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to add RT windows"),
                    HttpStatus.FORBIDDEN);
        }
    }
}
