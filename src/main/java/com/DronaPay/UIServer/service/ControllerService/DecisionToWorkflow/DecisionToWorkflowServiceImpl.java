package com.DronaPay.UIServer.service.ControllerService.DecisionToWorkflow;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.ResponseVO.DecisionClassDropDown;
import com.DronaPay.UIServer.ResponseVO.DropdownWithObject;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.requests.*;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.DecisionDetailsResponse;
import com.DronaPay.UIServer.response.DecisionListView;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.service.ApiServices.DecisionApiService;
import com.DronaPay.UIServer.service.CamundaService;
import com.DronaPay.UIServer.service.ControllerService.testing.ProductService;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.JsonNodeType;
import org.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.reactive.function.client.ClientResponse;

import java.net.http.HttpResponse;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class DecisionToWorkflowServiceImpl implements DecisionToWorkflowService {

    private static final Logger LOGGER = LoggerFactory.getLogger(DecisionToWorkflowServiceImpl.class);
    final String menu_name = MenuNames.DecisionToWorkflow;
    @Autowired
    private ProductService productService;
    @Autowired
    private DecisionService decisionService;

    @Autowired
    private TransactionClassesUiService transactionClassesUiService;
    @Autowired
    private ActivityLogService activityLogService;

    @Autowired
    private CamundaService camundaService;
    @Autowired
    private DecisionUiServiceImpl decisionUiServiceImpl;
    @Autowired
    private DecisionUiWorkflowAuditServiceImpl decisionAuditServiceImpl;
    @Autowired
    private StatusCodeService statusCodeService;
    @Autowired
    private DecisionApiService decisionApiService;
    @Autowired
    private DecisionAuditServiceImpl decisionAuditServiceImplRule;
    @Autowired
    private TransactionClassesUiAuditServiceImpl transactionClassessUiAuditService;
    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;
    @Autowired
    private WorkflowMasterService workflowMasterService;
    @Autowired
    private TenantRepositoryService tenantRepositoryService;

    @Override
    public ResponseEntity<?> getAllDecision(Authentication pr) {
        LOGGER.debug("entered in class " + DecisionToWorkflowServiceImpl.class + " in method getAllDecisions");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);
        DecisionListView decisionListView = new DecisionListView();

        decisionListView.setAdd(mp.isAdd());
        decisionListView.setApprove(mp.isApprove());
        decisionListView.setDelete(mp.isDelete());
        decisionListView.setEdit(mp.isEdit());
        decisionListView.setView(mp.isView());
        if (mp.isView()) {
            List<DecisionUi> decisionList = new ArrayList<>();
            List<DecisionClassDropDown> responses = new ArrayList<>();
            List<DecisionUiWorkflowAudit> decisionUiAudits = new ArrayList<>();
            // List<DecisionUiAudit> decisionUiAuditsRule = new ArrayList<>();

            try {
                List<Integer> tenantids = loggedUser.getUserTenant();
                decisionList = decisionUiServiceImpl.findAllNonDeletedTenants(tenantids);
                decisionList = decisionList.stream().filter(c -> c.getIRecordStatus() == 0)
                        .collect(Collectors.toList());
                decisionUiAudits = decisionAuditServiceImpl.findPendingEntriesTenant(tenantids);
                // decisionUiAuditsRule = decisionAuditServiceImplRule.findPendingEntries();
                // decisionUiAuditsRule = decisionUiAuditsRule.stream().filter(c ->
                // c.getIdecisionUiId() != null)
                // .collect(Collectors.toList());
                decisionList.stream()
                        .map(d -> responses.add(DecisionClassDropDown.builder()
                                .label(d.getVcDecisionName())
                                .value(d.getIDecisionID())
                                .prooductId(d.getIProductID().getIProductID())
                                .vcResultParam(d.getVcResultParams())
                                .lastUpdate(d.getDtApproverStamp())
                                .latestRemark(d.getLatestRemark())
                                .itenantId(d.getItenantId())
                                .tenantName(tenantRepositoryService.findByItenantId(d.getItenantId()).getTenantName())
                                .lastStatus(d.getLastStatus()).auditEntry(false)
                                .auditExist(false).makerChecker("M").build()))
                        .collect(Collectors.toList());

                for (int i = 0; i < responses.size(); i++) {
                    for (int k = 0; k < decisionUiAudits.size(); k++) {
                        if (decisionUiAudits.get(k).getIdecisionUiId() != null) {
                            if (responses.get(i).getValue()
                                    .equals(decisionUiAudits.get(k)
                                            .getIdecisionUiId())) {
                                responses.get(i).setAuditExist(true);
                            }
                        }
                    }
                }

                // for (int i = 0; i < responses.size(); i++) {
                // for (int k = 0; k < decisionUiAuditsRule.size(); k++) {
                // if (responses.get(i).getValue()
                // .equals(decisionUiAuditsRule.get(k).getIdecisionUiId().getIDecisionID())) {
                // responses.get(i).setAuditExist(true);
                // }
                // }
                // }

                decisionUiAudits.stream()
                        .map(d -> responses.add(DecisionClassDropDown.builder()
                                .label(d.getVcDecisionName())
                                .value(d.getIdecisionUiId() != null
                                        ? d.getIdecisionUiId()
                                        : -1)
                                .idecisionAuditID(d.getIdecisionAuditID())
                                .prooductId(d.getIProductID().getIProductID())
                                .vcResultParam(d.getVcResultParams())
                                .lastUpdate(d.getDtEntryStamp())
                                .latestRemark(d.getVcRemark())
                                .lastStatus("Pending")
                                .itenantId(d.getItenantId())
                                .tenantName(tenantRepositoryService.findByItenantId(d.getItenantId()).getTenantName())
                                .auditEntry(true)
                                .auditExist(false)
                                .makerChecker(d.getIEntryUserID() != loggedInUser.getIuserID() ? "C"
                                        : "M")
                                .action(d.getVcAction())
                                .build()))
                        .collect(Collectors.toList());

                decisionListView.setDecisionList(responses);

                LOGGER.debug("Exiting getTransactionClassesAndDecision Method in "
                        + DecisionToWorkflowServiceImpl.class
                        + " class with response  : with parameters type dropdown");
                activityLogService.addActivity(loggedInUser, "Decision Dropdown  accessed");
                return ResponseEntity.ok(decisionListView);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get decision details", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access decision dropdown for Transaction to decision");
            LOGGER.debug("Exiting getAllUploadChargeBacks Method in " + DecisionToWorkflowServiceImpl.class
                    + " class with response  : unauthorized to access list of lists");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access list of lists"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> editResultParam(Integer classID,
                                             EditResultParamOfTransaction eResultParamOfTransaction,
                                             Authentication pr) {
        LOGGER.debug(
                "entered in class " + DecisionToWorkflowServiceImpl.class + " editResultParam");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isEdit()) {
            Decisions editClass = null;
            try {
                // System.out.println(classID);
                editClass = decisionService.findByiDecisionID(classID);
                // System.out.println(editClass);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to edit transaction class", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            org.json.JSONObject param = new org.json.JSONObject(
                    eResultParamOfTransaction.getVcResultParams());
            JSONArray actionArr = param.optJSONArray("action");
            for (int i = 0; i < actionArr.length(); i++) {
                if (actionArr.optJSONObject(i).opt("bworkflow") != null) {
                    actionArr.optJSONObject(i).put("bworkflow", true);
                }
            }

            param.put("action", actionArr);

            try {

                ObjectMapper mapper = new ObjectMapper();
                JsonNode actualObj = mapper.readTree(param.toString());

                editClass.setVcResultParams(actualObj);
                LOGGER.debug("Exiting editDefaultRule Method in " + DecisionToWorkflowServiceImpl.class
                        + " class with response  : with parameters type dropdown");
                activityLogService.addActivity(loggedInUser, "Default rule edited successfully",
                        "Parameters : " + eResultParamOfTransaction.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(true, "Parameters Edited Successfully"),
                        HttpStatus.OK);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to edit transaction class", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to result param of transaction class ");
            LOGGER.debug("Exiting editResultParam Method in " + DecisionToWorkflowServiceImpl.class
                    + " class with response  : unauthorized to save transaction class");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to save transaction class"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> disableResultParam(Integer classID, Authentication pr) {
        LOGGER.debug(
                "entered in class " + DecisionToWorkflowServiceImpl.class + " disableResultParam");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isEdit()) {
            Decisions editClass = null;
            try {
                // System.out.println(classID);
                editClass = decisionService.findByiDecisionID(classID);
                ;
                // System.out.println(editClass);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to edit transaction class", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            org.json.JSONObject param = new org.json.JSONObject(editClass.getVcResultParams());
            JSONArray actionArr = param.optJSONArray("action");
            for (int i = 0; i < actionArr.length(); i++) {
                if (actionArr.optJSONObject(i).opt("bworkflow") != null) {
                    actionArr.optJSONObject(i).put("bworkflow", false);
                }
            }

            param.put("action", actionArr);

            try {
                editClass.setBactive(false);
                ObjectMapper mapper = new ObjectMapper();
                JsonNode actualObj = mapper.readTree(param.toString());
                editClass.setVcResultParams(actualObj);

                LOGGER.debug("Exiting disableResultParam Method in "
                        + DecisionToWorkflowServiceImpl.class
                        + " class with response  : with parameters type dropdown");
                activityLogService.addActivity(loggedInUser, "Default rule edited successfully");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(true, "Result Params disabled Successfully"),
                        HttpStatus.OK);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to disable result params", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to result param of transaction class ");
            LOGGER.debug("Exiting disableResultParam Method in " + DecisionToWorkflowServiceImpl.class
                    + " class with response  : unauthorized to save transaction class");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to save transaction class"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getWorkFlowName(Authentication pr) {
        LOGGER.debug("entering  class " + DecisionToWorkflowServiceImpl.class + " and method getWorkFlowName");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            List<WorkflowMasters> allWorkflows = null;
            try {
                allWorkflows = workflowMasterService.findAll();
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            ResponseEntity<String> clientResponse = null;
            try {
                clientResponse = camundaService.getWorkFlowName(loggedUser);

            } catch (Exception e) {
                LOGGER.error("Error : " + e);
                activityLogService.addActivity(loggedInUser, "failed to get workflow name",
                        "Error : " + e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

//            String responses = clientResponse.bodyToMono(String.class).block();
            String responses = clientResponse.getBody();
//            clientResponse.releaseBody();
            if (clientResponse.getStatusCode() == HttpStatus.OK) {

                JSONArray workflowNames = new JSONArray(responses);

                List<DropdownWithObject> workFlowDropDown = new ArrayList<>();

                try {
                    for (WorkflowMasters wfl : allWorkflows) {
                        for (int i = 0; i < workflowNames.length(); i++) {
                            org.json.JSONObject objectInArray = workflowNames
                                    .getJSONObject(i);
                            if (wfl.getWorkflowKey().equals(objectInArray.get("key"))) {
                                workFlowDropDown.add(DropdownWithObject.builder()
                                        .label(objectInArray.get("name"))
                                        .value(objectInArray.get("name"))
                                        .build());
                            }
                        }
                    }
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + responses);
                    activityLogService.addActivity(loggedInUser, "failed to get task history",
                            "Error : " + e.toString() + ", Parameters : " + responses);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                LOGGER.debug("Exiting getWorkFlowName Method in " + DecisionToWorkflowServiceImpl.class
                        + " class with response : workflow names");
                return ResponseEntity.ok(workFlowDropDown);
            } else {
                activityLogService.addActivity(loggedInUser, "failed to access workflow names");
                LOGGER.debug("Exiting getPayeeNames Method in " + DecisionToWorkflowServiceImpl.class
                        + " class with response : "
                        + responses);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, responses),
                        clientResponse.getStatusCode());
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get workflow names");
            LOGGER.debug("Exiting getWorkFlowName Method in " + DecisionToWorkflowServiceImpl.class
                    + " class with response : unauthorized to get workflow names");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to get workflow names"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getDecisionDetails(Integer idecisionid, Boolean audit, Integer tenantid, Authentication pr) {
        LOGGER.debug("entering  class " + DecisionToWorkflowServiceImpl.class
                + " and method getDecisionDetails");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            if (audit) {
                DecisionUiWorkflowAudit auditDecision = null;
                try {
                    // auditDecision =
                    // decisionAuditServiceImpl.findPendingDecisionByID(idecisionid);
                    auditDecision = decisionAuditServiceImpl
                            .findPendingDecisionByAuditIDAndTenant(idecisionid, tenantid);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (auditDecision != null) {
                    DecisionDetailsResponse response = new DecisionDetailsResponse();
                    response.setDecisionId(auditDecision.getIdecisionAuditID());
                    response.setTenantName(tenantRepositoryService.findByItenantId(auditDecision.getItenantId()).getTenantName());
                    response.setItenantId(auditDecision.getItenantId());
                    response.setLabel(auditDecision.getVcDecisionName());
                    response.setProductId(auditDecision.getIProductID().getIProductID());
                    response.setVcResultParam(auditDecision.getVcResultParams());
                    response.setAttribs(auditDecision.getAttribs());
                    response.setDecisionDetail(auditDecision.getVcDecisionDetail());
                    response.setLatestRemark(auditDecision.getVcRemark());
                    response.setMakerChecker(auditDecision.getIEntryUserID()
                            != loggedInUser.getIuserID() ? "C" : "M");

                    LOGGER.debug("Exiting getDecisionDetails Method in "
                            + DecisionToWorkflowServiceImpl.class
                            + " class with response  : with parameters type get decision details");
                    activityLogService.addActivity(loggedInUser,
                            "Decision details accessed successfully");
                    return ResponseEntity.ok(response);

                } else {
                    LOGGER.debug("Exiting getDecisionDetails Method in "
                            + DecisionToWorkflowServiceImpl.class
                            + " class with response  : with parameters type get decision details");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to access decision details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "No pending entries found"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                DecisionUi decision = null;
                try {
                    decision = decisionUiServiceImpl.findByiDecisionID(idecisionid, tenantid);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (decision != null) {
                    DecisionDetailsResponse decisionDetailsResponse = new DecisionDetailsResponse();
                    decisionDetailsResponse.setDecisionId(decision.getIDecisionID());
                    decisionDetailsResponse.setLabel(decision.getVcDecisionName());
                    decisionDetailsResponse.setProductId(decision.getIProductID().getIProductID());
                    decisionDetailsResponse.setItenantId(decision.getItenantId());
                    decisionDetailsResponse.setTenantName(tenantRepositoryService.findByItenantId(decision.getItenantId()).getTenantName());
                    decisionDetailsResponse.setVcResultParam(decision.getVcResultParams());
                    decisionDetailsResponse.setAttribs(decision.getAttribs());
                    decisionDetailsResponse.setDecisionDetail(decision.getVcDecisionDetail());
                    decisionDetailsResponse.setLatestRemark(decision.getLatestRemark());
                    decisionDetailsResponse.setMakerChecker("M");
                    LOGGER.debug("Exiting getDecisionDetails Method in "
                            + DecisionToWorkflowServiceImpl.class
                            + " class with response  : with parameters type get decision details");
                    activityLogService.addActivity(loggedInUser,
                            "Decision details accessed successfully");
                    return ResponseEntity.ok(decisionDetailsResponse);
                } else {
                    LOGGER.debug("Exiting getDecisionDetails Method in "
                            + DecisionToWorkflowServiceImpl.class
                            + " class with response  : with parameters type get decision details");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to access decision details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "No decision deatils found"),
                            HttpStatus.BAD_REQUEST);
                }
            }

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get decision details");
            LOGGER.debug("Exiting getDecisionDetails Method in " + DecisionToWorkflowServiceImpl.class
                    + " class with response : unauthorized to get decision details");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to get decision details"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> editDecisionDetails(EditDecisionRequest editDecisionRequest, Authentication pr) {
        LOGGER.debug("entering  class " + DecisionToWorkflowServiceImpl.class
                + " and method editDecisionDetails");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);
        if (mp.isEdit() && loggedUser.allowTenants(Arrays.asList(editDecisionRequest.getItenantId()))) {
            if (editDecisionRequest.getVcDecisionDetail() != null) {
                if (!editDecisionRequest.getVcDecisionDetail().isEmpty()
                        && !editDecisionRequest.getVcDecisionDetail().isBlank()) {
                } else {
                    LOGGER.debug("Exiting addNewTransactionClass Method in "
                            + DecisionToWorkflowServiceImpl.class
                            + " class with response  : with parameter add decision");
                    activityLogService.addActivity(loggedInUser, "Failed to add decision",
                            "Parameters : " + editDecisionRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Decision detail of new decison cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                LOGGER.debug("Exiting addNewTransactionClass Method in "
                        + DecisionToWorkflowServiceImpl.class
                        + " class with response  : with parameter add decision");
                activityLogService.addActivity(loggedInUser, "Failed to add decision",
                        "Parameters : " + editDecisionRequest.getProductId());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Decision detail of new decison cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (editDecisionRequest.getVcDecisionName() != null) {
                if (!editDecisionRequest.getVcDecisionName().isEmpty()
                        && !editDecisionRequest.getVcDecisionName().isBlank()) {
                    if (editDecisionRequest.getVcDecisionName().length() > 20) {
                        LOGGER.debug("Exiting addDecisionDetails Method in "
                                + DecisionToWorkflowServiceImpl.class
                                + " class with response  : with parameter add decision");
                        activityLogService.addActivity(loggedInUser, "Failed to add decision",
                                "Parameters : " + editDecisionRequest.getProductId());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Decision name should not be more than 20 characters"),
                                HttpStatus.BAD_REQUEST);
                    }
                } else {
                    LOGGER.debug("Exiting addDecisionDetails Method in "
                            + DecisionToWorkflowServiceImpl.class
                            + " class with response  : with parameter add decision");
                    activityLogService.addActivity(loggedInUser, "Failed to add decision",
                            "Parameters : " + editDecisionRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Decision name of new decison cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                LOGGER.debug("Exiting addDecisionDetails Method in "
                        + DecisionToWorkflowServiceImpl.class
                        + " class with response  : with parameter add decision");
                activityLogService.addActivity(loggedInUser, "Failed to add decision",
                        "Parameters : " + editDecisionRequest.getProductId());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Decision name of new decison cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }
            if (editDecisionRequest.getMakerRemark() != null) {
                if (editDecisionRequest.getMakerRemark().isEmpty()
                        || editDecisionRequest.getMakerRemark().isBlank()) {
                    LOGGER.debug("Exiting editDecisionDetails Method in "
                            + DecisionToWorkflowServiceImpl.class
                            + " class with response  : with parameters type edit decision details");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to access decision details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Maker remark cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                LOGGER.debug("Exiting editDecisionDetails Method in "
                        + DecisionToWorkflowServiceImpl.class
                        + " class with response  : with parameters type edit decision details");
                activityLogService.addActivity(loggedInUser, "Failed to access decision details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Maker remark cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }
            Products products = null;
            try {
                products = productService.findByiProductID(editDecisionRequest.getProductId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (editDecisionRequest.getAudit() == true) {
                DecisionUiWorkflowAudit audit = null;
                try {
                    // audit =
                    // decisionAuditServiceImpl.findPendingDecisionByID(editDecisionRequest.getDecisionId());
                    audit = decisionAuditServiceImpl.findPendingDecisionByAuditIDAndTenant(
                            editDecisionRequest.getDecisionId(), editDecisionRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (audit != null) {
                    if (audit.getIEntryUserID() != loggedInUser.getIuserID()) {
                        LOGGER.debug("Exiting editDecisionDetails Method in "
                                + DecisionToWorkflowServiceImpl.class
                                + " class with response  : with parameters type edit decision details");
                        activityLogService.addActivity(loggedInUser,
                                "Failed to access decision details");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Checker cannot edit this entry"),
                                HttpStatus.BAD_REQUEST);
                    }
                    ObjectMapper mapper = new ObjectMapper();
                    try {

                        JsonNode actualObj = mapper
                                .readTree(editDecisionRequest.getVcResultParam());
                        audit.setVcResultParams(actualObj);
                    } catch (Exception e) {
                        LOGGER.error("Error : " + e + "\nParam : "
                                + loggerEncoderUtil.encode(pr.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                                e.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                    if (products != null) {
                        audit.setIProductID(products);
                    } else {
                        LOGGER.debug("Exiting addNewTransactionClass Method in "
                                + DecisionToWorkflowServiceImpl.class
                                + " class with response  : with parameter edit decision");
                        activityLogService.addActivity(loggedInUser, "Failed to edit decision",
                                "Parameters : " + editDecisionRequest.getProductId());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "No Product found for product id :- "
                                                + editDecisionRequest
                                                .getProductId()),
                                HttpStatus.BAD_REQUEST);
                    }
                    audit.setVcRemark(editDecisionRequest.getMakerRemark());
                    JsonNode attribs = editDecisionRequest.getAttribs();
                    if (attribs != null && attribs.getNodeType() != JsonNodeType.NULL) {
                        audit.setAttribs(attribs);
                    }
                    audit.setVcDecisionDetail(editDecisionRequest.getVcDecisionDetail());
                    audit.setVcDecisionName(editDecisionRequest.getVcDecisionName());
                    if (audit.getVcAction().equals("A")) {
                        audit.setItenantId(editDecisionRequest.getItenantId());
                    }
                    decisionAuditServiceImpl.saveAudit(audit);
                    LOGGER.debug("Exiting editDecisionDetails Method in "
                            + DecisionToWorkflowServiceImpl.class
                            + " class with response  : with parameters edit decision");
                    activityLogService.addActivity(loggedInUser,
                            "Decision edition sent for approval");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(true, "Decision edition sent for approval"),
                            HttpStatus.OK);
                } else {

                    LOGGER.debug("Exiting editDecisionDetails Method in "
                            + DecisionToWorkflowServiceImpl.class
                            + " class with response  : with parameters type edit decision details");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to access decision details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "No pending entries found"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                DecisionUi decisionUi = null;

                DecisionUiWorkflowAudit exist = null;
                try {
                    exist = decisionAuditServiceImpl
                            .findPendingDecisionByID(editDecisionRequest.getDecisionId(), editDecisionRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (exist != null) {
                    LOGGER.debug("Exiting editDecisionDetails Method in "
                            + DecisionToWorkflowServiceImpl.class
                            + " class with response  : with parameters type edit decision details");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to access decision details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Entry is already pending for action"),
                            HttpStatus.BAD_REQUEST);
                }

                try {
                    decisionUi = decisionUiServiceImpl
                            .findByiDecisionID(editDecisionRequest.getDecisionId(), editDecisionRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                DecisionUiWorkflowAudit newAudit = new DecisionUiWorkflowAudit();
                newAudit.setBActive(decisionUi.isBactive());
                newAudit.setDtEntryDatetime(ZonedDateTime.now());
                newAudit.setDtEntryStamp(ZonedDateTime.now());
                newAudit.setIdecisionUiId(decisionUi.getIDecisionID());
                newAudit.setIEntryUserID(loggedInUser.getIuserID());
                newAudit.setIorgId(loggedInUser.getIorgId());
                if (products != null) {
                    newAudit.setIProductID(products);
                } else {
                    LOGGER.debug("Exiting addNewTransactionClass Method in "
                            + DecisionToWorkflowServiceImpl.class
                            + " class with response  : with parameter edit decision");
                    activityLogService.addActivity(loggedInUser, "Failed to edit decision",
                            "Parameters : " + editDecisionRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "No Product found for product id :- "
                                            + editDecisionRequest
                                            .getProductId()),
                            HttpStatus.BAD_REQUEST);
                }
                newAudit.setIRecordStatus(decisionUi.getIRecordStatus());
                newAudit.setBclosed(false);
                newAudit.setVcRemark(editDecisionRequest.getMakerRemark());
                newAudit.setVcAction("M");
                newAudit.setIUserID(decisionUi.getIUserID());
                newAudit.setIorgId(decisionUi.getIorgId());
                newAudit.setItenantId(decisionUi.getItenantId());
                newAudit.setVcDecisionDetail(editDecisionRequest.getVcDecisionDetail());
                newAudit.setVcDecisionMapInfo(decisionUi.getVcDecisionMapInfo());
                newAudit.setVcDecisionName(editDecisionRequest.getVcDecisionName());
                ObjectMapper mapper = new ObjectMapper();
                try {

                    JsonNode actualObj = mapper.readTree(editDecisionRequest.getVcResultParam());
                    newAudit.setVcResultParams(actualObj);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                JsonNode attribs = editDecisionRequest.getAttribs();
                if (attribs != null && attribs.getNodeType() != JsonNodeType.NULL) {
                    newAudit.setAttribs(attribs);
                }
                decisionAuditServiceImpl.saveAudit(newAudit);

                LOGGER.debug("Exiting editDecisionDetails Method in "
                        + DecisionToWorkflowServiceImpl.class
                        + " class with response  : with parameters edit decision");
                activityLogService.addActivity(loggedInUser, "Decision edition sent for approval");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(true, "Decision edition sent for approval"),
                        HttpStatus.OK);

            }

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to edit decision details");
            LOGGER.debug("Exiting getDecisionDetails Method in " + DecisionToWorkflowServiceImpl.class
                    + " class with response : unauthorized to edit decision details");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to edit decision details"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public ResponseEntity<?> approveDeicison(ApproveDecisionDetails approveDecisionDetails, Authentication pr) {
        LOGGER.debug("entering  class " + DecisionToWorkflowServiceImpl.class + " and method approveDeicison");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);
        if (mp.isApprove()) {

            if (approveDecisionDetails.getCheckerRemark() != null) {
                if (approveDecisionDetails.getCheckerRemark().isEmpty()
                        || approveDecisionDetails.getCheckerRemark().isBlank()) {
                    LOGGER.debug("Exiting approveDeicison Method in "
                            + DecisionToWorkflowServiceImpl.class
                            + " class with response  : with parameters type approve decision details");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to access decision details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Checker remark cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                LOGGER.debug("Exiting approveDeicison Method in " + DecisionToWorkflowServiceImpl.class
                        + " class with response  : with parameters type approve decision details");
                activityLogService.addActivity(loggedInUser, "Failed to access decision details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Checker remark cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (approveDecisionDetails.getApprove() == true) {
                DecisionUiWorkflowAudit audit = null;
                try {
                    // audit =
                    // decisionAuditServiceImpl.findPendingDecisionByID(approveDecisionDetails.getDecisionid());
                    audit = decisionAuditServiceImpl.findPendingDecisionByAuditIDAndTenant(
                            approveDecisionDetails.getIdecisionAuditId(), approveDecisionDetails.getTenantId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (audit != null) {
                    if (audit.getIEntryUserID() == loggedInUser.getIuserID()) {
                        LOGGER.debug("Exiting approveDeicison Method in "
                                + DecisionToWorkflowServiceImpl.class
                                + " class with response  : with parameters type approve decision details");
                        activityLogService.addActivity(loggedInUser,
                                "Failed to access decision details");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, "Maker cannot be checker"),
                                HttpStatus.BAD_REQUEST);
                    }

                    // Decisions masterDecisions = null;
                    // try {
                    // masterDecisions = decisionService
                    // .findByiDecisionID(audit.getIdecisionUiId().getIDecisionID());
                    // } catch (Exception e) {
                    // LOGGER.error("Error : " + e + "\nParam : " + pr);
                    // activityLogService.addActivity("failed to get user and permissions",
                    // e.toString());
                    // return new ResponseEntity<ApiResponse>(
                    // new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    // HttpStatus.INTERNAL_SERVER_ERROR);
                    // }

                    audit.setBclosed(true);
                    audit.setVcRemark("{ " + audit.getVcRemark() + " }" + "{ "
                            + approveDecisionDetails.getCheckerRemark() + " }");
                    if (audit.getVcAction().equals("A")) {
                        audit.setIstatus(statusCodeService.findByIStatusId(2));
                    } else if (audit.getVcAction().equals("M")) {
                        audit.setIstatus(statusCodeService.findByIStatusId(3));
                    } else if (audit.getVcAction().equals("X")) {
                        audit.setIstatus(statusCodeService.findByIStatusId(4));
                    }
                    audit.setDtApproverStamp(ZonedDateTime.now());
                    audit.setIApproverUserID(loggedInUser.getIuserID());
                    audit.setIorgId(loggedInUser.getIorgId());
                    decisionAuditServiceImpl.saveAudit(audit);
                    DecisionUi approvedAudit = null;

                    try {
                        approvedAudit = audit.parseAudit(audit);

                        approvedAudit.setLastStatus("Approved");
                        approvedAudit.setLatestRemark(
                                approveDecisionDetails.getCheckerRemark());
                        approvedAudit.setDtApproverStamp(ZonedDateTime.now());
                        approvedAudit.setIApproverUserID(audit.getIApproverUserID());
                        approvedAudit.setIorgId(audit.getIorgId());
                        approvedAudit.setIstatus(audit.getIstatus().getIStatusIDForMaster());
                        if (audit.getIdecisionUiId() != null) {
                            approvedAudit.setMasterDecisionId(decisionUiServiceImpl
                                    .findByiDecisionID(audit.getIdecisionUiId(), audit.getItenantId())
                                    .getMasterDecisionId());
                        }
                        approvedAudit = decisionUiServiceImpl.save(approvedAudit);
                    } catch (Exception e) {
                        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                        LOGGER.error("Error : " + e + "\nParam : "
                                + loggerEncoderUtil.encode(pr.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                                e.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    if (audit.getIdecisionUiId() != null) {
                        try {
                            ResponseEntity<String> res = null;
                            if (audit.getVcAction().equals("X")) {
                                System.out.println("delete called");
                                res = decisionApiService.deleteDecision(
                                        tenantRepositoryService.findAPIKeyTenant(audit.getItenantId()),
                                        approvedAudit.getMasterDecisionId());
                            } else {

                                res = decisionApiService.editDecision(approvedAudit);
                            }
                            // System.out.println("edit called");
                            System.out.println(res.getBody());
                            System.out.println(res.getStatusCode());
                            if (res.getStatusCode() != HttpStatus.OK) {
                                TransactionAspectSupport.currentTransactionStatus()
                                        .setRollbackOnly();
                                LOGGER.error("Error : Failed to approve decsion");
                                activityLogService.addActivity(loggedInUser,
                                        "failed to get user and permissions",
                                        approvedAudit.toString());
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }
                        } catch (Exception e) {
                            TransactionAspectSupport.currentTransactionStatus()
                                    .setRollbackOnly();
                            LOGGER.error("Error : " + e + "\nParam : "
                                    + loggerEncoderUtil.encode(pr.toString()));
                            activityLogService.addActivity(loggedInUser,
                                    "failed to get user and permissions",
                                    e.toString());
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                    } else {

                        try {
                            ResponseEntity<String> res = decisionApiService
                                    .addDecision(approvedAudit);
                            // System.out.println("add called");
                            // System.out.println(res.body());
                            // System.out.println(res.statusCode());

                            if (res.getStatusCode() != HttpStatus.OK) {
                                TransactionAspectSupport.currentTransactionStatus()
                                        .setRollbackOnly();
                                LOGGER.error("Error : Failed to approve decsion");
                                activityLogService.addActivity(loggedInUser,
                                        "failed to get user and permissions",
                                        approvedAudit.toString());
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }
                            ObjectMapper mapper = new ObjectMapper();
                            JsonNode node = mapper.readTree(res.getBody());
                            approvedAudit.setMasterDecisionId(
                                    node.get("decisionId").asInt());
                            approvedAudit = decisionUiServiceImpl.save(approvedAudit);
                        } catch (Exception e) {
                            TransactionAspectSupport.currentTransactionStatus()
                                    .setRollbackOnly();
                            LOGGER.error("Error : " + e + "\nParam : "
                                    + loggerEncoderUtil.encode(pr.toString()));
                            activityLogService.addActivity(loggedInUser,
                                    "failed to get user and permissions",
                                    e.toString());
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                    }

                    // masterDecisions.setVcResultParams(audit.getVcResultParams());

                    // try {
                    // decisionService.save(masterDecisions);
                    // } catch (Exception e) {
                    // LOGGER.error("Error : " + e + "\nParam : " + pr);
                    // activityLogService.addActivity("failed to get user and permissions",
                    // e.toString());
                    // return new ResponseEntity<ApiResponse>(
                    // new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    // HttpStatus.INTERNAL_SERVER_ERROR);
                    // }
                    String msg = "";
                    if (audit.getVcAction().equalsIgnoreCase("A")) {
                        msg = "Decision addition approved successfully";
                    } else if (audit.getVcAction().equalsIgnoreCase("M")) {
                        msg = "Decision edition approved successfully";
                    } else if (audit.getVcAction().equalsIgnoreCase("X")) {
                        msg = "Decision deletion approved successfully";
                    }
                    LOGGER.debug("Exiting approveDeicison Method in "
                            + DecisionToWorkflowServiceImpl.class
                            + " class with response  : with parameters approve decision");
                    activityLogService.addActivity(loggedInUser, msg);
                    return new ResponseEntity<ApiResponse>(new ApiResponse(true, msg),
                            HttpStatus.OK);

                } else {
                    LOGGER.debug("Exiting approveDeicison Method in "
                            + DecisionToWorkflowServiceImpl.class
                            + " class with response  : with parameters type approve decision details");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to apporve decision details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "No pending entries found"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                DecisionUiWorkflowAudit audit = null;
                try {
                    // audit =
                    // decisionAuditServiceImpl.findPendingDecisionByID(approveDecisionDetails.getDecisionid());
                    audit = decisionAuditServiceImpl.findPendingDecisionByAuditIDAndTenant(
                            approveDecisionDetails.getIdecisionAuditId(), approveDecisionDetails.getTenantId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (audit != null) {
                    if (audit.getIEntryUserID() == loggedInUser.getIuserID()) {
                        LOGGER.debug("Exiting approveDeicison Method in "
                                + DecisionToWorkflowServiceImpl.class
                                + " class with response  : with parameters type approve decision details");
                        activityLogService.addActivity(loggedInUser,
                                "Failed to access decision details");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, "Maker cannot be checker"),
                                HttpStatus.BAD_REQUEST);
                    }

                    audit.setBclosed(true);
                    audit.setVcRemark("{ " + audit.getVcRemark() + " }" + "{ "
                            + approveDecisionDetails.getCheckerRemark() + " }");
                    audit.setIstatus(statusCodeService.findByIStatusId(5));
                    audit.setDtApproverStamp(ZonedDateTime.now());
                    audit.setIApproverUserID(loggedInUser.getIuserID());
                    audit.setIorgId(loggedInUser.getIorgId());
                    decisionAuditServiceImpl.saveAudit(audit);

                    if (audit.getIdecisionUiId() != null) {
                        DecisionUi dec = null;
                        try {
                            dec = decisionUiServiceImpl.findByiDecisionID(
                                    audit.getIdecisionUiId(), audit.getItenantId());
                        } catch (Exception e) {
                            LOGGER.error("Error : " + e + "\nParam : "
                                    + loggerEncoderUtil.encode(pr.toString()));
                            activityLogService.addActivity(loggedInUser,
                                    "failed to get user and permissions",
                                    e.toString());
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                        dec.setLastStatus("Rejected");
                        dec.setLatestRemark(approveDecisionDetails.getCheckerRemark());
                        dec.setDtApproverStamp(ZonedDateTime.now());
                        dec.setIApproverUserID(loggedInUser.getIuserID());
                        dec.setIorgId(loggedInUser.getIorgId());
                        try {
                            decisionUiServiceImpl.save(dec);
                        } catch (Exception e) {
                            LOGGER.error("Error : " + e + "\nParam : "
                                    + loggerEncoderUtil.encode(pr.toString()));
                            activityLogService.addActivity(loggedInUser,
                                    "failed to get user and permissions",
                                    e.toString());
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                    }

                    String msg = "";
                    if (audit.getVcAction().equalsIgnoreCase("A")) {
                        msg = "Decision addition rejected successfully";
                    } else if (audit.getVcAction().equalsIgnoreCase("M")) {
                        msg = "Decision edition rejected successfully";
                    } else if (audit.getVcAction().equalsIgnoreCase("X")) {
                        msg = "Decision deletion rejected successfully";
                    }

                    LOGGER.debug("Exiting approveDeicison Method in "
                            + DecisionToWorkflowServiceImpl.class
                            + " class with response  : with parameters approve decision");
                    activityLogService.addActivity(loggedInUser, msg);
                    return new ResponseEntity<ApiResponse>(new ApiResponse(true, msg),
                            HttpStatus.OK);

                } else {
                    LOGGER.debug("Exiting approveDeicison Method in "
                            + DecisionToWorkflowServiceImpl.class
                            + " class with response  : with parameters type approve decision details");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to apporve decision details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "No pending entries found"),
                            HttpStatus.BAD_REQUEST);
                }
            }

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to approve decision details");
            LOGGER.debug("Exiting approveDeicison Method in " + DecisionToWorkflowServiceImpl.class
                    + " class with response : unauthorized to approve decision details");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to approve decision details"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> deleteDecision(DeleteDecisionRequest decisionRequest, Authentication pr) {
        LOGGER.debug("entering  class " + DecisionToWorkflowServiceImpl.class + " and method deleteDecision");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);
        if (mp.isDelete()) {
            DecisionUi decisionUi = null;

            DecisionUiWorkflowAudit exist = null;
            try {
                exist = decisionAuditServiceImpl
                        .findPendingDecisionByID(decisionRequest.getDecisionId(), decisionRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (exist != null) {
                LOGGER.debug("Exiting editDecisionDetails Method in "
                        + DecisionToWorkflowServiceImpl.class
                        + " class with response  : with parameters type edit decision details");
                activityLogService.addActivity(loggedInUser, "Failed to access decision details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Entry is already pending for action"),
                        HttpStatus.BAD_REQUEST);
            }

            List<TransactionClassesUI> res = new ArrayList<>();
            try {
                res = transactionClassesUiService.findByIdecisionId(decisionRequest.getDecisionId());
                res = res.stream().filter(c -> c.getIRecordStatus() != 1).collect(Collectors.toList());
            } catch (Exception e) {
                LOGGER.error("Error : transaction class 1" + e + "\nParam : "
                        + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (res.size() != 0) {
                LOGGER.debug("Exiting deleteDecision Method in " + DecisionToWorkflowServiceImpl.class
                        + " class with response  : with parameters type delete decision");
                activityLogService.addActivity(loggedInUser, "Failed to access decision details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Decision cannot be deleted, its already used by a class"),
                        HttpStatus.BAD_REQUEST);
            }

            List<TransactionClassesUI> params = null;
            try {
                params = transactionClassesUiService
                        .findByIdecisionIdInParams(decisionRequest.getDecisionId());
            } catch (Exception e) {
                LOGGER.error("Error transaction class ui 2: " + e + "\nParam : "
                        + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (params.size() != 0) {
                LOGGER.debug("Exiting deleteDecision Method in " + DecisionToWorkflowServiceImpl.class
                        + " class with response  : with parameters type delete decision");
                activityLogService.addActivity(loggedInUser, "Failed to access decision details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Decision cannot be deleted, its already used by a class"),
                        HttpStatus.BAD_REQUEST);
            }
            List<TransactionClassesUiAudit> resAudit = new ArrayList<>();
            resAudit = transactionClassessUiAuditService
                    .findPendinEntriesByIDecisionId(decisionRequest.getDecisionId());

            if (resAudit.size() != 0) {
                LOGGER.debug("Exiting deleteDecision Method in " + DecisionToWorkflowServiceImpl.class
                        + " class with response  : with parameters type delete decision");
                activityLogService.addActivity(loggedInUser, "Failed to access decision details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Decision cannot be deleted, its already used by a class in audit"),
                        HttpStatus.BAD_REQUEST);
            }

            try {
                decisionUi = decisionUiServiceImpl.findByiDecisionID(decisionRequest.getDecisionId(), decisionRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            DecisionUiWorkflowAudit newAudit = new DecisionUiWorkflowAudit();
            if (decisionUi != null) {
                newAudit = newAudit.parseToAudit(decisionUi);
                newAudit.setDtEntryDatetime(ZonedDateTime.now());
                newAudit.setDtEntryStamp(ZonedDateTime.now());
                newAudit.setIEntryUserID(loggedInUser.getIuserID());
                newAudit.setIorgId(loggedInUser.getIorgId());
                newAudit.setVcAction("X");
                newAudit.setBActive(false);
                newAudit.setIRecordStatus(1);
                newAudit.setIstatus(null);
                newAudit.setVcRemark(decisionRequest.getMakerRemark());
                decisionAuditServiceImpl.saveAudit(newAudit);
                LOGGER.debug("Exiting deleteDeicison Method in " + DecisionToWorkflowServiceImpl.class
                        + " class with response  : with parameters delete decision");
                activityLogService.addActivity(loggedInUser, "Decision deletion sent for approval");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(true, "Decision deletion sent for approval"),
                        HttpStatus.OK);
            } else {
                LOGGER.debug("Exiting deleteDecisionDetails Method in "
                        + DecisionToWorkflowServiceImpl.class
                        + " class with response  : with parameters type delete decision ");
                activityLogService.addActivity(loggedInUser, "Failed to delete decision ");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "No entry found for decision id "
                                        + decisionRequest.getDecisionId()),
                        HttpStatus.BAD_REQUEST);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to delete decision");
            LOGGER.debug("Exiting deleteeDeicison Method in " + DecisionToWorkflowServiceImpl.class
                    + " class with response : unauthorized to delete decision");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to delete decision"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> addDecisionDetails(AddNewDecisionRequestGt addDecisionRequest, Authentication pr) {
        LOGGER.debug("entering  class " + DecisionToWorkflowServiceImpl.class
                + " and method addDecisionDetails");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isAdd() && loggedUser.allowTenants(Arrays.asList(addDecisionRequest.getItenantId()))) {
            DecisionUiWorkflowAudit decisionUiWorkflowAudit = new DecisionUiWorkflowAudit();
            decisionUiWorkflowAudit.setBActive(addDecisionRequest.getActive());
            decisionUiWorkflowAudit.setDtEntryDatetime(ZonedDateTime.now());
            decisionUiWorkflowAudit.setBclosed(false);
            decisionUiWorkflowAudit.setDtEntryStamp(ZonedDateTime.now());
            decisionUiWorkflowAudit.setItenantId(addDecisionRequest.getItenantId());
            if (addDecisionRequest.getProductId() == null) {
                LOGGER.debug("Exiting addDecisionDetails Method in "
                        + DecisionToWorkflowServiceImpl.class
                        + " class with response  : with parameter add decision");
                activityLogService.addActivity(loggedInUser, "Failed to add decision",
                        "Parameters : " + addDecisionRequest.getProductId());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Product id of new decison cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }
            Products products = null;
            try {
                products = productService.findByiProductID(addDecisionRequest.getProductId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            if (products != null) {
                decisionUiWorkflowAudit.setIProductID(products);
            } else {
                LOGGER.debug("Exiting addNewTransactionClass Method in "
                        + DecisionToWorkflowServiceImpl.class
                        + " class with response  : with parameter add decision");
                activityLogService.addActivity(loggedInUser, "Failed to add decision",
                        "Parameters : " + addDecisionRequest.getProductId());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "No Product found for product id :- "
                                        + addDecisionRequest.getProductId()),
                        HttpStatus.BAD_REQUEST);
            }
            decisionUiWorkflowAudit.setIUserID(loggedInUser.getIuserID());
            decisionUiWorkflowAudit.setIorgId(loggedInUser.getIorgId());
            decisionUiWorkflowAudit.setIEntryUserID(loggedInUser.getIuserID());
            decisionUiWorkflowAudit.setIorgId(loggedInUser.getIorgId());
            if (addDecisionRequest.getVcDecisionDetail() != null) {
                if (!addDecisionRequest.getVcDecisionDetail().isEmpty()
                        && !addDecisionRequest.getVcDecisionDetail().isBlank()) {
                    decisionUiWorkflowAudit
                            .setVcDecisionDetail(addDecisionRequest.getVcDecisionDetail());
                } else {
                    LOGGER.debug("Exiting addNewTransactionClass Method in "
                            + DecisionToWorkflowServiceImpl.class
                            + " class with response  : with parameter add decision");
                    activityLogService.addActivity(loggedInUser, "Failed to add decision",
                            "Parameters : " + addDecisionRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Decision detail of new decison cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                LOGGER.debug("Exiting addNewTransactionClass Method in "
                        + DecisionToWorkflowServiceImpl.class
                        + " class with response  : with parameter add decision");
                activityLogService.addActivity(loggedInUser, "Failed to add decision",
                        "Parameters : " + addDecisionRequest.getProductId());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Decision detail of new decison cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            decisionUiWorkflowAudit.setVcAction("A");
            if (addDecisionRequest.getVcDecisionName() != null) {
                if (!addDecisionRequest.getVcDecisionName().isEmpty()
                        && !addDecisionRequest.getVcDecisionName().isBlank()) {
                    if (addDecisionRequest.getVcDecisionName().length() > 20) {
                        LOGGER.debug("Exiting addDecisionDetails Method in "
                                + DecisionToWorkflowServiceImpl.class
                                + " class with response  : with parameter add decision");
                        activityLogService.addActivity(loggedInUser, "Failed to add decision",
                                "Parameters : " + addDecisionRequest.getProductId());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Decision name should not be more than 20 characters"),
                                HttpStatus.BAD_REQUEST);
                    }
                    decisionUiWorkflowAudit
                            .setVcDecisionName(addDecisionRequest.getVcDecisionName());
                } else {
                    LOGGER.debug("Exiting addDecisionDetails Method in "
                            + DecisionToWorkflowServiceImpl.class
                            + " class with response  : with parameter add decision");
                    activityLogService.addActivity(loggedInUser, "Failed to add decision",
                            "Parameters : " + addDecisionRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Decision name of new decison cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                LOGGER.debug("Exiting addDecisionDetails Method in "
                        + DecisionToWorkflowServiceImpl.class
                        + " class with response  : with parameter add decision");
                activityLogService.addActivity(loggedInUser, "Failed to add decision",
                        "Parameters : " + addDecisionRequest.getProductId());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Decision name of new decison cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addDecisionRequest.getMakerRemark() != null) {
                if (!addDecisionRequest.getMakerRemark().isEmpty()
                        && !addDecisionRequest.getMakerRemark().isBlank()) {
                    decisionUiWorkflowAudit.setVcRemark(addDecisionRequest.getMakerRemark());
                } else {
                    LOGGER.debug("Exiting addDecisionDetails Method in "
                            + DecisionToWorkflowServiceImpl.class
                            + " class with response  : with parameter add decision");
                    activityLogService.addActivity(loggedInUser, "Failed to add decision",
                            "Parameters : " + addDecisionRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Decision name of new decison cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                LOGGER.debug("Exiting addDecisionDetails Method in "
                        + DecisionToWorkflowServiceImpl.class
                        + " class with response  : with parameter add decision");
                activityLogService.addActivity(loggedInUser, "Failed to add decision",
                        "Parameters : " + addDecisionRequest.getProductId());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Decision name of new decison cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }
            decisionUiWorkflowAudit.setIRecordStatus(0);
            JsonNode attribs = addDecisionRequest.getAttribs();
            if (attribs != null && attribs.getNodeType() != JsonNodeType.NULL) {
                decisionUiWorkflowAudit.setAttribs(attribs);
            }
            decisionUiWorkflowAudit.setVcResultParams(addDecisionRequest.getVcResultParams());
            try {
                decisionUiWorkflowAudit = decisionAuditServiceImpl.saveAudit(decisionUiWorkflowAudit);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            LOGGER.debug("Exiting addDecisionDetails Method in " + DecisionToWorkflowServiceImpl.class
                    + " class with response  : with parameters add decision");
            activityLogService.addActivity(loggedInUser, "Decision addition sent for approval");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(true, "Decision addition sent for approval"), HttpStatus.OK);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to add decision");
            LOGGER.debug("Exiting deleteeDeicison Method in " + DecisionToWorkflowServiceImpl.class
                    + " class with response : unauthorized to add decision");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to add decision"),
                    HttpStatus.FORBIDDEN);
        }

    }
}
