package com.DronaPay.UIServer.service.ControllerService.CaseManagement;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.ResponseVO.DropdownWithObject;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.model.WorkflowMasters;
import com.DronaPay.UIServer.requests.GetTaskListRequest;
import com.DronaPay.UIServer.requests.LoadMoreTaskListRequest;
import com.DronaPay.UIServer.requests.LoadMoreTaskListRequestGt;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.KeysTenants;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.service.CamundaService;
import com.DronaPay.UIServer.service.HelperServices.ExcelHelperService;
import com.DronaPay.UIServer.service.RepositoryService.ActivityLogService;
import com.DronaPay.UIServer.service.RepositoryService.WebUserService;
import com.DronaPay.UIServer.service.RepositoryService.WorkflowMasterService;
import com.DronaPay.UIServer.util.CamundaParamExtractor;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.ClientResponse;

import java.io.ByteArrayInputStream;
import java.util.*;

@Service
public class CaseSummaryServiceImpl implements CaseSummaryService {

    private static final Logger LOGGER = LoggerFactory.getLogger(CaseSummaryServiceImpl.class);

    private final String className = String.valueOf(CaseSummaryServiceImpl.class);

    final String menu_name = MenuNames.caseSummary;

    @Autowired
    private ActivityLogService activityLogService;

    @Autowired
    private WebUserService webUserService;

    @Autowired
    private CamundaService camundaService;

    @Autowired
    private CamundaParamExtractor camundaParamExtractor;

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Autowired
    private WorkflowMasterService workflowMasterService;

