package com.DronaPay.UIServer.service.ControllerService;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.util.ListValidationUtil;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.ResponseVO.DropDownVo;
import com.DronaPay.UIServer.ResponseVO.DropdownWithObject;
import com.DronaPay.UIServer.ResponseVO.UserAndPermissions;
import com.DronaPay.UIServer.ResponseVO.UserTaskDropDown;
import com.DronaPay.UIServer.VOMapper.DropdownWithObjectMapper;
import com.DronaPay.UIServer.controller.CaseManagementController.TasksController;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.model.WorkflowMasters;
import com.DronaPay.UIServer.requests.CamundaRequests.AddComment;
import com.DronaPay.UIServer.requests.*;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.BulkReassignTicket;
import com.DronaPay.UIServer.response.KeysTenants;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.service.CamundaService;
import com.DronaPay.UIServer.service.ControllerService.CaseManagement.TasksService;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.CamundaParamExtractor;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.DronaPay.UIServer.util.XMLParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.simple.JSONValue;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.w3c.dom.NodeList;

import java.util.*;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Service
public class ProcessBulkTicketsServiceImpl implements ProcessBulkTicketsService {
        final Logger LOGGER = LogManager.getLogger(TasksController.class);
        final String menu_name = MenuNames.Tasks;
        @Autowired
        private ActivityLogService activityLogService;
        @Autowired
        private WebUserService webUserService;
        @Autowired
        private CamundaService camundaService;
        @Autowired
        private TasksService tasksService;
        @Autowired
        private VpaService vpaService;
        @Autowired
        private LoggerEncoderUtil loggerEncoderUtil;
        @Autowired
        private WorkflowMasterService workflowMasterService;
        @Autowired
        private RulesTempServiceImpl rulesTempService;
        @Autowired
        private DecisionUiService decisionService;
        @Autowired
        private XMLParser xmlParser;
        @Autowired
        private CamundaParamExtractor camundaParamExtractor;
        @Value("${max.xml.field.length}")
        private Integer maxFieldLength;

        public LinkedHashMap<String, org.json.simple.JSONObject> renderedForm(String taskid, WebUser loggedInUser)
                        throws Exception {
                ResponseEntity<String> clientResponse = null;
                ResponseEntity<String> formVariable = null;

                clientResponse = camundaService.getRenderedForm(taskid, loggedInUser);
                formVariable = camundaService.getFormVariable(taskid, loggedInUser);

                // String response = clientResponse.bodyToMono(String.class).block();
                String response = clientResponse.getBody();
                // clientResponse.releaseBody();
                // String formVariableResponse = formVariable.bodyToMono(String.class).block();
                String formVariableResponse = formVariable.getBody();
                // formVariable.releaseBody();
                LinkedHashMap<String, org.json.simple.JSONObject> responseMap = new LinkedHashMap<>();
                if (clientResponse.getStatusCode() == HttpStatus.OK && formVariable.getStatusCode() == HttpStatus.OK) {

                        Object obj = JSONValue.parse(formVariableResponse);
                        org.json.simple.JSONObject formVariableResponseJson = (org.json.simple.JSONObject) obj;

                        Document html = Jsoup.parse(response);

                        Elements form = html.getElementsByClass("form-group");

                        for (Element element : form) {

                                if (element.select("input[type=checkbox]").size() > 0) {

                                        String checkboxid = element.select("input").attr("name");
                                        String labelText = element.select("label").text();
                                        org.json.simple.JSONObject checkbox = (org.json.simple.JSONObject) formVariableResponseJson
                                                        .get(checkboxid);
                                        checkbox.put("label", labelText);
                                        checkbox.put("inputType", "checkbox");
                                        checkbox.put("required",
                                                        element.select("input[required]").size() > 0 ? true : false);
                                        checkbox.put("readonly", element.select("input[readonly]").size() > 0
                                                        || element.select("input[disabled]").size() > 0 ? true : false);

                                        responseMap.put(checkboxid, checkbox);
                                }
                                if (element.select("select").size() > 0) {

                                        String radiobuttonid = element.select("select").attr("name");
                                        String labelText = element.select("label").text();
                                        org.json.simple.JSONObject radioButton = (org.json.simple.JSONObject) formVariableResponseJson
                                                        .get(radiobuttonid);

                                        radioButton.put("label", labelText);
                                        radioButton.put("required",
                                                        element.select("select[required]").size() > 0 ? true : false);
                                        radioButton.put("readonly", element.select("select[readonly]").size() > 0
                                                        || element.select("select[disabled]").size() > 0 ? true
                                                                        : false);
                                        List<org.json.simple.JSONObject> optionsList = new ArrayList<>();
                                        Elements options = element.select("option");

                                        if (options.size() < 3) {
                                                radioButton.put("inputType", "radiobutton");
                                        } else {
                                                radioButton.put("inputType", "select");
                                        }

                                        for (Element e : options) {

                                                Object tempString = JSONValue.parse("{}");
                                                org.json.simple.JSONObject temp = (org.json.simple.JSONObject) tempString;
                                                temp.put("label", e.select("option").text());
                                                temp.put("value", e.select("option").attr("value"));
                                                optionsList.add(temp);
                                        }
                                        radioButton.put("availableValue", optionsList);

                                        responseMap.put(radiobuttonid, radioButton);
                                }
                                if (element.select("input[type=text]").size() > 0) {
                                        String inputfieldid = element.select("input").attr("name");
                                        String labelText = element.select("label").text();
                                        org.json.simple.JSONObject input = (org.json.simple.JSONObject) formVariableResponseJson
                                                        .get(inputfieldid);
                                        input.put("label", labelText);
                                        input.put("inputType", "inputfield");
                                        input.put("variabletype", element.select("input").attr("cam-variable-type"));
                                        input.put("required",
                                                        element.select("input[required]").size() > 0 ? true : false);
                                        input.put("readonly", element.select("input[readonly]").size() > 0
                                                        || element.select("input[disabled]").size() > 0 ? true : false);

                                        String minlength = element.select("input").attr("minlength");
                                        if (!minlength.isEmpty() && !minlength.isBlank()) {
                                                input.put("minlength", Integer.parseInt(minlength));
                                        }

                                        String maxlenght = element.select("input").attr("maxlength");
                                        if (!maxlenght.isEmpty() && !maxlenght.isBlank()) {
                                                input.put("maxlength", Integer.parseInt(maxlenght));
                                        }

                                        String min = element.select("input").attr("min");
                                        if (!min.isEmpty() && !min.isBlank()) {
                                                input.put("min", Integer.parseInt(min));
                                        }

                                        String max = element.select("input").attr("max");
                                        if (!max.isEmpty() && !max.isBlank()) {
                                                input.put("max", Integer.parseInt(max));
                                        }
                                        responseMap.put(inputfieldid, input);
                                }
                        }
                        activityLogService.addActivity(loggedInUser, "rendered form accessed",
                                        "parameters : " + taskid);
                }
                return responseMap;
        }

