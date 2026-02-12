package com.DronaPay.UIServer.service.ControllerService.CaseManagement;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.ResponseVO.DropdownWithObject;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.model.WorkflowMasters;
import com.DronaPay.UIServer.requests.DateRange;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.service.CamundaService;
import com.DronaPay.UIServer.service.RepositoryService.ActivityLogService;
import com.DronaPay.UIServer.service.RepositoryService.WebUserService;
import com.DronaPay.UIServer.service.RepositoryService.WorkflowMasterService;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.DronaPay.UIServer.util.XMLParser;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.StringReader;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class CaseReportsServiceImpl implements CaseReportsService {

    private static final Logger LOGGER = LoggerFactory.getLogger(CaseReportsServiceImpl.class);
    final String menu_name = MenuNames.reports;
    @Autowired
    private CamundaService camundaService;
    @Autowired
    private WebUserService webUserService;
    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;
    @Autowired
    private ActivityLogService activityLogService;
    @Autowired
    private WorkflowMasterService workflowMasterService;
    @Value("${max.xml.field.length}")
    private Integer maxFieldLength;

    @Autowired
    private XMLParser xmlParser;

    public ResponseEntity<?> getDataForCaseStatusSummary(DateRange dateRange, Integer tenantid, Authentication pr) {

        LOGGER.debug("entering  class " + CaseReportsServiceImpl.class + " and method getDataForCaseStatusSummary");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();

        activityLogService.addActivity(loggedInUser,
                "data requested for Case Status Summary in Case Management Reports", dateRange.toString());
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            ResponseEntity<String> clientResponse = null;
            try {
                String keys = String.join(",", loggedUser.getWorkflows()
                        .stream()
                        .filter(wfl -> wfl.getItenantId().getItenantid().equals(tenantid))
                        .map(wfl -> wfl.getWorkflowKey())
                        .toList());
                clientResponse = camundaService.getWorkFlowNameAllDeployed(loggedInUser, keys, tenantid);
            } catch (Exception e) {
                LOGGER.error("Error : " + e);
                activityLogService.addActivity(loggedInUser, "failed to get workflow name", "Error : " + e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

//            String responses = clientResponse.bodyToMono(String.class).block();
            String responses = clientResponse.getBody();
//            clientResponse.releaseBody();
            Map<String, List<Object>> resmap = new HashMap<>();

            if (clientResponse.getStatusCode() == HttpStatus.OK) {

                List<Object> workflowname = new LinkedList<>();
                List<Object> createdTickets = new LinkedList<>();
                List<Object> openTickets = new LinkedList<>();
                List<Object> inProcess = new LinkedList<>();
                List<Object> closedTickets = new LinkedList<>();
                JSONArray workflowNames = new JSONArray(responses);

                String startLocalDate = dateRange.getStartDate();
                String endLocalDate = dateRange.getEndDate();

                try {
                    for (int i = 0; i < workflowNames.length(); i++) {
                        JSONObject objectInArray = workflowNames.getJSONObject(i);
                        if (!objectInArray.get("name").equals("Review Invoice")
                                && !objectInArray.get("name").equals("Invoice Receipt")) {
                            workflowname.add(objectInArray.getString("name"));
                            ResponseEntity<String> createdticket = camundaService
                                    .getHistoryProcessInstance(
                                            "{\"processDefinitionKey\":\"" + objectInArray.get("key") + "\","
                                                + "\"tenantIdIn\":[\"" + tenantid + "\"],"
                                                    + "\"startedAfter\": \"" + startLocalDate
                                                    + "\", \"startedBefore\" : \"" + endLocalDate + "\"}",
                                            loggedInUser);

                            String createdticketlist = createdticket.getBody();
                            Integer createdticketcount;
                            Integer closedticket;

                            List<String> listOfProcessInstanceId = new ArrayList<>();
                            if (createdticket.getStatusCode() == HttpStatus.OK) {
                                JSONArray objectInArray1 = new JSONArray(createdticketlist);
                                List<Object> historicProcessInstanceList = objectInArray1.toList();
                                createdticketcount = historicProcessInstanceList.size();
                                listOfProcessInstanceId = historicProcessInstanceList.stream()
                                        .map(a -> (Map<String, String>) a)
                                        .filter(a -> String.valueOf(a.get("state")).equalsIgnoreCase("active"))
                                        .map(a -> a.get("id")).collect(Collectors.toList());
                                closedticket = createdticketcount - listOfProcessInstanceId.size();
                            } else {
                                createdticketcount = 0;
                                closedticket = 0;
                            }

                            Integer inProcessInt;

                            if (listOfProcessInstanceId.size() > 0) {
                                JSONObject bodyToGetTaskAssignedCount = new JSONObject();
                                bodyToGetTaskAssignedCount.put("processInstanceIdIn", listOfProcessInstanceId);
                                bodyToGetTaskAssignedCount.put("assigned", true);
                                inProcessInt = camundaService.getCount("/task/count",
                                        bodyToGetTaskAssignedCount.toString(), loggedInUser);
                            } else {
                                inProcessInt = 0;
                            }

                            Integer countOfNotClosedTickets = createdticketcount - closedticket;
                            closedTickets.add(closedticket);
                            createdTickets.add(createdticketcount);
                            inProcess.add(inProcessInt);
                            openTickets.add(countOfNotClosedTickets - inProcessInt);

                        }
                    }
                } catch (Exception e) {
                    LOGGER.error(loggerEncoderUtil.encode("Error : " + e + "\nParam : " + responses));
                    activityLogService.addActivity(loggedInUser, "failed to get task history",
                            "Error : " + e.toString() + ", Parameters : " + responses);
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                resmap.put("Case Type", workflowname);
                resmap.put("Created Tickets", createdTickets);
                resmap.put("Open Tickets", openTickets);
                resmap.put("In Process", inProcess);
                resmap.put("Closed Tickets", closedTickets);

                Map<String, String> schema = new HashMap<>();
                schema.put("Case Type", "string");
                schema.put("Created Tickets", "integer");
                schema.put("Open Tickets", "integer");
                schema.put("In Process", "integer");
                schema.put("Closed Tickets", "integer");

                Map<String, Object> res = new HashMap<>();

                res.put("Data", resmap);
                res.put("Schema", schema);

                LOGGER.debug("Exiting getDataForCaseStatusSummary Method in " + TasksServiceImpl.class
                        + " class with response : workflow names");
                activityLogService.addActivity(loggedInUser,
                        "data accessed successfully for Case Status Summary in case management report ");

                return ResponseEntity.ok(res);
            } else {
                activityLogService.addActivity(loggedInUser, "failed to access workflow names");
                LOGGER.debug("Exiting getDataForCaseStatusSummary Method in " + CaseReportsServiceImpl.class
                        + " class with response : " + responses);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, responses), clientResponse.getStatusCode());
            }

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get workflow names");
            LOGGER.debug("Exiting getDataForCaseStatusSummary Method in " + CaseReportsServiceImpl.class
                    + " class with response : unauthorized to get workflow names");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get workflow names"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> getDataForCaseTypeWiseSummary(DateRange dateRange, Integer tenantid, Authentication pr) {

        LOGGER.debug("entering  class " + CaseReportsServiceImpl.class + " and method getDataForCaseTypeWiseSummary");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();

        activityLogService.addActivity(loggedInUser,
                "data requested for Case Type Wise Summary in Case Management Reports", dateRange.toString());
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            ResponseEntity<String> clientResponse = null;
            try {
                String keys = String.join(",", loggedUser.getWorkflows()
                        .stream()
                        .filter(wfl -> (wfl.getItenantId().getItenantid().equals(tenantid) && wfl.getIsFilterDisplay()))
                        .map(wfl -> wfl.getWorkflowKey())
                        .toList());
                clientResponse = camundaService.getWorkFlowNameAllDeployed(loggedInUser, keys, tenantid);
            } catch (Exception e) {
                LOGGER.error("Error : " + e);
                activityLogService.addActivity(loggedInUser, "failed to get workflow name", "Error : " + e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

//            String responses = clientResponse.bodyToMono(String.class).block();
            String responses = clientResponse.getBody();
//            clientResponse.releaseBody();
            List<Map<String, Object>> resList = new LinkedList<>();
            Map<String, Map<String, Integer>> caseWise = new HashMap<>();
            Map<String, Map<String, Object>> uniqUeReport = new HashMap<>();

            if (clientResponse.getStatusCode() == HttpStatus.OK) {

                JSONArray workflowNames = new JSONArray(responses);
                // LOGGER.info(workflowNames.toString());
                String startLocalDate = dateRange.getStartDate();
                String endLocalDate = dateRange.getEndDate();

                try {
                    for (int i = 0; i < workflowNames.length(); i++) {
                        Map<String, Object> resmap = new HashMap<>();
                        JSONObject taskListInstance = workflowNames.getJSONObject(i);
                        Map<String, Integer> task = new HashMap<>();
                        if (!taskListInstance.get("name").equals("Review Invoice")
                                && !taskListInstance.get("name").equals("Invoice Receipt")) {
                            resmap.put("dashboardName", taskListInstance.getString("key"));
                            // caseWise.put(taskListInstance.getString("key"), null)
                            Map<String, String> schema = new HashMap<>();
                            ResponseEntity<String> bpmnXml;
                            ResponseEntity<String> stat = null;
                            Integer closedticket;
                            ArrayList<String> columnorder = new ArrayList<>();
                            try {
                                bpmnXml = camundaService.getBPMN(taskListInstance.getString("id"), loggedInUser);
                                stat = camundaService.getStatestics(taskListInstance.getString("id"), startLocalDate,
                                        endLocalDate, loggedInUser);
                                closedticket = camundaService.getCount("/history/process-instance/count",
                                        "{\"finished\":true, \"processDefinitionKey\":\"" + taskListInstance.get("key")
                                               + "\"tenantIdIn\":[\"" + tenantid + "\"],"
                                                + "\"," + "\"startedAfter\": \"" + startLocalDate
                                                + "\", \"startedBefore\" : \"" + endLocalDate + "\"}",
                                        loggedInUser);
                            } catch (Exception e) {
                                LOGGER.error("Error : " + e + "\nParam : " + taskListInstance.getString("id"));
                                activityLogService.addActivity(loggedInUser, "failed to status drop down", "Error : "
                                        + e.toString() + ", Parameters : " + taskListInstance.getString("id"));
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }

                            String bpmnResponse = bpmnXml.getBody();
//                            String statString = stat.bodyToMono(String.class).block();
                            String statString = stat.getBody();
//                            stat.releaseBody();
                            ObjectMapper mapper1 = new ObjectMapper();

                            JSONArray statArray = new JSONArray(statString);
                            Map<String, Integer> statMap = new TreeMap<>();

                            for (int j = 0, size = statArray.length(); j < size; j++) {
                                org.json.JSONObject objectInArray = statArray.getJSONObject(j);
                                statMap.put(objectInArray.getString("id"), objectInArray.getInt("instances"));
                            }

                            try {

                                // JsonNode rootNode = mapper1.readTree(bpmnResponse);

                                // DocumentBuilder builder =
                                // DocumentBuilderFactory.newInstance().newDocumentBuilder();
                                // InputSource src = new InputSource();
                                // src.setCharacterStream(new StringReader(rootNode.get("bpmn20Xml").asText()));

                                JsonNode rootNode = mapper1.readTree(bpmnResponse);

                                org.w3c.dom.Document doc = xmlParser.XMLParser(rootNode.get("bpmn20Xml").asText());

                                NodeList userTasklist = doc.getElementsByTagName("bpmn:userTask");

                                if (userTasklist.getLength() > maxFieldLength) {
                                    LOGGER.info("\nParam : " + loggerEncoderUtil
                                            .encode(taskListInstance.getString("id")));
                                    activityLogService.addActivity(loggedInUser,
                                            "failed to get xml parametes length more then  "
                                                    + maxFieldLength,
                                            taskListInstance.getString("id"));
                                    return new ResponseEntity<ApiResponse>(
                                            new ApiResponse(false,
                                                    "No of fields should not exceed "
                                                            + maxFieldLength),
                                            HttpStatus.BAD_REQUEST);
                                }

                                Map<String, List<Object>> column = new TreeMap<>();
                                column.put("Case Open", Collections.singletonList(taskListInstance.getString("name")));
                                schema.put("Case Open", "string");
                                columnorder.add("Case Open");

                                // org.w3c.dom.Document doc = builder.parse(src);

                                for (int j = 0; j < doc.getElementsByTagName("bpmn:userTask").getLength(); j++) {

                                    if (statMap.containsKey(doc.getElementsByTagName("bpmn:userTask").item(j)
                                            .getAttributes().getNamedItem("id").getNodeValue())) {
                                        if (caseWise.containsKey(taskListInstance.getString("key"))) {
                                            if (caseWise.get(taskListInstance.getString("key"))
                                                    .containsKey(doc.getElementsByTagName("bpmn:userTask").item(j)
                                                            .getAttributes().getNamedItem("name").getNodeValue())) {
                                                column.put(
                                                        doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                .getAttributes().getNamedItem("name").getNodeValue(),
                                                        Collections.singletonList(statMap
                                                                .get(doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                        .getAttributes().getNamedItem("id")
                                                                        .getNodeValue())
                                                                + caseWise.get(taskListInstance.getString("key"))
                                                                        .get(doc.getElementsByTagName("bpmn:userTask")
                                                                                .item(j).getAttributes()
                                                                                .getNamedItem("name").getNodeValue())));
                                                task.put(
                                                        doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                .getAttributes().getNamedItem("name").getNodeValue(),
                                                        statMap.get(doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                .getAttributes().getNamedItem("id").getNodeValue())
                                                                + caseWise.get(taskListInstance.getString("key"))
                                                                        .get(doc.getElementsByTagName("bpmn:userTask")
                                                                                .item(j).getAttributes()
                                                                                .getNamedItem("name").getNodeValue()));
                                            } else {
                                                column.put(
                                                        doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                .getAttributes().getNamedItem("name").getNodeValue(),
                                                        Collections.singletonList(statMap.get(doc
                                                                .getElementsByTagName("bpmn:userTask").item(j)
                                                                .getAttributes().getNamedItem("id").getNodeValue())));
                                                task.put(
                                                        doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                .getAttributes().getNamedItem("name").getNodeValue(),
                                                        statMap.get(doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                .getAttributes().getNamedItem("id").getNodeValue()));
                                            }

                                        } else {
                                            column.put(
                                                    doc.getElementsByTagName("bpmn:userTask").item(j).getAttributes()
                                                            .getNamedItem("name").getNodeValue(),
                                                    Collections.singletonList(statMap.get(doc
                                                            .getElementsByTagName("bpmn:userTask").item(j)
                                                            .getAttributes().getNamedItem("id").getNodeValue())));
                                            task.put(
                                                    doc.getElementsByTagName("bpmn:userTask").item(j).getAttributes()
                                                            .getNamedItem("name").getNodeValue(),
                                                    statMap.get(doc.getElementsByTagName("bpmn:userTask").item(j)
                                                            .getAttributes().getNamedItem("id").getNodeValue()));
                                        }

                                    } else {

                                        if (caseWise.containsKey(taskListInstance.getString("key"))) {
                                            if (caseWise.get(taskListInstance.getString("key"))
                                                    .containsKey(doc.getElementsByTagName("bpmn:userTask").item(j)
                                                            .getAttributes().getNamedItem("name").getNodeValue())) {
                                                column.put(
                                                        doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                .getAttributes().getNamedItem("name").getNodeValue(),
                                                        Collections.singletonList(
                                                                0 + caseWise.get(taskListInstance.getString("key"))
                                                                        .get(doc.getElementsByTagName("bpmn:userTask")
                                                                                .item(j).getAttributes()
                                                                                .getNamedItem("name").getNodeValue())));
                                                task.put(
                                                        doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                .getAttributes().getNamedItem("name").getNodeValue(),
                                                        0 + caseWise.get(taskListInstance.getString("key"))
                                                                .get(doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                        .getAttributes().getNamedItem("name")
                                                                        .getNodeValue()));
                                            } else {
                                                column.put(
                                                        doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                .getAttributes().getNamedItem("name").getNodeValue(),
                                                        Collections.singletonList(0));
                                                task.put(
                                                        doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                .getAttributes().getNamedItem("name").getNodeValue(),
                                                        0);
                                            }

                                        } else {
                                            column.put(
                                                    doc.getElementsByTagName("bpmn:userTask").item(j).getAttributes()
                                                            .getNamedItem("name").getNodeValue(),
                                                    Collections.singletonList(0));
                                            task.put(doc.getElementsByTagName("bpmn:userTask").item(j).getAttributes()
                                                    .getNamedItem("name").getNodeValue(), 0);
                                        }
                                    }
                                    schema.put(doc.getElementsByTagName("bpmn:userTask").item(j).getAttributes()
                                            .getNamedItem("name").getNodeValue(), "integer");
                                    columnorder.add(doc.getElementsByTagName("bpmn:userTask").item(j).getAttributes()
                                            .getNamedItem("name").getNodeValue());
                                }

                                for (int j = 0; j < doc.getElementsByTagName("bpmn:receiveTask").getLength(); j++) {

                                    if (statMap.containsKey(doc.getElementsByTagName("bpmn:receiveTask").item(j)
                                            .getAttributes().getNamedItem("id").getNodeValue())) {
                                        column.put(
                                                doc.getElementsByTagName("bpmn:receiveTask").item(j).getAttributes()
                                                        .getNamedItem("name").getNodeValue(),
                                                Collections.singletonList(
                                                        statMap.get(doc.getElementsByTagName("bpmn:receiveTask").item(j)
                                                                .getAttributes().getNamedItem("id").getNodeValue())));
                                    } else {
                                        column.put(
                                                doc.getElementsByTagName("bpmn:receiveTask").item(j).getAttributes()
                                                        .getNamedItem("name").getNodeValue(),
                                                Collections.singletonList(0));
                                    }
                                    schema.put(doc.getElementsByTagName("bpmn:receiveTask").item(j).getAttributes()
                                            .getNamedItem("name").getNodeValue(), "integer");
                                    columnorder.add(doc.getElementsByTagName("bpmn:receiveTask").item(j).getAttributes()
                                            .getNamedItem("name").getNodeValue());
                                }
                                column.put("Closed", Collections.singletonList(closedticket));
                                schema.put("Closed", "integer");
                                columnorder.add("Closed");
                                String colour = "";

                                for (int il = 0; il < columnorder.size(); il++) {
                                    colour += "\"" + columnorder.get(il).toString() + "\"";
                                    colour += il < columnorder.size() - 1 ? "," : "";

                                }
                                resmap.put("dashboardLayout",
                                        "{\"sizes\": [1],\"master\": {\"widgets\": [\"PERSPECTIVE_GENERATED_ID_1\"]},\"viewers\": {\"PERSPECTIVE_GENERATED_ID_1\": {\"selectable\": false,\"plugin\": \"datagrid\",\"master\": true,\"name\": \""
                                                + taskListInstance.getString("name") + "\",\"columns\": [" + colour
                                                + "],\"table\": \"" + taskListInstance.getString("key")
                                                + "\",\"linked\": false}}}");
                                resmap.put("Schema", schema);
                                resmap.put("dashboardData", column);

                            } catch (Exception e) {
                                LOGGER.error("Error : " + e + "\nParam : " + bpmnResponse);
                                activityLogService.addActivity(loggedInUser, "failed to status drop down",
                                        "Error : " + e.toString() + ", Parameters : " + bpmnResponse);
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }
                            caseWise.put(taskListInstance.getString("key"), task);
                            // resList.add(resmap);
                            uniqUeReport.put(taskListInstance.getString("key"), resmap);
                        }
                    }
                    resList.addAll(uniqUeReport.values());
                } catch (Exception e) {
                    System.out.println("xyz5");
                    LOGGER.error(loggerEncoderUtil.encode("Error : " + e + "\nParam : " + responses));
                    activityLogService.addActivity(loggedInUser, "failed to get task history",
                            "Error : " + e.toString() + ", Parameters : " + responses);
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                LOGGER.debug("Exiting getDataForCaseTypeWiseSummary Method in " + CaseReportsServiceImpl.class
                        + " class with response : with data for requested date range ");
                activityLogService.addActivity(loggedInUser,
                        "data accessed successfully for Case Type Wise Summary in case management report ");
                return ResponseEntity.ok(resList);
            } else {
                activityLogService.addActivity(loggedInUser, "failed to access workflow names");
                LOGGER.debug("Exiting getDataForCaseTypeWiseSummary Method in " + CaseReportsServiceImpl.class
                        + " class with response : " + responses);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, responses), clientResponse.getStatusCode());
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get workflow names");
            LOGGER.debug("Exiting getDataForCaseTypeWiseSummary Method in " + CaseReportsServiceImpl.class
                    + " class with response : unauthorized to get workflow names");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get workflow names"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getWorkFlowName(Authentication pr) {

        LOGGER.debug("entering  class " + CaseReportsServiceImpl.class + " and method getWorkFlowName");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();

        activityLogService.addActivity(loggedInUser, " requested workflow names  in Case Management Reports");
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            List<WorkflowMasters> allWorkflows = null;
            try {
                allWorkflows = workflowMasterService.findAll();
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                // activityLogService.addActivity("failed to get user and permissions",
                // e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            ResponseEntity<String> clientResponse = null;
            try {
                clientResponse = camundaService.getWorkFlowName(loggedUser);

            } catch (Exception e) {
                LOGGER.error("Error : " + e);
                activityLogService.addActivity(loggedInUser, "failed to get workflow name", "Error : " + e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
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
                            org.json.JSONObject objectInArray = workflowNames.getJSONObject(i);
                            if (wfl.getWorkflowKey().equals(objectInArray.get("key"))) {
                                workFlowDropDown.add(DropdownWithObject.builder().label(objectInArray.get("name"))
                                        .value(objectInArray.get("key")).build());
                            }
                        }
                    }
                } catch (Exception e) {
                    LOGGER.error(loggerEncoderUtil.encode("Error : " + e + "\nParam : " + responses));
                    activityLogService.addActivity(loggedInUser, "failed to get task history",
                            "Error : " + e.toString() + ", Parameters : " + responses);
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                LOGGER.debug("Exiting getWorkFlowName Method in " + CaseReportsServiceImpl.class
                        + " class with response : workflow names");
                activityLogService.addActivity(loggedInUser,
                        "  workflow names  in Case Management Reports accessed successfully");
                return ResponseEntity.ok(workFlowDropDown);

            } else {
                activityLogService.addActivity(loggedInUser, "failed to access workflow names");
                LOGGER.debug("Exiting getPayeeNames Method in " + CaseReportsServiceImpl.class
                        + " class with response : " + responses);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, responses), clientResponse.getStatusCode());
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get workflow names");
            LOGGER.debug("Exiting getWorkFlowName Method in " + CaseReportsServiceImpl.class
                    + " class with response : unauthorized to get workflow names");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get workflow names"),
                    HttpStatus.FORBIDDEN);
        }
    }

}