    public ResponseEntity<?> getTaskList(LoadMoreTaskListRequestGt loadMoreTaskListRequestGt, Authentication pr) {
        LOGGER.debug("entered in class " + className + " in method getTaskList");

        KeysTenants keysTenants = camundaParamExtractor
                .extractTenantWorkflows(loadMoreTaskListRequestGt.getParameters());
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);
        LoadMoreTaskListRequest loadMoreTaskListRequest = new LoadMoreTaskListRequest();
        loadMoreTaskListRequest.setMaxResult(loadMoreTaskListRequestGt.getMaxResult());
        loadMoreTaskListRequest.setNextStartIndex(loadMoreTaskListRequestGt.getNextStartIndex());
        loadMoreTaskListRequest.setParameters(loadMoreTaskListRequestGt.getParameters());
        if (mp.isView()
                && loggedUser.allowTenantsWorkflowKeys(keysTenants.getItenantIds(), keysTenants.getWorkflowKeys())) {
            ResponseEntity<String> tasklist = null;
            try {
                tasklist = camundaService.getTaskListPostLoadMoreHttp(loadMoreTaskListRequest, loggedInUser);
                activityLogService.addActivity(loggedInUser, "task list for case summery accessed",
                        tasklist.getBody());
            } catch (Exception e) {

                LOGGER.error(loggerEncoderUtil
                        .encode("Error : " + e + "\nParam : path " + loadMoreTaskListRequest.toString()));
                activityLogService.addActivity(loggedInUser, "failed to access task list for case summery",
                        "Error : " + e.toString() + ", Parameters : " + loadMoreTaskListRequest.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            // String response = clientResponse.bodyToMono(String.class).block();

            List<String> instaceId = new ArrayList<>();
            JSONArray taskList = new JSONArray();
            if (tasklist != null) {
                if (tasklist.getStatusCode() == HttpStatus.OK) {
                    taskList = new JSONArray(tasklist.getBody());

                    for (int i = 0; i < taskList.length(); i++) {
                        instaceId.add(taskList.getJSONObject(i).optString("processInstanceId"));
                    }

                    ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
                    String json = null;
                    try {
                        json = ow.writeValueAsString(instaceId);
                    } catch (JsonProcessingException e) {
                        LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(instaceId.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to get details",
                                "Error : " + e.toString() + ", Parameters : " + instaceId);
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    String processInJson = "{\r\n  \"processInstanceIdIn\": " + json
                            + ",\r\n  \"sorting\": [\r\n    {\r\n      \"sortBy\": \"time\",\r\n      \"sortOrder\": \"desc\"\r\n    }\r\n  ]\r\n}";

                    ResponseEntity<String> details = null;

                    if (instaceId.size() != 0) {
                        try {
                            details = camundaService.postHistoryDetail(processInJson, loggedInUser);
                            activityLogService.addActivity(loggedInUser, "history details for case summery accessed",
                                    tasklist.getBody());
                        } catch (Exception e) {
                            LOGGER.error("Error : " + e + "\nParam : " + processInJson);
                            activityLogService.addActivity(loggedInUser, "failed to get details",
                                    "Error : " + e.toString() + ", Parameters : " + processInJson);
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                    }

                    // System.out.println(details.body());

                    if (details != null) {
                        if (details.getStatusCode() == HttpStatus.OK) {
                            JSONArray detailList = new JSONArray(details.getBody());

                            for (int k = 0; k < taskList.length(); k++) {
                                org.json.JSONObject taskListInstance = taskList.getJSONObject(k);
                                // System.out.println(detailList.length());
                                Boolean foundClaim = false;

                                for (int n = 0; n < detailList.length(); n++) {
                                    if (taskListInstance.getString("processInstanceId")
                                            .equals(detailList.getJSONObject(n).getString("processInstanceId"))) {

                                        if (detailList.getJSONObject(n).get("type").equals("variableUpdate")) {
                                            if (taskListInstance.get("assignee") != JSONObject.NULL
                                                    && detailList.getJSONObject(n).get("variableName")
                                                            .equals("userActivity")) {

                                                ObjectMapper mapperuser = new ObjectMapper();
                                                JsonNode nodeuser = null;
                                                try {
                                                    nodeuser = mapperuser
                                                            .readTree(detailList.getJSONObject(n).get("value")
                                                                    .toString());
                                                } catch (Exception e1) {
                                                    // TODO Auto-generated catch block
                                                    // e1.printStackTrace();
                                                    LOGGER.error("Error is " + e1);
                                                }

                                                if (nodeuser.get("action").asText().equals("Claim")
                                                        && foundClaim == false) {
                                                    taskListInstance.put("recentClaimee",
                                                            webUserService
                                                                    .findByIUserID(nodeuser.get("user").asText()));
                                                    taskListInstance.put("recentClaimTime",
                                                            detailList.getJSONObject(n).get("time"));
                                                    foundClaim = true;
                                                }
                                            }

                                            if (detailList.getJSONObject(n).get("variableName").equals("Alert")) {
                                                taskListInstance.put("Alert",
                                                        detailList.getJSONObject(n).get("value").toString());
                                            }

                                            if (detailList.getJSONObject(n).get("variableName").equals("payee")) {
                                                taskListInstance.put("payee",
                                                        detailList.getJSONObject(n).get("value").toString());
                                            }

                                            if (detailList.getJSONObject(n).get("variableName").equals("payer")) {
                                                taskListInstance.put("payer",
                                                        detailList.getJSONObject(n).get("value").toString());
                                            }

                                            if (detailList.getJSONObject(n).get("variableName")
                                                    .equals("TransactionAmount")) {
                                                // System.out.println(detailList.getJSONObject(n).get("value").toString());
                                                taskListInstance
                                                        .put("TransactionAmount",
                                                                Double.parseDouble(
                                                                        detailList.getJSONObject(n).get("value")
                                                                                .toString())
                                                                        / 100);
                                            }

                                            if (detailList.getJSONObject(n).get("variableName").equals("TicketID")) {
                                                taskListInstance.put("TicketID",
                                                        detailList.getJSONObject(n).get("value").toString());
                                            }

                                            if (detailList.getJSONObject(n).get("variableName")
                                                    .equals("WorkflowName")) {
                                                taskListInstance.put("WorkflowName",
                                                        detailList.getJSONObject(n).get("value").toString());
                                            }
                                        }

                                    }
                                }

                                taskList.put(k, taskListInstance);
                            }

                            // System.out.println(taskList);
                            activityLogService.addActivity(loggedInUser, "Task list for Case Summary accessed",
                                    "parameters : " + loadMoreTaskListRequest.toString());
                            LOGGER.debug("exiting class " + className + " and method getTaskList");
                            return ResponseEntity.ok(taskList.toString());

                        } else {
                            activityLogService.addActivity(loggedInUser, "failed to access task list for Case Summary",
                                    "Parameters : " + loadMoreTaskListRequest.toString());
                            LOGGER.error("exiting class " + className
                                    + " and method getTaskList with response : failed to get tasklist for Case Summary"
                                    + details.getBody());
                            return ResponseEntity.ok(taskList.toString());
                        }
                    }
                } else {
                    activityLogService.addActivity(loggedInUser, "failed to access task list for Case Summary",
                            "Parameters : " + loadMoreTaskListRequest.toString());
                    LOGGER.error("exiting class " + TasksServiceImpl.class
                            + " and method getTaskList with response : failed to get tasklist for Case Summary"
                            + tasklist.getBody());
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, tasklist.getBody()),
                            tasklist.getStatusCode());
                }
            }

            activityLogService.addActivity(loggedInUser, "failed to access task list for Case Summary",
                    "Parameters : " + loadMoreTaskListRequest.toString());
            LOGGER.info("exiting class " + TasksServiceImpl.class
                    + " and method getTaskList with response : failed to get task list for Case Summary");
            return ResponseEntity.ok(taskList.toString());
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access list of tasks for case summary");
            LOGGER.debug("Exiting getListDropDown Method in " + CaseSummaryServiceImpl.class
                    + " class with response  : unauthorized to access list of tasks for case summary");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access list of tasks for case summary"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getWorkFlowName(Authentication pr) {

        LOGGER.debug("entering  class " + CaseSummaryServiceImpl.class + " and method getWorkFlowName");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(MenuNames.Tasks);

        if (mp.isView()) {

            List<WorkflowMasters> allWorkflows = null;
            try {
                allWorkflows = workflowMasterService.findAll();
                activityLogService.addActivity(loggedInUser, " list of workflow for case summary accessed");
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
                activityLogService.addActivity(loggedInUser, " list of workflow names for case summary accessed");
            } catch (Exception e) {
                LOGGER.error("Error : " + e);
                activityLogService.addActivity(loggedInUser, "failed to get workflow name for case summary",
                        "Error : " + e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

//            String responses = clientResponse.bodyToMono(String.class).block();
            String responses = clientResponse.getBody();
//            clientResponse.releaseBody();
            if (clientResponse.getStatusCode() == HttpStatus.OK) {
                JSONArray workflowNames = new JSONArray(responses);

                List<DropdownWithObject> workFlowDropDown = new ArrayList<>();
                workFlowDropDown.add(DropdownWithObject.builder().label("All Cases").value("").build());

                try {
                    for (WorkflowMasters wfl : allWorkflows) {
                        for (int i = 0; i < workflowNames.length(); i++) {
                            org.json.JSONObject objectInArray = workflowNames.getJSONObject(i);
                            if (wfl.getWorkflowKey().equals(objectInArray.get("key"))) {
                                workFlowDropDown.add(DropdownWithObject.builder().label(objectInArray.get("name"))
                                        .value(objectInArray.get("key")).build());
                            }
                        }
                    }
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + responses);
                    activityLogService.addActivity(loggedInUser, "failed to get task history for case summary ",
                            "Error : " + e.toString() + ", Parameters : " + responses);
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                activityLogService.addActivity(loggedInUser,
                        " list of workflow names for case summary accessed successfully");
                LOGGER.debug("Exiting getWorkFlowName Method in " + CaseSummaryServiceImpl.class
                        + " class with response : workflow names for case summary");
                return ResponseEntity.ok(workFlowDropDown);

            } else {
                activityLogService.addActivity(loggedInUser, "unauthorized to get workflow names for case summary");
                LOGGER.debug("Exiting getWorkFlowName Method in " + CaseSummaryServiceImpl.class
                        + " class with response : unauthorized to get workflow names for case summary");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "unauthorized to get workflow names for case summary"),
                        HttpStatus.FORBIDDEN);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access list of tasks for case summary");
            LOGGER.debug("Exiting getWorkflowName Method in " + CaseSummaryServiceImpl.class
                    + " class with response  : unauthorized to access list of workflow names for case summary");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access list of workflow names for case summary"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getTaskListCount(String paramater, Authentication pr) {
        LOGGER.debug("entered in class " + className + " in method getTaskList");
        KeysTenants keysTenants = camundaParamExtractor.extractTenantWorkflows(paramater);
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()
                && loggedUser.allowTenantsWorkflowKeys(keysTenants.getItenantIds(), keysTenants.getWorkflowKeys())) {
            ResponseEntity<String> clientResponse = null;
            try {
                clientResponse = camundaService.getTaskListPostCount(paramater, loggedInUser);

            } catch (Exception e) {

                LOGGER.error("Error : " + e + "\nParam : path " + loggerEncoderUtil.encode(paramater));
                activityLogService.addActivity(loggedInUser, "failed to access task list for case summery",
                        "Error : " + e.toString() + ", Parameters : " + paramater);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

//            String response = clientResponse.bodyToMono(String.class).block();
            String response = clientResponse.getBody();
//            clientResponse.releaseBody();
            if (clientResponse.getStatusCode() == HttpStatus.OK) {
                ObjectMapper mapper = new ObjectMapper();
                try {
                    JsonNode actualObj = mapper.readTree(response);
                    activityLogService.addActivity(loggedInUser,
                            " task list count for case summary accessed successfully");
                    return ResponseEntity.ok(actualObj);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : path " + loggerEncoderUtil.encode(paramater));
                    activityLogService.addActivity(loggedInUser, "failed to access task list for case summery",
                            "Error : " + e.toString() + ", Parameters : " + paramater);
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

            } else {
                activityLogService.addActivity(loggedInUser, "failed to access task list for case summary",
                        "Parameters : " + paramater);
                LOGGER.error("exiting  class " + CaseSummaryServiceImpl.class
                        + " and method getTaskList with response : " + response);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, response), clientResponse.getStatusCode());

            }

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access list of tasks for case summary");
            LOGGER.debug("Exiting getListDropDown Method in " + CaseSummaryServiceImpl.class
                    + " class with response  : unauthorized to access list of tasks for case summary");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access list of tasks for case summary"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getTaskNew(LoadMoreTaskListRequest loadMoreTaskListRequest, Authentication pr) {
        // TODO Auto-generated method stub
        return null;
    }

    private void extractVariables(JSONObject detail, JSONObject taskListInstance, Boolean foundClaim) {
        if (detail.get("variableName").equals("userActivity")) {
            ObjectMapper mapperuser = new ObjectMapper();
            JsonNode nodeuser = null;
            try {
                nodeuser = mapperuser
                        .readTree(detail.get("value").toString());
            } catch (Exception e1) {
                // TODO Auto-generated catch block
                LOGGER.error("Error is " + e1);
            }

            if (nodeuser.get("action").asText().equals("Claim")
                    && foundClaim == false) {
                taskListInstance.put("recentClaimee",
                        webUserService.findByIUserID(nodeuser.get("user").asText()));
                taskListInstance.put("recentClaimTime",
                        detail.get("time"));
                foundClaim = true;
            }
        }

        if (detail.get("variableName").equals("Alert")) {
            taskListInstance.put("Alert",
                    detail.get("value").toString());
        }

        if (detail.get("variableName").equals("payee")) {
            taskListInstance.put("payee",
                    detail.get("value").toString());
        }

        if (detail.get("variableName").equals("payer")) {
            taskListInstance.put("payer",
                    detail.get("value").toString());
        }

        if (detail.get("variableName")
                .equals("TransactionAmount")) {
            // System.out.println(detailList.getJSONObject(n).get("value").toString());
            taskListInstance
                    .put("TransactionAmount",
                            Double.parseDouble(
                                    detail.get("value")
                                            .toString())
                                    / 100);
        }

        if (detail.get("variableName").equals("TicketID")) {
            taskListInstance.put("TicketID",
                    detail.get("value").toString());
        }

        if (detail.get("variableName")
                .equals("WorkflowName")) {
            taskListInstance.put("WorkflowName",
                    detail.get("value").toString());
        }
    }

    @Override
    public ResponseEntity<?> exportSummary(String paramater, Authentication pr) {
        LOGGER.debug("entered in class " + className + " in method  exportSummary");

        KeysTenants keysTenants = camundaParamExtractor.extractTenantWorkflows(paramater);
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()
                && loggedUser.allowTenantsWorkflowKeys(keysTenants.getItenantIds(), keysTenants.getWorkflowKeys())) {
            ResponseEntity<String> tasklist = null;
            GetTaskListRequest getTaskListRequest = new GetTaskListRequest();
            getTaskListRequest.setParameters(paramater);
            getTaskListRequest.setMaxResult(5000);
            long t1 = (new Date()).getTime();
            try {
                tasklist = camundaService.getTaskListPostHttp(getTaskListRequest, loggedInUser);

            } catch (Exception e) {
                LOGGER.error(
                        "Error : " + e + "\nParam : path " + loggerEncoderUtil.encode(getTaskListRequest.toString()));
                activityLogService.addActivity(loggedInUser, "failed to access task list for case summery",
                        "Error : " + e.toString() + ", Parameters : " + getTaskListRequest.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            long t2 = (new Date()).getTime();
            System.out.println("Time for get task list camunda api " + (t2 - t1));

            List<String> instaceId = new ArrayList<>();
            if (tasklist != null) {
                if (tasklist.getStatusCode() == HttpStatus.OK) {

                    activityLogService.addActivity(loggedInUser, " task list for case summary accessed successfully",
                            getTaskListRequest.toString());
                    JSONArray taskList = new JSONArray(tasklist.getBody());
                    Map<String, org.json.JSONObject> taskPosMap = new HashMap<>();
                    Map<String, org.json.JSONObject> dupProcMap = new HashMap<>();
                    Integer limit = 999;
                    ResponseEntity<String> details = null;
                    long t3 = (new Date()).getTime();
                    System.out.println("Task list length " + taskList.length());
                    for (int i = 0; i < taskList.length(); i++) {
                        String procInstId = taskList.getJSONObject(i).optString("processInstanceId");
                        instaceId.add(procInstId);
                        /// if proc instance is duplicate, don't overwrite, add to duplicate map
                        if (taskPosMap.containsKey(procInstId) == false) {
                            taskPosMap.put(procInstId, taskList.getJSONObject(i));
                        } else {
                            dupProcMap.put(procInstId, taskList.getJSONObject(i));
                        }

                        if (i == limit || i == taskList.length() - 1) {
                            ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
                            String json = null;
                            try {
                                json = ow.writeValueAsString(instaceId);
                            } catch (JsonProcessingException e) {
                                LOGGER.error("Error : " + e + "\nParam : " + instaceId);
                                activityLogService.addActivity(loggedInUser, "failed to get details",
                                        "Error : " + e.toString() + ", Parameters : " + instaceId);
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }

                            String processInJson = "{\r\n  \"processInstanceIdIn\": " + json
                                    + ",\r\n " + "\"variableUpdates\":true,"
                                    + "\r\n \"sorting\": [\r\n    {\r\n      \"sortBy\": \"processInstanceId\",\r\n      \"sortOrder\": \"desc\"\r\n    }\r\n, {\r\n      \"sortBy\": \"time\",\r\n      \"sortOrder\": \"desc\"\r\n    }\r\n  ]\r\n}";

                            // System.out.println("request for history detail" + processInJson);

                            if (instaceId.size() != 0) {
                                long hd1 = (new Date()).getTime();
                                try {
                                    details = camundaService.postHistoryDetail(processInJson, loggedInUser);
                                } catch (Exception e) {
                                    LOGGER.error("Error : " + e + "\nParam : " + processInJson);
                                    activityLogService.addActivity(loggedInUser, "failed to get details",
                                            "Error : " + e.toString() + ", Parameters : " + processInJson);
                                    return new ResponseEntity<ApiResponse>(
                                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                            HttpStatus.INTERNAL_SERVER_ERROR);
                                }
                                long hd2 = (new Date()).getTime();
                                System.out.println("Camunda api call time for history " + (hd2 - hd1));

                                if (details == null) {
                                    activityLogService.addActivity(loggedInUser,
                                            "failed to access task details for case summary",
                                            "Parameters : " + getTaskListRequest.toString());
                                    LOGGER.error("exiting  class " + CaseSummaryServiceImpl.class
                                            + " and method  exportSummary with response : " + tasklist.getBody());
                                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, "No details found"),
                                            tasklist.getStatusCode());
                                }
                                if (details.getStatusCode() != HttpStatus.OK) {
                                    activityLogService.addActivity(loggedInUser,
                                            "failed to access task details for case summary",
                                            "Parameters : " + getTaskListRequest.toString());
                                    LOGGER.error("exiting  class " + CaseSummaryServiceImpl.class
                                            + " and method  exportSummary with response : " + tasklist.getBody());
                                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, details.getBody()),
                                            tasklist.getStatusCode());
                                }

                                activityLogService.addActivity(loggedInUser, "accessed task details for case summary",
                                        "Parameters : " + getTaskListRequest.toString());
                                JSONArray detailsAll = new JSONArray(details.getBody());
                                String prevProcId = null;
                                Boolean foundClaim = false;
                                Boolean foundClaim2 = false;
                                org.json.JSONObject taskListInstance = null;
                                org.json.JSONObject taskListInstance2 = null;
                                
                                System.out.println("Details size " + detailsAll.length());
                                long variableUpdateCount = 0;
                                for (int j = 0; j < detailsAll.length(); j++) {
                                    JSONObject detail = detailsAll.getJSONObject(j);
                                    String curProcId = detail.getString("processInstanceId");
                                    if (!curProcId.equals(prevProcId)) {
                                        foundClaim = false;
                                        taskListInstance = taskPosMap.get(curProcId);
                                        extractVariables(detail, taskListInstance, foundClaim);
                                        if(dupProcMap.containsKey(curProcId)) {
                                            taskListInstance2 = dupProcMap.get(curProcId);
                                            foundClaim2 = false;
                                            extractVariables(detail, taskListInstance2, foundClaim2);
                                        } else {
                                            taskListInstance2 = null;
                                        }  
                                    } else {
                                        extractVariables(detail, taskListInstance, foundClaim);
                                        if(taskListInstance2 != null) {
                                            extractVariables(detail, taskListInstance2, foundClaim2);
                                        }
                                    }
                                    // if (detail.get("type").equals("variableUpdate")) {
                                    variableUpdateCount++;

                                    // }

                                    prevProcId = curProcId;
                                }
                                System.out.println("Variable update history count " + variableUpdateCount);
                            }

                            limit = limit + 999;
                            instaceId.removeAll(instaceId);
                        }
                    }

                    long t4 = (new Date()).getTime();
                    System.out.println("Time for history detail of task list " + (t4 - t3));

                    long t5 = (new Date()).getTime();
                    ByteArrayInputStream arrayInputStream = ExcelHelperService
                            .caseSummaryToExcel(taskList, loggedInUser);
                    InputStreamResource file = new InputStreamResource(arrayInputStream);
                    long t6 = (new Date()).getTime();
                    System.out.println("Generating excel takes time " + (t6 - t5));
                    activityLogService.addActivity(loggedInUser,
                            "Excel of list of task for Case summary downloaded successfully ",
                            "parameters : " + getTaskListRequest.toString());
                    LOGGER.debug("Exiting exportSummary Method in " + CaseSummaryServiceImpl.class
                            + " class with response  : list of tasks for case");
                    // System.gc();
                    return ResponseEntity.ok()
                            .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=Casesummary.zip")
                            .contentType(MediaType.parseMediaType("application/zip"))
                            .body(file);
                } else {
                    activityLogService.addActivity(loggedInUser, "failed to access task list for case summary",
                            "Parameters : " + getTaskListRequest.toString());
                    LOGGER.error("exiting  class " + CaseSummaryServiceImpl.class
                            + " and method  exportSummary with response : " + tasklist.getBody());
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, tasklist.getBody()),
                            tasklist.getStatusCode());

                }
            } else {
                activityLogService.addActivity(loggedInUser, "failed to access task list for case summary",
                        "Parameters : " + getTaskListRequest.toString());
                LOGGER.error("exiting  class " + CaseSummaryServiceImpl.class
                        + " and method  exportSummary with response : " + tasklist.getBody());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, tasklist.getBody()),
                        tasklist.getStatusCode());
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access list of tasks for case summary");
            LOGGER.debug("Exiting  exportSummary Method in " + CaseSummaryServiceImpl.class
                    + " class with response  : unauthorized to export  case summary");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Unauthorized to export  case summary"),
                    HttpStatus.FORBIDDEN);
        }
    }
}
