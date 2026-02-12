package com.DronaPay.UIServer.service.ControllerService.Observation;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.model.ObservationUiAudit;
import com.DronaPay.UIServer.model.ObservationWindows;
import com.DronaPay.UIServer.model.ObservationsUi;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.requests.AddObservationApiRequest;
import com.DronaPay.UIServer.requests.AddObsservationRequest;
import com.DronaPay.UIServer.response.*;
import com.DronaPay.UIServer.service.ApiServices.ObservationApiService;
import com.DronaPay.UIServer.service.ControllerService.WindowManagement.WindowManagementServiceImpl;
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
import java.util.List;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class ObservationControllerServiceImpl implements ObservationControllerService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ObservationControllerServiceImpl.class);
    final String menu_name = MenuNames.Observation;
    @Autowired
    private ActivityLogService activityLogService;
    @Autowired
    private WebUserService webUserService;
    @Autowired
    private StatusCodeService statusCodeService;
    @Autowired
    private ObservationsUiService observationUiService;
    @Autowired
    private ObservationUiAuditService observationUiAuditService;
    @Autowired
    private ObservationWindowsService observationWindowsService;
    @Autowired
    private TenantRepositoryService tenantRepositoryService;
    @Autowired
    private ObservationApiService observationApiService;
    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;


    @Override
    public ResponseEntity<?> findListOfObservation(Authentication pr) {
        LOGGER.debug("entered in class " + ObservationControllerServiceImpl.class
                + " in method findListOfObservation");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        ObservationsListView observationsListView = new ObservationsListView();
        observationsListView.setAdd(mp.isAdd());
        observationsListView.setApprove(mp.isApprove());
        observationsListView.setDelete(mp.isDelete());
        observationsListView.setEdit(mp.isEdit());
        observationsListView.setView(mp.isView());
        observationsListView.setPublish(mp.isPublish());

        if (mp.isView()) {
            List<ObservationsUi> observationsList = new ArrayList<>();
            List<ObservationUiAudit> observationUiAudits = new ArrayList<>();
            List<ObservationResponse> response = new ArrayList<>();
            try {
                observationsList = observationUiService.findAllNonDeletedTenants(loggedUser.getUserTenant());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to find all non deleted entries", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            try {
                observationUiAudits = observationUiAuditService.findAllPendingEntriesTenant(loggedUser.getUserTenant());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to find all pending entries", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            for (int i = 0; i < observationsList.size(); i++) {
                response.add(ObservationResponse.builder().auditEntry(false).auditExist(false)
                        .lastStatus(observationsList.get(i).getLastStatus())
                        .lastUpdate(observationsList.get(i).getDtApproverStamp())
                        .latestRemark(observationsList.get(i).getLatestRemark())
                        .itenantId(observationsList.get(i).getItenantId())
                        .tenantName(tenantRepositoryService.findByItenantId(observationsList.get(i).getItenantId()).getTenantName())
                        .makerChecker("M")
                        .observationCount(observationsList.get(i).getOCount())
                        .observationDuration(observationsList.get(i).getODuration())
                        .observationName(observationsList.get(i).getOname())
                        .oId(observationsList.get(i).getOid())
                        .aggregationType(observationsList.get(i).getAggregationType())
                        .wId(observationsList.get(i).getWid())
                        .wdesc(null)
                        .build());
            }

            for (int h = 0; h < response.size(); h++) {
                for (int k = 0; k < observationUiAudits.size(); k++) {

                    if (response.get(h).getOId().equals(observationUiAudits.get(k).getOid())) {
                        response.get(h).setAuditExist(true);
                    }

                }
            }

            for (int f = 0; f < observationUiAudits.size(); f++) {
                response.add(
                        ObservationResponse.builder()
                                .action(observationUiAudits.get(f).getVcAction())
                                .auditEntry(true)
                                .auditExist(false).lastStatus("Pending")
                                .lastUpdate(observationUiAudits.get(f)
                                        .getDtEntryStamp())
                                .latestRemark(observationUiAudits.get(f).getVcRemark())
                                .makerChecker(observationUiAudits.get(f)
                                        .getIEntryUserID()
                                        == loggedInUser
                                        .getIuserID() ? "M"
                                        : "C")
                                .observationCount(
                                        observationUiAudits.get(f).getOCount())
                                .observationDuration(observationUiAudits.get(f)
                                        .getODuration())
                                .observationName(observationUiAudits.get(f).getOname())
                                .oId(observationUiAudits.get(f).getOid() != null
                                        ? observationUiAudits.get(f).getOid()

                                        : null)
                                .oAuditId(observationUiAudits.get(f).getOauditId())
                                .aggregationType(observationUiAudits.get(f)
                                        .getAggregationType())
                                .itenantId(observationUiAudits.get(f).getItenantId())
                                .tenantName(tenantRepositoryService.findByItenantId(observationUiAudits.get(f).getItenantId()).getTenantName())
                                .wId(observationUiAudits.get(f).getWId())
                                .wdesc(null)
                                .build());
            }

            observationsListView.setObservationsList(response);
            LOGGER.debug("Exiting findListOfObservation Method in "
                    + ObservationControllerServiceImpl.class
                    + " class with response  : with parameters list of observations");
            activityLogService.addActivity(loggedInUser, "List of RT Observations accessed");
            return ResponseEntity.ok(observationsListView);

        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access RT observation list");
            LOGGER.debug("Exiting findListOfObservation Method in " + ObservationControllerServiceImpl.class
                    + " class with response  : unauthorized to access list of Observations");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access list of Observations"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> findObservationsById(Integer oId, Integer wid, Boolean audit, Integer tenantid, Authentication pr) {
        LOGGER.debug("entered in class " + ObservationControllerServiceImpl.class
                + " in method findObservationsById");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        if (mp.isView()) {

            if (audit == false) {
                ObservationsUi observationsUi = null;
                try {
                    observationsUi = observationUiService.findByObservationId(oId, wid, tenantid);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to find RT observation by id",
                            e.toString());
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                if (observationsUi != null) {

                    ObservationDetailResponse observationDetailResponse = ObservationDetailResponse
                            .builder()
                            .aggregationType(observationsUi.getAggregationType())
                            .id(observationsUi.getOid())
                            .observationCount(observationsUi.getOCount())
                            .observationDuration(observationsUi.getODuration())
                            .observationName(observationsUi.getOname())
                            .remark(observationsUi.getLatestRemark())
                            .wExpr(observationsUi.getWExperession())
                            .wId(observationsUi.getWid())
                            .orgId(observationsUi.getOid())
                            .whereExpr(observationsUi.getWhereExperession())
                            .wdesc(null)
                            .odesc(observationsUi.getOdesc())
                            .itenantId(observationsUi.getItenantId())
                            .tenantName(tenantRepositoryService.findByItenantId(observationsUi.getItenantId()).getTenantName())
                            .build();
                    LOGGER.debug("Exiting findObservationsById Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : with parameters RT Observation details");
                    activityLogService.addActivity(loggedInUser, "Observation details accessed");
                    return ResponseEntity.ok(observationDetailResponse);
                } else {
                    LOGGER.debug("Exiting findObservationsById Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : with parameters RT Observation details");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to access RT Observation details");
                    return new ResponseEntity<>(new ApiResponse(false, "No RT observations found"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                ObservationUiAudit observationUiAudit = null;

                try {
                    observationUiAudit = observationUiAuditService.findByObservationUiAduitId(oId, tenantid);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to find RT observation audit entry by id",
                            e.toString());
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (observationUiAudit != null) {
                    ObservationDetailResponse observationDetailResponse = ObservationDetailResponse
                            .builder()
                            .aggregationType(observationUiAudit.getAggregationType())
                            .id(observationUiAudit.getOauditId())
                            .observationCount(observationUiAudit.getOCount())
                            .observationDuration(observationUiAudit.getODuration())
                            .observationName(observationUiAudit.getOname())
                            .remark(observationUiAudit.getVcRemark())
                            .wExpr(observationUiAudit.getWExperession())
                            .wId(observationUiAudit.getWId())
                            .orgId(observationUiAudit.getOid())
                            .whereExpr(observationUiAudit.getWhereExperession())
                            .odesc(observationUiAudit.getOdesc())
                            .itenantId(observationUiAudit.getItenantId())
                            .tenantName(tenantRepositoryService.findByItenantId(observationUiAudit.getItenantId()).getTenantName())
                            .build();
                    LOGGER.debug("Exiting findObservationsById Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : with parameters RT Observation details");
                    activityLogService.addActivity(loggedInUser, "Observation details accessed");
                    return ResponseEntity.ok(observationDetailResponse);
                } else {
                    LOGGER.debug("Exiting findObservationsById Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : with parameters RT Observation details");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to access RT Observation details");
                    return new ResponseEntity<>(new ApiResponse(false, "No RT observations found"),
                            HttpStatus.BAD_REQUEST);
                }
            }

        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access RT observation ");
            LOGGER.debug("Exiting findObservationsById Method in " + ObservationControllerServiceImpl.class
                    + " class with response  : unauthorized to access RT Observation details");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access RT Observations details"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> addObservation(AddObsservationRequest addObsservationRequest, Authentication pr) {
        LOGGER.debug("entered in class " + ObservationControllerServiceImpl.class
                + " in method addObservation");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isAdd()) {

            if (addObsservationRequest.getObservationId() == null
                    || addObsservationRequest.getObservationId() == 0) {
                activityLogService.addActivity(loggedInUser,
                        "Failed to add RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to add RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Observation id cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addObsservationRequest.getAggregationType() != null) {
                if (addObsservationRequest.getAggregationType().isBlank()
                        || addObsservationRequest.getAggregationType().isEmpty()) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to add RT observation ");
                    LOGGER.debug("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to add RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Aggregation type cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                activityLogService.addActivity(loggedInUser,
                        "Failed to add RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to add RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Aggregation type cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addObsservationRequest.getMakerRemark() != null) {
                if (addObsservationRequest.getMakerRemark().isEmpty()
                        || addObsservationRequest.getMakerRemark().isBlank()) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to add RT observation ");
                    LOGGER.debug("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to add RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Maker remark cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                activityLogService.addActivity(loggedInUser,
                        "Failed to add RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to add RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Maker remark cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addObsservationRequest.getObservationDuration() != null) {
                if (addObsservationRequest.getObservationDuration().isEmpty()
                        || addObsservationRequest.getObservationDuration().isBlank()) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to add RT observation ");
                    LOGGER.debug("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to add RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Observation duration cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }

                try {

                    Duration d = Duration.parse(addObsservationRequest.getObservationDuration());
                } catch (DateTimeParseException e) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to add RT observation ");
                    LOGGER.error("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to add RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Observation duration is invalid,Please enter in ISO Temporal format"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                activityLogService.addActivity(loggedInUser,
                        "Failed to add RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to add RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Observation duration cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addObsservationRequest.getObservationName() != null) {
                if (addObsservationRequest.getObservationName().isBlank()
                        || addObsservationRequest.getObservationName().isEmpty()) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to add RT observation ");
                    LOGGER.debug("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to add RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Observation name cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }

                if (addObsservationRequest.getObservationName().length() > 101) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to add RT observation ");
                    LOGGER.debug("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to add RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Observation name cannot be more than 100 characters"),
                            HttpStatus.BAD_REQUEST);
                }

                Pattern pattern = Pattern.compile("\\s");
                Matcher matcher = pattern.matcher(addObsservationRequest.getObservationName());
                if (matcher.find()) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to add RT observation ");
                    LOGGER.debug("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to add RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Observation name cannot have spaces"),
                            HttpStatus.BAD_REQUEST);
                }

                try {
                    Optional<ObservationsUi> existingObservation = observationUiService.findByOnameAndItenantId(
                            addObsservationRequest.getObservationName(), addObsservationRequest.getItenantId());

                    if (existingObservation.isPresent()) {
                        activityLogService.addActivity(loggedInUser, "Failed to add RT observation - duplicate name for tenant");
                        LOGGER.debug("Exiting addObservation Method in " + ObservationControllerServiceImpl.class
                                + " class with response: failed to add RT Observation details - duplicate name for tenant");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, "Observation name already exists for the tenant"),
                                HttpStatus.CONFLICT);
                    }


                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to add RT observation", e.toString());
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }


            } else {
                activityLogService.addActivity(loggedInUser,
                        "Failed to add RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to add RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Observation name cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addObsservationRequest.getWgExpr() == null || addObsservationRequest.getWgExpr().isNull()
                    || addObsservationRequest.getWgExpr().isEmpty()) {
                activityLogService.addActivity(loggedInUser,
                        "Failed to add RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to add RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Groupby expression cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            ObservationWindows observationWindows = null;

            if (addObsservationRequest.getWindowId() != null) {
                try {
                    observationWindows = observationWindowsService
                            .findByWId(addObsservationRequest.getWindowId(), addObsservationRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to add observation", e.toString());
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (observationWindows == null) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to add RT observation ");
                    LOGGER.debug("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to add RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "No window is found for id : "
                                    + addObsservationRequest.getWindowId()),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                activityLogService.addActivity(loggedInUser,
                        "Failed to add RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to add RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Window id cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addObsservationRequest.getAggregationType().equals("COUNT_IF")
                    || addObsservationRequest.getAggregationType().equals("SUM_IF")) {
                if (addObsservationRequest.getWhereExpr() == null
                        || addObsservationRequest.getWhereExpr().isNull()
                        || addObsservationRequest.getWhereExpr().isEmpty()) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to add RT observation ");
                    LOGGER.debug("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to add RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Where expression cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            }

            if (addObsservationRequest.getMakerRemark() != null) {
                if (addObsservationRequest.getMakerRemark().isEmpty()
                        || addObsservationRequest.getMakerRemark().isBlank()) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to add RT observation ");
                    LOGGER.debug("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to add RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Maker remark cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                activityLogService.addActivity(loggedInUser,
                        "Failed to add RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to add RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Maker remark cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addObsservationRequest.getObservationId() == null
                    || addObsservationRequest.getObservationId() == 0) {
                activityLogService.addActivity(loggedInUser,
                        "Failed to add RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to add RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Observation id cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            ObservationsUi exist = null;

            try {
                exist = observationUiService
                        .findByObservationId(addObsservationRequest.getObservationId(), addObsservationRequest.getWindowId(), addObsservationRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to RT observation", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (exist != null) {

                Integer maxId = null;

                try {
                    maxId = observationUiService.findMaxId();
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to RT observation", e.toString());
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                activityLogService.addActivity(loggedInUser,
                        "Failed to add RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to add RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Observation id already exists.Please enter unique id above "
                                        + maxId),
                        HttpStatus.CONFLICT);
            }

            ObservationUiAudit existAudit = null;

            try {
                existAudit = observationUiAuditService
                        .findByOId(addObsservationRequest.getObservationId(), addObsservationRequest.getWindowId(), addObsservationRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to RT observation", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (existAudit != null) {
                activityLogService.addActivity(loggedInUser,
                        "Failed to add RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to add RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Observation id already exists in audit.Please enter unique id above "
                                        + addObsservationRequest.getObservationId()),
                        HttpStatus.CONFLICT);
            }


            Optional<ObservationsUi> existName = Optional.empty();

            try {
                existName = observationUiService
                        .findByOnameAndItenantId(addObsservationRequest.getObservationName(),addObsservationRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to RT observation", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (existName.isPresent()) {
                activityLogService.addActivity(loggedInUser,
                        "Failed to add RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to add RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Observation name already exists for same tenant"),
                        HttpStatus.CONFLICT);
            }

            ObservationUiAudit existAuditName = null;

            try {
                existAuditName = observationUiAuditService
                        .findByOnameAndItenantId(addObsservationRequest.getObservationName(),addObsservationRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to RT observation", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (existAuditName != null) {
                activityLogService.addActivity(loggedInUser,
                        "Failed to add RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to add RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Observation name already exists in audit"),
                        HttpStatus.CONFLICT);
            }

            ObservationUiAudit observationUiAudit = new ObservationUiAudit();
            observationUiAudit.setAggregationType(addObsservationRequest.getAggregationType());
            observationUiAudit.setBclosed(false);
            observationUiAudit.setDtEntryDateTime(ZonedDateTime.now());
            observationUiAudit.setDtEntryStamp(ZonedDateTime.now());
            observationUiAudit.setIEntryUserID(loggedInUser.getIuserID());
            observationUiAudit.setIorgId(loggedInUser.getIorgId());
            observationUiAudit.setIRecordStatus(0);
            observationUiAudit.setOCount(addObsservationRequest.getObservationCount());
            observationUiAudit.setODuration(addObsservationRequest.getObservationDuration());
            observationUiAudit.setOname(addObsservationRequest.getObservationName());
            observationUiAudit.setVcAction("A");
            observationUiAudit.setVcRemark(addObsservationRequest.getMakerRemark());
            observationUiAudit.setAggregationType(addObsservationRequest.getAggregationType());
            observationUiAudit.setWExperession(addObsservationRequest.getWgExpr());
            observationUiAudit.setWhereExperession(addObsservationRequest.getWhereExpr());
            observationUiAudit.setWId(observationWindows.getWid());
            observationUiAudit.setOid(addObsservationRequest.getObservationId());
            observationUiAudit.setOdesc(addObsservationRequest.getOdesc());
            observationUiAudit.setItenantId(addObsservationRequest.getItenantId());

            try {
                observationUiAudit = observationUiAuditService
                        .saveObservationUiAudit(observationUiAudit);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to add RT observation", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (observationUiAudit != null) {

                activityLogService.addActivity(loggedInUser,
                        "RT Observation added successfully");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : RT Observation addition sent for approval");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(true, "RT Observation addition sent for approval"),
                        HttpStatus.ACCEPTED);
            } else {
                activityLogService.addActivity(loggedInUser,
                        "Failed to add RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to add RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Failed to add RT observation"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to add RT observation ");
            LOGGER.debug("Exiting addObservation Method in " + ObservationControllerServiceImpl.class
                    + " class with response  : unauthorized to add RT Observation details");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to add RT Observations details"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> editObservation(AddObsservationRequest addObsservationRequest, Integer oId,
                                             Boolean audit,
                                             Authentication pr) {
        LOGGER.debug("entered in class " + ObservationControllerServiceImpl.class
                + " in method editObservation");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isEdit()) {
            if (addObsservationRequest.getAggregationType() != null) {
                if (addObsservationRequest.getAggregationType().isBlank()
                        || addObsservationRequest.getAggregationType().isEmpty()) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to edit RT observation ");
                    LOGGER.debug("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to edit RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Aggregation type cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                activityLogService.addActivity(loggedInUser,
                        "Failed to edit RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to edit RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Aggregation type cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addObsservationRequest.getMakerRemark() != null) {
                if (addObsservationRequest.getMakerRemark().isEmpty()
                        || addObsservationRequest.getMakerRemark().isBlank()) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to edit RT observation ");
                    LOGGER.debug("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to edit RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Maker remark cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                activityLogService.addActivity(loggedInUser,
                        "Failed to edit RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to edit RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Maker remark cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addObsservationRequest.getObservationDuration() != null) {
                if (addObsservationRequest.getObservationDuration().isEmpty()
                        || addObsservationRequest.getObservationDuration().isBlank()) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to edit RT observation ");
                    LOGGER.debug("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to edit RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Observation duration cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }

                try {

                    Duration d = Duration.parse(addObsservationRequest.getObservationDuration());
                } catch (DateTimeParseException e) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to add RT observation ");
                    LOGGER.error("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to add RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Observation duration is invalid,Please enter in ISO Temporal format"),
                            HttpStatus.BAD_REQUEST);
                }

            } else {
                activityLogService.addActivity(loggedInUser,
                        "Failed to edit RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to edit RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Observation duration cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addObsservationRequest.getObservationName() != null) {
                if (addObsservationRequest.getObservationName().isBlank()
                        || addObsservationRequest.getObservationName().isEmpty()) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to edit RT observation ");
                    LOGGER.debug("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to edit RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Observation name cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }

                if (addObsservationRequest.getObservationName().length() > 101) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to add RT observation ");
                    LOGGER.debug("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to add RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Observation name cannot be more than 100 characters"),
                            HttpStatus.BAD_REQUEST);
                }

                Pattern pattern = Pattern.compile("\\s");
                Matcher matcher = pattern.matcher(addObsservationRequest.getObservationName());
                if (matcher.find()) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to add RT observation ");
                    LOGGER.debug("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to add RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Observation name cannot have spaces"),
                            HttpStatus.BAD_REQUEST);
                }

            } else {
                activityLogService.addActivity(loggedInUser,
                        "Failed to edit RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to edit RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Observation name cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addObsservationRequest.getWgExpr() == null || addObsservationRequest.getWgExpr().isNull()
                    || addObsservationRequest.getWgExpr().isEmpty()) {
                activityLogService.addActivity(loggedInUser,
                        "Failed to edit RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to edit RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Groupby expression cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            ObservationWindows observationWindows = null;

            if (addObsservationRequest.getWindowId() != null) {
                try {
                    observationWindows = observationWindowsService
                            .findByWId(addObsservationRequest.getWindowId(), addObsservationRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to add RT observation", e.toString());
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (observationWindows == null) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to edit RT observation ");
                    LOGGER.debug("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to edit RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "No window is found for id : "
                                    + addObsservationRequest.getWindowId()),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                activityLogService.addActivity(loggedInUser,
                        "Failed to edit RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to edit RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Window id cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }
            if (addObsservationRequest.getAggregationType().equals("COUNT_IF")
                    || addObsservationRequest.getAggregationType().equals("SUM_IF")) {
                if (addObsservationRequest.getWhereExpr() == null
                        || addObsservationRequest.getWhereExpr().isNull()
                        || addObsservationRequest.getWhereExpr().isEmpty()) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to edit RT observation ");
                    LOGGER.debug("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to edit RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Where expression cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            }

            if (addObsservationRequest.getMakerRemark() != null) {
                if (addObsservationRequest.getMakerRemark().isEmpty()
                        || addObsservationRequest.getMakerRemark().isBlank()) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to edit RT observation ");
                    LOGGER.debug("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to edit RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Maker remark cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                activityLogService.addActivity(loggedInUser,
                        "Failed to edit RT observation ");
                LOGGER.debug("Exiting addObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to edit RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Maker remark cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            try {
                Optional<ObservationsUi> existingObservation = observationUiService.findByOnameAndItenantId(
                        addObsservationRequest.getObservationName(), addObsservationRequest.getItenantId());

                if (existingObservation.isPresent()) {
                    activityLogService.addActivity(loggedInUser, "Failed to add RT observation - duplicate name for tenant");
                    LOGGER.debug("Exiting addObservation Method in " + ObservationControllerServiceImpl.class
                            + " class with response: failed to add RT Observation details - duplicate name for tenant");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Observation name already exists for the tenant"),
                            HttpStatus.CONFLICT);
                }


            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to add RT observation", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (audit) {
                ObservationUiAudit observationUiAudit = null;

                try {
                    observationUiAudit = observationUiAuditService.findByObservationUiAduitId(oId, addObsservationRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to edit RT observation details",
                            e.toString());
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (observationUiAudit != null) {

                    if (observationUiAudit.getIEntryUserID() != loggedInUser
                            .getIuserID()) {
                        activityLogService.addActivity(loggedInUser,
                                "Failed to edit RT observation ");
                        LOGGER.debug("Exiting addObservation Method in "
                                + ObservationControllerServiceImpl.class
                                + " class with response  : failed to edit RT Observation details");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Only maker can edit this entry"),
                                HttpStatus.BAD_REQUEST);
                    }

                    observationUiAudit.setAggregationType(
                            addObsservationRequest.getAggregationType());
                    observationUiAudit.setDtEntryStamp(ZonedDateTime.now());
                    observationUiAudit.setOCount(addObsservationRequest.getObservationCount());
                    observationUiAudit
                            .setODuration(addObsservationRequest.getObservationDuration());
                    observationUiAudit.setOname(addObsservationRequest.getObservationName());
                    observationUiAudit.setVcRemark(addObsservationRequest.getMakerRemark());
                    observationUiAudit.setAggregationType(
                            addObsservationRequest.getAggregationType());
                    observationUiAudit.setWExperession(addObsservationRequest.getWgExpr());
                    observationUiAudit.setWhereExperession(addObsservationRequest.getWhereExpr());
                    observationUiAudit.setWId(observationWindows.getWid());
                    observationUiAudit.setItenantId(addObsservationRequest.getItenantId());
                    //     if(observationUiAudit.getVcAction().equals("A")) {
                    //         observationUiAudit.setItenantId(tenantRepositoryService.findByItenantId(addObsservationRequest.getItenantId()));
                    //     }

                    try {
                        observationUiAudit = observationUiAuditService
                                .saveObservationUiAudit(observationUiAudit);
                    } catch (Exception e) {
                        LOGGER.error(loggerEncoderUtil
                                .encode("Error : " + e + "\nParam : " + pr));
                        activityLogService.addActivity(loggedInUser, "failed to edit RT observation details",
                                e.toString());
                        return new ResponseEntity<>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    if (observationUiAudit != null) {

                        activityLogService.addActivity(loggedInUser,
                                "RT Observation edited successfully");
                        LOGGER.debug("Exiting editObservation Method in "
                                + ObservationControllerServiceImpl.class
                                + " class with response  : RT Observation edition sent for approval");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(true,
                                        "RT Observation edition sent for approval"),
                                HttpStatus.ACCEPTED);
                    } else {
                        activityLogService.addActivity(loggedInUser,
                                "Failed to add RT observation ");
                        LOGGER.debug("Exiting editObservation Method in "
                                + ObservationControllerServiceImpl.class
                                + " class with response  : failed to edit RT Observation details");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, "Failed to edit RT observation"),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                } else {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to edit RT observation ");
                    LOGGER.debug("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to edit RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "No Observatio found for id :" + oId),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                ObservationUiAudit obs = null;

                try {
                    obs = observationUiAuditService.findByOId(oId, addObsservationRequest.getWindowId(), addObsservationRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to edit RT observation details",
                            e.toString());
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (obs != null) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to edit RT observation ");
                    LOGGER.debug("Exiting addObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to edit RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Entry is already pending for action"),
                            HttpStatus.BAD_REQUEST);
                }

                ObservationUiAudit observationUiAudit = new ObservationUiAudit();
                observationUiAudit.setAggregationType(addObsservationRequest.getAggregationType());
                observationUiAudit.setBclosed(false);
                observationUiAudit.setDtEntryDateTime(ZonedDateTime.now());
                observationUiAudit.setDtEntryStamp(ZonedDateTime.now());
                observationUiAudit.setIEntryUserID(loggedInUser.getIuserID());
                observationUiAudit.setIorgId(loggedInUser.getIorgId());
                observationUiAudit.setIRecordStatus(0);
                observationUiAudit.setOCount(addObsservationRequest.getObservationCount());
                observationUiAudit.setODuration(addObsservationRequest.getObservationDuration());
                observationUiAudit.setOname(addObsservationRequest.getObservationName());
                observationUiAudit.setVcAction("M");
                observationUiAudit.setVcRemark(addObsservationRequest.getMakerRemark());
                observationUiAudit.setAggregationType(addObsservationRequest.getAggregationType());
                observationUiAudit.setWExperession(addObsservationRequest.getWgExpr());
                observationUiAudit.setWhereExperession(addObsservationRequest.getWhereExpr());
                observationUiAudit.setWId(observationWindows.getWid());
                observationUiAudit.setOdesc(addObsservationRequest.getOdesc());
                observationUiAudit.setItenantId(addObsservationRequest.getItenantId());

                try {
                    observationUiAudit = observationUiAuditService
                            .saveObservationUiAudit(observationUiAudit);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to edit RT observation", e.toString());
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (observationUiAudit != null) {

                    activityLogService.addActivity(loggedInUser,
                            "Observation edited successfully");
                    LOGGER.debug("Exiting editObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : RT Observation edition sent for approval");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(true, "RT Observation edition sent for approval"),
                            HttpStatus.ACCEPTED);
                } else {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to edi RT observation ");
                    LOGGER.debug("Exiting editObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to edit RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Failed to edit RT observation"),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

            }

        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to add RT observation ");
            LOGGER.debug("Exiting editObservation Method in " + ObservationControllerServiceImpl.class
                    + " class with response  : unauthorized to edit RT Observation details");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to edit RT Observations details"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> deleteObservation(Integer oId, Integer wid, String remark, Integer tenantid, Authentication pr) {
        LOGGER.debug("entered in class " + ObservationControllerServiceImpl.class
                + " in method deleteObservation");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        if (mp.isDelete()) {

            if (remark != null) {
                if (remark.isEmpty() || remark.isBlank()) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to delete RT observation ");
                    LOGGER.debug("Exiting deleteObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to delete RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Maker remark cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                activityLogService.addActivity(loggedInUser,
                        "Failed to delete observation ");
                LOGGER.debug("Exiting deleteObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to delete RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Maker remark cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            Pattern pattern = Pattern.compile("^[a-zA-Z0-9 ,_@*#%'/\\\\&.-]+$");
            Matcher matcher = pattern.matcher(remark);

            if (!matcher.matches()) {
                LOGGER.debug("Exiting deleteObservation Method in " + ObservationControllerServiceImpl.class
                        + " class with response: Invalid Maker remark format");
                activityLogService.addActivity(loggedInUser, "failed to delete observation due to invalid remark", remark);
                return new ResponseEntity<>(
                        new ApiResponse(false, "Maker remark can only contain alphabets, numbers, " +
                                "hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), " +
                                "percentage (%), single quotation ('), forward and backward slash (/ , \\), " +
                                "ampersand (&) and dot (.)"),
                        HttpStatus.BAD_REQUEST);
            }

            ObservationsUi observationsUi = null;
            try {
                observationsUi = observationUiService.findByObservationId(oId, wid, tenantid);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (observationsUi != null) {
                ObservationUiAudit observationUiAudit = new ObservationUiAudit();
                observationUiAudit.setAggregationType(observationsUi.getAggregationType());
                observationUiAudit.setBclosed(false);
                observationUiAudit.setDtEntryDateTime(observationsUi.getDtEntryDateTime());
                observationUiAudit.setDtEntryStamp(ZonedDateTime.now());
                observationUiAudit.setIEntryUserID(loggedInUser.getIuserID());
                observationUiAudit.setIorgId(loggedInUser.getIorgId());
                observationUiAudit.setIRecordStatus(1);
                observationUiAudit.setOCount(observationsUi.getOCount());
                observationUiAudit.setODuration(observationsUi.getODuration());
                observationUiAudit.setOname(observationsUi.getOname());
                observationUiAudit.setVcAction("X");
                observationUiAudit.setVcRemark(remark);
                observationUiAudit.setWExperession(observationsUi.getWExperession());
                observationUiAudit.setWhereExperession(observationsUi.getWhereExperession());
                observationUiAudit.setOid(observationsUi.getOid());
                observationUiAudit.setWId(observationsUi.getWid());
                observationUiAudit.setOdesc(observationsUi.getOdesc());
                observationUiAudit.setItenantId(observationsUi.getItenantId());

                try {
                    observationUiAudit = observationUiAuditService
                            .saveObservationUiAudit(observationUiAudit);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to delete RT observation", e.toString());
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (observationUiAudit != null) {

                    activityLogService.addActivity(loggedInUser,
                            "Observation deleted successfully");
                    LOGGER.debug("Exiting deleteObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : RT Observation deletion sent for approval");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(true, "RT Observation deletion sent for approval"),
                            HttpStatus.ACCEPTED);
                } else {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to delete RT observation ");
                    LOGGER.debug("Exiting editObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to delete RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Failed to delete RT observation"),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

            } else {
                activityLogService.addActivity(loggedInUser,
                        "Failed to delete RT observation ");
                LOGGER.debug("Exiting deleteObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to delete RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "No RT observation found for id : " + oId),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to delete RT observation ");
            LOGGER.debug("Exiting deleteObservation Method in " + ObservationControllerServiceImpl.class
                    + " class with response  : unauthorized to delete RT Observation details");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to delete RT Observations details"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public ResponseEntity<?> approveObservation(Integer oId, String remark, Boolean approve, Integer tenantId, Authentication pr) {
        LOGGER.debug("entered in class " + ObservationControllerServiceImpl.class
                + " in method approveObservation");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        if (mp.isApprove()) {

            ObservationUiAudit observationUiAudit = null;

            try {
                observationUiAudit = observationUiAuditService.findByObservationUiAduitId(oId, tenantId);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to approve RT observation", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (observationUiAudit != null) {

                if (observationUiAudit.getIEntryUserID() == loggedInUser.getIuserID()) {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to approve RT observation ");
                    LOGGER.debug("Exiting approveObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to approve RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Maker cannot be checker"),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (remark != null) {
                    if (remark.isBlank() || remark.isEmpty()) {
                        activityLogService.addActivity(loggedInUser,
                                "Failed to approve RT observation ");
                        LOGGER.debug("Exiting approveObservation Method in "
                                + ObservationControllerServiceImpl.class
                                + " class with response  : failed to approve RT Observation details");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Checker remark cannot be blank"),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                } else {
                    activityLogService.addActivity(loggedInUser,
                            "Failed to approve RT observation ");
                    LOGGER.debug("Exiting approveObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : failed to approve RT Observation details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Checker remark cannot be blank"),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                Pattern pattern = Pattern.compile("^[a-zA-Z0-9 ,_@*#%'/\\\\&.-]+$");
                Matcher matcher = pattern.matcher(remark);

                if (!matcher.matches()) {
                    LOGGER.debug("Exiting approveObservation Method in " + ObservationControllerServiceImpl.class
                            + " class with response: Invalid Checker remark format");
                    activityLogService.addActivity(loggedInUser, "failed to approve observation due to invalid remark", remark);
                    return new ResponseEntity<>(
                            new ApiResponse(false, "Checker remark can only contain alphabets, numbers, " +
                                    "hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), " +
                                    "percentage (%), single quotation ('), forward and backward slash (/ , \\), " +
                                    "ampersand (&) and dot (.)"),
                            HttpStatus.BAD_REQUEST);
                }

                observationUiAudit.setBclosed(true);
                observationUiAudit.setDtApproverStamp(ZonedDateTime.now());
                observationUiAudit.setIApproverUserID(loggedInUser.getIuserID());
                observationUiAudit.setIorgId(loggedInUser.getIorgId());
                observationUiAudit.setVcRemark(
                        "{ " + observationUiAudit.getVcRemark() + " } { " + remark + " } ");

                if (approve) {

                    if (observationUiAudit.getVcAction().equals("A")) {
                        observationUiAudit.setIstatus(statusCodeService.findByIStatusId(2));
                    } else if (observationUiAudit.getVcAction().equals("M")) {
                        observationUiAudit.setIstatus(statusCodeService.findByIStatusId(3));
                    } else {
                        observationUiAudit.setIstatus(statusCodeService.findByIStatusId(4));
                        observationUiAudit.setIRecordStatus(1);
                    }

                    try {
                        observationUiAudit = observationUiAuditService
                                .saveObservationUiAudit(observationUiAudit);
                    } catch (Exception e) {
                        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                        LOGGER.error(loggerEncoderUtil
                                .encode("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString())));
                        activityLogService.addActivity(loggedInUser, "failed to approve RT observation",
                                e.toString());
                        return new ResponseEntity<>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                    ObservationsUi observationsUi = observationUiAudit
                            .parseAudit(observationUiAudit);
                    observationsUi.setLastStatus("Approved");
                    observationsUi.setLatestRemark(remark);
                    observationUiAudit.setIApproverUserID(loggedInUser.getIuserID());
                    observationUiAudit.setIorgId(loggedInUser.getIorgId());
                    try {
                        observationsUi = observationUiService.saveObservations(observationsUi);
                    } catch (Exception e) {
                        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                        LOGGER.error(loggerEncoderUtil
                                .encode("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString())));
                        activityLogService.addActivity(loggedInUser, "failed to approve RT observation",
                                e.toString());
                        return new ResponseEntity<>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    ResponseEntity<String> addObservationReq = null;

                    String resMessage = "";

                    if (observationUiAudit.getVcAction().equals("A")) {
                        resMessage = "RT Observation addition approved successfully";
                        AddObservationApiRequest addObservationApiRequest = AddObservationApiRequest
                                .parseObservatioUi(observationsUi);

                        try {
                            addObservationReq = observationApiService.addObservation(tenantRepositoryService.findAPIKeyTenant(observationUiAudit.getItenantId()),
                                    addObservationApiRequest,
                                    observationsUi.getWid());
                        } catch (Exception e) {
                            TransactionAspectSupport.currentTransactionStatus()
                                    .setRollbackOnly();
                            LOGGER.error(loggerEncoderUtil
                                    .encode("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString())));
                            activityLogService.addActivity(loggedInUser, "failed to approve RT observation",
                                    e.toString());
                            return new ResponseEntity<>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }

                        if (addObservationReq.getStatusCode() != HttpStatus.OK) {
                            TransactionAspectSupport.currentTransactionStatus()
                                    .setRollbackOnly();
                            LOGGER.error("Error : " + (addObservationReq.getBody() == null ? "Body is null" :
                                    loggerEncoderUtil.encode(addObservationReq.getBody())));
                            activityLogService.addActivity(loggedInUser, "failed to approve RT observation",
                                    addObservationReq.getBody());
                            return new ResponseEntity<>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }

                    } else {

                        resMessage = "RT Observation deletion approved successfully";
                        ResponseEntity<String> deletReq = null;

                        try {
                            deletReq = observationApiService.deleteObservation(tenantRepositoryService.findAPIKeyTenant(observationsUi.getItenantId()),
                                    observationsUi.getOid(),
                                    observationsUi.getWid());
                        } catch (Exception e) {
                            TransactionAspectSupport.currentTransactionStatus()
                                    .setRollbackOnly();
                            LOGGER.error(loggerEncoderUtil
                                    .encode("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString())));
                            activityLogService.addActivity(loggedInUser, "failed to approve RT observation",
                                    e.toString());
                            return new ResponseEntity<>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }

                        if (deletReq.getStatusCode() != HttpStatus.OK) {
                            TransactionAspectSupport.currentTransactionStatus()
                                    .setRollbackOnly();
                            LOGGER.error(loggerEncoderUtil
                                    .encode("Error : " + (deletReq.getBody() == null ? "Body is null" :
                                            loggerEncoderUtil.encode(deletReq.getBody()))));
                            activityLogService.addActivity(loggedInUser, "failed to approve RT observation",
                                    deletReq.getBody());
                            return new ResponseEntity<>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                    }

                    activityLogService.addActivity(loggedInUser,
                            resMessage);
                    LOGGER.debug("Exiting approveObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : " + resMessage);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(true, resMessage),
                            HttpStatus.ACCEPTED);

                } else {

                    observationUiAudit.setIstatus(statusCodeService.findByIStatusId(5));

                    try {
                        observationUiAudit = observationUiAuditService
                                .saveObservationUiAudit(observationUiAudit);
                    } catch (Exception e) {
                        TransactionAspectSupport.currentTransactionStatus()
                                .setRollbackOnly();
                        LOGGER.error(loggerEncoderUtil
                                .encode("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString())));
                        activityLogService.addActivity(loggedInUser, "failed to approve RT observation",
                                e.toString());
                        return new ResponseEntity<>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    if (!observationUiAudit.getVcAction().equals("A")) {
                        ObservationsUi observationsUi = null;
                        try {
                            observationsUi = observationUiService.findByObservationId(
                                    observationUiAudit.getOid(), observationUiAudit.getWId(), observationUiAudit.getItenantId());
                        } catch (Exception e) {
                            TransactionAspectSupport.currentTransactionStatus()
                                    .setRollbackOnly();
                            LOGGER.error(loggerEncoderUtil
                                    .encode("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString())));
                            activityLogService.addActivity(loggedInUser, "failed to approve RT observation",
                                    e.toString());
                            return new ResponseEntity<>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }

                        observationsUi.setLastStatus("Rejected");
                        observationsUi.setLatestRemark(remark);
                        observationsUi.setDtApproverStamp(ZonedDateTime.now());

                        try {
                            observationsUi = observationUiService
                                    .saveObservations(observationsUi);
                        } catch (Exception e) {
                            TransactionAspectSupport.currentTransactionStatus()
                                    .setRollbackOnly();
                            LOGGER.error(loggerEncoderUtil
                                    .encode("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString())));
                            activityLogService.addActivity(loggedInUser, "failed to approve RT observation",
                                    e.toString());
                            return new ResponseEntity<>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                    }

                    String resMessage = "";

                    if (observationUiAudit.getVcAction().equals("A")) {
                        resMessage = "RT Observation addition rejected successfully";
                    } else if (observationUiAudit.getVcAction().equals("M")) {
                        resMessage = "RT Observation edition rejected successfully";
                    } else {
                        resMessage = "RT Observation deletion rejected successfully";
                    }

                    activityLogService.addActivity(loggedInUser,
                            resMessage);
                    LOGGER.debug("Exiting approveObservation Method in "
                            + ObservationControllerServiceImpl.class
                            + " class with response  : " + resMessage);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(true, resMessage),
                            HttpStatus.ACCEPTED);

                }
            } else {
                activityLogService.addActivity(loggedInUser,
                        "Failed to approve RT observation ");
                LOGGER.debug("Exiting approveObservation Method in "
                        + ObservationControllerServiceImpl.class
                        + " class with response  : failed to approve RT Observation details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "No RT observation found for id : " + oId),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to approve RT observation ");
            LOGGER.debug("Exiting apporveObservation Method in " + ObservationControllerServiceImpl.class
                    + " class with response  : unauthorized to approve RT Observation details");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to approve RT Observations details"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> autoSuggestID(Authentication pr) {
        LOGGER.debug("entered in class " + ObservationControllerServiceImpl.class
                + " in method addObservation");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        if (mp.isAdd()) {

            Integer maxId = null;
            Integer maxAuditId = null;

            try {
                maxId = observationUiService.findMaxId();
            } catch (Exception e) {

                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            try {
                maxAuditId = observationUiAuditService.findMaxIdPending();
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
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
                    "unauthorized to add RT observation ");
            LOGGER.debug("Exiting addObservation Method in " + ObservationControllerServiceImpl.class
                    + " class with response  : unauthorized to add RT Observation details");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to add RT Observations details"),
                    HttpStatus.FORBIDDEN);
        }

    }

}