        public ResponseEntity<?> getCaseTypeDropDown(Authentication pr) {
                WebUser loggedInUser = webUserService.loadUserByUsername(pr.getName());
                activityLogService.addActivity(loggedInUser,
                                "requested to access case type list for Process Bulk Ticket");
                List<WorkflowMasters> allWorkflows = null;
                try {
                        allWorkflows = workflowMasterService.findAll();
                } catch (Exception e) {
                        LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                                        e.toString());
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                }
                ResponseEntity<String> clientResponse = null;
                try {
                        clientResponse = camundaService.getProcessDefinationList("latestVersion=true", loggedInUser);
                } catch (Exception e) {
                        LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString()) + "\nParam : "
                                        + loggerEncoderUtil.encode(pr.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to get task definition", e.toString());
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                }
                // String response = clientResponse.bodyToMono(String.class).block();
                String response = clientResponse.getBody();
                // clientResponse.releaseBody();
                if (clientResponse.getStatusCode() == HttpStatus.OK) {
                        JSONArray jsonArray = new JSONArray(response);
                        List<DropDownVo> responseDropDownList = new ArrayList<>();
                        for (WorkflowMasters wfm : allWorkflows) {
                                for (int i = 0, size = jsonArray.length(); i < size; i++) {
                                        JSONObject objectInArray = jsonArray.getJSONObject(i);
                                        if (objectInArray.getString("key").equals(wfm.getWorkflowKey())) {
                                                responseDropDownList.add(DropDownVo.builder()
                                                                .label(objectInArray.getString("name"))
                                                                .value(objectInArray.getString("key"))
                                                                .build());
                                        }
                                }
                        }
                        activityLogService.addActivity(loggedInUser, "Process Bulk Tickets Accessed successfully ");
                        LOGGER.debug("exiting class " + ProcessBulkTicketsServiceImpl.class
                                        + " and method getCaseTypeDropDown");
                        return ResponseEntity.ok(responseDropDownList);
                } else {
                        activityLogService.addActivity(loggedInUser, "failed to access task list");
                        LOGGER.error("exiting class " + ProcessBulkTicketsServiceImpl.class
                                        + " and method getCaseTypeDropDown with response : "
                                        + loggerEncoderUtil.encode(response));
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, response),
                                        clientResponse.getStatusCode());
                }
        }

        // List<DropdownWithObject> workFlowDropDown = new ArrayList<>();
        // List<WorkflowMasters> allWorkflows = null;
        // try {
        // allWorkflows = workflowMasterService.findAll();
        // } catch (Exception e) {
        // LOGGER.error("Error : " + e + "\nParam : " +
        // loggerEncoderUtil.encode(pr.toString()));
        // activityLogService.addActivity("failed to get user and permissions",
        // e.toString());
        // return new ResponseEntity<ApiResponse>(
        // new ApiResponse(false, ResponseMessages.GenericErrorMessage),
        // HttpStatus.INTERNAL_SERVER_ERROR);
        // }
        // allWorkflows.stream().map(w -> (workFlowDropDown
        // .add(DropdownWithObject.builder().label(w.getWorkflowName())
        // .value(w.getWorkflowKey()).build()))).collect(Collectors.toList());
        // LOGGER.debug("Exiting getWorkFlowName Method in " +
        // ProcessBulkTicketsServiceImpl.class
        // + " class with response : workflow names");
        // return ResponseEntity.ok(workFlowDropDown);

        public ResponseEntity<?> getTaskList(LoadMoreTaskListRequestGt loadMoreTaskListRequestGt, Authentication pr) {
                LOGGER.debug("entering  class " + ProcessBulkTicketsServiceImpl.class
                                + " and method getTaskList");

                KeysTenants keysTenants = camundaParamExtractor
                                .extractTenantWorkflows(loadMoreTaskListRequestGt.getParameters());

                LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

                WebUser loggedInUser = loggedUser.getWebUser();
                MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

                activityLogService.addActivity(loggedInUser,
                                " requested to get task list for process bulk ticket ",
                                loadMoreTaskListRequestGt.toString());

                if (!mp.isView() || !loggedUser.allowTenantsWorkflowKeys(keysTenants.getItenantIds(),
                                keysTenants.getWorkflowKeys())) {
                        activityLogService.addActivity(loggedInUser, "failed to get status values");
                        LOGGER.debug("Exiting getTaskList Method in " + ProcessBulkTicketsServiceImpl.class
                                        + " class with response  : unauthorized to get form variable");
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, "unauthorized to get task list"),
                                        HttpStatus.FORBIDDEN);
                }

                activityLogService.addActivity(loggedInUser, "requested to access task list for Process Bulk Ticket",
                                loadMoreTaskListRequestGt.toString());
                ResponseEntity<String> clientResponse = null;
                LoadMoreTaskListRequest loadMoreTaskListRequest = new LoadMoreTaskListRequest();
                loadMoreTaskListRequest.setMaxResult(loadMoreTaskListRequestGt.getMaxResult());
                loadMoreTaskListRequest.setNextStartIndex(loadMoreTaskListRequestGt.getNextStartIndex());
                loadMoreTaskListRequest.setParameters(loadMoreTaskListRequestGt.getParameters());
                JSONObject params = new JSONObject(loadMoreTaskListRequest.getParameters());
                // if (!params.isNull("assigned")) {
                // if (params.getBoolean("assigned") == true) {
                // params.put("assignee", pr.getName());
                // loadMoreTaskListRequest.setParameters(params.toString());
                // }
                // }
                try {
                        clientResponse = camundaService.getTaskListPostLoadMore(loadMoreTaskListRequest, loggedInUser);
                } catch (Exception e) {
                        LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString()) + "\nParam : "
                                        + loggerEncoderUtil.encode(pr.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to get task list", e.toString());
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);

                }
                // String response = clientResponse.bodyToMono(String.class).block();
                String response = clientResponse.getBody();
                // clientResponse.releaseBody();

                JSONArray jsonArray = new JSONArray(response);
                JSONArray jsonArrayResponse = new JSONArray("[]");
                List<String> instaceId = new ArrayList<>();

                for (int i = 0; i < jsonArray.length(); i++) {
                        instaceId.add(jsonArray.getJSONObject(i).optString("processInstanceId"));
                }

                ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
                String json = null;
                try {
                        json = ow.writeValueAsString(instaceId);
                } catch (JsonProcessingException e) {
                        LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString()) + "\nParam : "
                                        + loggerEncoderUtil.encode(instaceId.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to get details",
                                        "Error : " + e.toString() + ", Parameters : " + instaceId);
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                }

                String processInJson = "{\n  \"processInstanceIdIn\":" + json + "\n}";

                ResponseEntity<String> details = null;

                if (instaceId.size() != 0) {
                        try {
                                details = camundaService.postHistoryDetail(processInJson, loggedInUser);
                        } catch (Exception e) {
                                LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString()) + "\nParam : "
                                                + loggerEncoderUtil.encode(processInJson));
                                activityLogService.addActivity(loggedInUser, "failed to get details",
                                                "Error : " + e.toString() + ", Parameters : " + processInJson);
                                return new ResponseEntity<ApiResponse>(
                                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                                HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                }

                LinkedHashMap<String, org.json.simple.JSONObject> responseMap = new LinkedHashMap<>();
                if (jsonArray.length() != 0) {
                        try {
                                responseMap = renderedForm((String) jsonArray.getJSONObject(0).get("id"), loggedInUser);
                        } catch (Exception e) {
                                // TODO Auto-generated catch block
                                LOGGER.error("Error " + e);
                        }
                }

                // if (jsonArray.length() != 0) {
                // try {
                // formVeriable = camundaService.getFormVariable((String)
                // jsonArray.getJSONObject(0).get("id"),
                // loggedInUser);
                // } catch (Exception e) {
                // LOGGER.error("Error : " + e + "\nParam : " + loadMoreTaskListRequest);
                // activityLogService.addActivity(loggedInUser, "failed to get form variables",
                // e.toString());
                // return new ResponseEntity<ApiResponse>(new ApiResponse(false, "failed to get
                // form variable"),
                // HttpStatus.INTERNAL_SERVER_ERROR);
                // }

                // formVeriableString = formVeriable.bodyToMono(String.class).block();
                // }

                // JSONObject formVariableJson = null;

                // if (formVeriableString != null) {

                // formVariableJson = new JSONObject(formVeriableString);
                // }

                if (details != null) {
                        if (details.getStatusCode() == HttpStatus.OK) {
                                JSONArray detailList = new JSONArray(details.getBody());
                                // System.out.println(detailList);

                                for (int k = 0; k < jsonArray.length(); k++) {
                                        org.json.JSONObject taskListInstance = jsonArray.getJSONObject(k);
                                        for (int n = 0; n < detailList.length(); n++) {
                                                if (taskListInstance.getString("processInstanceId")
                                                                .equals(detailList.getJSONObject(n)
                                                                                .getString("processInstanceId"))) {
                                                        taskListInstance.put("formVariable", responseMap);
                                                        if (detailList.getJSONObject(n).opt("variableName") != null) {
                                                                if (detailList.getJSONObject(n).get("variableName")
                                                                                .equals("Alert")) {
                                                                        taskListInstance.put("Alert",
                                                                                        detailList.getJSONObject(n)
                                                                                                        .get("value")
                                                                                                        .toString());
                                                                }

                                                                if (detailList.getJSONObject(n).get("variableName")
                                                                                .equals("payee")) {
                                                                        taskListInstance.put("payee",
                                                                                        detailList.getJSONObject(n)
                                                                                                        .get("value")
                                                                                                        .toString());
                                                                }

                                                                if (detailList.getJSONObject(n).get("variableName")
                                                                                .equals("payer")) {
                                                                        taskListInstance.put("payer",
                                                                                        detailList.getJSONObject(n)
                                                                                                        .get("value")
                                                                                                        .toString());
                                                                }

                                                                if (detailList.getJSONObject(n).get("variableName")
                                                                                .equals("TransactionAmount")) {

                                                                        taskListInstance
                                                                                        .put("TransactionAmount",
                                                                                                        Double.parseDouble(
                                                                                                                        detailList.getJSONObject(
                                                                                                                                        n)
                                                                                                                                        .get("value")
                                                                                                                                        .toString())
                                                                                                                        / 100);
                                                                }

                                                                if (detailList.getJSONObject(n).get("variableName")
                                                                                .equals("TicketID")) {
                                                                        taskListInstance.put("TicketID",
                                                                                        detailList.getJSONObject(n)
                                                                                                        .get("value")
                                                                                                        .toString());
                                                                }

                                                                if (detailList.getJSONObject(n).get("variableName")
                                                                                .equals("IntimateMerchant")) {
                                                                        taskListInstance.put("IntimateMerchant",
                                                                                        detailList.getJSONObject(n)
                                                                                                        .get("value")
                                                                                                        .toString());
                                                                }

                                                                if (detailList.getJSONObject(n).get("variableName")
                                                                                .equals("Action")) {
                                                                        taskListInstance.put("Action",
                                                                                        detailList.getJSONObject(n)
                                                                                                        .get("value")
                                                                                                        .toString());
                                                                }

                                                                if (detailList.getJSONObject(n).get("variableName")
                                                                                .equals("Action2")) {
                                                                        taskListInstance.put("Action2",
                                                                                        detailList.getJSONObject(n)
                                                                                                        .get("value")
                                                                                                        .toString());
                                                                }

                                                                if (detailList.getJSONObject(n).get("variableName")
                                                                                .equals("Action3")) {
                                                                        taskListInstance.put("Action2",
                                                                                        detailList.getJSONObject(n)
                                                                                                        .get("value")
                                                                                                        .toString());
                                                                }

                                                                if (detailList.getJSONObject(n).get("variableName")
                                                                                .equals("WorkflowName")) {
                                                                        taskListInstance.put("WorkflowName",
                                                                                        detailList.getJSONObject(n)
                                                                                                        .get("value")
                                                                                                        .toString());
                                                                }
                                                        }

                                                        taskListInstance.put("selected", false);
                                                }
                                        }

                                        jsonArray.put(k, taskListInstance);

                                }

                                activityLogService.addActivity(loggedInUser, "Task list accessed",
                                                "parameters : " + loadMoreTaskListRequest);
                                LOGGER.debug("exiting  class " + ProcessBulkTicketsServiceImpl.class
                                                + " and method getTaskList");
                                activityLogService.addActivity(loggedInUser,
                                                "  task list for Process Bulk Ticket accessed successfully",
                                                loadMoreTaskListRequestGt.toString());

                                return ResponseEntity.ok(jsonArray.toString());
                        }
                }
                // for (int i = 0, size = jsonArray.length(); i < size; i++) {
                // JSONObject objectInArray = jsonArray.getJSONObject(i);

                // if (objectInArray.get("assignee").equals(pr.getName()) ||
                // objectInArray.get("assignee").equals(null)) {
                // ClientResponse formVeriable = null;
                // try {
                // formVeriable = camundaService.getFormVariable((String)
                // objectInArray.get("id"), loggedInUser);
                // } catch (Exception e) {
                // LOGGER.error("Error : " + e + "\nParam : " + loadMoreTaskListRequest);
                // activityLogService.addActivity(loggedInUser, "failed to get form variables",
                // e.toString());
                // return new ResponseEntity<ApiResponse>(new ApiResponse(false, "failed to get
                // form variable"),
                // HttpStatus.INTERNAL_SERVER_ERROR);
                // }
                // String formVeriableString = formVeriable.bodyToMono(String.class).block();
                // JSONObject formVariableJson = new JSONObject(formVeriableString);

                // // System.out.println(new
                // //
                // JSONObject(formVariableJson.get("IsProcessBulk").toString()).getBoolean("value"));
                // objectInArray.put("formVariable", formVariableJson);
                // objectInArray.put("selected", false);
                // jsonArray.put(i, objectInArray);

                // if (formVariableJson.has("IsProcessBulk")) {

                // if (formVariableJson.getJSONObject("IsProcessBulk").getBoolean("value") ==
                // true) {

                // jsonArrayResponse.put(objectInArray);
                // }

                // }
                // }
                // }
                activityLogService.addActivity(loggedInUser, "Task list accessed",
                                "parameters : " + loadMoreTaskListRequest);
                LOGGER.debug("exiting  class " + ProcessBulkTicketsServiceImpl.class + " and method getTaskList");
                return ResponseEntity.ok(jsonArrayResponse.toString());
        }

        public ResponseEntity<?> claimTask(String body, Authentication pr) {
                LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

                WebUser loggedInUser = loggedUser.getWebUser();
                activityLogService.addActivity(loggedInUser, " requested to claim bulk task for Process Bulk Tickets ",
                                body);

                JSONArray jsonArray = new JSONArray(body);
                for (int i = 0, size = jsonArray.length(); i < size; i++) {
                        JSONObject objectInArray = jsonArray.getJSONObject(i);
                        ResponseEntity<String> clientResponse = null;
                        try {
                                clientResponse = camundaService.claimTask((String) objectInArray.get("id"),
                                                (String) objectInArray.get("processInstanceId"), loggedInUser);
                        } catch (Exception e) {
                                LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString()) + "\nParam : "
                                                + loggerEncoderUtil.encode(pr.toString()));
                                activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                                                e.toString());
                                return new ResponseEntity<ApiResponse>(
                                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                                HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                        // String response = clientResponse.bodyToMono(String.class).block();
                        String response = clientResponse.getBody();
                        // clientResponse.releaseBody();
                        if (clientResponse.getStatusCode() == HttpStatus.INTERNAL_SERVER_ERROR) {
                                JSONObject responseobj = new JSONObject(response);
                                String msg = responseobj.optString("message");
                                if (msg.contains("is already claimed by someone else")) {
                                        activityLogService.addActivity(loggedInUser, "failed to claim task",
                                                        "Parameters : " + body);
                                        LOGGER.info("Exiting claimTask Method in " + ProcessBulkTicketsServiceImpl.class
                                                        + " class with response  : " + response);
                                        return new ResponseEntity<ApiResponse>(
                                                        new ApiResponse(false, "Task already claimed by someone else"),
                                                        HttpStatus.BAD_REQUEST);
                                } else {
                                        activityLogService.addActivity(loggedInUser, "failed to claim task",
                                                        "Parameters : " + body);
                                        LOGGER.error("Exiting claimTask Method in "
                                                        + ProcessBulkTicketsServiceImpl.class
                                                        + " class with response  : " + response);
                                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, response),
                                                        clientResponse.getStatusCode());
                                }
                        } else if (clientResponse.getStatusCode() != HttpStatus.NO_CONTENT) {
                                activityLogService.addActivity(loggedInUser, "failed to claim task",
                                                "Parameters : " + body);
                                LOGGER.error("Exiting claimTask Method in " + ProcessBulkTicketsServiceImpl.class
                                                + " class with response  : " + response);
                                return new ResponseEntity<ApiResponse>(new ApiResponse(false, response),
                                                clientResponse.getStatusCode());
                        }

                }
                activityLogService.addActivity(loggedInUser,
                                "   claimed bulk task for Process Bulk Tickets successfully ",
                                body);

                return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Case Status changed successfully"),
                                HttpStatus.OK);
        }

        public ResponseEntity<?> submitForm(String body, Authentication pr) {
                LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

                WebUser loggedInUser = loggedUser.getWebUser();
                activityLogService.addActivity(loggedInUser, " requested to submit bulk task for Process Bulk Tickets ",
                                body);

                JSONArray jsonArray = new JSONArray(body);
                List<Long> failedTicket = new ArrayList<>();
                List<Long> failedCommentTicket = new ArrayList<>();
                for (int i = 0, size = jsonArray.length(); i < size; i++) {
                        // System.out.println(jsonArray.getJSONObject(i));
                        JSONObject objectInArray = jsonArray.getJSONObject(i);
                        JSONObject formVeriable = new JSONObject("{}");
                        if (objectInArray.has("formVariable")) {

                                formVeriable.put("variables", objectInArray.getJSONObject("formVariable"));
                        }

                        ResponseEntity<String> clientResponse = null;
                        if (objectInArray.has("comment")) {

                                AddComment ac = new AddComment();
                                ac.setTaskid(objectInArray.getJSONObject("comment").getString("taskid"));
                                ac.setProcessInstanceId(
                                                objectInArray.getJSONObject("comment").getString("processInstanceId"));
                                ac.setMessage(objectInArray.getJSONObject("comment").getString("message"));

                                ResponseEntity<String> addCommentResponse = null;

                                try {
                                        addCommentResponse = camundaService.addComment(ac, loggedInUser);
                                        // addCommentResponse.releaseBody();
                                } catch (Exception e) {
                                        LOGGER.error("Error : " + e + "\nParam : "
                                                        + loggerEncoderUtil.encode(ac.toString()));
                                        activityLogService.addActivity(loggedInUser, "failed to add comment",
                                                        "Error : " + e.toString() + ", Parameters : " + ac);

                                }

                        }

                        try {
                                clientResponse = camundaService.submitForm((String) objectInArray.get("id"),
                                                (String) objectInArray.get("processInstanceId"),
                                                String.valueOf(formVeriable), loggedInUser);
                        } catch (Exception e) {
                                LOGGER.error(
                                                loggerEncoderUtil.encode("Error : " + e + "\nParam : "
                                                                + (String) objectInArray.get("id")));
                                activityLogService.addActivity(loggedInUser, "failed to get rendered form",
                                                "Error : " + e.toString() + ", Parameters : "
                                                                + (String) objectInArray.get("id"));

                        }
                        // clientResponse.releaseBody();
                        if (clientResponse.getStatusCode() != HttpStatus.OK
                                        && clientResponse.getStatusCode() != HttpStatus.NO_CONTENT) {
                                // System.out.println(clientResponse.bodyToMono(String.class).block());
                                failedTicket.add(objectInArray.getJSONObject("TicketID").getLong("value"));
                        }

                }
                if (failedTicket.size() == 0) {
                        activityLogService.addActivity(loggedInUser,
                                        " bulk task submitted successfully for Process Bulk Tickets ",
                                        body);

                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(true, "Case Status changed successfully"),
                                        HttpStatus.OK);
                } else {

                        activityLogService.addActivity(loggedInUser,
                                        "bulk processing all tasks is not submitted successfully",
                                        "parameters : " + body);
                        LOGGER.debug("Exiting submitForm Method in " + ProcessBulkTicketsServiceImpl.class
                                        + " class with response  : task submitted successfully");
                        String failId = failedTicket.stream().map(Object::toString).collect(Collectors.joining(", "));
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                        "Bulk processing of ticket " + failId
                                                                        + " is not submitted successfully"),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                }

        }

        @Override
        public ResponseEntity<?> getStatusDropDown(GetWorkflowState req, Authentication pr) {
                LOGGER.debug("entering  class " + ProcessBulkTicketsServiceImpl.class
                                + " and method getStatusDropDown");

                LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

                WebUser loggedInUser = loggedUser.getWebUser();
                MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

                activityLogService.addActivity(loggedInUser,
                                " requested to get workflow state for process bulk ticket ",
                                req.toString());

                if (!mp.isView()) {
                        activityLogService.addActivity(loggedInUser, "failed to get status values");
                        LOGGER.debug("Exiting getTaskList Method in " + ProcessBulkTicketsServiceImpl.class
                                        + " class with response  : unauthorized to get form variable");
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, "unauthorized to get task list"),
                                        HttpStatus.FORBIDDEN);
                }

                List<UserTaskDropDown> statusDropDown = new ArrayList<>();

                ResponseEntity<String> bpmnXml = null;
                try {
                        bpmnXml = camundaService.getBPMN(
                                        "key/" + req.getWorkFlowKey() + "/tenant-id/" + req.getTenantId(),
                                        loggedInUser);
                } catch (Exception e) {
                        LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString()) + "\nParam : "
                                        + loggerEncoderUtil.encode(req.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to get BPMN XML",
                                        "Error : " + e.toString() + ", Parameters : " + req.toString());
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                }
                String bpmnResponse = bpmnXml.getBody();

                ObjectMapper mapper1 = new ObjectMapper();

                try {

                        JsonNode rootNode = mapper1.readTree(bpmnResponse);

                        org.w3c.dom.Document doc = xmlParser.XMLParser(rootNode.get("bpmn20Xml").asText());

                        NodeList userTasklist = doc.getElementsByTagName("bpmn:userTask");

                        if (userTasklist.getLength() > maxFieldLength) {
                                LOGGER.info("\nParam : " + loggerEncoderUtil.encode(req.getWorkFlowKey()));
                                activityLogService.addActivity(loggedInUser,
                                                "failed to get xml parametes length more then  " + maxFieldLength,
                                                req.getWorkFlowKey());
                                return new ResponseEntity<ApiResponse>(
                                                new ApiResponse(false,
                                                                "No of fields should not exceed " + maxFieldLength),
                                                HttpStatus.BAD_REQUEST);
                        }
                        for (int j = 0; j < doc.getElementsByTagName("bpmn:userTask").getLength(); j++) {

                                for (int k = 0; k < doc.getElementsByTagName("bpmn:userTask").item(j).getChildNodes()
                                                .item(1)
                                                .getChildNodes().getLength(); k++) {

                                        if (doc.getElementsByTagName("bpmn:userTask").item(j).getChildNodes().item(1)
                                                        .getChildNodes().item(k).getNodeName()
                                                        .equals("camunda:properties")) {
                                                for (int h = 0; h < doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                .getChildNodes().item(1).getChildNodes().item(k)
                                                                .getChildNodes().getLength(); h++) {

                                                        if (doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                        .getChildNodes().item(1)
                                                                        .getChildNodes().item(k).getChildNodes().item(h)
                                                                        .getNodeName().equals("camunda:property")) {

                                                                if (doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                                .getChildNodes().item(1).getChildNodes()
                                                                                .item(k).getChildNodes().item(h)
                                                                                .getAttributes().getNamedItem("name")
                                                                                .getNodeValue()
                                                                                .equals("isProcessBulk")) {

                                                                        if (doc.getElementsByTagName("bpmn:userTask")
                                                                                        .item(j)
                                                                                        .getChildNodes().item(1)
                                                                                        .getChildNodes().item(k)
                                                                                        .getChildNodes().item(h)
                                                                                        .getAttributes()
                                                                                        .getNamedItem("value")
                                                                                        .getNodeValue()
                                                                                        .equals("true")) {
                                                                                String criteria = null;
                                                                           

                                                                                List<String> groups = new ArrayList<>();
                                                                                if (doc.getElementsByTagName(
                                                                                                "bpmn:userTask")
                                                                                                .item(j)
                                                                                                .getAttributes()
                                                                                                .getNamedItem("camunda:candidateGroups") != null) {
                                                                                        groups = Arrays.asList(
                                                                                                        doc.getElementsByTagName(
                                                                                                                        "bpmn:userTask")
                                                                                                                        .item(j)
                                                                                                                        .getAttributes()
                                                                                                                        .getNamedItem("camunda:candidateGroups")
                                                                                                                        .getNodeValue()
                                                                                                                        .split(","));
                                                                                }

                                                                                statusDropDown.add(UserTaskDropDown
                                                                                                .builder()
                                                                                                .label(doc.getElementsByTagName(
                                                                                                                "bpmn:userTask")
                                                                                                                .item(j)
                                                                                                                .getAttributes()
                                                                                                                .getNamedItem("name")
                                                                                                                .getNodeValue())
                                                                                                .value(doc.getElementsByTagName(
                                                                                                                "bpmn:userTask")
                                                                                                                .item(j)
                                                                                                                .getAttributes()
                                                                                                                .getNamedItem("id")
                                                                                                                .getNodeValue())
                                                                                                .groups(groups)
                                                                                                .build());

                                                                        }

                                                                }

                                                        }

                                                }

                                        }

                                }

                        }

                } catch (Exception e) {
                        e.printStackTrace();
                        LOGGER.error("Error : " + e);
                        activityLogService.addActivity(loggedInUser, "failed to get Values from BPMN XML",
                                        "Error : " + e.toString() + ", Parameters : " + req.toString());
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);

                }

                if (bpmnXml.getStatusCode() == HttpStatus.OK) {
                        activityLogService.addActivity(loggedInUser, "Task list accessed",
                                        "parameters : " + req.toString());
                        Set<UserTaskDropDown> removeDuplicates = new HashSet<>();
                        removeDuplicates.addAll(statusDropDown);
                        statusDropDown = new ArrayList<UserTaskDropDown>();
                        statusDropDown.addAll(removeDuplicates);
                        activityLogService.addActivity(loggedInUser,
                                        "  status dropdown options for Process Bulk Tickets accessed successfully ",
                                        req.toString());

                        LOGGER.debug("Exiting getStatusDropDown Method in " + ProcessBulkTicketsServiceImpl.class
                                        + " class with response : status list");
                        return ResponseEntity.ok(statusDropDown);
                } else {
                        activityLogService.addActivity(loggedInUser, "failed to access task list",
                                        "Parameters : " + req.toString());
                        LOGGER.debug(loggerEncoderUtil
                                        .encode("Exiting getStatusDropDown Method in "
                                                        + ProcessBulkTicketsServiceImpl.class
                                                        + " class with response : " + bpmnResponse));
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, bpmnResponse),
                                        bpmnXml.getStatusCode());
                }
        }

        @Override
        public ResponseEntity<?> getChangeStatusDropDown(ChangeStatusDropDownRequest changeStatusDropDownRequest,
                        Authentication pr) {

                LOGGER.debug("entering  class " + ProcessBulkTicketsServiceImpl.class
                                + " and method getChangeStatusDropDown");

                LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

                WebUser loggedInUser = loggedUser.getWebUser();
                MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

                activityLogService.addActivity(loggedInUser,
                                " requested to change status dropdown options for Process Bulk Tickets ",
                                changeStatusDropDownRequest.toString());

                HashMap<String, Map<String, Object>> bulkFields = new HashMap<>();
                HashMap<String, String> label = new HashMap<>();

                if (mp.isView()) {
                        ResponseEntity<String> bpmnXml = null;
                        try {
                                bpmnXml = camundaService.getBPMN(
                                                "key/" + changeStatusDropDownRequest.getWorkFlowKey() + "/tenant-id/"
                                                                + changeStatusDropDownRequest.getTenantId(),
                                                loggedInUser);
                        } catch (Exception e) {
                                LOGGER.error(loggerEncoderUtil
                                                .encode("Error : " + e + "\nParam : "
                                                                + changeStatusDropDownRequest.getWorkFlowKey()));
                                activityLogService.addActivity(loggedInUser, "failed to get BPMN XML",
                                                "Error : " + e.toString() + ", Parameters : "
                                                                + changeStatusDropDownRequest.getWorkFlowKey());
                                return new ResponseEntity<ApiResponse>(
                                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                                HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                        String bpmnResponse = bpmnXml.getBody();
                        // System.out.println(bpmnXml.statusCode());

                        ObjectMapper mapper1 = new ObjectMapper();

                        try {

                                JsonNode rootNode = mapper1.readTree(bpmnResponse);

                                org.w3c.dom.Document doc = xmlParser.XMLParser(rootNode.get("bpmn20Xml").asText());

                                NodeList userTasklist = doc.getElementsByTagName("bpmn:userTask");

                                if (userTasklist.getLength() > maxFieldLength) {
                                        LOGGER.info("\nParam : " + loggerEncoderUtil
                                                        .encode(changeStatusDropDownRequest.getWorkFlowKey()));
                                        activityLogService.addActivity(loggedInUser,
                                                        "failed to get xml parametes length more then  "
                                                                        + maxFieldLength,
                                                        changeStatusDropDownRequest.getWorkFlowKey());
                                        return new ResponseEntity<ApiResponse>(
                                                        new ApiResponse(false,
                                                                        "No of fields should not exceed "
                                                                                        + maxFieldLength),
                                                        HttpStatus.BAD_REQUEST);
                                }

                                for (int j = 0; j < doc.getElementsByTagName("bpmn:userTask").getLength(); j++) {

                                        if (doc.getElementsByTagName("bpmn:userTask").item(j).getAttributes()
                                                        .getNamedItem("name")
                                                        .getNodeValue()
                                                        .equals(changeStatusDropDownRequest.getUserTaskState())) {

                                                for (int k = 0; k < doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                .getChildNodes().item(1)
                                                                .getChildNodes().item(1).getChildNodes()
                                                                .getLength(); k++) {
                                                        if (doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                        .getChildNodes().item(1)
                                                                        .getChildNodes().item(1).getChildNodes().item(k)
                                                                        .getNodeName()
                                                                        .equals("camunda:formField")) {
                                                                if (doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                                .getChildNodes().item(1)
                                                                                .getChildNodes().item(1).getChildNodes()
                                                                                .item(k).getAttributes()
                                                                                .getNamedItem("id").getNodeValue()
                                                                                .toString().startsWith("bulkProcess") ||
                                                                                doc.getElementsByTagName(
                                                                                                "bpmn:userTask").item(j)
                                                                                                .getChildNodes().item(1)
                                                                                                .getChildNodes().item(1)
                                                                                                .getChildNodes()
                                                                                                .item(k).getAttributes()
                                                                                                .getNamedItem("id")
                                                                                                .getNodeValue()
                                                                                                .toString()
                                                                                                .startsWith("conditions")) {
                                                                        String id = doc
                                                                                        .getElementsByTagName(
                                                                                                        "bpmn:userTask")
                                                                                        .item(j)
                                                                                        .getChildNodes().item(1)
                                                                                        .getChildNodes().item(1)
                                                                                        .getChildNodes()
                                                                                        .item(k).getAttributes()
                                                                                        .getNamedItem("id")
                                                                                        .getNodeValue()
                                                                                        .toString()
                                                                                        .replace("bulkProcess-", "");
                                                                        JSONObject bulkField = new JSONObject();
                                                                        bulkField.put("id", id);
                                                                        List<DropdownWithObject> changeStatusDropDown = new ArrayList<>();

                                                                        for (int h = 0; h < doc
                                                                                        .getElementsByTagName(
                                                                                                        "bpmn:userTask")
                                                                                        .item(j)
                                                                                        .getChildNodes().item(1)
                                                                                        .getChildNodes().item(1)
                                                                                        .getChildNodes().item(k)
                                                                                        .getChildNodes()
                                                                                        .getLength(); h++) {
                                                                                if (doc.getElementsByTagName(
                                                                                                "bpmn:userTask").item(j)
                                                                                                .getChildNodes().item(1)
                                                                                                .getChildNodes().item(1)
                                                                                                .getChildNodes().item(k)
                                                                                                .getChildNodes().item(h)
                                                                                                .getNodeName()
                                                                                                .equals("camunda:value")) {

                                                                                        changeStatusDropDown.add(
                                                                                                        DropdownWithObject
                                                                                                                        .builder()
                                                                                                                        .label(doc.getElementsByTagName(
                                                                                                                                        "bpmn:userTask")
                                                                                                                                        .item(j)
                                                                                                                                        .getChildNodes()
                                                                                                                                        .item(1)
                                                                                                                                        .getChildNodes()
                                                                                                                                        .item(1)
                                                                                                                                        .getChildNodes()
                                                                                                                                        .item(k)
                                                                                                                                        .getChildNodes()
                                                                                                                                        .item(h)
                                                                                                                                        .getAttributes()
                                                                                                                                        .getNamedItem("name")
                                                                                                                                        .getNodeValue())
                                                                                                                        .value(doc.getElementsByTagName(
                                                                                                                                        "bpmn:userTask")
                                                                                                                                        .item(j)
                                                                                                                                        .getChildNodes()
                                                                                                                                        .item(1)
                                                                                                                                        .getChildNodes()
                                                                                                                                        .item(1)
                                                                                                                                        .getChildNodes()
                                                                                                                                        .item(k)
                                                                                                                                        .getChildNodes()
                                                                                                                                        .item(h)
                                                                                                                                        .getAttributes()
                                                                                                                                        .getNamedItem("id")
                                                                                                                                        .getNodeValue())

                                                                                                                        .build());
                                                                                }
                                                                        }
                                                                        bulkField.put("options", changeStatusDropDown);
                                                                        bulkFields.put(id, bulkField.toMap());
                                                                } else if (doc.getElementsByTagName("bpmn:userTask")
                                                                                .item(j).getChildNodes().item(1)
                                                                                .getChildNodes().item(1).getChildNodes()
                                                                                .item(k).getAttributes()
                                                                                .getNamedItem("id").getNodeValue()
                                                                                .equals("IntimateMerchant")) {
                                                                        List<DropdownWithObject> changeStatusDropDown = new ArrayList<>();
                                                                        changeStatusDropDown.add(DropdownWithObject
                                                                                        .builder().value(true)
                                                                                        .label("Intimate Merchant")
                                                                                        .build());
                                                                        changeStatusDropDown.add(DropdownWithObject
                                                                                        .builder().value(false)
                                                                                        .label("Do Not Initimate Merchant")
                                                                                        .build());

                                                                }

                                                                System.out.println(doc.toString());

                                                                try {

                                                                        label.put(doc
                                                                                        .getElementsByTagName(
                                                                                                        "bpmn:userTask")
                                                                                        .item(j)
                                                                                        .getChildNodes().item(1)
                                                                                        .getChildNodes().item(1)
                                                                                        .getChildNodes()
                                                                                        .item(k).getAttributes()
                                                                                        .getNamedItem("id")
                                                                                        .getNodeValue()
                                                                                        .toString(),
                                                                                        doc
                                                                                                        .getElementsByTagName(
                                                                                                                        "bpmn:userTask")
                                                                                                        .item(j)
                                                                                                        .getChildNodes()
                                                                                                        .item(1)
                                                                                                        .getChildNodes()
                                                                                                        .item(1)
                                                                                                        .getChildNodes()
                                                                                                        .item(k)
                                                                                                        .getAttributes()
                                                                                                        .getNamedItem("label")
                                                                                                        .getNodeValue()
                                                                                                        .toString());

                                                                } catch (Exception e) {
                                                                        System.out.println(doc
                                                                                        .getElementsByTagName(
                                                                                                        "bpmn:userTask")
                                                                                        .item(j)
                                                                                        .getChildNodes().item(1)
                                                                                        .getChildNodes().item(1)
                                                                                        .getChildNodes()
                                                                                        .item(k).getAttributes()
                                                                                        .getNamedItem("id")
                                                                                        .getNodeValue()
                                                                                        .toString());
                                                                }

                                                        }
                                                }
                                        }

                                }

                        } catch (Exception e) {
                                e.printStackTrace();
                                LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString()) + "\nParam : "
                                                + loggerEncoderUtil.encode(bpmnResponse));
                                activityLogService.addActivity(loggedInUser, "failed to get Values from BPMN XML",
                                                "Error : " + e.toString() + ", Parameters : " + bpmnResponse);
                                return new ResponseEntity<ApiResponse>(
                                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                                HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                        activityLogService.addActivity(loggedInUser, "Status Values Obtained",
                                        "parameters : " + bpmnResponse);
                        LOGGER.debug("Exiting getChangeStatusDropDown Method in " + ProcessBulkTicketsServiceImpl.class
                                        + " class with response : status list");

                        activityLogService.addActivity(loggedInUser,
                                        " change status dropdown options for Process Bulk Tickets accessed successfully ");

                        for (String key : bulkFields.keySet()) {

                                if (label.containsKey(key)) {

                                        Map<String, Object> field = bulkFields.get(key);
                                        field.put("label", label.get(key));
                                        bulkFields.put(key, field);
                                }
                        }
                        return ResponseEntity.ok(bulkFields);
                } else {
                        activityLogService.addActivity(loggedInUser, "failed to get status values");
                        LOGGER.debug("Exiting getChangeStatusDropDown Method in " + ProcessBulkTicketsServiceImpl.class
                                        + " class with response  : unauthorized to get form variable");
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, "unauthorized to get rendered form"),
                                        HttpStatus.FORBIDDEN);
                }
        }

        @Override
        public ResponseEntity<?> getVpaDropdown(String type, Authentication pr) {

                LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

                WebUser user = loggedUser.getWebUser();

                activityLogService.addActivity(user, " requested to vpa dropdown options for Process Bulk Tickets ",
                                type);

                try {
                        List<DropdownWithObject> responses = null;
                        if (type.equalsIgnoreCase("payer")) {
                                responses = DropdownWithObjectMapper.parseVpaFromVpa(vpaService.findAll());
                        } else if (type.equalsIgnoreCase("payee")) {
                                responses = DropdownWithObjectMapper.parseVpaFromVpa(vpaService.findAll());
                        }

                        activityLogService.addActivity(user,
                                        " vpa dropdown options for Process Bulk Tickets accessed successfully ", type);
                        return ResponseEntity.ok(responses);
                } catch (Exception e) {

                        LOGGER.error("Error : " + e.toString());
                        activityLogService.addActivity(user, "failed to access vpa dropdown accessed",
                                        "Error : " + e.toString());
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                }
        }

        @Override
        public ResponseEntity<?> getDocumentRejectionReason(ChangeStatusDropDownRequest changeStatusDropDownRequest,
                        Authentication pr) {

                LOGGER.debug("entering  class " + ProcessBulkTicketsServiceImpl.class
                                + " and method getChangeStatusDropDown");

                LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

                WebUser loggedInUser = loggedUser.getWebUser();

                activityLogService.addActivity(loggedInUser,
                                " requested to Document rejection reason dropdown options for Process Bulk Tickets ",
                                changeStatusDropDownRequest.toString());

                MenuPermissions mp = loggedUser.getPermissions().get(menu_name);
                List<DropdownWithObject> changeStatusDropDown = new ArrayList<>();

                if (mp.isView()) {
                        ResponseEntity<String> bpmnXml = null;
                        try {
                                bpmnXml = camundaService.getBPMN(
                                                "key/" + changeStatusDropDownRequest.getWorkFlowKey()
                                                                .split(Pattern.quote("="))[1],
                                                loggedInUser);
                        } catch (Exception e) {
                                LOGGER.error(loggerEncoderUtil
                                                .encode("Error : " + e + "\nParam : "
                                                                + loggerEncoderUtil.encode(changeStatusDropDownRequest
                                                                                .getWorkFlowKey())));
                                activityLogService.addActivity(loggedInUser, "failed to get BPMN XML",
                                                "Error : " + e.toString() + ", Parameters : "
                                                                + changeStatusDropDownRequest.getWorkFlowKey());
                                return new ResponseEntity<ApiResponse>(
                                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                                HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                        String bpmnResponse = bpmnXml.getBody();

                        ObjectMapper mapper1 = new ObjectMapper();

                        try {

                                JsonNode rootNode = mapper1.readTree(bpmnResponse);

                                org.w3c.dom.Document doc = xmlParser.XMLParser(rootNode.get("bpmn20Xml").asText());

                                NodeList userTasklist = doc.getElementsByTagName("bpmn:userTask");

                                if (userTasklist.getLength() > maxFieldLength) {
                                        LOGGER.info("\nParam : " + loggerEncoderUtil
                                                        .encode(changeStatusDropDownRequest.getWorkFlowKey()));
                                        activityLogService.addActivity(loggedInUser,
                                                        "failed to get xml parametes length more then  "
                                                                        + maxFieldLength,
                                                        changeStatusDropDownRequest.getWorkFlowKey());
                                        return new ResponseEntity<ApiResponse>(
                                                        new ApiResponse(false,
                                                                        "No of fields should not exceed "
                                                                                        + maxFieldLength),
                                                        HttpStatus.BAD_REQUEST);
                                }

                                for (int j = 0; j < doc.getElementsByTagName("bpmn:userTask").getLength(); j++) {

                                        if (doc.getElementsByTagName("bpmn:userTask").item(j).getAttributes()
                                                        .getNamedItem("name")
                                                        .getNodeValue()
                                                        .equals(changeStatusDropDownRequest.getUserTaskState())) {

                                                for (int k = 0; k < doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                .getChildNodes().item(1)
                                                                .getChildNodes().item(1).getChildNodes()
                                                                .getLength(); k++) {
                                                        if (doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                        .getChildNodes().item(1)
                                                                        .getChildNodes().item(1).getChildNodes().item(k)
                                                                        .getNodeName()
                                                                        .equals("camunda:formField")) {
                                                                if (doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                                .getChildNodes().item(1)
                                                                                .getChildNodes().item(1).getChildNodes()
                                                                                .item(k).getAttributes()
                                                                                .getNamedItem("id").getNodeValue()
                                                                                .equals("DocRejReason")) {
                                                                        for (int h = 0; h < doc
                                                                                        .getElementsByTagName(
                                                                                                        "bpmn:userTask")
                                                                                        .item(j)
                                                                                        .getChildNodes().item(1)
                                                                                        .getChildNodes().item(1)
                                                                                        .getChildNodes().item(k)
                                                                                        .getChildNodes()
                                                                                        .getLength(); h++) {
                                                                                if (doc.getElementsByTagName(
                                                                                                "bpmn:userTask").item(j)
                                                                                                .getChildNodes().item(1)
                                                                                                .getChildNodes().item(1)
                                                                                                .getChildNodes().item(k)
                                                                                                .getChildNodes().item(h)
                                                                                                .getNodeName()
                                                                                                .equals("camunda:value")) {

                                                                                        if (!doc.getElementsByTagName(
                                                                                                        "bpmn:userTask")
                                                                                                        .item(j)
                                                                                                        .getChildNodes()
                                                                                                        .item(1)
                                                                                                        .getChildNodes()
                                                                                                        .item(1)
                                                                                                        .getChildNodes()
                                                                                                        .item(k)
                                                                                                        .getChildNodes()
                                                                                                        .item(h)
                                                                                                        .getAttributes()
                                                                                                        .getNamedItem("name")
                                                                                                        .getNodeValue()
                                                                                                        .equalsIgnoreCase(
                                                                                                                        "none")) {
                                                                                                changeStatusDropDown
                                                                                                                .add(DropdownWithObject
                                                                                                                                .builder()
                                                                                                                                .label(doc.getElementsByTagName(
                                                                                                                                                "bpmn:userTask")
                                                                                                                                                .item(j)
                                                                                                                                                .getChildNodes()
                                                                                                                                                .item(1)
                                                                                                                                                .getChildNodes()
                                                                                                                                                .item(1)
                                                                                                                                                .getChildNodes()
                                                                                                                                                .item(k)
                                                                                                                                                .getChildNodes()
                                                                                                                                                .item(h)
                                                                                                                                                .getAttributes()
                                                                                                                                                .getNamedItem("name")
                                                                                                                                                .getNodeValue())
                                                                                                                                .value(doc.getElementsByTagName(
                                                                                                                                                "bpmn:userTask")
                                                                                                                                                .item(j)
                                                                                                                                                .getChildNodes()
                                                                                                                                                .item(1)
                                                                                                                                                .getChildNodes()
                                                                                                                                                .item(1)
                                                                                                                                                .getChildNodes()
                                                                                                                                                .item(k)
                                                                                                                                                .getChildNodes()
                                                                                                                                                .item(h)
                                                                                                                                                .getAttributes()
                                                                                                                                                .getNamedItem("id")
                                                                                                                                                .getNodeValue())
                                                                                                                                .build());
                                                                                        }

                                                                                }
                                                                        }
                                                                }
                                                        }
                                                }
                                        }

                                }

                        } catch (Exception e) {
                                LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString()) + "\nParam : "
                                                + loggerEncoderUtil.encode(bpmnResponse));
                                activityLogService.addActivity(loggedInUser, "failed to get Values from BPMN XML",
                                                "Error : " + e.toString() + ", Parameters : " + bpmnResponse);
                                return new ResponseEntity<ApiResponse>(
                                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                                HttpStatus.INTERNAL_SERVER_ERROR);

                        }
                        activityLogService.addActivity(loggedInUser,
                                        " document rejection reason dropdown options for Process Bulk Tickets accessed successfully ",
                                        changeStatusDropDownRequest.toString());

                        LOGGER.debug("Exiting getDocumentRejectionReason Method in "
                                        + ProcessBulkTicketsServiceImpl.class
                                        + " class with response : status list");
                        Collections.reverse(changeStatusDropDown);
                        return ResponseEntity.ok(changeStatusDropDown);
                } else {
                        activityLogService.addActivity(loggedInUser, "Failed to get values of Rejection Reason");
                        LOGGER.debug("Exiting getChangeStatusDropDown Method in " + ProcessBulkTicketsServiceImpl.class
                                        + " class with response  : unauthorized to get form variable");
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, "Failed to get values of Rejection Reason"),
                                        HttpStatus.FORBIDDEN);
                }
        }

        @Override
        public ResponseEntity<?> getDocumentListToBeSubmited(ChangeStatusDropDownRequest changeStatusDropDownRequest,
                        Authentication pr) {

                LOGGER.debug("entering  class " + ProcessBulkTicketsServiceImpl.class
                                + " and method getChangeStatusDropDown");

                LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

                WebUser loggedInUser = loggedUser.getWebUser();

                activityLogService.addActivity(loggedInUser,
                                " requested to get document list to be submitted dropdown options for Process Bulk Tickets ",
                                changeStatusDropDownRequest.toString());

                MenuPermissions mp = loggedUser.getPermissions().get(menu_name);
                List<DropdownWithObject> changeStatusDropDown = new ArrayList<>();

                if (mp.isView()) {
                        ResponseEntity<String> bpmnXml = null;
                        try {
                                bpmnXml = camundaService.getBPMN(
                                                "key/" + changeStatusDropDownRequest.getWorkFlowKey()
                                                                .split(Pattern.quote("="))[1],
                                                loggedInUser);
                        } catch (Exception e) {
                                LOGGER.error(loggerEncoderUtil
                                                .encode("Error : " + e + "\nParam : "
                                                                + loggerEncoderUtil.encode(changeStatusDropDownRequest
                                                                                .getWorkFlowKey())));
                                activityLogService.addActivity(loggedInUser, "failed to get BPMN XML",
                                                "Error : " + e.toString() + ", Parameters : "
                                                                + changeStatusDropDownRequest.getWorkFlowKey());
                                return new ResponseEntity<ApiResponse>(
                                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                                HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                        String bpmnResponse = bpmnXml.getBody();
                        // System.out.println(bpmnXml.statusCode());
                        ObjectMapper mapper1 = new ObjectMapper();

                        try {

                                JsonNode rootNode = mapper1.readTree(bpmnResponse);
                                org.w3c.dom.Document doc = xmlParser.XMLParser(rootNode.get("bpmn20Xml").asText());

                                NodeList userTasklist = doc.getElementsByTagName("bpmn:userTask");

                                if (userTasklist.getLength() > maxFieldLength) {
                                        LOGGER.info("\nParam : " + loggerEncoderUtil
                                                        .encode(changeStatusDropDownRequest.getWorkFlowKey()));
                                        activityLogService.addActivity(loggedInUser,
                                                        "failed to get xml parametes length more then  "
                                                                        + maxFieldLength,
                                                        changeStatusDropDownRequest.getWorkFlowKey());
                                        return new ResponseEntity<ApiResponse>(
                                                        new ApiResponse(false,
                                                                        "No of fields should not exceed "
                                                                                        + maxFieldLength),
                                                        HttpStatus.BAD_REQUEST);
                                }

                                for (int j = 0; j < doc.getElementsByTagName("bpmn:userTask").getLength(); j++) {

                                        if (doc.getElementsByTagName("bpmn:userTask").item(j).getAttributes()
                                                        .getNamedItem("name")
                                                        .getNodeValue()
                                                        .equals(changeStatusDropDownRequest.getUserTaskState())) {

                                                for (int k = 0; k < doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                .getChildNodes().item(1)
                                                                .getChildNodes().item(1).getChildNodes()
                                                                .getLength(); k++) {
                                                        if (doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                        .getChildNodes().item(1)
                                                                        .getChildNodes().item(1).getChildNodes().item(k)
                                                                        .getNodeName()
                                                                        .equals("camunda:formField")) {
                                                                if (doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                                .getChildNodes().item(1)
                                                                                .getChildNodes().item(1).getChildNodes()
                                                                                .item(k).getAttributes()
                                                                                .getNamedItem("id").getNodeValue()
                                                                                .equals("Document1")
                                                                                || doc.getElementsByTagName(
                                                                                                "bpmn:userTask").item(j)
                                                                                                .getChildNodes().item(1)
                                                                                                .getChildNodes().item(1)
                                                                                                .getChildNodes().item(k)
                                                                                                .getAttributes()
                                                                                                .getNamedItem("id")
                                                                                                .getNodeValue()
                                                                                                .equals("DocumentListToBeSubmitted")
                                                                                || doc.getElementsByTagName(
                                                                                                "bpmn:userTask").item(j)
                                                                                                .getChildNodes().item(1)
                                                                                                .getChildNodes().item(1)
                                                                                                .getChildNodes().item(k)
                                                                                                .getAttributes()
                                                                                                .getNamedItem("id")
                                                                                                .getNodeValue()
                                                                                                .equals("Document2")) {
                                                                        for (int h = 0; h < doc
                                                                                        .getElementsByTagName(
                                                                                                        "bpmn:userTask")
                                                                                        .item(j)
                                                                                        .getChildNodes().item(1)
                                                                                        .getChildNodes().item(1)
                                                                                        .getChildNodes().item(k)
                                                                                        .getChildNodes()
                                                                                        .getLength(); h++) {
                                                                                if (doc.getElementsByTagName(
                                                                                                "bpmn:userTask").item(j)
                                                                                                .getChildNodes().item(1)
                                                                                                .getChildNodes().item(1)
                                                                                                .getChildNodes().item(k)
                                                                                                .getChildNodes().item(h)
                                                                                                .getNodeName()
                                                                                                .equals("camunda:value")) {

                                                                                        if (!doc.getElementsByTagName(
                                                                                                        "bpmn:userTask")
                                                                                                        .item(j)
                                                                                                        .getChildNodes()
                                                                                                        .item(1)
                                                                                                        .getChildNodes()
                                                                                                        .item(1)
                                                                                                        .getChildNodes()
                                                                                                        .item(k)
                                                                                                        .getChildNodes()
                                                                                                        .item(h)
                                                                                                        .getAttributes()
                                                                                                        .getNamedItem("name")
                                                                                                        .getNodeValue()
                                                                                                        .equalsIgnoreCase(
                                                                                                                        "none")) {
                                                                                                changeStatusDropDown
                                                                                                                .add(DropdownWithObject
                                                                                                                                .builder()
                                                                                                                                .label(doc.getElementsByTagName(
                                                                                                                                                "bpmn:userTask")
                                                                                                                                                .item(j)
                                                                                                                                                .getChildNodes()
                                                                                                                                                .item(1)
                                                                                                                                                .getChildNodes()
                                                                                                                                                .item(1)
                                                                                                                                                .getChildNodes()
                                                                                                                                                .item(k)
                                                                                                                                                .getChildNodes()
                                                                                                                                                .item(h)
                                                                                                                                                .getAttributes()
                                                                                                                                                .getNamedItem("name")
                                                                                                                                                .getNodeValue())
                                                                                                                                .value(doc.getElementsByTagName(
                                                                                                                                                "bpmn:userTask")
                                                                                                                                                .item(j)
                                                                                                                                                .getChildNodes()
                                                                                                                                                .item(1)
                                                                                                                                                .getChildNodes()
                                                                                                                                                .item(1)
                                                                                                                                                .getChildNodes()
                                                                                                                                                .item(k)
                                                                                                                                                .getChildNodes()
                                                                                                                                                .item(h)
                                                                                                                                                .getAttributes()
                                                                                                                                                .getNamedItem("id")
                                                                                                                                                .getNodeValue())
                                                                                                                                .build());
                                                                                        }

                                                                                }
                                                                        }
                                                                }
                                                        }
                                                }
                                        }

                                }

                        } catch (Exception e) {
                                LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString()) + "\nParam : "
                                                + loggerEncoderUtil.encode(bpmnResponse));
                                activityLogService.addActivity(loggedInUser, "failed to get Values from BPMN XML",
                                                "Error : " + e.toString() + ", Parameters : " + bpmnResponse);
                                return new ResponseEntity<ApiResponse>(
                                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                                HttpStatus.INTERNAL_SERVER_ERROR);

                        }
                        activityLogService.addActivity(loggedInUser,
                                        "   document list to be submitted dropdown options for Process Bulk Tickets accessed successfully  ",
                                        changeStatusDropDownRequest.toString());

                        LOGGER.debug("Exiting getDocumentListToBeSubmited Method in "
                                        + ProcessBulkTicketsServiceImpl.class
                                        + " class with response : status list");
                        Collections.reverse(changeStatusDropDown);
                        return ResponseEntity.ok(changeStatusDropDown);
                } else {
                        activityLogService.addActivity(loggedInUser,
                                        "Failed to get values of Document List to be submitted");
                        LOGGER.debug("Exiting getDocumentListToBeSubmited Method in "
                                        + ProcessBulkTicketsServiceImpl.class
                                        + " class with response  : unauthorized to get form variable");
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, "Failed to get values of Document List to be submitted"),
                                        HttpStatus.FORBIDDEN);
                }
        }

        @Override
        public ResponseEntity<?> getTaskListCount(String paramater, Authentication pr) {
                LOGGER.debug("entered in class " + ProcessBulkTicketsServiceImpl.class + " in method getTaskList");

                KeysTenants keysTenants = camundaParamExtractor.extractTenantWorkflows(paramater);
                LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

                WebUser loggedInUser = loggedUser.getWebUser();
                MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

                if (mp.isView() && loggedUser.allowTenantsWorkflowKeys(keysTenants.getItenantIds(),
                                keysTenants.getWorkflowKeys())) {
                        JSONObject params = new JSONObject(paramater);
                        // if (!params.isNull("assigned")) {
                        // if (params.getBoolean("assigned") == true) {
                        // params.put("assignee", pr.getName());

                        // }
                        // }
                        ResponseEntity<String> clientResponse = null;
                        try {
                                clientResponse = camundaService.getTaskListPostCount(params.toString(), loggedInUser);
                        } catch (Exception e) {

                                LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString()) + "\nParam : path "
                                                + loggerEncoderUtil.encode(paramater));
                                activityLogService.addActivity(loggedInUser,
                                                "failed to access task list for case summery",
                                                "Error : " + e.toString() + ", Parameters : " + paramater);
                                return new ResponseEntity<ApiResponse>(
                                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                                HttpStatus.INTERNAL_SERVER_ERROR);
                        }

                        // String response = clientResponse.bodyToMono(String.class).block();
                        String response = clientResponse.getBody();
                        // clientResponse.releaseBody();
                        if (clientResponse.getStatusCode() == HttpStatus.OK) {
                                ObjectMapper mapper = new ObjectMapper();
                                try {
                                        JsonNode actualObj = mapper.readTree(response);
                                        activityLogService.addActivity(loggedInUser,
                                                        " task list count for Process Bulk Tickets accessed successfully  ",
                                                        paramater);

                                        return ResponseEntity.ok(actualObj);
                                } catch (Exception e) {
                                        LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString())
                                                        + "\nParam : path "
                                                        + loggerEncoderUtil.encode(paramater));
                                        activityLogService.addActivity(loggedInUser,
                                                        "failed to access task list for case summery",
                                                        "Error : " + e.toString() + ", Parameters : " + paramater);
                                        return new ResponseEntity<ApiResponse>(
                                                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                                        HttpStatus.INTERNAL_SERVER_ERROR);
                                }

                        } else {
                                activityLogService.addActivity(loggedInUser,
                                                "failed to access task list for case summary",
                                                "Parameters : " + paramater);
                                LOGGER.error("exiting  class " + ProcessBulkTicketsServiceImpl.class
                                                + " and method getTaskList with response : "
                                                + loggerEncoderUtil.encode(response));
                                return new ResponseEntity<ApiResponse>(new ApiResponse(false, response),
                                                clientResponse.getStatusCode());

                        }

                } else {
                        activityLogService.addActivity(loggedInUser,
                                        "unauthorized to access list of tasks for case summary");
                        LOGGER.debug("Exiting getListDropDown Method in " + ProcessBulkTicketsServiceImpl.class
                                        + " class with response  : unauthorized to access list of tasks for case summary");
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, "unauthorized to access list of tasks for case summary"),
                                        HttpStatus.FORBIDDEN);
                }
        }

        @Override
        public ResponseEntity<?> getRuleDropDowns(Authentication pr) {
                LOGGER.debug("entered in class " + ProcessBulkTicketsServiceImpl.class
                                + " in method getRuleListDropDown");
                LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

                WebUser loggedInUser = loggedUser.getWebUser();
                MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

                if (mp.isView()) {
                        List<DropdownWithObject> response = new ArrayList<>();
                        List<String> rulename = new ArrayList<>();
                        try {
                                rulename = rulesTempService.findDistinctRuleName();
                                // System.out.println(rulename);
                                rulename.stream().map(
                                                c -> response.add(DropdownWithObject.builder().label(c.toString())
                                                                .value(c.toString()).build()))
                                                .collect(Collectors.toList());
                        } catch (Exception e) {
                                LOGGER.error("Error : " + e + "\nParam : "
                                                + loggerEncoderUtil.encode(loggedInUser.toString()));
                                activityLogService.addActivity(loggedInUser, "failed to access dropdown", e.toString());
                                return new ResponseEntity<ApiResponse>(
                                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                                HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                        activityLogService.addActivity(loggedInUser, "Rules Dropdown accessed");
                        LOGGER.debug("exiting in class " + ProcessBulkTicketsServiceImpl.class
                                        + " in method getRuleListDropDown");
                        return ResponseEntity.ok(response);
                } else {
                        activityLogService.addActivity(loggedInUser, "unauthorized to access Rules dropdown");
                        LOGGER.debug("Exiting  getRuleListDropDown Method in " + ProcessBulkTicketsServiceImpl.class
                                        + " class with response  : unauthorized to access Rules dropdown");
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, "unauthorized to access Rules dropdown"),
                                        HttpStatus.FORBIDDEN);
                }
        }

        @Override
        public ResponseEntity<?> getListOfUsers(Integer tenantid, Authentication pr) {
                LOGGER.debug("entered in class " + ProcessBulkTicketsServiceImpl.class + " in method getListOfUsers");
                LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

                WebUser loggedInUser = loggedUser.getWebUser();
                MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

                if (mp.isView()) {
                        List<DropdownWithObject> response = new ArrayList<>();
                        List<WebUser> users = new ArrayList<>();
                        try {
                                users = webUserService.findAllActiveUsersTenant(tenantid,
                                                loggedInUser.getIorgId().getIorgid());
                                users.stream().map(
                                                c -> response.add(
                                                                DropdownWithObject.builder().label(c.getUsername())
                                                                                .value(c.getIuserID().toString())
                                                                                .build()))
                                                .collect(Collectors.toList());

                        } catch (Exception e) {
                                LOGGER.error("Error : " + e + "\nParam : "
                                                + loggerEncoderUtil.encode(loggedInUser.toString()));
                                activityLogService.addActivity(loggedInUser, "failed to access dropdown", e.toString());
                                return new ResponseEntity<ApiResponse>(
                                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                                HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                        activityLogService.addActivity(loggedInUser, "Users Dropdown accessed");
                        LOGGER.debug("exiting in class " + ProcessBulkTicketsServiceImpl.class
                                        + " in method getListOfUsers");
                        return ResponseEntity.ok(response);
                } else {
                        activityLogService.addActivity(loggedInUser, "unauthorized to access Rules dropdown");
                        LOGGER.debug("Exiting getListDropDown Method in " + ProcessBulkTicketsServiceImpl.class
                                        + " class with response  : unauthorized to access Rules dropdown");
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, "unauthorized to access users dropdown"),
                                        HttpStatus.FORBIDDEN);
                }
        }

        @Override
        public ResponseEntity<?> reassignTask(ProcessBulkReassignRequest processBulkReassignRequest,
                        Authentication pr) {
                LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

                WebUser loggedInUser = loggedUser.getWebUser();
                WebUser claimedUser = null;
                if (processBulkReassignRequest.getCurrentAssignee() != null) {
                        if (!processBulkReassignRequest.getCurrentAssignee().isEmpty()
                                        && !processBulkReassignRequest.getCurrentAssignee().isBlank()) {

                                LOGGER.info("Current User found for request "
                                                + loggerEncoderUtil.encode(processBulkReassignRequest.toString()));
                                claimedUser = webUserService
                                                .loadUserByUsername(processBulkReassignRequest.getCurrentAssignee());
                        }
                }
                WebUser reassignedUser = webUserService.loadUserByUsername(processBulkReassignRequest.getNewAssignee());
                activityLogService.addActivity(loggedInUser, " requested to claim bulk task for Process Bulk Tickets ",
                                processBulkReassignRequest.toString());

                List<BulkReassignTicket> failedTickets = new ArrayList<>();

                for (int i = 0; i < processBulkReassignRequest.getTasks().size(); i++) {
                        ProcessBulkReassignRequest.TaskProcessMap task = processBulkReassignRequest.getTasks().get(i);
                        ResponseEntity<String> addCommentRequest = null;
                        AddComment ac = new AddComment();
                        ac.setTaskid(task.getTaskid());
                        ac.setProcessInstanceId(task.getProcessId());
                        ac.setMessage(processBulkReassignRequest.getComments());
                        try {
                                addCommentRequest = camundaService.addComment(ac, loggedInUser);
                                // addCommentRequest.releaseBody();
                        } catch (Exception e) {
                                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(ac.toString()));
                                activityLogService.addActivity(loggedInUser, "failed to add comment",
                                                "Error : " + e.toString() + ", Parameters : " + ac);
                                failedTickets
                                                .add(BulkReassignTicket.builder().ticketId(task.getTicketId())
                                                                .error("Failed in adding comment : Internal error "
                                                                                + e.getMessage())
                                                                .build());

                        }
                        // String addCommentResponse =
                        // addCommentRequest.bodyToMono(String.class).block();
                        String addCommentResponse = addCommentRequest.getBody();
                        // addCommentRequest.releaseBody();
                        LOGGER.info("Add comment response " + addCommentResponse);
                        LOGGER.info("Add comment status" + addCommentRequest.getStatusCode());

                        if (addCommentRequest.getStatusCode() == HttpStatus.OK) {

                                ResponseEntity<String> unClaimRequest = null;
                                String uncalimTicketResponse = "";

                                if (claimedUser != null) {
                                        try {
                                                unClaimRequest = camundaService.unClaimTask(task.getTaskid(),
                                                                task.getProcessId(), claimedUser);
                                        } catch (Exception e) {
                                                LOGGER.error("Error : " + e + "\nParam : "
                                                                + loggerEncoderUtil.encode(ac.toString()));
                                                activityLogService.addActivity(loggedInUser, "failed to Uncalim ticket",
                                                                "Error : " + e.toString() + ", Parameters : " + ac);
                                                failedTickets.add(
                                                                BulkReassignTicket.builder()
                                                                                .ticketId(task.getTicketId())
                                                                                .error("Failed in uncaliming ticket : Internal error "
                                                                                                + e.getMessage())
                                                                                .build());
                                        }

                                        uncalimTicketResponse = unClaimRequest.getBody();
                                        // unClaimRequest.releaseBody();
                                        LOGGER.info("Add comment response " + uncalimTicketResponse);
                                        LOGGER.info("Add comment status" + unClaimRequest.getStatusCode());
                                }

                                Boolean callClaim = false;
                                if (unClaimRequest != null) {

                                        callClaim = unClaimRequest.getStatusCode().is2xxSuccessful();
                                }

                                if (callClaim || claimedUser == null) {
                                        ResponseEntity<String> claimRequest = null;
                                        try {
                                                claimRequest = camundaService.claimTask(task.getTaskid(),
                                                                task.getProcessId(), reassignedUser);
                                        } catch (Exception e) {
                                                LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString())
                                                                + "\nParam : "
                                                                + loggerEncoderUtil.encode(pr.toString()));
                                                activityLogService.addActivity(loggedInUser,
                                                                "failed to get user and permissions",
                                                                e.toString());
                                                failedTickets.add(BulkReassignTicket.builder()
                                                                .ticketId(task.getTicketId())
                                                                .error("Failed in claiming ticket : Internal error "
                                                                                + e.getMessage())
                                                                .build());

                                        }
                                        String claimResponse = claimRequest.getBody();
                                        // claimRequest.releaseBody();
                                        if (claimRequest.getStatusCode() != HttpStatus.NO_CONTENT) {
                                                activityLogService.addActivity(loggedInUser, "failed to claim task",
                                                                "Parameters : " + processBulkReassignRequest
                                                                                .toString());
                                                LOGGER.error("Exiting claimTask Method in "
                                                                + ProcessBulkTicketsServiceImpl.class
                                                                + " class with response  : " + claimResponse);
                                                failedTickets
                                                                .add(BulkReassignTicket.builder()
                                                                                .ticketId(task.getTicketId())
                                                                                .error(claimResponse).build());

                                        }
                                } else {
                                        failedTickets
                                                        .add(BulkReassignTicket.builder().ticketId(task.getTicketId())
                                                                        .error(uncalimTicketResponse).build());
                                }
                        } else {
                                failedTickets
                                                .add(BulkReassignTicket.builder().ticketId(task.getTicketId())
                                                                .error(addCommentResponse).build());
                        }

                }

                if (failedTickets.size() != 0) {
                        activityLogService.addActivity(loggedInUser, "Bulk Reassignment of ticket is not successfull ",
                                        failedTickets.toString());

                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(failedTickets, false,
                                                        "Bulk Reassignment of ticket is not successfull"),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                }
                activityLogService.addActivity(loggedInUser,
                                "   claimed bulk task for Process Bulk Tickets successfully ",
                                processBulkReassignRequest.toString());

                String msg = null;
                if (claimedUser == null) {
                        msg = processBulkReassignRequest.getTasks().size() + " Cases Assigned to "
                                        + reassignedUser.getVcUserName();
                } else {
                        msg = processBulkReassignRequest.getTasks().size() + " Cases Reassigned from "
                                        + claimedUser.getVcUserName() + " to " + reassignedUser.getVcUserName();
                }
                return new ResponseEntity<ApiResponse>(new ApiResponse(true, msg),
                                HttpStatus.OK);
        }

        public ResponseEntity<?> submitFormOpen(SubmitTaskOpen submitTaskOpen) {
                // WebUser loggedInUser =
                // webUserService.loadUserByUsername(submitTaskOpen.getClaimedUser());
                // activityLogService.addActivity(loggedInUser, " requested to submit bulk task
                // for Process Bulk Tickets ",
                // submitTaskOpen.getBody());

                // List<Long> failedTicket = new ArrayList<>();
                // System.out.println(jsonArray.getJSONObject(i));
                JSONObject objectInArray = new JSONObject(submitTaskOpen.getBody());
                JSONObject formVeriable = new JSONObject("{}");
                if (objectInArray.has("formVariable")) {

                        JSONObject allVars = objectInArray.getJSONObject("formVariable");
                        JSONObject bypassVar = new JSONObject();
                        bypassVar.put("value", true);
                        bypassVar.put("type", "boolean");
                        allVars.put("bulkbypass", bypassVar);
                        formVeriable.put("variables", allVars);
                }

                ResponseEntity<String> clientResponse = null;
                if (objectInArray.has("comments")) {

                        AddComment ac = new AddComment();
                        ac.setTaskid(submitTaskOpen.getTaskid());
                        ac.setProcessInstanceId(submitTaskOpen.getProcessId());
                        ac.setMessage(submitTaskOpen.getComments());

                        ResponseEntity<String> addCommentResponse = null;

                        try {
                                long start = System.currentTimeMillis();
                                addCommentResponse = camundaService.addCommentOpen(ac, submitTaskOpen.getClaimedUser());
                                long end = System.currentTimeMillis();
                                System.out.println("Add comment time " + (end - start));
                                // addCommentResponse.releaseBody();
                        } catch (Exception e) {
                                LOGGER.error("Error : " + e + "\nParam : " + ac);

                        }

                }

                try {
                        clientResponse = camundaService.submitFormOpne(submitTaskOpen.getTaskid(),
                                        submitTaskOpen.getProcessId(),
                                        formVeriable.toString(), submitTaskOpen.getClaimedUser());
                } catch (Exception e) {
                        LOGGER.error(
                                        loggerEncoderUtil.encode("Error : " + e + "\nParam : "
                                                        + (String) objectInArray.get("id")));
                }
                LOGGER.info("submit task response " + clientResponse.getBody());
                LOGGER.info("submit task status " + clientResponse.getStatusCode());
                // clientResponse.releaseBody();

                if (clientResponse.getStatusCode() == HttpStatusCode.valueOf(204)) {

                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(true, "Case Status changed successfully"),
                                        HttpStatus.OK);
                } else {

                        LOGGER.debug("Exiting submitForm Method in " + ProcessBulkTicketsServiceImpl.class
                                        + " class with response  : task submitted successfully");

                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                        "Bulk processing of ticket " + submitTaskOpen.getTaskid()
                                                                        + " is not submitted successfully"),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                }

        }

        @Override
        public ResponseEntity<?> reassignTaskOpen(ProcessBulkReassignRequestOpen processBulkReassignRequest) {

                List<BulkReassignTicket> failedTickets = new ArrayList<>();

                ResponseEntity<String> addCommentRequest = null;
                AddComment ac = new AddComment();
                ac.setTaskid(processBulkReassignRequest.getTaskid());
                ac.setProcessInstanceId(processBulkReassignRequest.getProcessId());
                ac.setMessage(processBulkReassignRequest.getComments());
                try {
                        addCommentRequest = camundaService.addCommentOpen(ac,
                                        processBulkReassignRequest.getLoggedInUser());
                        // addCommentRequest.releaseBody();
                } catch (Exception e) {
                        LOGGER.error("Error : " + e + "\nParam : " + ac);
                        failedTickets
                                        .add(BulkReassignTicket.builder()
                                                        .ticketId(processBulkReassignRequest.getTicketId())
                                                        .error("Failed in adding comment : Internal error "
                                                                        + e.getMessage())
                                                        .build());

                }
                // String addCommentResponse =
                // addCommentRequest.bodyToMono(String.class).block();
                String addCommentResponse = addCommentRequest.getBody();
                LOGGER.info("Add comment response " + addCommentResponse);
                LOGGER.info("Add comment status" + addCommentRequest.getBody());
                // addCommentRequest.releaseBody();
                if (addCommentRequest.getStatusCode() == HttpStatus.OK) {
                        // addCommentRequest.releaseBody();
                        ResponseEntity<String> unClaimRequest = null;
                        String uncalimTicketResponse = "";

                        if (processBulkReassignRequest.getCurrentAssignee() != null) {
                                try {
                                        unClaimRequest = camundaService.unClaimTaskOpen(
                                                        processBulkReassignRequest.getTaskid(),
                                                        processBulkReassignRequest.getProcessId(),
                                                        processBulkReassignRequest.getCurrentAssignee());
                                } catch (Exception e) {
                                        LOGGER.error("Error : " + e + "\nParam : " + ac);

                                        failedTickets.add(
                                                        BulkReassignTicket.builder()
                                                                        .ticketId(processBulkReassignRequest
                                                                                        .getTicketId())
                                                                        .error("Failed in uncaliming ticket : Internal error "
                                                                                        + e.getMessage())
                                                                        .build());
                                }

                                uncalimTicketResponse = unClaimRequest.getBody();
                                // unClaimRequest.releaseBody();
                                LOGGER.info("Add comment response " + uncalimTicketResponse);
                                LOGGER.info("Add comment status" + unClaimRequest.getStatusCode());
                        }

                        Boolean callClaim = false;
                        if (unClaimRequest != null) {

                                callClaim = unClaimRequest.getStatusCode().is2xxSuccessful();
                        }

                        if (callClaim || processBulkReassignRequest.getCurrentAssignee() == null) {
                                ResponseEntity<String> claimRequest = null;
                                try {
                                        claimRequest = camundaService.claimTaskOpen(
                                                        processBulkReassignRequest.getTaskid(),
                                                        processBulkReassignRequest.getProcessId(),
                                                        processBulkReassignRequest.getNewAssignee());
                                } catch (Exception e) {
                                        LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString())
                                                        + "\nParam : "
                                                        + processBulkReassignRequest.getLoggedInUser());
                                        failedTickets.add(BulkReassignTicket.builder()
                                                        .ticketId(processBulkReassignRequest.getTicketId())
                                                        .error("Failed in claiming ticket : Internal error "
                                                                        + e.getMessage())
                                                        .build());

                                }
                                String claimResponse = claimRequest.getBody();
                                // claimRequest.releaseBody();
                                if (claimRequest.getStatusCode() != HttpStatus.NO_CONTENT) {

                                        LOGGER.error("Exiting claimTask Method in "
                                                        + ProcessBulkTicketsServiceImpl.class
                                                        + " class with response  : " + claimResponse);
                                        failedTickets
                                                        .add(BulkReassignTicket.builder()
                                                                        .ticketId(processBulkReassignRequest
                                                                                        .getTicketId())
                                                                        .error(claimResponse).build());

                                }
                        } else {
                                failedTickets
                                                .add(BulkReassignTicket.builder()
                                                                .ticketId(processBulkReassignRequest.getTicketId())
                                                                .error(uncalimTicketResponse).build());
                        }
                } else {
                        failedTickets
                                        .add(BulkReassignTicket.builder()
                                                        .ticketId(processBulkReassignRequest.getTicketId())
                                                        .error(addCommentResponse).build());
                }

                if (failedTickets.size() != 0) {

                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(failedTickets, false,
                                                        "Bulk Reassignment of ticket is not successfull"),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                }

                String msg = null;
                if (processBulkReassignRequest.getCurrentAssignee() == null) {
                        msg = " Cases Assigned to "
                                        + processBulkReassignRequest.getNewAssignee();
                } else {
                        msg = " Cases Reassigned from "
                                        + processBulkReassignRequest.getCurrentAssignee() + " to "
                                        + processBulkReassignRequest.getNewAssignee();
                }
                return new ResponseEntity<ApiResponse>(new ApiResponse(true, msg),
                                HttpStatus.OK);
        }


    public ResponseEntity<?> getDecisionAndRules(Authentication pr,
                                                 Integer tenantid) {

        LOGGER.debug("entered in class " + ProcessBulkTicketsServiceImpl.class +
                " in method getDecisionAndRules");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            ListValidationUtil listValidationUtil = new ListValidationUtil( activityLogService, loggerEncoderUtil,decisionService,rulesTempService);
            return listValidationUtil.getDecisionAndRules(pr,tenantid,loggedInUser,MenuNames.Tasks);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to " +
                    "access decisions and rules ");
            LOGGER.debug("Exiting getDecisionAndRules Method in " + ProcessBulkTicketsServiceImpl.class
                    + " class with response  : unauthorized to access " +
                    "decisions and rules ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access decisions " +
                            "and rules "),
                    HttpStatus.FORBIDDEN);
        }
    }
}
