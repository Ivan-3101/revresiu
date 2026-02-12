package com.DronaPay.UIServer.service.ControllerService.CaseManagement;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.Enum.DatabaseType;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.ResponseVO.DecRulesVO;
import com.DronaPay.UIServer.ResponseVO.DropDownVo;
import com.DronaPay.UIServer.ResponseVO.DropdownWithObject;
import com.DronaPay.UIServer.VOMapper.*;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.repository.MyBatiesMapper.AccountWithCountMapper;
import com.DronaPay.UIServer.repository.TaskVariablesRepository;
import com.DronaPay.UIServer.requests.*;
import com.DronaPay.UIServer.requests.CamundaRequests.AddComment;
import com.DronaPay.UIServer.requests.CamundaRequests.AddCommentGt;
import com.DronaPay.UIServer.requests.CamundaRequests.PriorityQueueTaskRequest;
import com.DronaPay.UIServer.response.*;
import com.DronaPay.UIServer.service.ApiServices.SanctionApiService;
import com.DronaPay.UIServer.service.CamundaService;
import com.DronaPay.UIServer.service.FrmService;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.*;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.fasterxml.jackson.databind.node.ObjectNode;
import jakarta.servlet.http.HttpServletRequest;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.*;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import jakarta.annotation.PostConstruct;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;
import java.io.StringReader;
import java.net.http.HttpResponse;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAccessor;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class TasksServiceImpl implements TasksService {

    private static final Logger LOGGER = LoggerFactory.getLogger(TasksServiceImpl.class);
    final String menu_name = MenuNames.Tasks;

    final String menu_name_manual = MenuNames.ManualTicket;
//    @Qualifier("jdbcAnalyticsService")
//    @Autowired
//    JdbcTemplate jdbcTemplateAnalytics;
//    @Qualifier("jdbcTransactionalService")
//    @Autowired
//    JdbcTemplate jdbcTemplateTransactional;
    private Map<DatabaseType, JdbcTemplate> jdbcTemplateMap;

    @Autowired
    public TasksServiceImpl(Map<DatabaseType, JdbcTemplate> jdbcTemplateMap) {
        this.jdbcTemplateMap = jdbcTemplateMap;
    }

    @Value("${max.xml.field.length}")
    private Integer maxFieldLength;
    @Autowired
    private ActivityLogService activityLogService;
    @Autowired
    private AnalyticalDBQueryExecution analyticalDBQueryExecution;
    @Autowired
    private WebUserService webUserService;
    @Autowired
    private CamundaService camundaService;
    @Autowired
    private ValidationFieldsListService validationFieldsListService;
    @Autowired
    private FormMasterService formMasterService;
    @Autowired
    private CamundaParamExtractor camundaParamExtractor;
    @Autowired
    private Environment env;
    @Autowired
    private VpaService vpaService;
    @Autowired
    private FrmService frmService;
    @Autowired
    private RulesTempServiceImpl rulesTempService;
    @Autowired
    private AccountWithCountMapper accountWithCountMapper;
    @Autowired
    private PanelAccesMapRepositoryService panelAccessMapRepositoryService;
    @Autowired
    private SectionParametersService summaryParametersService;
    @Autowired
    private GroupToTaskFilterMapService groupToTaskFilterMapService;
    @Autowired
    private DecisionUiService decisionUiService;
    @Autowired
    private XMLParser xmlParser;
    @Autowired
    private STRFromActionAfterCreation strFromActionAfterCreation;
    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;
    @Autowired
    private FormMasterDTOMapper formMasterDTOMapper;
    @Autowired
    private FormValueDTOMapper formValueDTOMapper;
    @Autowired
    private FormValueService formValueService;
    @Autowired
    private WorkflowMasterService workflowMasterService;
    @Autowired
    private SanctionApiService sanctionApiService;
    @Autowired
    private TaskLHSMapService taskLHSMapService;
    @Autowired
    private TaskVariablesRepository taskVariablesRepo;

    @Autowired
    private TransactionClassesUiService transactionClassesUiService;

    @Autowired
    private MetadataUiService metadataUiService;

    @Autowired
    private AccountsService accountService;
    @Autowired
    private ProfileParamsService profileParamsService;
    @Autowired
    private GroupDescService groupDescService;

    @Autowired
    private WebuserMappingUtil webuserMappingUtil;

    @Autowired
    private DashboardQueryParmeterService dashboardQueryParmeterService;

    @Autowired
    private DashboardQueryService dashboardQueryService;

    @Autowired
    private DashboardErrorUtil dashboardErrorUtil;

    public ResponseEntity<?> getListDropDown(Authentication pr) {
        LOGGER.debug("entered in class " + TasksServiceImpl.class + " in method getListDropDown");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            Map<String, Object> response = new HashMap<>();
            try {
                List<GroupDesc> group_desc_list = loggedUser.getGroups();
                List<Integer> listofgroupid = new ArrayList<>();

                UserMapping userMapping = new UserMapping();
                userMapping.setMappingIds(group_desc_list
                        .stream()
                        .map(groupDesc -> groupDesc.getIgroupID())
                        .collect(Collectors.toList()));
                userMapping.setTenantids(group_desc_list
                        .stream()
                        .map(groupDesc -> groupDesc.getItenantId())
                        .collect(Collectors.toList()));

                List<GroupToTaskFilterMap> listofgroup = groupToTaskFilterMapService
                        .findAllByIGroupIDAndTenantID(userMapping);
                List<Map<String, Object>> reslist = new ArrayList<>();
                for (GroupToTaskFilterMap groupToTaskFilterMap : listofgroup) {

                    Map<String, Object> addtolist = new HashMap<>();
                    addtolist.put("name", groupToTaskFilterMap.getITaskFilterID().getVcFilterName());
                    addtolist.put("render", groupToTaskFilterMap.getITaskFilterID().getBRender());
                    addtolist.put("required", groupToTaskFilterMap.getITaskFilterID().getBRequired());
                    addtolist.put("position", groupToTaskFilterMap.getIPosition());
                    addtolist.put("keyName", groupToTaskFilterMap.getITaskFilterID().getVcKeyName());
                    addtolist.put("errorName", groupToTaskFilterMap.getITaskFilterID().getVcErrorName());
                    addtolist.put("condition", groupToTaskFilterMap.getITaskFilterID().getVcCondition());
                    reslist.add(addtolist);
                }

                List<DropDownVo> respons = DropDownVoMapper.parseGroup(loggedInUser);
                response.put("dropdown", respons);
                response.put("fields", reslist);
                List<WorkflowMasters> workflows = new ArrayList<>();
                workflows = workflowMasterService.findAllManualCreation();

                Map<String, Object> manualCreation = new HashMap<>();
                if (mp.isAdd() && workflows.size() > 0) {
                    manualCreation.put("isManualEnabled", true);
                    manualCreation.put("permissions", mp);
                } else {
                    manualCreation.put("isManualEnabled", false);
                }
                response.put("manualCreation", manualCreation);

            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(loggedInUser.toString()));
                activityLogService.addActivity(loggedInUser, "failed to access dropdown", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            activityLogService.addActivity(loggedInUser, "Task Dropdown accessed");
            LOGGER.debug("exiting in class " + TasksServiceImpl.class + " in method getListDropDown");

            return ResponseEntity.ok(response);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access case management dropdown");
            LOGGER.debug("Exiting getListDropDown Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to access case management dropdown");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access case management dropdown"),
                    HttpStatus.FORBIDDEN);
        }
    }

    private JSONArray extractLHSFields(org.json.JSONObject task, Map<String, org.json.JSONObject> camundaVar,
            List<TaskLHSMap> fieldsConfig) {
        JSONArray allFields = new JSONArray();

        for (TaskLHSMap lhs : fieldsConfig) {
            org.json.JSONObject field = new org.json.JSONObject();
            if(lhs.getValueConfig().has("path")){
            String[] valuePath = lhs.getValueConfig().get("path").asText().split("\\.");
            Object value = null;
            if (valuePath.length == 2 && valuePath[0].equals("this")) {
                value = task.opt(valuePath[1]);
            } else if (valuePath.length == 3 && valuePath[0].equals("this") && valuePath[1].equals("variables")) {
                value = (camundaVar.get(valuePath[2]) != null ? camundaVar.get(valuePath[2]).opt("value") : null);
            } else if (valuePath.length > 3 && valuePath[0].equals("this") && valuePath[1].equals("variables")) {
                // assume a json camunda variable
                org.json.JSONObject jsonVar = new org.json.JSONObject(camundaVar.get(valuePath[2]).getString("value"));
                String varPath = "";
                for (int i = 3; i < valuePath.length; i++) {
                    varPath = varPath + "/" + valuePath[i];
                }
                value = jsonVar.optQuery(varPath);
            } else {
                value = valuePath;
            }

            if (value != null && lhs.getValueConfig().get("type").asText().equals("amount")) {
                value = Double.parseDouble(value.toString()) / 100;
            }
            if (value != null) {
                field.put("value", value);
            } else {
                field.put("value", org.json.JSONObject.NULL);
            }
            }



            field.put("rowno", lhs.getIrow());
            field.put("order", lhs.getIorder());
            field.put("colwidth", lhs.getIcolumn());
            field.put("type", lhs.getValueConfig().get("type").asText());
            field.put("tag", lhs.getValueConfig().get("tag").asText());
            if(lhs.getValueConfig().has("jsonLogic")){
                field.put("jsonLogic",lhs.getValueConfig().get("jsonLogic"));
            }

            if(lhs.getValueConfig().has("computationJson")){
                JSONArray updatedComputationJson=   new JSONArray(lhs.getValueConfig().get("computationJson").toString());

                for(int i=0;i<updatedComputationJson.length();i++){
                    org.json.JSONObject currObject=updatedComputationJson.getJSONObject(i);

                    String varName=currObject.getString("variableName");
                    Object objValue=camundaVar.containsKey(varName)?camundaVar.get(varName).get("value"):"";

                    currObject.put("value",objValue);
                }

                field.put("computationJson",updatedComputationJson);
            }

            if (lhs.getValueConfig().has("className")) {
                field.put("className", lhs.getValueConfig().get("className").asText());
            }
            allFields.put(field);
        }
        return allFields;
    }

    public ResponseEntity<?> getTaskListLHS(GetTaskListRequestGt getTaskListRequestGt, Authentication pr) {

        LOGGER.debug("entered in class " + TasksServiceImpl.class + " in method getTaskList");

        KeysTenants keysTenants = camundaParamExtractor.extractTenantWorkflows(getTaskListRequestGt.getParameters());

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()
                && loggedUser.allowTenantsWorkflowKeys(keysTenants.getItenantIds(), keysTenants.getWorkflowKeys())) {

            List<String> defs = new ArrayList<>();
            defs.add("DeclineTransaction");
            defs.add("RiskAlert");

            List<TaskResponse> tasks = new ArrayList<>();
            // System.out.println(getTaskListRequest);

            // if (getTaskListRequest.getOpen()) {
            // tasks = accountWithCountMapper.findAllTaskNew(null,
            // getTaskListRequest.getRiskScore(),
            // getTaskListRequest.getSortDir(), getTaskListRequest.getSortBy(),
            // getTaskListRequest.getDefKey(),
            // getTaskListRequest.getMaxResult(),
            // getTaskListRequest.getMinAmount(), getTaskListRequest.getMaxAmount(),
            // getTaskListRequest.getFailedRules(), getTaskListRequest.getStage(),
            // getTaskListRequest.getLevel(), getTaskListRequest.getType(),
            // getTaskListRequest.getAddress(),
            // getTaskListRequest.getStartDate(), getTaskListRequest.getEndDate(),
            // getTaskListRequest.getTicketid());

            // } else {
            // tasks = accountWithCountMapper.findAllTaskNew(loggedInUser.getVcUserName(),
            // getTaskListRequest.getRiskScore(), getTaskListRequest.getSortDir(),
            // getTaskListRequest.getSortBy(), getTaskListRequest.getDefKey(),
            // getTaskListRequest.getMaxResult(),
            // getTaskListRequest.getMinAmount(), getTaskListRequest.getMaxAmount(),
            // getTaskListRequest.getFailedRules(), getTaskListRequest.getStage(),
            // getTaskListRequest.getLevel(), getTaskListRequest.getType(),
            // getTaskListRequest.getAddress(),
            // getTaskListRequest.getStartDate(), getTaskListRequest.getEndDate(),
            // getTaskListRequest.getTicketid());
            // }

            GetTaskListRequest getTaskListRequest = new GetTaskListRequest();
            getTaskListRequest.setMy(getTaskListRequestGt.getMy());
            getTaskListRequest.setAddress(getTaskListRequestGt.getAddress());
            getTaskListRequest.setClosed(getTaskListRequestGt.getClosed());
            getTaskListRequest.setDefKey(getTaskListRequestGt.getDefKey());
            getTaskListRequest.setEndDate(getTaskListRequestGt.getEndDate());
            getTaskListRequest.setFailedRules(getTaskListRequestGt.getFailedRules());
            getTaskListRequest.setLevel(getTaskListRequestGt.getLevel());
            getTaskListRequest.setMaxAmount(getTaskListRequestGt.getMaxAmount());
            getTaskListRequest.setMaxResult(getTaskListRequestGt.getMaxResult());
            getTaskListRequest.setMinAmount(getTaskListRequestGt.getMinAmount());
            getTaskListRequest.setOpen(getTaskListRequestGt.getOpen());
            getTaskListRequest.setParameters(getTaskListRequestGt.getParameters());
            getTaskListRequest.setRiskScore(getTaskListRequestGt.getRiskScore());
            getTaskListRequest.setSortBy(getTaskListRequestGt.getSortBy());
            getTaskListRequest.setSortDir(getTaskListRequestGt.getSortDir());
            getTaskListRequest.setStage(getTaskListRequestGt.getStage());
            getTaskListRequest.setStartDate(getTaskListRequestGt.getStartDate());
            getTaskListRequest.setTicketid(getTaskListRequestGt.getTicketid());
            getTaskListRequest.setType(getTaskListRequestGt.getType());

            ResponseEntity<String> tasklist = null;
            JsonNode countjosn = null;
            // System.out.println(getTaskListRequest.getParameters());
            List<TaskLHSMap> lhsSchemaAll = null;
            try {
                lhsSchemaAll = taskLHSMapService.findByOption(getTaskListRequestGt.getOption());
            } catch (Exception e) {
                LOGGER.error(
                        "Error : " + e + "\nParam : " + loggerEncoderUtil.encode(getTaskListRequestGt.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get task list",
                        "Error : " + e.toString() + ", Parameters : " + getTaskListRequest);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            if (getTaskListRequest.getClosed() == false) {
                try {
                    long t1 = System.currentTimeMillis();
                    ResponseEntity<String> countClientResponse = camundaService
                            .getTaskListPostCount(getTaskListRequest.getParameters(), loggedInUser);
                    long t2 = System.currentTimeMillis();

                    // countjosn = countClientResponse.bodyToMono(JsonNode.class).block();
                    countjosn = new ObjectMapper().readTree(countClientResponse.getBody());
                    // countClientResponse.releaseBody();
                    tasklist = camundaService.getTaskListPostHttp(getTaskListRequest, loggedInUser);
                    long t3 = System.currentTimeMillis();
                    LOGGER.info("Time count " + (t2 - t1) + " time task " + (t3 - t2));
                } catch (Exception e) {
                    LOGGER.error(
                            "Error : " + e + "\nParam : " + loggerEncoderUtil.encode(getTaskListRequest.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get task list",
                            "Error : " + e.toString() + ", Parameters : " + getTaskListRequest);
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
            } else {
                if (getTaskListRequest.getMy() == false) {
                    try {
                        // System.out.println(new Date());
                        List<String> workflowkeylist = getTaskListRequest.getDefKey();
                        if (workflowkeylist == null) {
                            // null in getDefKey() implies no filter hence to be fetched for all workflows

                            // List<GroupDesc> group_desc_list = loggedUser.getGroups();
                            //
                            // UserMapping userMapping = new UserMapping();
                            // userMapping.setTenantids(group_desc_list
                            // .stream().map(a -> a.getItenantId()).collect(Collectors.toList()));
                            // userMapping.setMappingIds(group_desc_list
                            // .stream().map(a -> a.getIgroupID()).collect(Collectors.toList()));
                            //
                            // System.out.println(userMapping);
                            // List<Integer> workflowid = panelAccessMapRepositoryService
                            // .findAllByUserGroupInAndItenantIdIn(userMapping)
                            // .stream().map(a -> a.getWorkflowMasters()).collect(Collectors.toList());

                            workflowkeylist = loggedUser
                                    .getWorkflows()
                                    .stream()
                                    .map(a -> a.getWorkflowKey())
                                    .distinct()
                                    .collect(Collectors.toList());

                        }
                        System.out.println("workflow list is " + workflowkeylist);
                        ResponseEntity<String> countClientResponse = camundaService
                                .getProcessInstHistoryPostCount(getTaskListRequest.getParameters(), loggedInUser,
                                        workflowkeylist);
                        // countjosn = countClientResponse.bodyToMono(JsonNode.class).block();
                        countjosn = new ObjectMapper().readTree(countClientResponse.getBody());
                        // countClientResponse.releaseBody();
                        tasklist = camundaService.getTaskListCompletedHttp(getTaskListRequest, loggedInUser,
                                workflowkeylist);
                        // System.out.println(new Date());
                    } catch (Exception e) {
                        LOGGER.error("Error : " + e + "\nParam : "
                                + loggerEncoderUtil.encode(getTaskListRequest.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to get task list",
                                "Error : " + e.toString() + ", Parameters : " + getTaskListRequest);
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                } else {

                    try {
                        // System.out.println(new Date());
                        ResponseEntity<String> countClientResponse = camundaService
                                .getTaskListHistoryPostCount(getTaskListRequest.getParameters(), loggedInUser);
                        // countjosn = countClientResponse.bodyToMono(JsonNode.class).block();
                        countjosn = new ObjectMapper().readTree(countClientResponse.getBody());
                        // countClientResponse.releaseBody();
                        tasklist = camundaService.getTaskListCompletedHistoryHttp(getTaskListRequest, loggedInUser);
                        // System.out.println(new Date());
                    } catch (Exception e) {
                        LOGGER.error("Error : " + e + "\nParam : "
                                + loggerEncoderUtil.encode(getTaskListRequest.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to get task list",
                                "Error : " + e.toString() + ", Parameters : " + getTaskListRequest);
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                }
            }

            List<String> instaceId = new ArrayList<>();
            JSONArray taskList = new JSONArray();

            Map<String, Object> response = new HashMap<>();
            response.put("count", countjosn.get("count"));

            if (tasklist != null) {
                if (tasklist.getStatusCode() == HttpStatus.OK) {
                    taskList = new JSONArray(tasklist.getBody());

                    for (int i = 0; i < taskList.length(); i++) {
                        if (getTaskListRequest.getClosed()) {
                            if (getTaskListRequest.getMy()) {
                                instaceId.add(taskList.getJSONObject(i).optString("processInstanceId"));
                            } else {
                                instaceId.add(taskList.getJSONObject(i).optString("id"));
                                taskList.getJSONObject(i).put("processInstanceId",
                                        taskList.getJSONObject(i).optString("id"));
                                taskList.getJSONObject(i).put("created",
                                        taskList.getJSONObject(i).optString("startTime"));
                            }
                        } else {
                            instaceId.add(taskList.getJSONObject(i).optString("processInstanceId"));
                        }

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

                    // String processInJson = "{\n \"processInstanceIdIn\":" + json
                    // + ",\r\n
                    // \"variableNameIn\":[\"WorkflowName\",\"TicketID\",\"failedRules\",\"TransactionAmount\",\"fieldDropDowns\",\"RiskScore\",\"AvgRiskScore\"]
                    // \r\n \r\n \r\n}";

                    TaskVariables varList = taskVariablesRepo.getById(1);
                    String processInJson = "{\n \"processInstanceIdIn\":" + json
                            + ",\r\n \"variableNameIn\":" + varList.getVariables() + "\r\n    \r\n   \r\n}";
                    ResponseEntity<String> details = null;

                    System.out.println("history variable request body " + processInJson);
                    if (instaceId.size() != 0) {
                        try {
                            System.out.println("history time start " + System.currentTimeMillis());
                            details = camundaService.postHistoryVarInstance(processInJson, loggedInUser);
                            System.out.println("History time end " + System.currentTimeMillis());
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
                            Map<String, JSONArray> processVarMap = new HashMap<>();
                            JSONArray detailList = new JSONArray(details.getBody());
                            System.out.println("detail list size " + detailList.length());
                            for (int i = 0; i < detailList.length(); i++) {
                                String procId = detailList.getJSONObject(i).getString("processInstanceId");
                                if (!processVarMap.containsKey(procId)) {
                                    processVarMap.put(procId, new JSONArray());
                                }
                                JSONArray varArr = processVarMap.get(procId);
                                varArr.put(detailList.getJSONObject(i));
                            }

                            for (int k = 0; k < taskList.length(); k++) {
                                org.json.JSONObject taskListInstance = taskList.getJSONObject(k);
                                JSONArray varArr = processVarMap.get(taskListInstance.getString("processInstanceId"));
                                Map<String, org.json.JSONObject> camundaVar = new HashMap<>();
                                if (varArr != null) {
                                    for (int n = 0; n < varArr.length(); n++) {
                                        camundaVar.put(varArr.getJSONObject(n).getString("name"),
                                                varArr.getJSONObject(n));
                                        if (varArr.getJSONObject(n).getString("name").equals("RiskScore")) {
                                            taskListInstance.put("riskScore", varArr.getJSONObject(n).get("value"));
                                        }

                                        if (varArr.getJSONObject(n).getString("name")
                                                .equals("AvgRiskScore")) {
                                            taskListInstance.put("AvgRiskScore",
                                                    varArr.getJSONObject(n).get("value"));
                                        }

                                        if (varArr.getJSONObject(n).getString("name")
                                                .equals("WorkflowName")) {
                                            taskListInstance.put("workflowName",
                                                    varArr.getJSONObject(n).get("value"));
                                        }

                                        if (varArr.getJSONObject(n).getString("name").equals("TicketID")) {
                                            taskListInstance.put("ticketID", varArr.getJSONObject(n).get("value"));
                                        }

                                        if (varArr.getJSONObject(n).getString("name")
                                                .equals("failedRules")) {
                                            taskListInstance.put("failedRules",
                                                    varArr.getJSONObject(n).get("value"));
                                        }

                                        if (varArr.getJSONObject(n).getString("name")
                                                .equals("fieldDropDowns")) {
                                            taskListInstance.put("fieldDropDowns",
                                                    varArr.getJSONObject(n).get("value"));
                                        }

                                        if (varArr.getJSONObject(n).getString("name")
                                                .equals("TransactionAmount")) {
                                            String amount = varArr.getJSONObject(n).get("value").toString();
                                            taskListInstance.put("transactionAmount", Double.parseDouble(amount) / 100);
                                        }

                                    }
                                }

                                String workflowKey = taskListInstance.getString("processDefinitionId").split(":")[0];
                                Integer workflowTenant = taskListInstance.getInt("tenantId");

                                WorkflowMasters workflow = loggedUser.getWorkflows().stream().filter(wf -> {
                                    return wf.getWorkflowKey().equals(workflowKey)
                                            && wf.getItenantId().getItenantid().equals(workflowTenant);
                                }).findFirst().orElse(null);

                                // workflow = workflowMasterService.findByWorkflowAndTenantId(workflowKey,
                                // workflowTenant);
                                List<TaskLHSMap> lhsConfig = new ArrayList<>();
                                if (workflow != null) {
                                    lhsConfig = lhsSchemaAll.stream().filter(sc -> {
                                        if (sc.getWorkflowId() == workflow.getWorkflowId()
                                                && sc.getItenantId() == workflow.getItenantId().getItenantid()) {
                                            return true;
                                        } else {
                                            return false;
                                        }
                                    }).sorted(new Comparator<TaskLHSMap>() {
                                        @Override
                                        public int compare(TaskLHSMap t1, TaskLHSMap t2) {
                                            if (t1.getIrow() != t2.getIrow()) {
                                                return t1.getIrow() - t2.getIrow();
                                            } else {
                                                return t1.getIorder() - t2.getIorder();
                                            }
                                        }
                                    }).collect(Collectors.toList());
                                }
                                JSONArray lhsFields = extractLHSFields(taskListInstance, camundaVar, lhsConfig);
                                taskListInstance.put("lhsDisplay", lhsFields);

                                taskList.put(k, taskListInstance);

                            }

                            response.put("list", taskList.toList());

                            // System.out.println(taskList);
                            activityLogService.addActivity(loggedInUser, "Task list accessed",
                                    "parameters : " + getTaskListRequest);
                            LOGGER.debug("exiting class " + TasksServiceImpl.class + " and method getTaskList");
                            return ResponseEntity.ok(response);

                        } else {
                            response.put("list", taskList.toList());
                            activityLogService.addActivity(loggedInUser, "failed to access task list",
                                    "Parameters : " + getTaskListRequest.toString());
                            LOGGER.error("exiting class " + TasksServiceImpl.class
                                    + " and method getTaskList with response : failed to get tasklist because details api call failed"
                                    + details.getBody());
                            return ResponseEntity.ok(response);
                        }
                    }
                } else {
                    activityLogService.addActivity(loggedInUser, "failed to access task list",
                            "Parameters : " + getTaskListRequest.toString());
                    LOGGER.error("exiting class " + TasksServiceImpl.class
                            + " and method getTaskList with response : failed to get tasklist"
                            + loggerEncoderUtil.encode(tasklist.getBody()));
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, tasklist.getBody()),
                            tasklist.getStatusCode());
                }
            }
            response.put("list", taskList.toList());

            activityLogService.addActivity(loggedInUser, "task list accessed ",
                    "Parameters : " + getTaskListRequest.toString());
            LOGGER.debug("exiting class " + TasksServiceImpl.class
                    + " and method getTaskList with response : failed to get tasklist because task list is empty status code : "
                    + tasklist.getStatusCode() + " body : " + tasklist.getBody());
            return ResponseEntity.ok(response);

            // System.out.println(accountWithCountMapper.findAllTaskNew("cadmin",10,true,"amount",defs));

            // return ResponseEntity.ok(tasks);

            // try {
            // clientResponse = camundaService.getTaskListPost(getTaskListRequest,
            // loggedInUser);
            // LOGGER.info("get task api response received");
            // } catch (Exception e) {
            // LOGGER.error("Error : " + e + "\nParam : " + loggedInUser);
            // activityLogService.addActivity(loggedInUser, "failed to access task list",
            // e.toString());
            // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
            // ResponseMessages.GenericErrorMessage),
            // HttpStatus.INTERNAL_SERVER_ERROR);
            // }

            // String response = clientResponse.bodyToMono(String.class).block();
            // if (clientResponse.statusCode() == HttpStatus.OK) {

            // JSONArray taskList = new JSONArray(response);
            // for (int i = 0; i < taskList.length(); i++) {
            // org.json.JSONObject taskListInstance = taskList.getJSONObject(i);
            // ClientResponse formVariableClientResponse = null;
            // try {
            // formVariableClientResponse =
            // camundaService.getFormVariable(taskListInstance.getString("id"),
            // loggedInUser);
            // LOGGER.info("form variable received");
            // } catch (Exception e) {
            // LOGGER.error("Error : " + e + "\nParam : " + getTaskListRequest.toString());
            // activityLogService.addActivity(loggedInUser, "failed to access task list",
            // e.toString());
            // return new ResponseEntity<ApiResponse>(new ApiResponse(false, "failed to get
            // form variable"),
            // HttpStatus.INTERNAL_SERVER_ERROR);
            // }

            // String riskScoreResponse = null;
            // org.json.JSONObject riskScoreList = null;
            // org.json.JSONObject riskScoreJson = null;
            // org.json.JSONObject TicketID = null;
            // org.json.JSONObject Transaction = null;
            // org.json.JSONObject workflowName = null;
            // org.json.JSONObject failedRule = null;

            // try {
            // riskScoreResponse =
            // formVariableClientResponse.bodyToMono(String.class).block();
            // riskScoreList = new org.json.JSONObject(riskScoreResponse);
            // riskScoreJson = riskScoreList.optJSONObject("RiskScore");
            // workflowName = riskScoreList.isNull("WorkflowName") ? null
            // : riskScoreList.optJSONObject("WorkflowName");
            // TicketID = riskScoreList.isNull("TicketID") ? null
            // : riskScoreList.optJSONObject("TicketID");
            // Transaction = riskScoreList.isNull("Transaction") ? null
            // : riskScoreList.optJSONObject("Transaction");
            // failedRule = riskScoreList.isNull("failedRules") ? null
            // : riskScoreList.optJSONObject("failedRules");
            // } catch (Exception e) {
            // LOGGER.error("Error : " + e + "\nParam : " + getTaskListRequest);
            // activityLogService.addActivity(loggedInUser, "failed to access task list",
            // e.toString());
            // return new ResponseEntity<ApiResponse>(
            // new ApiResponse(false, "failed to get parameters from form variables"),
            // HttpStatus.INTERNAL_SERVER_ERROR);
            // }

            // LOGGER.info("parameters received from form variable");

            // if (riskScoreJson != null) {
            // taskListInstance.put("RiskScore", riskScoreJson.opt("value"));
            // if (riskScoreJson.get("value").equals(0) ||
            // riskScoreJson.opt("value").equals(10)) {
            // taskListInstance.put("Status", "Paid");
            // } else if (riskScoreJson.get("value").equals(100)) {
            // taskListInstance.put("Status", "Blocked");
            // }
            // } else {
            // taskListInstance.put("RiskScore", org.json.JSONObject.NULL);
            // }

            // if (workflowName != null)
            // taskListInstance.put("WorkflowName", workflowName.opt("value"));
            // else
            // taskListInstance.put("WorkflowName", org.json.JSONObject.NULL);

            // if (TicketID != null)
            // taskListInstance.put("TicketID", TicketID.opt("value"));
            // else
            // taskListInstance.put("TicketID", org.json.JSONObject.NULL);

            // if (failedRule != null) {
            // taskListInstance.put("failedRules", failedRule.opt("value"));
            // }

            // if (Transaction != null) {
            // if
            // (taskListInstance.get("processDefinitionId").toString().contains("DoubleDebit"))
            // {
            // try {
            // JSONArray jsonArray = new JSONArray((String) Transaction.opt("value"));
            // org.json.JSONObject objectInArray1 = jsonArray.optJSONObject(0);
            // if (!objectInArray1.isEmpty()) {

            // Double amount =null;
            // if (amount == null) {
            // amount = Double.parseDouble(objectInArray1.optQuery("/payer/amount") == null
            // ? "000"
            // : objectInArray1.optQuery("/payer/amount").toString());
            // }
            // taskListInstance.put("TransactionAmount",
            // amount != null && amount > 0 ? amount / 100 : org.json.JSONObject.NULL);

            // taskListInstance.put("PayeeVpa",
            // objectInArray1.optQuery("/payee/addr") == null ? org.json.JSONObject.NULL
            // : objectInArray1.optQuery("/payee/addr"));
            // taskListInstance.put("PayerVpa",
            // objectInArray1.optQuery("/payer/addr") == null ? org.json.JSONObject.NULL
            // : objectInArray1.optQuery("/payer/addr"));

            // }
            // } catch (Exception e) {
            // LOGGER.error("Error : " + e + "\nParam : " + Transaction);
            // activityLogService.addActivity(loggedInUser, "failed to access task list",
            // e.toString());
            // return new ResponseEntity<ApiResponse>(
            // new ApiResponse(false, "failed to get risk score"),
            // HttpStatus.INTERNAL_SERVER_ERROR);
            // }
            // } else {
            // try {
            // String transactionString = Transaction.optString("value");
            // org.json.JSONObject rootNode = new org.json.JSONObject(transactionString);

            // if (!rootNode.isEmpty()) {
            // Double amount = null;
            // // Long.parseLong(rootNode.optQuery("/payee/amount").toString());
            // if (amount == null) {
            // amount = Double.parseDouble(rootNode.optQuery("/payer/amount") == null ?
            // "000"
            // : rootNode.optQuery("/payer/amount").toString());
            // }

            // taskListInstance.put("TransactionAmount",
            // amount != null && amount > 0 ? amount / 100 : org.json.JSONObject.NULL);

            // taskListInstance.put("PayeeVpa",
            // rootNode.optQuery("/payee/addr") == null ? org.json.JSONObject.NULL
            // : rootNode.optQuery("/payee/addr"));
            // taskListInstance.put("PayerVpa",
            // rootNode.optQuery("/payer/addr") == null ? org.json.JSONObject.NULL
            // : rootNode.optQuery("/payer/addr"));
            // }
            // } catch (Exception e) {
            // LOGGER.error("Error : " + e + "\nParam : " + Transaction);
            // activityLogService.addActivity(loggedInUser, "failed to access task list",
            // e.toString());
            // return new ResponseEntity<ApiResponse>(
            // new ApiResponse(false, "failed to get risk score"),
            // HttpStatus.INTERNAL_SERVER_ERROR);
            // }
            // }
            // }
            // taskList.put(i, taskListInstance);
            // }
            // activityLogService.addActivity(loggedInUser, "Task list accessed",
            // "parameters : " + getTaskListRequest.toString());
            // LOGGER.debug("exiting class " + TasksServiceImpl.class + " and method
            // getTaskList");
            // return ResponseEntity.ok(taskList.toString());
            // } else {
            // activityLogService.addActivity(loggedInUser, "failed to access task list",
            // "Parameters : " + getTaskListRequest.toString());
            // LOGGER.error("exiting class " + TasksServiceImpl.class + " and method
            // getTaskList with response : "
            // + response);
            // return new ResponseEntity<ApiResponse>(new ApiResponse(false, response),
            // clientResponse.statusCode());
            // }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access list of tasks");
            LOGGER.debug("Exiting getListDropDown Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to access list of tasks");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to access list of tasks"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> getTaskList(GetTaskListRequestGt getTaskListRequestGt, Authentication pr) {

        LOGGER.debug("entered in class " + TasksServiceImpl.class + " in method getTaskList");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            List<String> defs = new ArrayList<>();
            defs.add("DeclineTransaction");
            defs.add("RiskAlert");

            List<TaskResponse> tasks = new ArrayList<>();
            // System.out.println(getTaskListRequest);

            // if (getTaskListRequest.getOpen()) {
            // tasks = accountWithCountMapper.findAllTaskNew(null,
            // getTaskListRequest.getRiskScore(),
            // getTaskListRequest.getSortDir(), getTaskListRequest.getSortBy(),
            // getTaskListRequest.getDefKey(),
            // getTaskListRequest.getMaxResult(),
            // getTaskListRequest.getMinAmount(), getTaskListRequest.getMaxAmount(),
            // getTaskListRequest.getFailedRules(), getTaskListRequest.getStage(),
            // getTaskListRequest.getLevel(), getTaskListRequest.getType(),
            // getTaskListRequest.getAddress(),
            // getTaskListRequest.getStartDate(), getTaskListRequest.getEndDate(),
            // getTaskListRequest.getTicketid());

            // } else {
            // tasks = accountWithCountMapper.findAllTaskNew(loggedInUser.getVcUserName(),
            // getTaskListRequest.getRiskScore(), getTaskListRequest.getSortDir(),
            // getTaskListRequest.getSortBy(), getTaskListRequest.getDefKey(),
            // getTaskListRequest.getMaxResult(),
            // getTaskListRequest.getMinAmount(), getTaskListRequest.getMaxAmount(),
            // getTaskListRequest.getFailedRules(), getTaskListRequest.getStage(),
            // getTaskListRequest.getLevel(), getTaskListRequest.getType(),
            // getTaskListRequest.getAddress(),
            // getTaskListRequest.getStartDate(), getTaskListRequest.getEndDate(),
            // getTaskListRequest.getTicketid());
            // }

            GetTaskListRequest getTaskListRequest = new GetTaskListRequest();
            getTaskListRequest.setMy(getTaskListRequestGt.getMy());
            getTaskListRequest.setAddress(getTaskListRequestGt.getAddress());
            getTaskListRequest.setClosed(getTaskListRequestGt.getClosed());
            getTaskListRequest.setDefKey(getTaskListRequestGt.getDefKey());
            getTaskListRequest.setEndDate(getTaskListRequestGt.getEndDate());
            getTaskListRequest.setFailedRules(getTaskListRequestGt.getFailedRules());
            getTaskListRequest.setLevel(getTaskListRequestGt.getLevel());
            getTaskListRequest.setMaxAmount(getTaskListRequestGt.getMaxAmount());
            getTaskListRequest.setMaxResult(getTaskListRequestGt.getMaxResult());
            getTaskListRequest.setMinAmount(getTaskListRequestGt.getMinAmount());
            getTaskListRequest.setOpen(getTaskListRequestGt.getOpen());
            getTaskListRequest.setParameters(getTaskListRequestGt.getParameters());
            getTaskListRequest.setRiskScore(getTaskListRequestGt.getRiskScore());
            getTaskListRequest.setSortBy(getTaskListRequestGt.getSortBy());
            getTaskListRequest.setSortDir(getTaskListRequestGt.getSortDir());
            getTaskListRequest.setStage(getTaskListRequestGt.getStage());
            getTaskListRequest.setStartDate(getTaskListRequestGt.getStartDate());
            getTaskListRequest.setTicketid(getTaskListRequestGt.getTicketid());
            getTaskListRequest.setType(getTaskListRequestGt.getType());

            ResponseEntity<String> tasklist = null;
            JsonNode countjosn = null;
            // System.out.println(getTaskListRequest.getParameters());
            if (getTaskListRequest.getClosed() == false) {
                try {
                    // System.out.println(new Date());
                    ResponseEntity<String> countClientResponse = camundaService
                            .getTaskListPostCount(getTaskListRequest.getParameters(), loggedInUser);
                    // countjosn = countClientResponse.bodyToMono(JsonNode.class).block();
                    countjosn = new ObjectMapper().readTree(countClientResponse.getBody());
                    // countClientResponse.releaseBody();
                    tasklist = camundaService.getTaskListPostHttp(getTaskListRequest, loggedInUser);
                    // System.out.println(new Date());
                } catch (Exception e) {
                    LOGGER.error(
                            "Error : " + e + "\nParam : " + loggerEncoderUtil.encode(getTaskListRequest.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get task list",
                            "Error : " + e.toString() + ", Parameters : " + getTaskListRequest);
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
            } else {
                if (getTaskListRequest.getMy() == false) {
                    try {
                        // System.out.println(new Date());
                        List<String> temp = new ArrayList<>();
                        ResponseEntity<String> countClientResponse = camundaService
                                .getProcessInstHistoryPostCount(getTaskListRequest.getParameters(), loggedInUser, temp);
                        // countjosn = countClientResponse.bodyToMono(JsonNode.class).block();
                        countjosn = new ObjectMapper().readTree(countClientResponse.getBody());
                        // countClientResponse.releaseBody();
                        tasklist = camundaService.getTaskListCompletedHttp(getTaskListRequest, loggedInUser, temp);
                        // System.out.println(new Date());
                    } catch (Exception e) {
                        LOGGER.error("Error : " + e + "\nParam : "
                                + loggerEncoderUtil.encode(getTaskListRequest.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to get task list",
                                "Error : " + e.toString() + ", Parameters : " + getTaskListRequest);
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                } else {

                    try {
                        // System.out.println(new Date());
                        ResponseEntity<String> countClientResponse = camundaService
                                .getTaskListHistoryPostCount(getTaskListRequest.getParameters(), loggedInUser);
                        // countjosn = countClientResponse.bodyToMono(JsonNode.class).block();
                        countjosn = new ObjectMapper().readTree(countClientResponse.getBody());
                        // countClientResponse.releaseBody();
                        tasklist = camundaService.getTaskListCompletedHistoryHttp(getTaskListRequest, loggedInUser);
                        // System.out.println(new Date());
                    } catch (Exception e) {
                        LOGGER.error("Error : " + e + "\nParam : "
                                + loggerEncoderUtil.encode(getTaskListRequest.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to get task list",
                                "Error : " + e.toString() + ", Parameters : " + getTaskListRequest);
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                }
            }

            List<String> instaceId = new ArrayList<>();
            JSONArray taskList = new JSONArray();

            Map<String, Object> response = new HashMap<>();
            response.put("count", countjosn.get("count"));

            if (tasklist != null) {
                if (tasklist.getStatusCode() == HttpStatus.OK) {
                    taskList = new JSONArray(tasklist.getBody());

                    for (int i = 0; i < taskList.length(); i++) {
                        if (getTaskListRequest.getClosed()) {
                            if (getTaskListRequest.getMy()) {
                                instaceId.add(taskList.getJSONObject(i).optString("processInstanceId"));
                            } else {
                                instaceId.add(taskList.getJSONObject(i).optString("id"));
                                taskList.getJSONObject(i).put("processInstanceId",
                                        taskList.getJSONObject(i).optString("id"));
                                taskList.getJSONObject(i).put("created",
                                        taskList.getJSONObject(i).optString("startTime"));
                            }
                        } else {
                            instaceId.add(taskList.getJSONObject(i).optString("processInstanceId"));
                        }

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

                    String processInJson = "{\n  \"processInstanceIdIn\":" + json
                            + ",\r\n    \"variableNameIn\":[\"WorkflowName\",\"TicketID\",\"failedRules\",\"TransactionAmount\",\"fieldDropDowns\",\"RiskScore\",\"AvgRiskScore\"]\r\n    \r\n   \r\n}";

                    ResponseEntity<String> details = null;

                    if (instaceId.size() != 0) {
                        try {
                            // System.out.println(new Date());
                            details = camundaService.postHistoryVarInstance(processInJson, loggedInUser);
                            // System.out.println(new Date());
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
                                for (int n = 0; n < detailList.length(); n++) {
                                    if (taskListInstance.getString("processInstanceId")
                                            .equals(detailList.getJSONObject(n).getString("processInstanceId"))) {

                                        if (detailList.getJSONObject(n).getString("name").equals("RiskScore")) {
                                            taskListInstance.put("riskScore", detailList.getJSONObject(n).get("value"));
                                        }

                                        if (detailList.getJSONObject(n).getString("name")
                                                .equals("AvgRiskScore")) {
                                            taskListInstance.put("AvgRiskScore",
                                                    detailList.getJSONObject(n).get("value"));
                                        }

                                        if (detailList.getJSONObject(n).getString("name")
                                                .equals("Transaction")) {
                                            taskListInstance.put("Transaction",
                                                    detailList.getJSONObject(n).get("value"));
                                        }

                                        if (detailList.getJSONObject(n).getString("name")
                                                .equals("WorkflowName")) {
                                            taskListInstance.put("workflowName",
                                                    detailList.getJSONObject(n).get("value"));
                                        }

                                        if (detailList.getJSONObject(n).getString("name").equals("TicketID")) {
                                            taskListInstance.put("ticketID", detailList.getJSONObject(n).get("value"));
                                        }

                                        if (detailList.getJSONObject(n).getString("name")
                                                .equals("failedRules")) {
                                            taskListInstance.put("failedRules",
                                                    detailList.getJSONObject(n).get("value"));
                                        }

                                        if (detailList.getJSONObject(n).getString("name")
                                                .equals("fieldDropDowns")) {
                                            taskListInstance.put("fieldDropDowns",
                                                    detailList.getJSONObject(n).get("value"));
                                        }

                                        if (detailList.getJSONObject(n).getString("name")
                                                .equals("TransactionAmount")) {
                                            String amount = detailList.getJSONObject(n).get("value").toString();
                                            taskListInstance.put("transactionAmount", Double.parseDouble(amount) / 100);
                                        }

                                    }
                                }

                                taskList.put(k, taskListInstance);
                            }

                            response.put("list", taskList.toList());

                            // System.out.println(taskList);
                            activityLogService.addActivity(loggedInUser, "Task list accessed",
                                    "parameters : " + getTaskListRequest);
                            LOGGER.debug("exiting class " + TasksServiceImpl.class + " and method getTaskList");
                            return ResponseEntity.ok(response);

                        } else {
                            response.put("list", taskList.toList());
                            activityLogService.addActivity(loggedInUser, "failed to access task list",
                                    "Parameters : " + getTaskListRequest.toString());
                            LOGGER.error("exiting class " + TasksServiceImpl.class
                                    + " and method getTaskList with response : failed to get tasklist because details api call failed"
                                    + details.getBody());
                            return ResponseEntity.ok(response);
                        }
                    }
                } else {
                    activityLogService.addActivity(loggedInUser, "failed to access task list",
                            "Parameters : " + getTaskListRequest.toString());
                    LOGGER.error("exiting class " + TasksServiceImpl.class
                            + " and method getTaskList with response : failed to get tasklist"
                            + loggerEncoderUtil.encode(tasklist.getBody()));
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, tasklist.getBody()),
                            tasklist.getStatusCode());
                }
            }
            response.put("list", taskList.toList());

            activityLogService.addActivity(loggedInUser, "task list accessed ",
                    "Parameters : " + getTaskListRequest.toString());
            LOGGER.debug("exiting class " + TasksServiceImpl.class
                    + " and method getTaskList with response : failed to get tasklist because task list is empty status code : "
                    + tasklist.getStatusCode() + " body : " + tasklist.getBody());
            return ResponseEntity.ok(response);

            // System.out.println(accountWithCountMapper.findAllTaskNew("cadmin",10,true,"amount",defs));

            // return ResponseEntity.ok(tasks);

            // try {
            // clientResponse = camundaService.getTaskListPost(getTaskListRequest,
            // loggedInUser);
            // LOGGER.info("get task api response received");
            // } catch (Exception e) {
            // LOGGER.error("Error : " + e + "\nParam : " + loggedInUser);
            // activityLogService.addActivity(loggedInUser, "failed to access task list",
            // e.toString());
            // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
            // ResponseMessages.GenericErrorMessage),
            // HttpStatus.INTERNAL_SERVER_ERROR);
            // }

            // String response = clientResponse.bodyToMono(String.class).block();
            // if (clientResponse.statusCode() == HttpStatus.OK) {

            // JSONArray taskList = new JSONArray(response);
            // for (int i = 0; i < taskList.length(); i++) {
            // org.json.JSONObject taskListInstance = taskList.getJSONObject(i);
            // ClientResponse formVariableClientResponse = null;
            // try {
            // formVariableClientResponse =
            // camundaService.getFormVariable(taskListInstance.getString("id"),
            // loggedInUser);
            // LOGGER.info("form variable received");
            // } catch (Exception e) {
            // LOGGER.error("Error : " + e + "\nParam : " + getTaskListRequest.toString());
            // activityLogService.addActivity(loggedInUser, "failed to access task list",
            // e.toString());
            // return new ResponseEntity<ApiResponse>(new ApiResponse(false, "failed to get
            // form variable"),
            // HttpStatus.INTERNAL_SERVER_ERROR);
            // }

            // String riskScoreResponse = null;
            // org.json.JSONObject riskScoreList = null;
            // org.json.JSONObject riskScoreJson = null;
            // org.json.JSONObject TicketID = null;
            // org.json.JSONObject Transaction = null;
            // org.json.JSONObject workflowName = null;
            // org.json.JSONObject failedRule = null;

            // try {
            // riskScoreResponse =
            // formVariableClientResponse.bodyToMono(String.class).block();
            // riskScoreList = new org.json.JSONObject(riskScoreResponse);
            // riskScoreJson = riskScoreList.optJSONObject("RiskScore");
            // workflowName = riskScoreList.isNull("WorkflowName") ? null
            // : riskScoreList.optJSONObject("WorkflowName");
            // TicketID = riskScoreList.isNull("TicketID") ? null
            // : riskScoreList.optJSONObject("TicketID");
            // Transaction = riskScoreList.isNull("Transaction") ? null
            // : riskScoreList.optJSONObject("Transaction");
            // failedRule = riskScoreList.isNull("failedRules") ? null
            // : riskScoreList.optJSONObject("failedRules");
            // } catch (Exception e) {
            // LOGGER.error("Error : " + e + "\nParam : " + getTaskListRequest);
            // activityLogService.addActivity(loggedInUser, "failed to access task list",
            // e.toString());
            // return new ResponseEntity<ApiResponse>(
            // new ApiResponse(false, "failed to get parameters from form variables"),
            // HttpStatus.INTERNAL_SERVER_ERROR);
            // }

            // LOGGER.info("parameters received from form variable");

            // if (riskScoreJson != null) {
            // taskListInstance.put("RiskScore", riskScoreJson.opt("value"));
            // if (riskScoreJson.get("value").equals(0) ||
            // riskScoreJson.opt("value").equals(10)) {
            // taskListInstance.put("Status", "Paid");
            // } else if (riskScoreJson.get("value").equals(100)) {
            // taskListInstance.put("Status", "Blocked");
            // }
            // } else {
            // taskListInstance.put("RiskScore", org.json.JSONObject.NULL);
            // }

            // if (workflowName != null)
            // taskListInstance.put("WorkflowName", workflowName.opt("value"));
            // else
            // taskListInstance.put("WorkflowName", org.json.JSONObject.NULL);

            // if (TicketID != null)
            // taskListInstance.put("TicketID", TicketID.opt("value"));
            // else
            // taskListInstance.put("TicketID", org.json.JSONObject.NULL);

            // if (failedRule != null) {
            // taskListInstance.put("failedRules", failedRule.opt("value"));
            // }

            // if (Transaction != null) {
            // if
            // (taskListInstance.get("processDefinitionId").toString().contains("DoubleDebit"))
            // {
            // try {
            // JSONArray jsonArray = new JSONArray((String) Transaction.opt("value"));
            // org.json.JSONObject objectInArray1 = jsonArray.optJSONObject(0);
            // if (!objectInArray1.isEmpty()) {

            // Double amount =null;
            // if (amount == null) {
            // amount = Double.parseDouble(objectInArray1.optQuery("/payer/amount") == null
            // ? "000"
            // : objectInArray1.optQuery("/payer/amount").toString());
            // }
            // taskListInstance.put("TransactionAmount",
            // amount != null && amount > 0 ? amount / 100 : org.json.JSONObject.NULL);

            // taskListInstance.put("PayeeVpa",
            // objectInArray1.optQuery("/payee/addr") == null ? org.json.JSONObject.NULL
            // : objectInArray1.optQuery("/payee/addr"));
            // taskListInstance.put("PayerVpa",
            // objectInArray1.optQuery("/payer/addr") == null ? org.json.JSONObject.NULL
            // : objectInArray1.optQuery("/payer/addr"));

            // }
            // } catch (Exception e) {
            // LOGGER.error("Error : " + e + "\nParam : " + Transaction);
            // activityLogService.addActivity(loggedInUser, "failed to access task list",
            // e.toString());
            // return new ResponseEntity<ApiResponse>(
            // new ApiResponse(false, "failed to get risk score"),
            // HttpStatus.INTERNAL_SERVER_ERROR);
            // }
            // } else {
            // try {
            // String transactionString = Transaction.optString("value");
            // org.json.JSONObject rootNode = new org.json.JSONObject(transactionString);

            // if (!rootNode.isEmpty()) {
            // Double amount = null;
            // // Long.parseLong(rootNode.optQuery("/payee/amount").toString());
            // if (amount == null) {
            // amount = Double.parseDouble(rootNode.optQuery("/payer/amount") == null ?
            // "000"
            // : rootNode.optQuery("/payer/amount").toString());
            // }

            // taskListInstance.put("TransactionAmount",
            // amount != null && amount > 0 ? amount / 100 : org.json.JSONObject.NULL);

            // taskListInstance.put("PayeeVpa",
            // rootNode.optQuery("/payee/addr") == null ? org.json.JSONObject.NULL
            // : rootNode.optQuery("/payee/addr"));
            // taskListInstance.put("PayerVpa",
            // rootNode.optQuery("/payer/addr") == null ? org.json.JSONObject.NULL
            // : rootNode.optQuery("/payer/addr"));
            // }
            // } catch (Exception e) {
            // LOGGER.error("Error : " + e + "\nParam : " + Transaction);
            // activityLogService.addActivity(loggedInUser, "failed to access task list",
            // e.toString());
            // return new ResponseEntity<ApiResponse>(
            // new ApiResponse(false, "failed to get risk score"),
            // HttpStatus.INTERNAL_SERVER_ERROR);
            // }
            // }
            // }
            // taskList.put(i, taskListInstance);
            // }
            // activityLogService.addActivity(loggedInUser, "Task list accessed",
            // "parameters : " + getTaskListRequest.toString());
            // LOGGER.debug("exiting class " + TasksServiceImpl.class + " and method
            // getTaskList");
            // return ResponseEntity.ok(taskList.toString());
            // } else {
            // activityLogService.addActivity(loggedInUser, "failed to access task list",
            // "Parameters : " + getTaskListRequest.toString());
            // LOGGER.error("exiting class " + TasksServiceImpl.class + " and method
            // getTaskList with response : "
            // + response);
            // return new ResponseEntity<ApiResponse>(new ApiResponse(false, response),
            // clientResponse.statusCode());
            // }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access list of tasks");
            LOGGER.debug("Exiting getListDropDown Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to access list of tasks");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to access list of tasks"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> claimTask(String taskid, String processInstanceId, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method claimTask");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            ResponseEntity<String> clientResponse = null;
            try {
                clientResponse = camundaService.claimTask(taskid, processInstanceId, loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(taskid));
                activityLogService.addActivity(loggedInUser, "failed to claim task",
                        "Error : " + e.toString() + ", Parameters : " + taskid);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            // String response = clientResponse.bodyToMono(String.class).block();
            String response = clientResponse.getBody();
            // clientResponse.releaseBody();

            if (clientResponse.getStatusCode() == HttpStatus.NO_CONTENT) {
                activityLogService.addActivity(loggedInUser, "Task claimed", "parameters : " + taskid);
                LOGGER.debug("Exiting claimTask Method in " + TasksServiceImpl.class + " class with success response ");
                return ResponseEntity.ok(response);
            } else if (clientResponse.getStatusCode() == HttpStatus.INTERNAL_SERVER_ERROR) {
                org.json.JSONObject responseobj = new org.json.JSONObject(response);
                String msg = responseobj.optString("message");
                HttpStatusCode status = HttpStatusCode.valueOf(400);
                if (msg.contains("Task '" + taskid + "' is already claimed by someone else.")) {
                    msg = "Task already claimed by someone else";
                    LOGGER.info("Exiting claimTask Method in " + TasksServiceImpl.class
                            + " class with response  : " + response);
                } else if (msg.contains("Cannot find task with id " + taskid + ": task is null")) {
                    msg = "Task already closed";
                    LOGGER.info("Exiting claimTask Method in " + TasksServiceImpl.class
                            + " class with response  : " + response);
                } else if (msg.contains("Cannot put process instance variable userActivity: execution "
                        + processInstanceId + " doesn't exist: execution is null")) {
                    msg = "Ticket already closed";
                    LOGGER.info("Exiting claimTask Method in " + TasksServiceImpl.class
                            + " class with response  : " + response);
                } else {
                    msg = response;
                    status = clientResponse.getStatusCode();
                    LOGGER.error("Exiting claimTask Method in " + TasksServiceImpl.class
                            + " class with response  : " + response);
                }

                activityLogService.addActivity(loggedInUser, "failed to claim task",
                        "Parameters : " + taskid);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, msg),
                        status);
            } else {
                activityLogService.addActivity(loggedInUser, "failed to claim task", "Parameters : " + taskid);
                LOGGER.error("Exiting claimTask Method in " + TasksServiceImpl.class + " class with response  : "
                        + response);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, response),
                        clientResponse.getStatusCode());
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to claim task");
            LOGGER.debug("Exiting claimTask Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to claim task");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to claim task"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> claimBulkTask(List<ClaimBulkRequest> taskidlist, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method claimBulkTask");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();

        activityLogService.addActivity(loggedInUser, "Requested to claim bulk tasks");
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            for (int i = 0, size = taskidlist.size(); i < size; i++) {
                ResponseEntity<String> clientResponse = null;
                try {
                    clientResponse = camundaService.claimTask(taskidlist.get(i).getTaskid(),
                            taskidlist.get(i).getProcessid(), loggedInUser);
                } catch (Exception e) {
                    LOGGER.error(
                            "Error : " + e + "\nParam : " + loggerEncoderUtil.encode(taskidlist.get(i).toString()));
                    activityLogService.addActivity(loggedInUser, "failed to claim task",
                            "Error : " + e.toString() + ", Parameters : " + taskidlist.get(i));
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                // String response = clientResponse.bodyToMono(String.class).block();
                String response = clientResponse.getBody();
                // clientResponse.releaseBody();
                if (clientResponse.getStatusCode() == HttpStatus.INTERNAL_SERVER_ERROR) {
                    org.json.JSONObject responseobj = new org.json.JSONObject(response);
                    String msg = responseobj.optString("message");
                    if (msg.contains("is already claimed by someone else")) {
                        activityLogService.addActivity(loggedInUser, "failed to claim task",
                                "Parameters : " + taskidlist.get(i));
                        LOGGER.info("Exiting claimBulkTask Method in " + TasksServiceImpl.class
                                + " class with response  : " + response);
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, "Task already claimed by someone else"),
                                HttpStatusCode.valueOf(400));
                    } else {
                        activityLogService.addActivity(loggedInUser, "failed to claim task",
                                "Parameters : " + taskidlist.get(i));
                        LOGGER.error("Exiting claimBulkTask Method in " + TasksServiceImpl.class
                                + " class with response  : " + response);
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, response),
                                clientResponse.getStatusCode());
                    }
                } else if (clientResponse.getStatusCode() != HttpStatus.NO_CONTENT) {
                    activityLogService.addActivity(loggedInUser, "failed to claim bulk task",
                            "Parameters : " + taskidlist.get(i));
                    LOGGER.error(
                            "Exiting claimBulkTask Method in " + TasksServiceImpl.class + " class with response  : "
                                    + response);
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, response),
                            clientResponse.getStatusCode());
                }
            }
            activityLogService.addActivity(loggedInUser, "Bulk Task claimed", "parameters : " + taskidlist);
            LOGGER.debug("Exiting claimBulkTask Method in " + TasksServiceImpl.class + " class with success response ");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Bulk task claimed successfully"),
                    HttpStatus.OK);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to claim task");
            LOGGER.debug("Exiting claimBulkTask Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to claim task");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to claim task"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> unClaimTask(String taskid, String processInstanceId, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method unClaimTask");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            ResponseEntity<String> clientResponse = null;
            try {
                clientResponse = camundaService.unClaimTask(taskid, processInstanceId, loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(taskid));
                activityLogService.addActivity(loggedInUser, "failed to claim task",
                        "Error : " + e.toString() + ", Parameters : " + taskid);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            // String response = clientResponse.bodyToMono(String.class).block();
            String response = clientResponse.getBody();
            // clientResponse.releaseBody();
            if (clientResponse.getStatusCode() == HttpStatus.NO_CONTENT) {
                activityLogService.addActivity(loggedInUser, "Task unclaimed", "parameters : " + taskid);
                LOGGER.debug(
                        "Exiting ucClaimTask Method in " + TasksServiceImpl.class + " class with success response ");
                return ResponseEntity.ok(response);
            } else {

                org.json.JSONObject responseobj = new org.json.JSONObject(response);
                String msg = responseobj.optString("message");
                HttpStatusCode status = HttpStatusCode.valueOf(400);
                if (msg.contains("Task '" + taskid + "' is already claimed by someone else.")) {
                    msg = "Task already claimed by someone else";
                    LOGGER.info("Exiting unClaimTask Method in " + TasksServiceImpl.class
                            + " class with response  : " + response);
                } else if (msg.contains("Cannot find task with id " + taskid + ": task is null")) {
                    msg = "Task already closed";
                    LOGGER.info("Exiting unClaimTask Method in " + TasksServiceImpl.class
                            + " class with response  : " + response);
                } else if (msg.contains("Cannot put process instance variable userActivity: execution "
                        + processInstanceId + " doesn't exist: execution is null")) {
                    msg = "Ticket already closed";
                    LOGGER.info("Exiting unClaimTask Method in " + TasksServiceImpl.class
                            + " class with response  : " + response);
                } else {
                    msg = response;
                    status = clientResponse.getStatusCode();
                    LOGGER.error("Exiting unClaimTask Method in " + TasksServiceImpl.class
                            + " class with response  : " + response);
                }

                activityLogService.addActivity(loggedInUser, "failed to unclaim task", "Parameters : " + taskid);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, msg), status);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to claim task");
            LOGGER.debug("Exiting unclaimTask Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to unclaim task");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to unclaim task"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> getComments(String processinstanceid, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getComments");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            ResponseEntity<String> clientResponse = null;
            try {
                clientResponse = camundaService.getActivityInstance(
                        "sortBy=startTime&sortOrder=desc&processInstanceId=" + processinstanceid
                                + "&activityType=userTask",
                        loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(processinstanceid));
                activityLogService.addActivity(loggedInUser, "failed to get list of comment",
                        "Error : " + e.toString() + ", Parameters : " + processinstanceid);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            String response = clientResponse.getBody();

            if (clientResponse.getStatusCode() == HttpStatus.OK) {

                JSONArray jsonArray = new JSONArray(response);
                JSONArray jsonArrayResponse = new JSONArray("[]");
                for (int i = 0, size = jsonArray.length(); i < size; i++) {
                    org.json.JSONObject objectInArray = jsonArray.getJSONObject(i);
                    ResponseEntity<String> commentList = null;
                    try {
                        commentList = camundaService.getComments((String) objectInArray.get("taskId"), loggedInUser);

                    } catch (Exception e) {
                        LOGGER.error(loggerEncoderUtil
                                .encode("Error : " + e + "\nParam : " + (String) objectInArray.get("taskId")));
                        activityLogService.addActivity(loggedInUser, "failed to get comment",
                                "Error : " + e.toString() + ", Parameters : " + (String) objectInArray.get("taskId"));
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    // String commentListString = commentList.bodyToMono(String.class).block();
                    String commentListString = commentList.getBody();
                    // commentList.releaseBody();
                    if (commentList.getStatusCode() == HttpStatus.OK) {
                        JSONArray commentListJson = new JSONArray(commentListString);
                        jsonArrayResponse.putAll(commentListJson);
                    } else {
                        activityLogService.addActivity(loggedInUser, "failed to claim task",
                                "Parameters : " + (String) objectInArray.get("taskId"));
                        LOGGER.error("Exiting getComments Method in " + TasksServiceImpl.class
                                + " class with response  : " + loggerEncoderUtil.encode(commentListString));
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, commentListString),
                                commentList.getStatusCode());
                    }
                }
                activityLogService.addActivity(loggedInUser, "comments list accessed",
                        "parameters : " + processinstanceid);
                LOGGER.debug("Exiting getComments Method in " + TasksServiceImpl.class
                        + " class with response  : comments list ");
                return ResponseEntity.ok(jsonArrayResponse.toString());
            } else {
                activityLogService.addActivity(loggedInUser, "failed to get list of comment",
                        "Parameters : " + processinstanceid);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, response),
                        clientResponse.getStatusCode());
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get comments");
            LOGGER.debug("Exiting getComments Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get comments");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get comments"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> getCaseHistory(String processinstanceid, String processDefId, Integer itenantid, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getCaseHistory");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            activityLogService.addActivity(loggedInUser, "authorized to get Case History"," Parameters : " + processinstanceid);

            ResponseEntity<String> clientResponse = null;

            try {
                clientResponse = camundaService.getActivityInstance(
                        "sortBy=startTime&sortOrder=desc&processInstanceId=" + processinstanceid, loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(processinstanceid));
                activityLogService.addActivity(loggedInUser, "failed to get case history",
                        "Error : " + e.toString() + ", Parameters : " + processinstanceid);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (clientResponse.getStatusCode() == HttpStatus.OK) {
                String response = clientResponse.getBody();

                JSONArray activityInstanceList = new JSONArray(response);

                if (activityInstanceList.isEmpty()) {
                    return getCaseHistoryTrino(processinstanceid, processDefId, itenantid, loggedUser, pr);
                } else {
                    return getCaseHistoryPostgre(processinstanceid, processDefId, itenantid, response, loggedInUser, pr);
                }
            } else {
                LOGGER.error("Error in  getActivityInstance \nParam : " + loggerEncoderUtil.encode(processinstanceid));
                activityLogService.addActivity(loggedInUser, "failed to get case history",
                        "Error in getActivityInstance, Parameters : " + processinstanceid);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        clientResponse.getStatusCode());
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get Case History");
            LOGGER.debug("Exiting getCaseHistory Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get Case History");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get Case History"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> getCaseHistoryPostgre(String processinstanceid, String processDefId, Integer itenantid, String response, WebUser loggedInUser,Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getCaseHistoryPostgre");

        Map<String, String> taskUserMap = new TreeMap<String, String>();
        Map<String, String> taskNameMap = new TreeMap<String, String>();
        Map<String, String> claimUserMap = new TreeMap<String, String>();
        Map<String, String> labelMap = new TreeMap<String, String>();
        Map<Date, Map> duplicateInstance = new TreeMap<>(Collections.reverseOrder());
        Map<Date, Map> duplicateActInstance = new TreeMap<>(Collections.reverseOrder());

        Map<Date, Map> sortedMap = new TreeMap<>(Collections.reverseOrder());

        DateFormat df1 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");

        JSONArray activityInstanceList = new JSONArray(response);
        for (int i = 0, size = activityInstanceList.length(); i < size; i++) {
            org.json.JSONObject activityInstance = activityInstanceList.getJSONObject(i);
            if (activityInstance.getString("activityType").equalsIgnoreCase("usertask")) {
                String username = webUserService.findByIUserID(activityInstance.get("assignee").toString());
                System.out.println("username is " + username);
                taskUserMap.put(activityInstance.getString("taskId"), username);
                taskNameMap.put(activityInstance.getString("taskId"),
                        activityInstance.getString("activityName"));
            }
        }

        // ClientResponse defId = null;
        // String processDefId = "";
        // ObjectMapper mapper = new ObjectMapper();

        // try {
        // defId = camundaService.getDefinition(processinstanceid, loggedInUser);
        // } catch (Exception e) {
        // LOGGER.error("Error : " + e + "\nParam : " + processinstanceid);
        // activityLogService.addActivity(loggedInUser, "failed to get case history",
        // "Error : " + e.toString() + ", Parameters : " + processinstanceid);
        // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
        // ResponseMessages.GenericErrorMessage),
        // HttpStatus.INTERNAL_SERVER_ERROR);
        // }

        // String defIdResponse = defId.bodyToMono(String.class).block();

        // try {
        // JsonNode rootNode1 = mapper.readTree(defIdResponse);
        // processDefId = rootNode1.get("definitionId").asText();
        // } catch (Exception e) {
        // LOGGER.error("Error : " + e + "\nParam : " + defIdResponse);
        // activityLogService.addActivity(loggedInUser, "failed to get case history",
        // "Error : " + e.toString() + ", Parameters : " + defIdResponse);
        // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
        // ResponseMessages.GenericErrorMessage),
        // HttpStatus.INTERNAL_SERVER_ERROR);
        // }

        ResponseEntity<String> bpmnXml = null;

        try {
            bpmnXml = camundaService.getBPMN(processDefId, loggedInUser);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(processinstanceid));
            activityLogService.addActivity(loggedInUser, "failed to get list of history details",
                    "Error : " + e.toString() + ", Parameters : " + processinstanceid);
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        String bpmnResponse = bpmnXml.getBody();

        ObjectMapper mapper1 = new ObjectMapper();

        try {
            JsonNode rootNode = mapper1.readTree(bpmnResponse);

            org.w3c.dom.Document doc = xmlParser.XMLParser(rootNode.get("bpmn20Xml").asText());

            NodeList formFieldlist = doc.getElementsByTagName("camunda:formField");

            if (formFieldlist.getLength() > maxFieldLength) {
                LOGGER.info("\nParam : " + loggerEncoderUtil.encode(processDefId));
                activityLogService.addActivity(loggedInUser,
                        "failed to get xml parametes length more then  " + maxFieldLength,
                        processDefId);
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "No of fields should not exceed " + maxFieldLength),
                        HttpStatus.BAD_REQUEST);
            }
            for (int i = 0; i < formFieldlist.getLength(); i++) {
                Node formField = formFieldlist.item(i);
                if (!formField.getAttributes().getNamedItem("id").getNodeValue().equals("conditions") &&
                        !formField.getAttributes().getNamedItem("id").getNodeValue().equals("custom_err_msg") &&
                        !formField.getAttributes().getNamedItem("id").getNodeValue().equals("links") &&
                        !formField.getAttributes().getNamedItem("id").getNodeValue().equals("apis")
                        && !formField.getAttributes().getNamedItem("id").getNodeValue().equals("setAuto")
                        && !formField.getAttributes().getNamedItem("id").getNodeValue().equals("disableIf")
                        && !formField.getAttributes().getNamedItem("id").getNodeValue().equals("validations")
                        && !labelMap.containsKey(formField.getAttributes().getNamedItem("id")
                        .getNodeValue())) {
                    labelMap.put(
                            formField.getAttributes().getNamedItem("id")
                                    .getNodeValue(),
                            formField.getAttributes().getNamedItem("label") != null
                                    ? formField.getAttributes().getNamedItem("label")
                                    .getNodeValue()
                                    : "");
                    NodeList valuelist = formField.getChildNodes();
                    if (valuelist != null) {
                        for (int j = 0; j < valuelist.getLength(); j++) {
                            Node value = valuelist.item(j);
                            if (value.getNodeName().equals("camunda:value")) {
                                labelMap.put(
                                        value.getAttributes().getNamedItem("id").getNodeValue(),
                                        value.getAttributes().getNamedItem("name").getNodeValue());
                            }
                        }
                    }

                    }
                }

                // for (int i = 0; i <
                // doc.getElementsByTagName("camunda:formField").getLength(); i++) {
                //
                // labelMap.put(
                // doc.getElementsByTagName("camunda:formField").item(i).getAttributes().getNamedItem("id")
                // .getNodeValue(),
                // doc.getElementsByTagName("camunda:formField").item(i).getAttributes().getNamedItem("label")
                // != null ?
                // doc.getElementsByTagName("camunda:formField").item(i).getAttributes().getNamedItem("label")
                // .getNodeValue() : "");
                //
                // }
                //
                // for (int i = 0; i < doc.getElementsByTagName("camunda:value").getLength();
                // i++) {
                // labelMap.put(
                // doc.getElementsByTagName("camunda:value").item(i).getAttributes().getNamedItem("id")
                // .getNodeValue(),
                // doc.getElementsByTagName("camunda:value").item(i).getAttributes().getNamedItem("name")
                // .getNodeValue());
                // }
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + bpmnResponse);
                activityLogService.addActivity(loggedInUser, "failed to get list of history details",
                        "Error : " + e.toString() + ", Parameters : " + bpmnResponse);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            // ClientResponse claimUnclaim = null;

            // try {
            // claimUnclaim = camundaService.getClaimUnclaim(
            // "sortBy=timestamp&sortOrder=desc&processInstanceId=" + processinstanceid,
            // loggedInUser);
            // } catch (Exception e) {
            // LOGGER.error("Error : " + e + "\nParam : " + processinstanceid);
            // activityLogService.addActivity(loggedInUser, "failed to get case history",
            // "Error : " + e.toString() + ", Parameters : " + processinstanceid);
            // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
            // ResponseMessages.GenericErrorMessage),
            // HttpStatus.INTERNAL_SERVER_ERROR);
            // }

            // String claimResponse = claimUnclaim.bodyToMono(String.class).block();

            // JSONArray claimList = new JSONArray(claimResponse);

            // for (int i = 0; i < claimList.length(); i++) {
            // org.json.JSONObject claimInstance = claimList.getJSONObject(i);
            // if (claimInstance.get("operationType").equals("Claim")) {
            // claimInstance.put("caseHistoryType", "claimStatus");
            // claimUserMap.put((String) claimInstance.get("taskId"), (String)
            // claimInstance.get("userId"));
            // try {
            // if (sortedMap.containsKey(df1.parse((String)
            // claimInstance.get("timestamp")))) {

            // duplicateInstance.put(df1.parse((String) claimInstance.get("timestamp")),
            // claimInstance.toMap());
            // } else {
            // sortedMap.put(df1.parse((String) claimInstance.get("timestamp")),
            // claimInstance.toMap());
            // }
            // } catch (ParseException e) {
            // LOGGER.error("Error : " + e + "\nParam : " + claimInstance);
            // activityLogService.addActivity(loggedInUser, "failed to get case history",
            // "Error : " + e.toString() + ", Parameters : " + claimInstance);
            // return new ResponseEntity<ApiResponse>(
            // new ApiResponse(false, ResponseMessages.GenericErrorMessage),
            // HttpStatus.INTERNAL_SERVER_ERROR);
            // }
            // }
            // }

            ResponseEntity<String> historyDetail = null;

            try {
                historyDetail = camundaService.getHistoryDetail(
                        "sortBy=time&sortOrder=desc&processInstanceId=" + processinstanceid, loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(processinstanceid));
                activityLogService.addActivity(loggedInUser, "failed to get case history",
                        "Error : " + e.toString() + ", Parameters : " + processinstanceid);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            JSONArray historyDetailList = new JSONArray(historyDetail.getBody());

            ArrayList<Map> parent = new ArrayList<>();

            for (int h = 0; h < historyDetailList.length(); h++) {
                org.json.JSONObject histroyDetailInstance = historyDetailList.getJSONObject(h);

                if (histroyDetailInstance.get("type").equals("variableUpdate")) {
                    if (histroyDetailInstance.get("variableName").equals("userActivity")) {
                        histroyDetailInstance.put("caseHistoryType", "claimStatus");

                        ObjectMapper mapperuser = new ObjectMapper();
                        JsonNode nodeuser = null;
                        try {
                            nodeuser = mapperuser.readTree(histroyDetailInstance.get("value").toString());
                            if (nodeuser.get("user") != null) {
                                ((ObjectNode) nodeuser).put("user",
                                        webUserService.findByIUserID(nodeuser.get("user").asText()));
                            }
                            histroyDetailInstance.put("value", mapperuser.writeValueAsString(nodeuser));
                        } catch (Exception e1) {
                            // TODO Auto-generated catch block
                            LOGGER.error("Error is " + e1);
                        }

                        if (nodeuser.get("user") != null) {

                            if (nodeuser.get("id") != null) {

                                histroyDetailInstance.put("taskName", taskNameMap.get(nodeuser.get("id").asText()));
                            }
                            // System.out.println(nodeuser);
                            if (nodeuser.get("action").asText().equals("Claim")) {
                                if (!claimUserMap.containsKey(nodeuser.get("id").asText())) {

                                    claimUserMap.put(nodeuser.get("id").asText(), nodeuser.get("user").asText());
                                }
                            }
                            try {
                                if (!nodeuser.get("action").asText().equals("Submit")) {
                                    if (sortedMap.containsKey(df1.parse((String) histroyDetailInstance.get("time")))) {
                                        duplicateInstance.put(df1.parse((String) histroyDetailInstance.get("time")),
                                                histroyDetailInstance.toMap());

                                        // String inDate = ((String) histroyDetailInstance.get("time")).replace(
                                        // ((String) histroyDetailInstance.get("time")).split(Pattern.quote("."))[1],
                                        // "000+0000");
                                        // sortedMap.put(df1.parse(inDate), histroyDetailInstance.toMap());
                                    } else {

                                        sortedMap.put(df1.parse((String) histroyDetailInstance.get("time")),
                                                histroyDetailInstance.toMap());
                                    }
                                }

                            } catch (ParseException e) {

                                LOGGER.error(
                                        "Error : " + e + "\nParam : " + loggerEncoderUtil.encode(processinstanceid));
                                activityLogService.addActivity(loggedInUser, "failed to get case history",
                                        "Error : " + e.toString() + ", Parameters : " + processinstanceid);
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);

                            }
                        }

                    }

                    if (histroyDetailInstance.get("variableName").equals("checker_action_whitelist_obj")) {

                        histroyDetailInstance.put("caseHistoryType", "remarks");
                        histroyDetailInstance.put("fieldIdLabel",
                                labelMap.get("checker_action_whitelist"));

                        ObjectMapper mapperuser = new ObjectMapper();
                        JsonNode nodeuser = null;
                        try {
                            nodeuser = mapperuser.readTree(histroyDetailInstance.get("value").toString());
                        } catch (Exception e1) {
                            // TODO Auto-generated catch block
                            LOGGER.error("Error " + e1);
                        }

                        try {
                            if (nodeuser.get("user") != null && nodeuser.get("value") != null) {
                                histroyDetailInstance.put("fieldValueLabel", nodeuser.get("value"));
                                histroyDetailInstance.put("userId", nodeuser.get("user"));
                            }
                        } catch (Exception e) {
                            LOGGER.error(e.toString());
                        }
                        // histroyDetailInstance.put("userId",
                        // claimUserMap.get((String) histroyDetailInstance.get("taskId")));
                        try {
                            if (sortedMap.containsKey(df1.parse((String) histroyDetailInstance.get("time")))) {
                                duplicateInstance.put(df1.parse((String) histroyDetailInstance.get("time")),
                                        histroyDetailInstance.toMap());
                                // String inDate = ((String) histroyDetailInstance.get("time")).replace(
                                // ((String) histroyDetailInstance.get("time")).split(Pattern.quote("."))[1],
                                // "000+0000");
                                // sortedMap.put(df1.parse(inDate), histroyDetailInstance.toMap());
                            } else {

                                sortedMap.put(df1.parse((String) histroyDetailInstance.get("time")),
                                        histroyDetailInstance.toMap());
                            }
                        } catch (ParseException e) {

                            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(processinstanceid));
                            activityLogService.addActivity(loggedInUser, "failed to get case history",
                                    "Error : " + e.toString() + ", Parameters : " + processinstanceid);
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);

                        }

                    }

                    if (histroyDetailInstance.get("variableName").equals("systemComment")) {

                        histroyDetailInstance.put("caseHistoryType", "remarks");
                        histroyDetailInstance.put("fieldIdLabel", "FRM Remark");

                        histroyDetailInstance.put("fieldValueLabel", histroyDetailInstance.get("value").toString());
                        histroyDetailInstance.put("userId", "FRM");

                        try {
                            if (sortedMap.containsKey(df1.parse((String) histroyDetailInstance.get("time")))) {
                                duplicateInstance.put(df1.parse((String) histroyDetailInstance.get("time")),
                                        histroyDetailInstance.toMap());
                                // String inDate = ((String) histroyDetailInstance.get("time")).replace(
                                // ((String) histroyDetailInstance.get("time")).split(Pattern.quote("."))[1],
                                // "000+0000");
                                // sortedMap.put(df1.parse(inDate), histroyDetailInstance.toMap());
                            } else {

                                sortedMap.put(df1.parse((String) histroyDetailInstance.get("time")),
                                        histroyDetailInstance.toMap());
                            }
                        } catch (ParseException e) {

                            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(processinstanceid));
                            activityLogService.addActivity(loggedInUser, "failed to get case history",
                                    "Error : " + e.toString() + ", Parameters : " + processinstanceid);
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);

                        }

                    }

                    if (histroyDetailInstance.get("variableName").equals("strHistoryUpdate")) {

                        histroyDetailInstance.put("caseHistoryType", "remarks");
                        histroyDetailInstance.put("fieldIdLabel",
                                "STR Form History");

                        ObjectMapper mapperuser = new ObjectMapper();
                        System.out.println("Value " + histroyDetailInstance.get("value").toString());
                        JsonNode nodeuser = null;
                        try {
                            nodeuser = mapperuser.readTree(histroyDetailInstance.get("value").toString());
                        } catch (Exception e1) {
                            // TODO Auto-generated catch block
                            LOGGER.error("Error " + e1);
                        }

                        try {
                            if (nodeuser.get("user") != null && nodeuser.get("value") != null) {
                                histroyDetailInstance.put("fieldValueLabel", nodeuser.get("value"));
                                histroyDetailInstance.put("userId",
                                        webUserService.findByIUserID(nodeuser.get("user").asText()));
                            }
                        } catch (Exception e) {
                            LOGGER.error(e.toString());
                        }
                        // histroyDetailInstance.put("userId",
                        // claimUserMap.get((String) histroyDetailInstance.get("taskId")));
                        try {
                            if (sortedMap.containsKey(df1.parse((String) histroyDetailInstance.get("time")))) {
                                duplicateInstance.put(df1.parse((String) histroyDetailInstance.get("time")),
                                        histroyDetailInstance.toMap());
                                // String inDate = ((String) histroyDetailInstance.get("time")).replace(
                                // ((String) histroyDetailInstance.get("time")).split(Pattern.quote("."))[1],
                                // "000+0000");
                                // sortedMap.put(df1.parse(inDate), histroyDetailInstance.toMap());
                            } else {

                                sortedMap.put(df1.parse((String) histroyDetailInstance.get("time")),
                                        histroyDetailInstance.toMap());
                            }
                        } catch (ParseException e) {

                            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(processinstanceid));
                            activityLogService.addActivity(loggedInUser, "failed to get case history",
                                    "Error : " + e.toString() + ", Parameters : " + processinstanceid);
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);

                        }

                    }
                    if (histroyDetailInstance.get("variableName").equals("AlertIDs")) {
                        histroyDetailInstance.put("caseHistoryType", "alerts");
                        histroyDetailInstance.put("title", "Following Alerts Generated");
                        String alerts = histroyDetailInstance.get("value").toString();
                        System.out.println("Value " + alerts);
                        histroyDetailInstance.put("alertIDs", Arrays.asList(alerts.split(",")));
                        try {
                            if (sortedMap.containsKey(df1.parse((String) histroyDetailInstance.get("time")))) {
                                duplicateInstance.put(df1.parse((String) histroyDetailInstance.get("time")),
                                        histroyDetailInstance.toMap());
                                // String inDate = ((String) histroyDetailInstance.get("time")).replace(
                                // ((String) histroyDetailInstance.get("time")).split(Pattern.quote("."))[1],
                                // "000+0000");
                                // sortedMap.put(df1.parse(inDate), histroyDetailInstance.toMap());
                            } else {

                                sortedMap.put(df1.parse((String) histroyDetailInstance.get("time")),
                                        histroyDetailInstance.toMap());
                            }
                        } catch (ParseException e) {

                            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(processinstanceid));
                            activityLogService.addActivity(loggedInUser, "failed to get case history",
                                    "Error : " + e.toString() + ", Parameters : " + processinstanceid);
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);

                        }

                    }
                    if (histroyDetailInstance.get("variableName").equals("parentProcess")) {
                        ObjectMapper mapperParent = new ObjectMapper();
                        JsonNode nodeParent = null;
                        try {
                            nodeParent = mapperParent.readTree(histroyDetailInstance.get("value").toString());
                        } catch (Exception e1) {
                            // TODO Auto-generated catch block
                            LOGGER.error("Error " + e1);
                        }

                        ResponseEntity<?> parentRes = getCaseHistory(nodeParent.get("Id").asText(),
                            nodeParent.get("defId").asText(), itenantid, pr);
                        try {
                            parent = (ArrayList<Map>) parentRes.getBody();
                        } catch (Exception e) {
                            // TODO: handle exception
                            LOGGER.error("Error " + e);
                        }

                    }

                }
            }

            // System.out.println(claimUserMap);

            for (int i = 0; i < historyDetailList.length(); i++) {

                org.json.JSONObject histroyDetailInstance = historyDetailList.getJSONObject(i);

                if (histroyDetailInstance.get("type").equals("formField")) {
                    if (histroyDetailInstance.get("fieldId").equals("Remarks")
                            || histroyDetailInstance.get("fieldId").equals("DocumentReviewRemarks")
                            || histroyDetailInstance.get("fieldId").equals("Action1")
                            || histroyDetailInstance.get("fieldId").equals("Action2")
                            || histroyDetailInstance.get("fieldId").equals("Action")
                            || histroyDetailInstance.get("fieldId").toString().startsWith("Action")
                            || histroyDetailInstance.get("fieldId").equals("Block")) {

//                    System.out.println("histroyDetailInstance : " + histroyDetailInstance);
                        histroyDetailInstance.put("caseHistoryType", "remarks");
                        histroyDetailInstance.put("fieldIdLabel",
                                labelMap.get((String) histroyDetailInstance.get("fieldId")));

                        histroyDetailInstance.put("fieldValueLabel",
                                labelMap.get((String) histroyDetailInstance.get("fieldValue")));

                        histroyDetailInstance.put("userId",
                                claimUserMap.get((String) histroyDetailInstance.get("taskId")));
                        try {
                            if (sortedMap.containsKey(df1.parse((String) histroyDetailInstance.get("time")))) {
                                duplicateInstance.put(df1.parse((String) histroyDetailInstance.get("time")),
                                        histroyDetailInstance.toMap());
                                // String inDate = ((String) histroyDetailInstance.get("time")).replace(
                                // ((String) histroyDetailInstance.get("time")).split(Pattern.quote("."))[1],
                                // "000+0000");
                                // sortedMap.put(df1.parse(inDate), histroyDetailInstance.toMap());
                            } else {

                                sortedMap.put(df1.parse((String) histroyDetailInstance.get("time")),
                                        histroyDetailInstance.toMap());
                            }
                        } catch (ParseException e) {

                            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(processinstanceid));
                            activityLogService.addActivity(loggedInUser, "failed to get case history",
                                    "Error : " + e.toString() + ", Parameters : " + processinstanceid);
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);

                        }
                    }

                }

            }

            for (int i = 0; i < historyDetailList.length(); i++) {
                org.json.JSONObject histroyDetailInstance = historyDetailList.getJSONObject(i);
                if (histroyDetailInstance.get("type").equals("variableUpdate")) {

                    if (!histroyDetailInstance.get("activityInstanceId").toString().contains("Activity")) {
                        if (histroyDetailInstance.get("variableName").equals("Document")
                                || histroyDetailInstance.get("variableName").equals("separate")) {
                            histroyDetailInstance.put("caseHistoryType", "merchantResponse");
                            try {

                                if (sortedMap.containsKey(df1.parse((String) histroyDetailInstance.get("time")))) {
                                    duplicateInstance.put(df1.parse((String) histroyDetailInstance.get("time")),
                                            histroyDetailInstance.toMap());
                                } else {
                                    sortedMap.put(df1.parse((String) histroyDetailInstance.get("time")),
                                            histroyDetailInstance.toMap());
                                }

                            } catch (ParseException e) {

                                LOGGER.error("Error : " + e + "\nParam : "
                                        + loggerEncoderUtil.encode((String) histroyDetailInstance.get("taskId")));
                                activityLogService.addActivity(loggedInUser, "failed to get case history",
                                        "Error : " + e.toString() + ", Parameters : "
                                                + (String) histroyDetailInstance.get("taskId"));
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }

                        }
                    }

                }
            }

            if (activityInstanceList.length() != 0) {

                // System.out.println(activityInstanceList);
                for (int i = 0, size = activityInstanceList.length(); i < size; i++) {
                    org.json.JSONObject activityInstance = activityInstanceList.getJSONObject(i);
                    if (activityInstance.getString("activityType").equalsIgnoreCase("usertask")) {
                        activityInstance.put("assignee",
                                webUserService.findByIUserID(activityInstance.optString("assignee")));
                        if (activityInstance.has("endTime") && !activityInstance.isNull("endTime")
                                && !activityInstance.getBoolean("canceled")) {
                            activityInstance.put("activityName", activityInstance.get("activityName") + " :- Submit");
                            // System.out.println(activityInstance.get("activityName") + " :- Submit");
                            try {
                                activityInstance.put("caseHistoryType", "activityInstance");
                                // System.out.println( sortedMap.containsKey(df1.parse((String)
                                // activityInstance.get("endTime"))));
                                if (sortedMap.containsKey(df1.parse((String) activityInstance.get("endTime")))) {
                                    // System.out.println( sortedMap.containsKey(df1.parse((String)
                                    // activityInstance.get("endTime"))));
                                    // System.out.println( duplicateInstance.containsKey(df1.parse((String)
                                    // activityInstance.get("endTime"))));
                                    if (duplicateInstance
                                            .containsKey(df1.parse((String) activityInstance.get("endTime")))) {
                                        duplicateActInstance.put(df1.parse((String) activityInstance.get("endTime")),
                                                activityInstance.toMap());
                                    } else {
                                        duplicateInstance.put(df1.parse((String) activityInstance.get("endTime")),
                                                activityInstance.toMap());
                                    }

                                } else {
                                    sortedMap.put(df1.parse((String) activityInstance.get("endTime")),
                                            activityInstance.toMap());
                                }

                            } catch (ParseException e) {
                                LOGGER.error("Error : " + e + "\nParam : "
                                        + loggerEncoderUtil.encode((String) activityInstance.get("taskId")));
                                activityLogService.addActivity(loggedInUser, "failed to get case history",
                                        "Error : " + e.toString() + ", Parameters : "
                                                + (String) activityInstance.get("taskId"));
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }
                        }

                        if (activityInstance.has("startTime") &&
                                !activityInstance.isNull("startTime")) {
                            activityInstance.put("endTime", activityInstance.get("startTime"));
                            activityInstance.put("activityName",
                                    activityInstance.get("activityName").toString().replace(" :- Submit", "")
                                            + " :- Start");
                            // System.out.println( activityInstance.get("activityName").toString().replace("
                            // :- Submit", "")
                            // + " :- Start");
                            activityInstance.remove(activityInstance.get("assignee").toString());
                            try {
                                activityInstance.put("caseHistoryType", "activityInstance");
                                // System.out.println( sortedMap.containsKey(df1.parse((String)
                                // activityInstance.get("startTime"))));

                                if (sortedMap.containsKey(df1.parse((String) activityInstance.get("startTime")))) {
                                    // System.out.println( sortedMap.containsKey(df1.parse((String)
                                    // activityInstance.get("startTime"))));
                                    // System.out.println( duplicateInstance.containsKey(df1.parse((String)
                                    // activityInstance.get("startTime"))));
                                    if (duplicateInstance
                                            .containsKey(df1.parse((String) activityInstance.get("startTime")))) {
                                        duplicateActInstance.put(df1.parse((String) activityInstance.get("startTime")),
                                                activityInstance.toMap());
                                    } else {
                                        duplicateInstance.put(df1.parse((String) activityInstance.get("startTime")),
                                                activityInstance.toMap());
                                    }

                                } else {
                                    sortedMap.put(df1.parse((String) activityInstance.get("startTime")),
                                            activityInstance.toMap());
                                }

                            } catch (ParseException e) {
                                LOGGER.error("Error : " + e + "\nParam : "
                                        + loggerEncoderUtil.encode((String) activityInstance.get("taskId")));
                                activityLogService.addActivity(loggedInUser, "failed to get case history",
                                        "Error : " + e.toString() + ", Parameters : "
                                                + (String) activityInstance.get("taskId"));
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }
                        }

                        ResponseEntity<String> commentList = null;
                        try {
                            commentList = camundaService.getComments((String) activityInstance.get("taskId"),
                                    loggedInUser);
                        } catch (Exception e) {
                            LOGGER.error(loggerEncoderUtil
                                    .encode("Error : " + e + "\nParam : " + (String) activityInstance.get("taskId")));
                            activityLogService.addActivity(loggedInUser, "failed to get case history",
                                    "Error : " + e.toString() + ", Parameters : "
                                            + (String) activityInstance.get("taskId"));
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                        // String commentListString = commentList.bodyToMono(String.class).block();
                        String commentListString = commentList.getBody();
                        // commentList.releaseBody();
                        if (commentList.getStatusCode() == HttpStatus.OK) {

                            JSONArray commentListJson = new JSONArray(commentListString);
                            for (int a = 0; a <= commentListJson.length() - 1; a++) {
                                org.json.JSONObject comment = commentListJson.getJSONObject(a);
                                comment.put("caseHistoryType", "comment");

                                // change iuserid to username
                                ObjectMapper mapperuser = new ObjectMapper();
                                JsonNode nodeuser = null;
                                try {
                                    nodeuser = mapperuser.readTree(comment.get("message").toString());
                                } catch (JsonParseException e) {
                                    try {
                                        nodeuser = mapperuser
                                                .readTree(comment.get("message").toString().replaceAll("\n", ""));
                                    } catch (JsonProcessingException ex) {
                                        throw new RuntimeException(ex);
                                    }

                                } catch (JsonMappingException e) {
                                    throw new RuntimeException(e);
                                } catch (JsonProcessingException e) {
                                    throw new RuntimeException(e);
                                }

                                try {
                                    if (nodeuser.get("user") != null) {
                                        ((ObjectNode) nodeuser).put("user",
                                                webUserService.findByIUserID(nodeuser.get("user").asText()));
                                    }
                                    comment.put("message", mapperuser.writeValueAsString(nodeuser));
                                } catch (Exception e1) {
                                    // TODO Auto-generated catch block
                                    LOGGER.error("Error is " + e1 + " values : " + comment.get("message").toString());
                                }

                                if (claimUserMap.containsKey(comment.get("taskId"))) {
                                    comment.put("userId", claimUserMap.get(comment.get("taskId")));
                                }
                                try {
                                    if (sortedMap.containsKey(df1.parse((String) comment.get("time")))) {
                                        duplicateInstance.put(df1.parse((String) comment.get("time")), comment.toMap());
                                    } else {
                                        sortedMap.put(df1.parse((String) comment.get("time")), comment.toMap());
                                    }

                                } catch (ParseException e) {
                                    LOGGER.error("Error : " + e + "\nParam : "
                                            + loggerEncoderUtil.encode((String) activityInstance.get("taskId")));
                                    activityLogService.addActivity(loggedInUser, "failed to get case history",
                                            "Error : " + e.toString() + ", Parameters : "
                                                    + (String) activityInstance.get("taskId"));
                                    return new ResponseEntity<ApiResponse>(
                                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                            HttpStatus.INTERNAL_SERVER_ERROR);
                                }
                            }

                        } else {
                            activityLogService.addActivity(loggedInUser, "failed to get case history",
                                    "Parameters : " + (String) activityInstance.get("taskId"));
                            LOGGER.error(loggerEncoderUtil
                                .encode("Exiting getCaseHistoryPostgre Method in " + TasksServiceImpl.class
                                            + " class with response  : " + commentListString));
                            return new ResponseEntity<ApiResponse>(new ApiResponse(false, commentListString),
                                    commentList.getStatusCode());
                        }

                        ResponseEntity<String> attachmentList = null;
                        try {
                            attachmentList = camundaService.getAttachment((String) activityInstance.get("taskId"),
                                    loggedInUser);
                        } catch (Exception e) {

                            LOGGER.error(loggerEncoderUtil
                                    .encode("Error : " + e + "\nParam : " + (String) activityInstance.get("taskId")));
                            activityLogService.addActivity(loggedInUser, "failed to get case history",
                                    "Error : " + e.toString() + ", Parameters : "
                                            + (String) activityInstance.get("taskId"));
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                        // String attachmentListString =
                        // attachmentList.bodyToMono(String.class).block();
                        String attachmentListString = attachmentList.getBody();
                        // attachmentList.releaseBody();
                        if (attachmentList.getStatusCode() == HttpStatus.OK) {

                            JSONArray attachmentListJson = new JSONArray(attachmentListString);
                            for (int a = 0; a <= attachmentListJson.length() - 1; a++) {
                                org.json.JSONObject attachment = attachmentListJson.getJSONObject(a);
                                if (claimUserMap.containsKey(attachment.getString("taskId"))) {
                                    attachment.put("username", claimUserMap.get(attachment.getString("taskId")));
                                }
                                attachment.put("caseHistoryType", "attachment");

                                ObjectMapper mapperuser = new ObjectMapper();
                                JsonNode nodeuser = null;
                                try {
                                    nodeuser = mapperuser.readTree(attachment.get("description").toString());
                                    if (nodeuser.get("user") != null) {
                                        ((ObjectNode) nodeuser).put("user",
                                                webUserService.findByIUserID(nodeuser.get("user").asText()));
                                    }
                                    attachment.put("description", mapperuser.writeValueAsString(nodeuser));
                                } catch (Exception e1) {
                                    // TODO Auto-generated catch block
                                    LOGGER.error("Error is " + e1);
                                }

                                try {
                                    if (sortedMap.containsKey(df1.parse((String) attachment.get("createTime")))) {
                                        duplicateInstance.put(df1.parse((String) attachment.get("createTime")),
                                                attachment.toMap());
                                    } else {

                                        sortedMap.put(df1.parse((String) attachment.get("createTime")),
                                                attachment.toMap());
                                    }
                                } catch (ParseException e) {
                                    LOGGER.error("Error : " + e + "\nParam : "
                                            + loggerEncoderUtil.encode((String) activityInstance.get("taskId")));
                                    activityLogService.addActivity(loggedInUser, "failed to get case history",
                                            "Error : " + e.toString() + ", Parameters : "
                                                    + (String) activityInstance.get("taskId"));
                                    return new ResponseEntity<ApiResponse>(
                                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                            HttpStatus.INTERNAL_SERVER_ERROR);
                                }
                            }

                        } else {
                            activityLogService.addActivity(loggedInUser, "failed to claim task",
                                    "Parameters : " + (String) activityInstance.get("taskId"));
                            return new ResponseEntity<ApiResponse>(new ApiResponse(false, attachmentListString),
                                    attachmentList.getStatusCode());
                        }
                    } else if ((activityInstance.getString("activityType").equalsIgnoreCase("noneendevent")
                            && activityInstance.optString("activityName").toLowerCase().contains("close"))
                            || activityInstance.getString("activityType").equalsIgnoreCase("startevent")
                            || (activityInstance.optString("activityName")
                            .equalsIgnoreCase("Hold Settlement Intimation") && activityInstance.has("endTime")
                            && !activityInstance.isNull("endTime"))
                            || (activityInstance.getString("activityType").equalsIgnoreCase("sendTask")
                            && activityInstance.has("endTime") && !activityInstance.isNull("endTime"))
                            || (activityInstance.getString("activityType").equalsIgnoreCase("receiveTask") &&
                            activityInstance.has("endTime") && !activityInstance.isNull("endTime")
                            && !activityInstance.getBoolean("canceled"))) {

                        try {
                            if (!activityInstance.optString("activityName").isBlank()
                                    || !activityInstance.optString("activityName").isEmpty()) {
                                activityInstance.put("caseHistoryType", "activityInstance");
                                if (activityInstance.getString("activityType").equalsIgnoreCase("receiveTask")) {
                                    activityInstance.put("caseHistoryType", "receiveTask");
                                }
                                if (activityInstance.getString("activityType").equalsIgnoreCase("sendTask")
                                        || activityInstance.optString("activityName")
                                        .equalsIgnoreCase("Hold Settlement Intimation")) {
                                    activityInstance.put("caseHistoryType", "sendTask");

                                }
                                if (activityInstance.getString("activityType").equalsIgnoreCase("receiveTask")
                                        || activityInstance.getString("activityType").equalsIgnoreCase("sendTask")
                                        || activityInstance.optString("activityName")
                                        .equalsIgnoreCase("Hold Settlement Intimation")) {
                                    if (sortedMap.containsKey(df1.parse((String) activityInstance.get("endTime")))) {
                                        duplicateInstance.put(df1.parse((String) activityInstance.get("endTime")),
                                                activityInstance.toMap());
                                    } else {
                                        sortedMap.put(df1.parse((String) activityInstance.get("endTime")),
                                                activityInstance.toMap());
                                    }

                                } else {
                                    if (sortedMap.containsKey(df1.parse((String) activityInstance.get("startTime")))) {
                                        duplicateInstance.put(df1.parse((String) activityInstance.get("startTime")),
                                                activityInstance.toMap());
                                    } else {
                                        sortedMap.put(df1.parse((String) activityInstance.get("startTime")),
                                                activityInstance.toMap());
                                    }
                                }

                            }

                        } catch (ParseException e) {

                            LOGGER.error("Error : " + e + "\nParam : task id-"
                                    + loggerEncoderUtil.encode((String) activityInstance.get("taskId")));
                            activityLogService.addActivity(loggedInUser, "failed to get case history",
                                    "Error : " + e.toString() + ", Parameters : task id-"
                                            + (String) activityInstance.get("taskId"));
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                    }
                }
                ArrayList<Map> finalResponse = new ArrayList<>();
                ArrayList<Map> valueList = new ArrayList<Map>(sortedMap.values());
                // System.out.println(duplicateInstance);

                try {
                    for (int k = 0; k < valueList.size(); k++) {
                        if (valueList.get(k).containsKey("time")) {

                            finalResponse.add(valueList.get(k));
                            if (duplicateInstance.containsKey(df1.parse((String) valueList.get(k).get("time")))) {

                                finalResponse
                                        .add(duplicateInstance.get(df1.parse((String) valueList.get(k).get("time"))));
                            }
                        } else if (valueList.get(k).containsKey("endTime")) {

                            finalResponse.add(valueList.get(k));
                            if (duplicateActInstance.containsKey(df1.parse((String) valueList.get(k).get("endTime")))) {
                                finalResponse
                                        .add(duplicateActInstance
                                                .get(df1.parse((String) valueList.get(k).get("endTime"))));
                            }
                            if (duplicateInstance.containsKey(df1.parse((String) valueList.get(k).get("endTime")))) {

                                finalResponse
                                        .add(duplicateInstance
                                                .get(df1.parse((String) valueList.get(k).get("endTime"))));
                            }

                        } else {
                            finalResponse.add(valueList.get(k));
                        }
                    }

                    finalResponse.addAll(parent);
                } catch (Exception e) {
                    LOGGER.error(
                            "Error : " + e + "\nParam : valueList-" + loggerEncoderUtil.encode(valueList.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get case history",
                            "Error : " + e.toString() + ", Parameters :  valueList-" + valueList);
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                activityLogService.addActivity(loggedInUser, "comments list accessed",
                        "parameters : " + processinstanceid);
            LOGGER.debug("Exiting getCaseHistoryPostgre Method in " + TasksServiceImpl.class
                        + " class with response  : case history ");
                return ResponseEntity.ok(finalResponse);
            } else {
                activityLogService.addActivity(loggedInUser, "failed to get list of comment",
                        "Parameters : " + processinstanceid);
            LOGGER.error("Exiting getCaseHistoryPostgre Method in " + TasksServiceImpl.class + " class with response  : "
                        + response);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, response),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public ResponseEntity<?> getCaseHistoryTrino(String processinstanceid, String processDefId, Integer itenantid, LoggedUser loggedUser, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getCaseHistoryTrino");

        WebUser loggedInUser = loggedUser.getWebUser();

        Map<String, String> taskUserMap = new TreeMap<String, String>();
        Map<String, String> taskNameMap = new TreeMap<String, String>();
        Map<String, String> claimUserMap = new TreeMap<String, String>();
        Map<String, String> labelMap = new TreeMap<String, String>();
        Map<Date, Map> duplicateInstance = new TreeMap<>(Collections.reverseOrder());
        Map<Date, Map> duplicateActInstance = new TreeMap<>(Collections.reverseOrder());
        Map<Date, Map> sortedMap = new TreeMap<>(Collections.reverseOrder());
        DateFormat df1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");

        // --- Get Activity Instance ---

        Integer iuserid = loggedInUser.getIuserID();
        Integer iorgid  = loggedInUser.getIorgId().getIorgid();
        UserMapping classid = loggedUser.getUserClass();

        DashboardQueryRequest dashboardQueryRequest = new DashboardQueryRequest();
        dashboardQueryRequest.setQueryID(178);
        dashboardQueryRequest.setItenantID(itenantid);
        dashboardQueryRequest.setIuserid(iuserid);
        dashboardQueryRequest.setIorgid(iorgid);
        dashboardQueryRequest.setClassIds(classid);


        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> params = new HashMap<>();
        params.put("processinstanceid",processinstanceid);
        DashboardDataService temp = new DashboardDataService(dashboardQueryService,
                dashboardQueryParmeterService, loggerEncoderUtil, activityLogService,
                jdbcTemplateMap, transactionClassesUiService, dashboardErrorUtil);
        try{
            dashboardQueryRequest.setParametersJson(mapper.writeValueAsString(params));

        }catch(Exception e){
            LOGGER.error("Error serializing params to JSON: " + e.getMessage());
        }
        ResponseEntity<?> result;
        try{
            result = temp.getResultSetDataService(dashboardQueryRequest);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(processinstanceid));
            activityLogService.addActivity(
                loggedUser.getWebUser(),
                "failed to get case history",
                "Error : " + e.toString() + ", Parameters : " + processinstanceid
            );
            return new ResponseEntity<>(
                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                HttpStatus.INTERNAL_SERVER_ERROR
            );
        }
        if (result.getBody() instanceof ApiResponse || !result.getStatusCode().is2xxSuccessful()) {
            return result;
        }
        ResultSetResponse resultSetResponse = (ResultSetResponse) result.getBody();
        List<Map<String, Object>> activityInstanceListData = (List<Map<String, Object>>) resultSetResponse.data();
        JSONArray activityInstanceList = new JSONArray();
        if (activityInstanceListData != null && !activityInstanceListData.isEmpty()) {
            activityInstanceList = new JSONArray(activityInstanceListData);
        }

        // --- Get History Detail ---
        DashboardQueryRequest dashboardQueryRequestHistory = new DashboardQueryRequest();
        dashboardQueryRequestHistory.setQueryID(180);

        dashboardQueryRequestHistory.setItenantID(itenantid);
        dashboardQueryRequestHistory.setIuserid(iuserid);
        dashboardQueryRequestHistory.setIorgid(iorgid);
        dashboardQueryRequestHistory.setClassIds(classid);


        Map<String, Object> paramsHistory = new HashMap<>();
        paramsHistory.put("processinstanceid", processinstanceid);

        try {
            dashboardQueryRequestHistory.setParametersJson(mapper.writeValueAsString(paramsHistory));
        } catch (Exception e) {
            LOGGER.error("Error serializing params to JSON: " + e.getMessage());
        }

        ResponseEntity<?> resultHistory;
        try {
            resultHistory = temp.getResultSetDataService(dashboardQueryRequestHistory);
        } catch (Exception e) {
            LOGGER.error("Error fetching history detail : " + e +
                    "\nParam : " + loggerEncoderUtil.encode(processinstanceid));
            activityLogService.addActivity(
                    loggedInUser,
                    "failed to get case history",
                    "Error : " + e.toString() + ", Parameters : " + processinstanceid
            );
            return new ResponseEntity<>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }

        if (resultHistory.getBody() instanceof ApiResponse || !resultHistory.getStatusCode().is2xxSuccessful()) {
            return resultHistory;
        }

        ResultSetResponse resultSetResponseHistory = (ResultSetResponse) resultHistory.getBody();
        List<Map<String, Object>> historyRows = (List<Map<String, Object>>) resultSetResponseHistory.data();
        JSONArray historyDetailList = new JSONArray(historyRows);
        Set<String> taskIds = new HashSet<>();

        if(activityInstanceList.isEmpty()){
            LOGGER.debug("No activity instances found, reconstructing from taskinst and procinst tables");

            try {
                // First get all userActivity entries from history detail to find task IDs
                for (int h = 0; h < historyDetailList.length(); h++) {
                    org.json.JSONObject histroyDetailInstance = historyDetailList.getJSONObject(h);

                    if ("VariableUpdate".equalsIgnoreCase(histroyDetailInstance.optString("type")) &&
                            "userActivity".equals(histroyDetailInstance.optString("name"))) {

                        try {
                            ObjectMapper mapperuser = new ObjectMapper();
                            JsonNode nodeuser = mapperuser.readTree(histroyDetailInstance.optString("value", "{}"));
                            if (nodeuser.has("id") && !nodeuser.get("id").isNull()) {
                                String taskId = nodeuser.get("id").asText();
                                taskIds.add(taskId);
                            }
                        } catch (Exception e) {
                            LOGGER.error("Error parsing userActivity value: " + e.getMessage());
                        }
                    }
                }

                // If we found task IDs from userActivity, fetch task instances
                if (!taskIds.isEmpty()) {
                    DashboardQueryRequest taskInstRequest = new DashboardQueryRequest();
                    taskInstRequest.setQueryID(183); // You'll need to create this query
                    taskInstRequest.setItenantID(itenantid);
                    taskInstRequest.setIuserid(iuserid);
                    taskInstRequest.setIorgid(iorgid);
                    taskInstRequest.setClassIds(classid);

                    Map<String, Object> taskInstParams = new HashMap<>();
                    taskInstParams.put("taskids", new ArrayList<>(taskIds));
                    taskInstParams.put("processinstanceid", processinstanceid);
                    taskInstRequest.setParametersJson(mapper.writeValueAsString(taskInstParams));

                    ResponseEntity<?> taskInstResult = temp.getResultSetDataService(taskInstRequest);

                    if (taskInstResult.getStatusCode().is2xxSuccessful() &&
                            !(taskInstResult.getBody() instanceof ApiResponse)) {

                        ResultSetResponse taskInstResponse = (ResultSetResponse) taskInstResult.getBody();
                        List<Map<String, Object>> taskInstData = (List<Map<String, Object>>) taskInstResponse.data();

                        // Convert task instances to activity instances format
                        for (Map<String, Object> taskInst : taskInstData) {
                            org.json.JSONObject activityInstance = new org.json.JSONObject(taskInst);

                            activityInstance.put("activityType", "userTask");
                            activityInstanceList.put(activityInstance);

                            // Also populate taskUserMap and taskNameMap
                            String assignee = (String) taskInst.get("assignee");
                            String username = assignee != null ? webUserService.findByIUserID(assignee) : null;
                            String taskId = (String) taskInst.get("taskId");
                            String taskName = (String) taskInst.get("activityName");

                            taskUserMap.put(taskId, username);
                            taskNameMap.put(taskId, taskName);
                        }
                    }
                }

                // Also get start events from procinst table
                DashboardQueryRequest procInstRequest = new DashboardQueryRequest();
                procInstRequest.setQueryID(184); // You'll need to create this query


                procInstRequest.setItenantID(itenantid);
                procInstRequest.setIuserid(iuserid);
                procInstRequest.setIorgid(iorgid);
                procInstRequest.setClassIds(classid);

                Map<String, Object> procInstParams = new HashMap<>();
                procInstParams.put("processinstanceid", processinstanceid);

                procInstRequest.setParametersJson(mapper.writeValueAsString(procInstParams));

                ResponseEntity<?> procInstResult = temp.getResultSetDataService(procInstRequest);

                if (procInstResult.getStatusCode().is2xxSuccessful() &&
                        !(procInstResult.getBody() instanceof ApiResponse)) {

                    ResultSetResponse procInstResponse = (ResultSetResponse) procInstResult.getBody();
                    List<Map<String, Object>> procInstData = (List<Map<String, Object>>) procInstResponse.data();

                    if (!procInstData.isEmpty()) {
                        Map<String, Object> procInst = procInstData.get(0);

                        Boolean isCanceled = (Boolean) procInst.get("canceled");
                        String startTime = procInst.get("startTime").toString();
                        String endTime = procInst.get("endTime") != null ? procInst.get("endTime").toString() : null;

                        // Create start event activity instance
                        org.json.JSONObject startEvent = new org.json.JSONObject();
                        startEvent.put("processInstanceId", processinstanceid);
                        startEvent.put("processDefinitionId", procInst.get("processDefinitionId"));
                        startEvent.put("activityType", "startEvent");
                        startEvent.put("activityName", "Create Ticket");
                        startEvent.put("tenantId", procInst.get("tenantId"));
                        startEvent.put("startTime", startTime);
                        startEvent.put("endTime", startTime);
                        startEvent.put("canceled", isCanceled != null ? isCanceled : false);

                        activityInstanceList.put(startEvent);

                        // Check if there's an end event (process has ended)
                        if (endTime != null) {
                            org.json.JSONObject endEvent = new org.json.JSONObject();
                            endEvent.put("processInstanceId", processinstanceid);
                            endEvent.put("processDefinitionId", procInst.get("processDefinitionId"));
                            endEvent.put("activityType", "noneEndEvent");
                            endEvent.put("activityName", "Close Ticket");
                            endEvent.put("tenantId", procInst.get("tenantId"));
                            endEvent.put("startTime", endTime);
                            endEvent.put("endTime", endTime);
                            endEvent.put("canceled", isCanceled != null ? isCanceled : false);

                            activityInstanceList.put(endEvent);
                        }
                    }
                }

                LOGGER.debug("Reconstructed " + activityInstanceList.length() + " activity instances from taskinst and procinst");

            } catch (Exception e) {
                LOGGER.error("Error reconstructing activity instances: " + e.getMessage());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR
                );
            }
        } else {
            for (int i = 0, size = activityInstanceList.length(); i < size; i++) {
                org.json.JSONObject activityInstance = activityInstanceList.getJSONObject(i);
                if (activityInstance.getString("activityType").equalsIgnoreCase("usertask")) {
                    String assignee = activityInstance.optString("assignee", null);
                    String username = assignee != null ? webUserService.findByIUserID(assignee) : null;
                    taskUserMap.put(activityInstance.getString("taskId"), username);
                    taskNameMap.put(activityInstance.getString("taskId"),
                            activityInstance.getString("activityName"));
                }
            }

            for (int i = 0, size = activityInstanceList.length(); i < size; i++) {
                org.json.JSONObject activityInstance = activityInstanceList.getJSONObject(i);
                if (activityInstance.getString("activityType").equalsIgnoreCase("usertask")) {
                    String taskId = activityInstance.optString("taskId");
                    if (taskId != null && !taskId.isEmpty()) {
                        taskIds.add(taskId);
                    }
                }
            }
        }

        if(activityInstanceList.isEmpty()){
            activityLogService.addActivity(loggedInUser, "failed to get list of activity instances",
                    "Parameters : " + processinstanceid);
            LOGGER.error("Exiting getCaseHistoryTrino Method in " + TasksServiceImpl.class + " - No activity instances found for process instance id " + processinstanceid);
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.NOT_FOUND);
        }

        // --- Get BPMN ---
        DashboardQueryRequest dashboardQueryRequestBpmn = new DashboardQueryRequest();
        dashboardQueryRequestBpmn.setQueryID(179);

        dashboardQueryRequestBpmn.setItenantID(itenantid);
        dashboardQueryRequestBpmn.setIuserid(iuserid);
        dashboardQueryRequestBpmn.setIorgid(iorgid);
        dashboardQueryRequestBpmn.setClassIds(classid);

        Map<String, Object> paramsBpmn = new HashMap<>();
        paramsBpmn.put("processdefid",processDefId);
        try{
            dashboardQueryRequestBpmn.setParametersJson(mapper.writeValueAsString(paramsBpmn));
        }catch(Exception e){
            LOGGER.error("Error serializing params to JSON: " + e.getMessage());
        }
        ResponseEntity<?> resultBpmn;
        try{
            resultBpmn = temp.getResultSetDataService(dashboardQueryRequestBpmn);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(processinstanceid));
            activityLogService.addActivity(
                    loggedUser.getWebUser(),
                    "failed to get case history",
                    "Error : " + e.toString() + ", Parameters : " + processinstanceid
            );
            return new ResponseEntity<>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }
        if (resultBpmn.getBody() instanceof ApiResponse || !resultBpmn.getStatusCode().is2xxSuccessful()) {
            return resultBpmn;
        }
        ResultSetResponse resultSetResponseBpmn = (ResultSetResponse) resultBpmn.getBody();
        List<Map<String, Object>> rows  = (List<Map<String, Object>>) resultSetResponseBpmn.data();
        if (rows.isEmpty()) {
            LOGGER.error("No BPMN found for processDefId: " + processDefId);
            return new ResponseEntity<>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.NOT_FOUND
            );
        }
        String bpmnResponse = (String) rows.get(0).get("bpmn20Xml");

        try {
            org.w3c.dom.Document doc = xmlParser.XMLParser(bpmnResponse);

            NodeList formFieldlist = doc.getElementsByTagName("camunda:formField");

            if (formFieldlist.getLength() > maxFieldLength) {
                LOGGER.info("\nParam : " + loggerEncoderUtil.encode(processDefId));
                activityLogService.addActivity(loggedInUser,
                        "failed to get xml parametes length more then  " + maxFieldLength,
                        processDefId);
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "No of fields should not exceed " + maxFieldLength),
                        HttpStatus.BAD_REQUEST);
            }
            for (int i = 0; i < formFieldlist.getLength(); i++) {
                Node formField = formFieldlist.item(i);
                if (!formField.getAttributes().getNamedItem("id").getNodeValue().equals("conditions") &&
                        !formField.getAttributes().getNamedItem("id").getNodeValue().equals("custom_err_msg") &&
                        !formField.getAttributes().getNamedItem("id").getNodeValue().equals("links") &&
                        !formField.getAttributes().getNamedItem("id").getNodeValue().equals("apis")
                        && !formField.getAttributes().getNamedItem("id").getNodeValue().equals("setAuto")
                        && !formField.getAttributes().getNamedItem("id").getNodeValue().equals("disableIf")
                        && !formField.getAttributes().getNamedItem("id").getNodeValue().equals("validations")
                        && !labelMap.containsKey(formField.getAttributes().getNamedItem("id")
                        .getNodeValue())) {
                    labelMap.put(
                            formField.getAttributes().getNamedItem("id")
                                    .getNodeValue(),
                            formField.getAttributes().getNamedItem("label") != null
                                    ? formField.getAttributes().getNamedItem("label")
                                    .getNodeValue()
                                    : "");
                    NodeList valuelist = formField.getChildNodes();
                    if (valuelist != null) {
                        for (int j = 0; j < valuelist.getLength(); j++) {
                            Node value = valuelist.item(j);
                            if (value.getNodeName().equals("camunda:value")) {
                                labelMap.put(
                                        value.getAttributes().getNamedItem("id").getNodeValue(),
                                        value.getAttributes().getNamedItem("name").getNodeValue());
                            }
                        }
                    }

                }
            }
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + bpmnResponse);
            activityLogService.addActivity(loggedInUser, "failed to get list of history details",
                    "Error : " + e.toString() + ", Parameters : " + bpmnResponse);
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        // History detail processing

        ArrayList<Map> parent = new ArrayList<>();

        for (int h = 0; h < historyDetailList.length(); h++) {
            org.json.JSONObject histroyDetailInstance = historyDetailList.getJSONObject(h);

            if ("VariableUpdate".equalsIgnoreCase(histroyDetailInstance.optString("type"))) {
                String variableName = histroyDetailInstance.optString("name");

                if ("userActivity".equals(variableName)) {
                    histroyDetailInstance.put("caseHistoryType", "claimStatus");

                    ObjectMapper mapperuser = new ObjectMapper();
                    JsonNode nodeuser = null;
                    try {
                        nodeuser = mapperuser.readTree(histroyDetailInstance.get("value").toString());
                        if (nodeuser.get("user") != null) {
                            ((ObjectNode) nodeuser).put("user",
                                    webUserService.findByIUserID(nodeuser.get("user").asText()));
                        }
                        histroyDetailInstance.put("value", mapperuser.writeValueAsString(nodeuser));
                    } catch (Exception e1) {
                        LOGGER.error("Error is " + e1);
                    }

                    if (nodeuser != null && nodeuser.get("user") != null) {
                        if (nodeuser.get("id") != null) {
                            histroyDetailInstance.put("taskName", taskNameMap.get(nodeuser.get("id").asText()));
                        }
                        if ("Claim".equals(nodeuser.get("action").asText())) {
                            if (!claimUserMap.containsKey(nodeuser.get("id").asText())) {
                                claimUserMap.put(nodeuser.get("id").asText(), nodeuser.get("user").asText());
                            }
                        }
                        try {
                            if (!"Submit".equals(nodeuser.get("action").asText())) {
                                if (sortedMap.containsKey(df1.parse((String) histroyDetailInstance.get("time")))) {
                                    duplicateInstance.put(df1.parse((String) histroyDetailInstance.get("time")),
                                            histroyDetailInstance.toMap());
                                } else {
                                    sortedMap.put(df1.parse((String) histroyDetailInstance.get("time")),
                                            histroyDetailInstance.toMap());
                                }
                            }
                        } catch (ParseException e) {
                            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(processinstanceid));
                            activityLogService.addActivity(loggedInUser, "failed to get case history",
                                    "Error : " + e.toString() + ", Parameters : " + processinstanceid);
                            return new ResponseEntity<>(
                                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                    }
                }

                if ("checker_action_whitelist_obj".equals(variableName)) {
                    histroyDetailInstance.put("caseHistoryType", "remarks");
                    histroyDetailInstance.put("fieldIdLabel", labelMap.get("checker_action_whitelist"));

                    ObjectMapper mapperuser = new ObjectMapper();
                    JsonNode nodeuser = null;
                    try {
                        nodeuser = mapperuser.readTree(histroyDetailInstance.get("value").toString());
                    } catch (Exception e1) {
                        LOGGER.error("Error " + e1);
                    }

                    try {
                        if (nodeuser != null && nodeuser.get("user") != null && nodeuser.get("value") != null) {
                            histroyDetailInstance.put("fieldValueLabel", nodeuser.get("value"));
                            histroyDetailInstance.put("userId", nodeuser.get("user"));
                        }
                    } catch (Exception e) {
                        LOGGER.error(e.toString());
                    }

                    try {
                        if (sortedMap.containsKey(df1.parse((String) histroyDetailInstance.get("time")))) {
                            duplicateInstance.put(df1.parse((String) histroyDetailInstance.get("time")),
                                    histroyDetailInstance.toMap());
                        } else {
                            sortedMap.put(df1.parse((String) histroyDetailInstance.get("time")),
                                    histroyDetailInstance.toMap());
                        }
                    } catch (ParseException e) {
                        LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(processinstanceid));
                        activityLogService.addActivity(loggedInUser, "failed to get case history",
                                "Error : " + e.toString() + ", Parameters : " + processinstanceid);
                        return new ResponseEntity<>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                }

                if ("strHistoryUpdate".equals(variableName)) {
                    histroyDetailInstance.put("caseHistoryType", "remarks");
                    histroyDetailInstance.put("fieldIdLabel", "STR Form History");

                    ObjectMapper mapperuser = new ObjectMapper();
                    JsonNode nodeuser = null;
                    try {
                        nodeuser = mapperuser.readTree(histroyDetailInstance.get("value").toString());
                    } catch (Exception e1) {
                        LOGGER.error("Error " + e1);
                    }

                    try {
                        if (nodeuser != null && nodeuser.get("user") != null && nodeuser.get("value") != null) {
                            histroyDetailInstance.put("fieldValueLabel", nodeuser.get("value"));
                            histroyDetailInstance.put("userId",
                                    webUserService.findByIUserID(nodeuser.get("user").asText()));
                        }
                    } catch (Exception e) {
                        LOGGER.error(e.toString());
                    }

                    try {
                        if (sortedMap.containsKey(df1.parse((String) histroyDetailInstance.get("time")))) {
                            duplicateInstance.put(df1.parse((String) histroyDetailInstance.get("time")),
                                    histroyDetailInstance.toMap());
                        } else {
                            sortedMap.put(df1.parse((String) histroyDetailInstance.get("time")),
                                    histroyDetailInstance.toMap());
                        }
                    } catch (ParseException e) {
                        LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(processinstanceid));
                        activityLogService.addActivity(loggedInUser, "failed to get case history",
                                "Error : " + e.toString() + ", Parameters : " + processinstanceid);
                        return new ResponseEntity<>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                }

                if ("AlertIDs".equals(variableName)) {
                    histroyDetailInstance.put("caseHistoryType", "alerts");
                    histroyDetailInstance.put("title", "Following Alerts Generated");
                    String alerts = histroyDetailInstance.get("value").toString();
                    histroyDetailInstance.put("alertIDs", Arrays.asList(alerts.split(",")));

                    try {
                        if (sortedMap.containsKey(df1.parse((String) histroyDetailInstance.get("time")))) {
                            duplicateInstance.put(df1.parse((String) histroyDetailInstance.get("time")),
                                    histroyDetailInstance.toMap());
                        } else {
                            sortedMap.put(df1.parse((String) histroyDetailInstance.get("time")),
                                    histroyDetailInstance.toMap());
                        }
                    } catch (ParseException e) {
                        LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(processinstanceid));
                        activityLogService.addActivity(loggedInUser, "failed to get case history",
                                "Error : " + e.toString() + ", Parameters : " + processinstanceid);
                        return new ResponseEntity<>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                }

                if ("parentProcess".equals(variableName)) {
                    ObjectMapper mapperParent = new ObjectMapper();
                    JsonNode nodeParent = null;
                    try {
                        nodeParent = mapperParent.readTree(histroyDetailInstance.get("value").toString());
                    } catch (Exception e1) {
                        LOGGER.error("Error " + e1);
                    }

                    ResponseEntity<?> parentRes = getCaseHistory(
                            nodeParent.get("Id").asText(),
                            nodeParent.get("defId").asText(),
                            itenantid,
                            pr
                    );
                    try {
                        parent = (ArrayList<Map>) parentRes.getBody();
                    } catch (Exception e) {
                        LOGGER.error("Error " + e);
                    }
                }
            }
        }

        for (int i = 0; i < historyDetailList.length(); i++) {
            org.json.JSONObject histroyDetailInstance = historyDetailList.getJSONObject(i);

            if ("FormProperty".equalsIgnoreCase(histroyDetailInstance.optString("type"))) {
                String fieldId = histroyDetailInstance.optString("name"); // name → fieldId
                if ("Remarks".equals(fieldId)
                        || "DocumentReviewRemarks".equals(fieldId)
                        || "Action1".equals(fieldId)
                        || "Action2".equals(fieldId)
                        || "Action".equals(fieldId)
                        || fieldId.startsWith("Action")
                        || "Block".equals(fieldId)) {

                    histroyDetailInstance.put("type", "formField");
                    histroyDetailInstance.put("caseHistoryType", "remarks");
                    histroyDetailInstance.put("fieldIdLabel", labelMap.get(fieldId));
                    histroyDetailInstance.put("fieldValueLabel", labelMap.get(histroyDetailInstance.optString("value")));
                    histroyDetailInstance.put("fieldValue", histroyDetailInstance.optString("value"));
                    histroyDetailInstance.put("userId", claimUserMap.get(histroyDetailInstance.optString("taskId")));

                    try {
                        if (sortedMap.containsKey(df1.parse((String) histroyDetailInstance.get("time")))) {
                            duplicateInstance.put(df1.parse((String) histroyDetailInstance.get("time")),
                                    histroyDetailInstance.toMap());
                        } else {
                            sortedMap.put(df1.parse((String) histroyDetailInstance.get("time")),
                                    histroyDetailInstance.toMap());
                        }
                    } catch (ParseException e) {
                        LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(processinstanceid));
                        activityLogService.addActivity(loggedInUser, "failed to get case history",
                                "Error : " + e.toString() + ", Parameters : " + processinstanceid);
                        return new ResponseEntity<>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                }
            }
        }

        for (int i = 0; i < historyDetailList.length(); i++) {
            org.json.JSONObject histroyDetailInstance = historyDetailList.getJSONObject(i);

            if ("VariableUpdate".equalsIgnoreCase(histroyDetailInstance.optString("type"))) {
                if (!histroyDetailInstance.optString("activityInstanceId").contains("Activity")) {
                    String variableName = histroyDetailInstance.optString("name");
                    if ("Document".equals(variableName) || "separate".equals(variableName)) {
                        histroyDetailInstance.put("caseHistoryType", "merchantResponse");

                        try {
                            if (sortedMap.containsKey(df1.parse((String) histroyDetailInstance.get("time")))) {
                                duplicateInstance.put(df1.parse((String) histroyDetailInstance.get("time")),
                                        histroyDetailInstance.toMap());
                            } else {
                                sortedMap.put(df1.parse((String) histroyDetailInstance.get("time")),
                                        histroyDetailInstance.toMap());
                            }
                        } catch (ParseException e) {
                            LOGGER.error("Error : " + e + "\nParam : "
                                    + loggerEncoderUtil.encode(histroyDetailInstance.optString("taskId")));
                            activityLogService.addActivity(loggedInUser, "failed to get case history",
                                    "Error : " + e.toString() + ", Parameters : "
                                            + histroyDetailInstance.optString("taskId"));
                            return new ResponseEntity<>(
                                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                    }
                }
            }
        }

        // --- Get Comments ---

        // Fetch all comments in bulk
        Map<String, List<org.json.JSONObject>> commentsByTaskId = new HashMap<>();
        if (!taskIds.isEmpty()) {
            try {
                // Use your custom query to fetch all comments for these task IDs
                DashboardQueryRequest commentsRequest = new DashboardQueryRequest();
                commentsRequest.setQueryID(181);
                commentsRequest.setItenantID(itenantid);
                commentsRequest.setIuserid(iuserid);
                commentsRequest.setIorgid(iorgid);
                commentsRequest.setClassIds(classid);

                Map<String, Object> commentsParams = new HashMap<>();
                commentsParams.put("taskids", new ArrayList<>(taskIds));
                commentsParams.put("processinstanceid", processinstanceid);
                commentsRequest.setParametersJson(mapper.writeValueAsString(commentsParams));

                ResponseEntity<?> commentsResult = temp.getResultSetDataService(commentsRequest);

                if (commentsResult.getStatusCode().is2xxSuccessful() &&
                        !(commentsResult.getBody() instanceof ApiResponse)) {

                    ResultSetResponse commentsResponse = (ResultSetResponse) commentsResult.getBody();
                    List<Map<String, Object>> commentsData = (List<Map<String, Object>>) commentsResponse.data();

                    // Group comments by task ID
                    for (Map<String, Object> comment : commentsData) {
                        String taskId = (String) comment.get("taskId");
                        commentsByTaskId.computeIfAbsent(taskId, k -> new ArrayList<>())
                                .add(new org.json.JSONObject(comment));
                    }
                }
            } catch (Exception e) {
                LOGGER.error("Error fetching comments in bulk: " + e.getMessage());
                activityLogService.addActivity(
                        loggedInUser,
                        "failed to get case history",
                        "Error : " + e.toString() + ", Parameters : " + processinstanceid
                );
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR
                );
            }
        }

        // Get Attachments

        // Fetch all attachments in bulk
        Map<String, List<org.json.JSONObject>> attachmentsByTaskId = new HashMap<>();
        if (!taskIds.isEmpty()) {
            try {
                // Use your custom query to fetch all attachments for these task IDs
                DashboardQueryRequest attachmentsRequest = new DashboardQueryRequest();
                attachmentsRequest.setQueryID(182);
                attachmentsRequest.setItenantID(itenantid);
                attachmentsRequest.setIuserid(iuserid);
                attachmentsRequest.setIorgid(iorgid);
                attachmentsRequest.setClassIds(classid);

                Map<String, Object> attachmentsParams = new HashMap<>();
                attachmentsParams.put("taskids", new ArrayList<>(taskIds));
                attachmentsParams.put("processinstanceid", processinstanceid);
                attachmentsRequest.setParametersJson(mapper.writeValueAsString(attachmentsParams));

                ResponseEntity<?> attachmentsResult = temp.getResultSetDataService(attachmentsRequest);

                if (attachmentsResult.getStatusCode().is2xxSuccessful() &&
                        !(attachmentsResult.getBody() instanceof ApiResponse)) {

                    ResultSetResponse attachmentsResponse = (ResultSetResponse) attachmentsResult.getBody();
                    List<Map<String, Object>> attachmentsData = (List<Map<String, Object>>) attachmentsResponse.data();

                    // Group attachments by task ID
                    for (Map<String, Object> attachment : attachmentsData) {
                        String taskId = (String) attachment.get("taskId");
                        attachmentsByTaskId.computeIfAbsent(taskId, k -> new ArrayList<>())
                                .add(new org.json.JSONObject(attachment));
                    }
                }
            } catch (Exception e) {
                LOGGER.error("Error fetching attachments in bulk: " + e.getMessage());
                activityLogService.addActivity(
                        loggedInUser,
                        "failed to get case history",
                        "Error : " + e.toString() + ", Parameters : " + processinstanceid
                );
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR
                );
            }
        }

        // Now process the activity instances with pre-fetched data
        if (!activityInstanceList.isEmpty()) {
            for (int i = 0, size = activityInstanceList.length(); i < size; i++) {
                org.json.JSONObject activityInstance = activityInstanceList.getJSONObject(i);

                if (activityInstance.getString("activityType").equalsIgnoreCase("usertask")) {

                    activityInstance.put("assignee", webUserService.findByIUserID(activityInstance.optString("assignee")));

                    if (activityInstance.has("endTime") && !activityInstance.isNull("endTime")
                            && !activityInstance.getBoolean("canceled")) {
                        activityInstance.put("activityName", activityInstance.get("activityName") + " :- Submit");
                        try {
                            activityInstance.put("caseHistoryType", "activityInstance");
                            if (sortedMap.containsKey(df1.parse((String) activityInstance.get("endTime")))) {
                                if (duplicateInstance
                                        .containsKey(df1.parse((String) activityInstance.get("endTime")))) {
                                    duplicateActInstance.put(df1.parse((String) activityInstance.get("endTime")),
                                            activityInstance.toMap());
                                } else {
                                    duplicateInstance.put(df1.parse((String) activityInstance.get("endTime")),
                                            activityInstance.toMap());
                                }

        } else {
                                sortedMap.put(df1.parse((String) activityInstance.get("endTime")),
                                        activityInstance.toMap());
                            }

                        } catch (ParseException e) {
                            LOGGER.error("Error : " + e + "\nParam : "
                                    + loggerEncoderUtil.encode((String) activityInstance.get("taskId")));
                            activityLogService.addActivity(loggedInUser, "failed to get case history",
                                    "Error : " + e.toString() + ", Parameters : "
                                            + (String) activityInstance.get("taskId"));
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                    }

                    if (activityInstance.has("startTime") &&
                            !activityInstance.isNull("startTime")) {
                        activityInstance.put("endTime", activityInstance.get("startTime"));
                        activityInstance.put("activityName",
                                activityInstance.get("activityName").toString().replace(" :- Submit", "")
                                        + " :- Start");
                        if(activityInstance.has("assignee")) activityInstance.remove(activityInstance.get("assignee").toString());
                        try {
                            activityInstance.put("caseHistoryType", "activityInstance");

                            if (sortedMap.containsKey(df1.parse((String) activityInstance.get("startTime")))) {
                                if (duplicateInstance
                                        .containsKey(df1.parse((String) activityInstance.get("startTime")))) {
                                    duplicateActInstance.put(df1.parse((String) activityInstance.get("startTime")),
                                            activityInstance.toMap());
                                } else {
                                    duplicateInstance.put(df1.parse((String) activityInstance.get("startTime")),
                                            activityInstance.toMap());
                                }

                            } else {
                                sortedMap.put(df1.parse((String) activityInstance.get("startTime")),
                                        activityInstance.toMap());
                            }

                        } catch (ParseException e) {
                            LOGGER.error("Error : " + e + "\nParam : "
                                    + loggerEncoderUtil.encode((String) activityInstance.get("taskId")));
                            activityLogService.addActivity(loggedInUser, "failed to get case history",
                                    "Error : " + e.toString() + ", Parameters : "
                                            + (String) activityInstance.get("taskId"));
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                    }

                    String taskId = activityInstance.optString("taskId");

                    // Process comments from pre-fetched data
                    List<org.json.JSONObject> taskComments = commentsByTaskId.getOrDefault(taskId, new ArrayList<>());
                    for (org.json.JSONObject comment : taskComments) {
                        comment.put("caseHistoryType", "comment");

                        // Process user mapping in comment message
                        ObjectMapper mapperuser = new ObjectMapper();
                        try {
                            JsonNode nodeuser = mapperuser.readTree(comment.optString("message", "{}"));
                            if (nodeuser.get("user") != null) {
                                ((ObjectNode) nodeuser).put("user",
                                        webUserService.findByIUserID(nodeuser.get("user").asText()));
                            }
                            comment.put("message", mapperuser.writeValueAsString(nodeuser));
                        } catch (Exception e1) {
                            LOGGER.error( "Error processing comment: taskId={}, processInstanceId={}, message={}", taskId, processinstanceid,comment.optString("message","{}"), e1);

                        }

                        if (claimUserMap.containsKey(comment.optString("taskId"))) {
                            comment.put("userId", claimUserMap.get(comment.optString("taskId")));
                        }

                        try {
                            if (sortedMap.containsKey(df1.parse(comment.optString("time")))) {
                                duplicateInstance.put(df1.parse(comment.optString("time")), comment.toMap());
                            } else {
                                sortedMap.put(df1.parse(comment.optString("time")), comment.toMap());
                            }
                        } catch (ParseException e) {
                            LOGGER.error("Parse error with comment time: " + e);
                        }
                    }

                    // Process attachments from pre-fetched data
                    List<org.json.JSONObject> taskAttachments = attachmentsByTaskId.getOrDefault(taskId, new ArrayList<>());
                    for (org.json.JSONObject attachment : taskAttachments) {
                        if (claimUserMap.containsKey(attachment.optString("taskId"))) {
                            attachment.put("username", claimUserMap.get(attachment.optString("taskId")));
                        }
                        attachment.put("caseHistoryType", "attachment");

                        ObjectMapper mapperuser = new ObjectMapper();
                        try {
                            JsonNode nodeuser = mapperuser.readTree(attachment.optString("description", "{}"));
                            if (nodeuser.get("user") != null) {
                                ((ObjectNode) nodeuser).put("user",
                                        webUserService.findByIUserID(nodeuser.get("user").asText()));
                            }
                            attachment.put("description", mapperuser.writeValueAsString(nodeuser));
                        } catch (Exception e1) {
                            LOGGER.error("Error processing attachment: " + e1);
                        }

                        try {
                            if (sortedMap.containsKey(df1.parse(attachment.optString("createTime")))) {
                                duplicateInstance.put(df1.parse(attachment.optString("createTime")),
                                        attachment.toMap());
                            } else {
                                sortedMap.put(df1.parse(attachment.optString("createTime")),
                                        attachment.toMap());
                            }
                        } catch (ParseException e) {
                            LOGGER.error("Parse error with attachment time: " + e);
                        }
        }

                } else if ((activityInstance.getString("activityType").equalsIgnoreCase("noneendevent")
                        && activityInstance.optString("activityName").equalsIgnoreCase("close ticket"))
                        || activityInstance.getString("activityType").equalsIgnoreCase("startevent")
                        || (activityInstance.optString("activityName")
                        .equalsIgnoreCase("Hold Settlement Intimation") && activityInstance.has("endTime")
                        && !activityInstance.isNull("endTime"))
                        || (activityInstance.getString("activityType").equalsIgnoreCase("sendTask")
                        && activityInstance.has("endTime") && !activityInstance.isNull("endTime"))
                        || (activityInstance.getString("activityType").equalsIgnoreCase("receiveTask") &&
                        activityInstance.has("endTime") && !activityInstance.isNull("endTime")
                        && !activityInstance.getBoolean("canceled"))) {

                    try {
                        if (!activityInstance.optString("activityName").isBlank()
                                || !activityInstance.optString("activityName").isEmpty()) {
                            activityInstance.put("caseHistoryType", "activityInstance");
                            if (activityInstance.getString("activityType").equalsIgnoreCase("receiveTask")) {
                                activityInstance.put("caseHistoryType", "receiveTask");
                            }
                            if (activityInstance.getString("activityType").equalsIgnoreCase("sendTask")
                                    || activityInstance.optString("activityName")
                                    .equalsIgnoreCase("Hold Settlement Intimation")) {
                                activityInstance.put("caseHistoryType", "sendTask");

                            }
                            if (activityInstance.getString("activityType").equalsIgnoreCase("receiveTask")
                                    || activityInstance.getString("activityType").equalsIgnoreCase("sendTask")
                                    || activityInstance.optString("activityName")
                                    .equalsIgnoreCase("Hold Settlement Intimation")) {
                                if (sortedMap.containsKey(df1.parse((String) activityInstance.get("endTime")))) {
                                    duplicateInstance.put(df1.parse((String) activityInstance.get("endTime")),
                                            activityInstance.toMap());
                                } else {
                                    sortedMap.put(df1.parse((String) activityInstance.get("endTime")),
                                            activityInstance.toMap());
                                }

                            } else {
                                if (sortedMap.containsKey(df1.parse((String) activityInstance.get("startTime")))) {
                                    duplicateInstance.put(df1.parse((String) activityInstance.get("startTime")),
                                            activityInstance.toMap());
                                } else {
                                    sortedMap.put(df1.parse((String) activityInstance.get("startTime")),
                                            activityInstance.toMap());
                                }
                            }

                        }

                    } catch (ParseException e) {

                        LOGGER.error("Error : " + e + "\nParam : task id-"
                                + loggerEncoderUtil.encode((String) activityInstance.get("taskId")));
                        activityLogService.addActivity(loggedInUser, "failed to get case history",
                                "Error : " + e.toString() + ", Parameters : task id-"
                                        + (String) activityInstance.get("taskId"));
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                }
            }
            ArrayList<Map> finalResponse = new ArrayList<>();
            ArrayList<Map> valueList = new ArrayList<Map>(sortedMap.values());

            try {
                for (int k = 0; k < valueList.size(); k++) {
                    if (valueList.get(k).containsKey("time")) {

                        finalResponse.add(valueList.get(k));
                        if (duplicateInstance.containsKey(df1.parse((String) valueList.get(k).get("time")))) {

                            finalResponse
                                    .add(duplicateInstance.get(df1.parse((String) valueList.get(k).get("time"))));
                        }
                    } else if (valueList.get(k).containsKey("endTime")) {

                        finalResponse.add(valueList.get(k));
                        if (duplicateActInstance.containsKey(df1.parse((String) valueList.get(k).get("endTime")))) {
                            finalResponse
                                    .add(duplicateActInstance
                                            .get(df1.parse((String) valueList.get(k).get("endTime"))));
                        }
                        if (duplicateInstance.containsKey(df1.parse((String) valueList.get(k).get("endTime")))) {

                            finalResponse
                                    .add(duplicateInstance
                                            .get(df1.parse((String) valueList.get(k).get("endTime"))));
                        }

                    } else {
                        finalResponse.add(valueList.get(k));
                    }
                }

                finalResponse.addAll(parent);
            } catch (Exception e) {
                LOGGER.error(
                        "Error : " + e + "\nParam : valueList-" + loggerEncoderUtil.encode(valueList.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get case history",
                        "Error : " + e.toString() + ", Parameters :  valueList-" + valueList);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            activityLogService.addActivity(loggedInUser, "comments list accessed",
                    "parameters : " + processinstanceid);
            LOGGER.debug("Exiting getCaseHistoryTrino Method in " + TasksServiceImpl.class
                    + " class with response  : case history ");
            return ResponseEntity.ok(finalResponse);
        }

        ArrayList<Map> finalResponse = new ArrayList<>();
        return ResponseEntity.ok(finalResponse);
    }

    public ResponseEntity<?> getFormVariable(String taskid, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getFormVariable");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            ResponseEntity<String> clientResponse = null;
            try {
                clientResponse = camundaService.getFormVariable(taskid, loggedInUser);
            } catch (Exception e) {

                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(taskid));
                activityLogService.addActivity(loggedInUser, "failed to get form variable", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            // String response = clientResponse.bodyToMono(String.class).block();
            String response = clientResponse.getBody();
            // clientResponse.releaseBody();
            if (clientResponse.getStatusCode() == HttpStatus.OK) {
                activityLogService.addActivity(loggedInUser, "form variables accessed", "parameters : " + taskid);
                LOGGER.debug("Exiting getFormVariable Method in " + TasksServiceImpl.class
                        + " class with response  : with form variable response ");
                return ResponseEntity.ok(response);
            } else {
                activityLogService.addActivity(loggedInUser, "failed to get form variable", "Parameters : " + taskid);
                LOGGER.error("Exiting getFormVariable Method in " + TasksServiceImpl.class + " class with response  : "
                        + response);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, response),
                        clientResponse.getStatusCode());
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get form variable");
            LOGGER.debug("Exiting getFormVariable Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get form variable");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get form variable"),
                    HttpStatus.FORBIDDEN);
        }

    }

    public ResponseEntity<?> getRenderedForm(String taskid, Boolean closed, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getRenderedForm");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            if (closed == false) {
                ResponseEntity<String> clientResponse = null;
                // ClientResponse formVariable = null;
                ResponseEntity<String> deployedForm = null;

                ResponseEntity<String> formVariable = null;
                try {
                    clientResponse = camundaService.getRenderedForm(taskid, loggedInUser);
                    formVariable = camundaService.getFormVariableNew(taskid, loggedInUser);
                    deployedForm = camundaService.getDeployed(taskid, loggedInUser);
                } catch (Exception e) {

                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(taskid));
                    activityLogService.addActivity(loggedInUser, "failed to get rendered form", e.toString());
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                String response = null;
                if (clientResponse.getStatusCode() == HttpStatus.OK) {
                    // response = clientResponse.bodyToMono(String.class).block();
                    response = clientResponse.getBody();
                } else if (deployedForm.getStatusCode() == HttpStatus.OK) {
                    // response = deployedForm.bodyToMono(String.class).block();
                    response = deployedForm.getBody();
                }
                // clientResponse.releaseBody();
                // deployedForm.releaseBody();
                String formVariableResponse = formVariable.getBody();

                if ((clientResponse.getStatusCode() == HttpStatus.OK || deployedForm.getStatusCode() == HttpStatus.OK)
                        && formVariable.getStatusCode() == HttpStatus.OK) {

                    try {

                        Object obj = JSONValue.parse(formVariableResponse);
                        JSONObject formVariableResponseJson = (JSONObject) obj;

                        LinkedHashMap<String, JSONObject> responseMap = new LinkedHashMap<>();

                        Document html = Jsoup.parse(response);

                        Elements form = html.getElementsByClass("form-group");

                        for (Element element : form) {

                            if (element.select("input[type=checkbox]").size() > 0) {

                                String checkboxid = null;
                                if (element.select("input").attr("name") != null) {
                                    checkboxid = element.select("input").attr("name");
                                } else {
                                    checkboxid = element.select("input").attr("id");
                                }
                                String labelText = element.select("label").text();
                                JSONObject checkbox = null;
                                if (formVariableResponseJson.get(checkboxid) != null) {
                                    checkbox = (JSONObject) formVariableResponseJson.get(checkboxid);
                                } else {
                                    checkbox = new JSONObject();
                                    checkbox.put("value", null);
                                    checkbox.put("type", "boolean");
                                }

                                checkbox.put("label", labelText);
                                checkbox.put("inputType", "checkbox");
                                checkbox.put("required", element.select("input[required]").size() > 0 ? true : false);
                                checkbox.put("readonly", element.select("input[readonly]").size() > 0
                                        || element.select("input[disabled]").size() > 0 ? true : false);

                                responseMap.put(checkboxid, checkbox);
                            }
                            if (element.select("select").size() > 0) {
                                String radiobuttonid = null;
                                if (element.select("select").attr("name") != null) {
                                    radiobuttonid = element.select("select").attr("name");
                                } else {
                                    radiobuttonid = element.select("select").attr("id");
                                }
                                String labelText = element.select("label").text();
                                JSONObject radioButton = (JSONObject) formVariableResponseJson.get(radiobuttonid);

                                if (radioButton != null) {
                                    radioButton.put("label", labelText);
                                    radioButton.put("required",
                                            element.select("select[required]").size() > 0 ? true : false);
                                    radioButton.put("readonly", element.select("select[readonly]").size() > 0
                                            || element.select("select[disabled]").size() > 0 ? true : false);
                                    List<JSONObject> optionsList = new ArrayList<>();
                                    Elements options = element.select("option");

                                    if (options.size() < 3) {
                                        radioButton.put("inputType", "radiobutton");
                                    } else {
                                        radioButton.put("inputType", "select");
                                    }

                                    for (Element e : options) {

                                        Object tempString = JSONValue.parse("{}");
                                        JSONObject temp = (JSONObject) tempString;
                                        temp.put("label", e.select("option").text());
                                        temp.put("value", e.select("option").attr("value"));
                                        optionsList.add(temp);
                                    }
                                    radioButton.put("availableValue", optionsList);

                                    responseMap.put(radiobuttonid, radioButton);
                                } else {
                                    radioButton = new JSONObject();
                                    radioButton.put("value", null);
                                    radioButton.put("type", "String");
                                    radioButton.put("required",
                                            element.select("select[required]").size() > 0 ? true : false);
                                    radioButton.put("readonly", element.select("select[readonly]").size() > 0
                                            || element.select("select[disabled]").size() > 0 ? true : false);
                                    List<JSONObject> optionsList = new ArrayList<>();
                                    Elements options = element.select("option");

                                    if (options.size() < 3) {
                                        radioButton.put("inputType", "radiobutton");
                                    } else {
                                        radioButton.put("inputType", "select");
                                    }

                                    for (Element e : options) {

                                        Object tempString = JSONValue.parse("{}");
                                        JSONObject temp = (JSONObject) tempString;
                                        temp.put("label", e.select("option").text());
                                        temp.put("value", e.select("option").attr("value"));
                                        optionsList.add(temp);
                                    }
                                    radioButton.put("availableValue", optionsList);

                                    responseMap.put(radiobuttonid, radioButton);
                                }

                            }
                            if (element.select("input[type=text]").size() > 0) {

                                String inputfieldid = null;
                                if (element.select("input").attr("name") != null) {
                                    inputfieldid = element.select("input").attr("name");
                                } else {
                                    inputfieldid = element.select("input").attr("id");
                                }
                                // String labelText = element.select("label").text();
                                JSONObject input = null;
                                if (formVariableResponseJson.get(inputfieldid) != null) {
                                    input = (JSONObject) formVariableResponseJson.get(inputfieldid);
                                } else {
                                    input = new JSONObject();
                                    input.put("value", "");
                                    input.put("type", "String");
                                }

                                input.put("label", element.select("label").text());
                                input.put("inputType", "inputfield");
                                input.put("variabletype",
                                        element.select("input").attr("uib-datepicker-popup").equals("dd/MM/yyyy")
                                                ? "date"
                                                : element.select("input").attr("cam-variable-type"));
                                input.put("required", element.select("input[required]").size() > 0 ? true : false);
                                input.put("readonly", element.select("input[readonly]").size() > 0
                                        || element.select("input[disabled]").size() > 0 ? true : false);

                                // if(element.select("input").attr("uib-datepicker-popup").equals("dd/MM/yyyy")){
                                // input.put("type", "date");
                                // }

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

                                if (!responseMap.containsKey(formVariableResponseJson.get("Transaction"))) {
                                    responseMap.put("Transaction",
                                            (JSONObject) formVariableResponseJson.get("Transaction"));
                                }

                                if (!responseMap.containsKey(formVariableResponseJson.get("RiskScore"))) {
                                    responseMap.put("RiskScore",
                                            (JSONObject) formVariableResponseJson.get("RiskScore"));
                                }

                                if (formVariableResponseJson.get("holdedtransactions") != null) {
                                    JSONObject holdedTransaction = (JSONObject) formVariableResponseJson
                                            .get("holdedtransactions");

                                    org.json.JSONObject copyTrans = new org.json.JSONObject(
                                            holdedTransaction.toString());
                                    copyTrans.remove("valueInfo");

                                    JSONArray values;
                                    try {
                                         values = new JSONArray(
                                                copyTrans.get("value").toString());
                                    }
                                    catch (Exception e )
                                    {
                                        LOGGER.info(  "failed to parse holded txn json" + copyTrans.get("value").toString());
                                        values = new JSONArray();
                                    }

                                    JSONArray valueNew = new JSONArray();
                                    for (int k = 0; k < values.length(); k++) {
                                        valueNew.put(new org.json.JSONObject(values.get(k).toString()));
                                    }
                                    copyTrans.put("value", valueNew);

                                    responseMap.put("holdedtransactions", new JSONObject(copyTrans.toMap()));
                                }
                                responseMap.put(inputfieldid, input);
                            }

                        }
                        formVariableResponse = null;
                        activityLogService.addActivity(loggedInUser, "rendered form accessed",
                                "parameters : " + taskid);
                        return ResponseEntity.ok(responseMap);
                    } catch (Exception e) {
                        LOGGER.error(loggerEncoderUtil
                                .encode("Error : " + e + "\nParam : " + response + " " + formVariableResponse));
                        activityLogService.addActivity(loggedInUser, "failed to get rendered form", e.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                } else {
                    if (formVariable.getStatusCode() == HttpStatus.OK) {
                        return ResponseEntity.ok(formVariableResponse);
                    }
                    if (clientResponse.getStatusCode() != HttpStatus.OK) {

                        // response = clientResponse.bodyToMono(String.class).block();
                        response = clientResponse.getBody();
                        org.json.JSONObject responseobj = new org.json.JSONObject(response);
                        String msg = responseobj.optString("message");
                        HttpStatusCode status = HttpStatusCode.valueOf(400);
                        if (msg.contains("Task '" + taskid + "' not found: task is null")) {
                            msg = "Task already closed";
                            LOGGER.info("Exiting getRenderedForm Method in " + TasksServiceImpl.class
                                    + " class with response  : " + response);
                        } else {
                            msg = response;
                            status = clientResponse.getStatusCode();
                            LOGGER.error("Exiting getRenderedForm Method in " + TasksServiceImpl.class
                                    + " class with response  : " + response);
                        }

                        activityLogService.addActivity(loggedInUser, "failed to get rendered form",
                                "Parameters : " + taskid);
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, msg),
                                status);
                    } else {
                        activityLogService.addActivity(loggedInUser, "failed to get rendered form",
                                "Parameters : " + taskid);
                        LOGGER.error("Exiting getRenderedForm Method in " + TasksServiceImpl.class
                                + " class with response  : " + response);
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, formVariableResponse),
                                formVariable.getStatusCode());
                    }
                }

            } else {
                List<String> instaceId = new ArrayList<>();
                instaceId.add(taskid);
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

                String processInJson = "{\n  \"processInstanceIdIn\":" + json
                        + ",\r\n    \"variableNameIn\":[\"Transaction\",\"RiskScore\", \"TransactionType\"]\r\n    \r\n   \r\n}";

                ResponseEntity<String> details = null;

                if (instaceId.size() != 0) {
                    try {
                        details = camundaService.postHistoryVarInstance(processInJson, loggedInUser);
                    } catch (Exception e) {
                        LOGGER.error("Error : " + e + "\nParam : " + processInJson);
                        activityLogService.addActivity(loggedInUser, "failed to get details",
                                "Error : " + e.toString() + ", Parameters : " + processInJson);
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                }
                // System.out.println(details.getBody());

                org.json.JSONObject responObj = new org.json.JSONObject();

                if (details != null) {
                    if (details.getStatusCode() == HttpStatus.OK) {
                        JSONArray detailList = new JSONArray(details.getBody());

                        for (int i = 0; i < detailList.length(); i++) {
                            org.json.JSONObject valueObj = new org.json.JSONObject();
                            if (detailList.getJSONObject(i).getString("name")
                                    .equals("Transaction")) {
                                responObj.put("Transaction",
                                        valueObj.put("value", detailList.getJSONObject(i).get("value")));
                            }

                            if (detailList.getJSONObject(i).getString("name")
                                    .equals("TransactionType")) {
                                responObj.put("TransactionType",
                                        valueObj.put("value", detailList.getJSONObject(i).get("value")));
                            }

                            if (detailList.getJSONObject(i).getString("name")
                                    .equals("RiskScore")) {
                                responObj.put("RiskScore",
                                        valueObj.put("value", detailList.getJSONObject(i).get("value")));
                            }

                        }

                    }
                }

                activityLogService.addActivity(loggedInUser, "rendered form accessed",
                        "parameters : " + taskid);
                return ResponseEntity.ok(responObj.toMap());

            }

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get rendered form");
            LOGGER.debug("Exiting getRenderedForm Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get form variable");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get rendered form"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> submitForm(String taskid, String processInstanceId, String body, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method submitForm");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            ResponseEntity<String> clientResponse = null;

            try {
                clientResponse = camundaService.submitForm(taskid, processInstanceId, body, loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(taskid));
                activityLogService.addActivity(loggedInUser, "failed to get rendered form",
                        "Error : " + e.toString() + ", Parameters : " + taskid);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            // String response = clientResponse.bodyToMono(String.class).block();
            String response = clientResponse.getBody();
            // clientResponse.releaseBody();
            if (clientResponse.getStatusCode() == HttpStatus.NO_CONTENT) {

                activityLogService.addActivity(loggedInUser, "camunda task submitted successfully",
                        "parameters : " + taskid);
                LOGGER.debug("Exiting submitForm Method in " + TasksServiceImpl.class
                        + " class with response  : task submitted successfully");
                return new ResponseEntity<ApiResponse>(new ApiResponse(true, "task submitted successfully"),
                        HttpStatus.NO_CONTENT);
            } else if (response.contains("Cannot find task with id")) {
                activityLogService.addActivity(loggedInUser, "task already submitted", "Parameters : " + taskid);
                LOGGER.info("Exiting submitForm Method in " + TasksServiceImpl.class + " class with response  : "
                        + response);
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Task does not exist. Please confirm if task is already not closed"),
                        HttpStatus.BAD_REQUEST);
            } else {
                activityLogService.addActivity(loggedInUser, "failed to submit form", "Parameters : " + taskid);
                LOGGER.error("Exiting submitForm Method in " + TasksServiceImpl.class + " class with response  : "
                        + response);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, response),
                        clientResponse.getStatusCode());
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to submit form");
            LOGGER.debug("Exiting submitForm Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to submit form");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to submit form"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> addComment(AddCommentGt addCommentGt, Authentication pr) {

        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method addComment");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            ResponseEntity<String> clientResponse = null;

            if (addCommentGt.getMessage().isEmpty() || addCommentGt.getMessage().isBlank()) {
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Comment cannot be empty"),
                        HttpStatus.BAD_REQUEST);
            }

            try {
                AddComment addComment = new AddComment();
                addComment.setTaskid(addCommentGt.getTaskid());
                addComment.setProcessInstanceId(addCommentGt.getProcessInstanceId());
                addComment.setMessage(addCommentGt.getMessage());
                clientResponse = camundaService.addComment(addComment, loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(addCommentGt.toString()));
                activityLogService.addActivity(loggedInUser, "failed to add comment",
                        "Error : " + e.toString() + ", Parameters : " + addCommentGt);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            // String response = clientResponse.bodyToMono(String.class).block();
            String response = clientResponse.getBody();
            // clientResponse.releaseBody();
            if (clientResponse.getStatusCode() == HttpStatus.OK) {
                activityLogService.addActivity(loggedInUser, "comments list accessed", "parameters : " + addCommentGt);
                LOGGER.debug("Exiting addComment Method in " + TasksServiceImpl.class
                        + " class with response  : comment added successfully");
                return ResponseEntity.ok(response);
            } else if (clientResponse.getStatusCode() == HttpStatus.BAD_REQUEST) {
                org.json.JSONObject responseobj = new org.json.JSONObject(response);
                String msg = responseobj.optString("message");
                HttpStatusCode status= HttpStatusCode.valueOf(400);
                if (msg.contains("No task found for task id " + addCommentGt.getTaskid())) {
                    msg = "Task does not exist. Please confirm if task is already not closed";
                    LOGGER.info(loggerEncoderUtil
                            .encode("Exiting addComment Method in " + TasksServiceImpl.class
                                    + " class with response  : "
                                    + response));
                } else {
                    msg = response;
                    status = clientResponse.getStatusCode();
                    LOGGER.error(loggerEncoderUtil
                            .encode("Exiting addComment Method in " + TasksServiceImpl.class
                                    + " class with response  : "
                                    + response));
                    LOGGER.info("Parameters : " + addCommentGt);
                }
                activityLogService.addActivity(loggedInUser, "failed to add comment", "Parameters : " + addCommentGt);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, msg), status);
            }
            activityLogService.addActivity(loggedInUser, "failed to add comment", "Parameters : " + addCommentGt);
            LOGGER.error(loggerEncoderUtil
                    .encode("Exiting addComment Method in " + TasksServiceImpl.class + " class with response  : "
                            + response));
            LOGGER.info("Parameters : " + addCommentGt.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, response), clientResponse.getStatusCode());

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to add comment");
            LOGGER.debug("Exiting addComment Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to add comment");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to add comment"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> addA(
            MultipartFile file,
            String id,
            String attachmentName,
            String attachmentDescription,
            String attachmentType,
            String url,
            Authentication pr) {

        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method addA");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            if (file.getOriginalFilename().startsWith(".")) {
                activityLogService.addActivity(loggedInUser, "failed to upload document ");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Invalid file ,file name cannot start with '.'"),
                        HttpStatus.UNSUPPORTED_MEDIA_TYPE);
            }

            if (!env.getProperty("casemanagement.file.formats").contains(file.getContentType())) {
                activityLogService.addActivity(loggedInUser, "Failed to upload file", file.getContentType());
                LOGGER.debug("exiting  class " + TasksServiceImpl.class
                        + " and method getTaskList with response : Failed to upload file");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "File format is not supported"),
                        HttpStatus.BAD_REQUEST);
            }

            ResponseEntity<String> clientResponse = null;
            try {
                clientResponse = camundaService.addAttachment(
                        file,
                        id,
                        attachmentName,
                        attachmentDescription,
                        attachmentType,
                        url,
                        loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParameters : id : " + loggerEncoderUtil.encode(id)
                        + "attachment name : " + loggerEncoderUtil.encode(attachmentName)
                        + "Attachment Description : " + loggerEncoderUtil.encode(attachmentDescription)
                        + "Attachment Type : " + loggerEncoderUtil.encode(attachmentType)
                        + "url : " + loggerEncoderUtil.encode(url));
                activityLogService.addActivity(loggedInUser, "failed to add comment",
                        "Error : " + e.toString() + "\nParameters : id : " + id
                                + "attachment name : " + attachmentName
                                + "Attachment Description : " + attachmentDescription
                                + "Attachment Type : " + attachmentType
                                + "url : " + url);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);

            }

            // String response = clientResponse.bodyToMono(String.class).block();
            String response = clientResponse.getBody();
            // clientResponse.releaseBody();
            if (clientResponse.getStatusCode() == HttpStatus.OK) {
                activityLogService.addActivity(loggedInUser, "attachment added", " Parameters : id : " + id
                        + "attachment name : " + attachmentName
                        + "Attachment Description : " + attachmentDescription
                        + "Attachment Type : " + attachmentType
                        + "url : " + url);

                LOGGER.debug("Exiting addA Method in " + TasksServiceImpl.class
                        + " class with response : attachment added successfully");
                return ResponseEntity.ok(response);
            } else {
                activityLogService.addActivity(loggedInUser, "failed to add attachment", " Parameters : id : " + id
                        + "attachment name : " + attachmentName
                        + "Attachment Description : " + attachmentDescription
                        + "Attachment Type : " + attachmentType
                        + "url : " + url);
                LOGGER.error("Error : " + response + " Parameters : id : " + loggerEncoderUtil.encode(id)
                        + "attachment name : " + loggerEncoderUtil.encode(attachmentName)
                        + "Attachment Description : " + loggerEncoderUtil.encode(attachmentDescription)
                        + "Attachment Type : " + loggerEncoderUtil.encode(attachmentType)
                        + "url : " + loggerEncoderUtil.encode(url));

                LOGGER.debug("Exiting addA Method in " + TasksServiceImpl.class + " class with response : " + response);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, response),
                        clientResponse.getStatusCode());
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to add attachment");
            LOGGER.debug("Exiting addA Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to add attachment");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to add attachment"),
                    HttpStatus.FORBIDDEN);
        }

    }

    public ResponseEntity<?> getAttachment(String processinstanceid, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getAttachment");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            ResponseEntity<String> clientResponse = null;
            try {
                clientResponse = camundaService.getActivityInstance(
                        "sortBy=startTime&sortOrder=desc&processInstanceId=" + processinstanceid
                                + "&activityType=userTask",
                        loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(processinstanceid));
                activityLogService.addActivity(loggedInUser, "failed to add comment",
                        "Error : " + e.toString() + ", Parameters : " + processinstanceid);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            String response = clientResponse.getBody();

            if (clientResponse.getStatusCode() == HttpStatus.OK) {
                JSONArray jsonArray = new JSONArray(response);
                JSONArray jsonArrayResponse = new JSONArray("[]");
                for (int i = 0, size = jsonArray.length(); i < size; i++) {
                    org.json.JSONObject objectInArray = jsonArray.getJSONObject(i);
                    ResponseEntity<String> attachmentList = null;
                    try {
                        attachmentList = camundaService.getAttachment((String) objectInArray.get("taskId"),
                                loggedInUser);
                    } catch (Exception e) {
                        LOGGER.error(loggerEncoderUtil
                                .encode("Error : " + e + "\nParam : task id-" + (String) objectInArray.get("taskId")));
                        activityLogService.addActivity(loggedInUser, "failed to add comment", "Error : " + e.toString()
                                + ", Parameters : task id-" + (String) objectInArray.get("taskId"));
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                    // String attachmentListString =
                    // attachmentList.bodyToMono(String.class).block();
                    String attachmentListString = attachmentList.getBody();
                    // attachmentList.releaseBody();
                    JSONArray attachmentListJson = new JSONArray(attachmentListString);
                    if (attachmentList.getStatusCode() == HttpStatus.OK) {
                        for (int x = attachmentListJson.length() - 1; x >= 0; x--) {
                            jsonArrayResponse.put(attachmentListJson.getJSONObject(x));
                        }
                    } else {
                        activityLogService.addActivity(loggedInUser, "failed to add comment",
                                "Parameters : " + (String) objectInArray.get("taskId"));
                        LOGGER.debug("Exiting getAttachment Method in " + TasksServiceImpl.class
                                + " class with response  :" + attachmentListString);
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, attachmentListString),
                                attachmentList.getStatusCode());
                    }
                }
                activityLogService.addActivity(loggedInUser, "list of attachment accessed successfully",
                        "parameters : " + processinstanceid);
                LOGGER.debug("Exiting getAttachment Method in " + TasksServiceImpl.class
                        + " class with response  : attachments list");
                return ResponseEntity.ok(jsonArrayResponse.toString());
            } else {
                activityLogService.addActivity(loggedInUser, "failed to get list of attachment",
                        "Parameters : " + processinstanceid);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, response),
                        clientResponse.getStatusCode());
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get list of attachments");
            LOGGER.debug("Exiting getAttachment Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get list of attachments");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get list of attachments"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> getUserOperation(String taskid, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getUserOperation");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            ResponseEntity<String> clientResponse = null;
            try {
                clientResponse = camundaService.getUserOperation(taskid, loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : task id-" + loggerEncoderUtil.encode(taskid));
                activityLogService.addActivity(loggedInUser, "failed to add comment",
                        "Error : " + e.toString() + ", Parameters : task id-" + taskid);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            // String response = clientResponse.bodyToMono(String.class).block();
            String response = clientResponse.getBody();
            // clientResponse.releaseBody();
            if (clientResponse.getStatusCode() == HttpStatus.OK) {
                activityLogService.addActivity(loggedInUser, "list of user operation accessed successfully",
                        "parameters : " + taskid);
                LOGGER.debug("Exiting getUserOperation Method in " + TasksServiceImpl.class
                        + " class with response  : unauthorized to get list of attachments");
                return ResponseEntity.ok(response);
            } else {
                activityLogService.addActivity(loggedInUser, "failed to get list of user operation",
                        "Parameters : " + taskid);
                LOGGER.error("Exiting getUserOperation Method in " + TasksServiceImpl.class + " class with response  : "
                        + response);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, response),
                        clientResponse.getStatusCode());
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get list user operations");
            LOGGER.debug("Exiting getUserOperation Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get list user operations");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get list user operations"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> downloadAttachment(String taskid, String attachmentid, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method downloadAttachment");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            URLChecker urlChecker = new URLChecker();

            if (urlChecker.isURL(attachmentid)) {
                activityLogService.addActivity(loggedInUser, "failed to download attachment attachment id is url");
                LOGGER.debug("Exiting downloadAttachment Method in " + TasksServiceImpl.class
                        + " class with response  : failed to download attachment attachment id is url");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "failed to download attachment attachment id is url"),
                        HttpStatus.BAD_REQUEST);
            }

            if (urlChecker.isURL(taskid)) {

                activityLogService.addActivity(loggedInUser, "failed to download attachment task id is url");
                LOGGER.debug("Exiting downloadAttachment Method in " + TasksServiceImpl.class
                        + " class with response  : failed to download attachment task id is url");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "failed to download attachment task id is url"),
                        HttpStatus.BAD_REQUEST);
            }

            Resource resource = null;
            try {
                resource = camundaService.downloadAttachmentFromInputStream(taskid, attachmentid, loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(taskid));
                activityLogService.addActivity(loggedInUser, "failed to download attachment",
                        "Error : " + e.toString() + ", Parameters : " + taskid);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            activityLogService.addActivity(loggedInUser, "attachment downloaded successfully",
                    "parameters : " + taskid);
            LOGGER.debug("Exiting downloadAttachment Method in " + TasksServiceImpl.class
                    + " class with response  : attachment downloaded successfully");
            return ResponseEntity.ok().contentType(MediaType.parseMediaType("application/octet-stream"))
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
                    .body(resource);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to download attachment");
            LOGGER.debug("Exiting downloadAttachment Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to download attachment");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to download attachment"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> getActivityInstance(String parameters, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getActivityInstance");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            ResponseEntity<String> clientResponse = null;
            try {
                clientResponse = camundaService.getActivityInstance(parameters, loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(parameters));
                activityLogService.addActivity(loggedInUser, "failed to get activity instance",
                        "Error : " + e.toString() + ", Parameters : " + parameters);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            String responses = clientResponse.getBody();

            if (clientResponse.getStatusCode() == HttpStatus.OK) {
                activityLogService.addActivity(loggedInUser, "activity instance accessed successfully",
                        "parameters : " + parameters);
                LOGGER.debug("Exiting getActivityInstance Method in " + TasksServiceImpl.class
                        + " class with response  : activity instance list");
                return ResponseEntity.ok(responses);
            } else {
                activityLogService.addActivity(loggedInUser, "failed to get activity instance",
                        "Parameters : " + parameters);
                LOGGER.error("Exiting getActivityInstance Method in " + TasksServiceImpl.class
                        + " class with response  : " + responses);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, responses),
                        clientResponse.getStatusCode());
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get activity instance");
            LOGGER.debug("Exiting getActivityInstance Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get activity instance");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get activity instance"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> getVariableName(String taskid, String variabledata, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getVariableName");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            ResponseEntity<String> clientResponse = null;
            try {
                clientResponse = camundaService.getVariableData(taskid, variabledata, loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : task id-" + loggerEncoderUtil.encode(taskid));
                activityLogService.addActivity(loggedInUser, "failed to get variable name",
                        "Error : " + e.toString() + ", Parameters : task id -" + taskid);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (clientResponse.getStatusCode() == HttpStatus.OK) {
                // Object responses = clientResponse.bodyToMono(Object.class).block();
                String responses = clientResponse.getBody();
                // clientResponse.releaseBody();
                activityLogService.addActivity(loggedInUser, "variable name retrieved successfully",
                        "parameters : " + taskid);
                LOGGER.debug("Exiting getVariableName Method in " + TasksServiceImpl.class
                        + " class with response  : variable name");
                return ResponseEntity.ok(responses);
            } else {

                // String responses = clientResponse.bodyToMono(String.class).block();
                String responses = clientResponse.getBody();
                // clientResponse.releaseBody();
                activityLogService.addActivity(loggedInUser, "failed to get task attachment", "Parameters : " + taskid);
                LOGGER.error(
                        "Exiting getVariableName Method in " + TasksServiceImpl.class + " class with response  : "
                                + responses);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, responses),
                        clientResponse.getStatusCode());
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get variable name");
            LOGGER.debug("Exiting getActivityInstance Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get variable name");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get variable name"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> getTaskHistory(String taskid, Authentication pr) {

        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getTaskHistory");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            ResponseEntity<String> clientResponse = null;
            try {
                clientResponse = camundaService.getTaskHistory(taskid, loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : task id-" + loggerEncoderUtil.encode(taskid));
                activityLogService.addActivity(loggedInUser, "failed to get task history",
                        "Error : " + e.toString() + ", Parameters : task id -" + taskid);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            // String responses = clientResponse.bodyToMono(String.class).block();
            String responses = clientResponse.getBody();
            // clientResponse.releaseBody();
            if (clientResponse.getStatusCode() == HttpStatus.OK) {
                activityLogService.addActivity(loggedInUser, "task history accessed successfully",
                        "parameters : " + taskid);
                LOGGER.debug("Exiting getVariableName Method in " + TasksServiceImpl.class
                        + " class with response  : task history");
                return ResponseEntity.ok(responses);
            } else {
                activityLogService.addActivity(loggedInUser, "failed to get task history", "Parameters : " + taskid);
                LOGGER.debug(
                        "Exiting getVariableName Method in " + TasksServiceImpl.class + " class with response  : "
                                + responses);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, responses),
                        clientResponse.getStatusCode());
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get task history");
            LOGGER.debug("Exiting getActivityInstance Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get task history");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get task history"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getWorkFlowName(Authentication pr) {

        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getWorkFlowName");

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
                activityLogService.addActivity(loggedInUser, "failed to get workflow name", "Error : " + e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            // String responses = clientResponse.bodyToMono(String.class).block();
            String responses = clientResponse.getBody();
            // clientResponse.releaseBody();
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
                    LOGGER.error("Error : " + e + "\nParam : " + responses);
                    activityLogService.addActivity(loggedInUser, "failed to get task history",
                            "Error : " + e.toString() + ", Parameters : " + responses);
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                LOGGER.debug("Exiting getWorkFlowName Method in " + TasksServiceImpl.class
                        + " class with response : workflow names");
                return ResponseEntity.ok(workFlowDropDown);
            } else {
                activityLogService.addActivity(loggedInUser, "unauthorized to get workflow names");
                LOGGER.debug("Exiting getWorkFlowName Method in " + TasksServiceImpl.class
                        + " class with response : unauthorized to get workflow names");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get workflow names"),
                        HttpStatus.FORBIDDEN);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get payee name");
            LOGGER.debug("Exiting getPayeeNames Method in " + TasksServiceImpl.class
                    + " class with response : unauthorized to get payee name");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get payee name"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getPayeeNames(String type, Authentication pr) {

        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getPayeeNames");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            try {
                List<DropdownWithObject> responses = null;
                if (type.equalsIgnoreCase("payer")) {
                    responses = DropdownWithObjectMapper.parseVpaFromVpa(vpaService.findAll());
                } else if (type.equalsIgnoreCase("payee")) {
                    responses = DropdownWithObjectMapper.parseVpaFromVpa(vpaService.findAll());
                }
                activityLogService.addActivity(loggedInUser, "vpa dropdown accessed",
                        "Parameters : " + responses.toString());
                return ResponseEntity.ok(responses);
            } catch (Exception e) {

                LOGGER.error("Error : " + e.toString());
                activityLogService.addActivity(loggedInUser, "failed to access vpa dropdown accessed",
                        "Error : " + e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get payee name");
            LOGGER.debug("Exiting getPayeeNames Method in " + TasksServiceImpl.class
                    + " class with response : unauthorized to get payee name");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get payee name"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getPayerNames(String type, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getPayerNames");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            try {
                List<DropdownWithObject> responses = null;
                if (type.equalsIgnoreCase("payer")) {
                    responses = DropdownWithObjectMapper.parseVpaFromVpa(vpaService.findAll());
                } else if (type.equalsIgnoreCase("payee")) {
                    responses = DropdownWithObjectMapper.parseVpaFromVpa(vpaService.findAll());
                }
                activityLogService.addActivity(loggedInUser, "vpa dropdown accessed",
                        "Parameters : " + responses.toString());
                return ResponseEntity.ok(responses);
            } catch (Exception e) {

                LOGGER.error("Error : " + e.toString());
                activityLogService.addActivity(loggedInUser, "failed to access vpa dropdown accessed",
                        "Error : " + e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get payer name");
            LOGGER.debug("Exiting getPayerNames Method in " + TasksServiceImpl.class
                    + " class with response : unauthorized to get payer name");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get payer name"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getStatusDropDown(GetTaskListRequestGt getTaskListRequest, Integer tenantid,
                                               String workflowKey, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getStatusDropDown");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            ResponseEntity<String> clientResponseWorkflow = null;
            try {
                clientResponseWorkflow = camundaService.getWorkFlowNameAllDeployed(loggedInUser, workflowKey, tenantid);

            } catch (Exception e) {
                LOGGER.error("Error : " + e);
                activityLogService.addActivity(loggedInUser, "failed to get workflow name",
                        "Error : " + e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            // String responses = clientResponseWorkflow.bodyToMono(String.class).block();
            // clientResponseWorkflow.releaseBody();
            String responses = clientResponseWorkflow.getBody();
            // System.out.println(responses);
            // ClientResponse clientResponse = null;
            // try {
            // clientResponse = camundaService.getTaskListPost(getTaskListRequest,
            // loggedInUser);
            // } catch (Exception e) {
            // LOGGER.error("Error : " + e + "\nParam : " + getTaskListRequest.toString());
            // activityLogService.addActivity(loggedInUser, "failed to status drop down",
            // "Error : " + e.toString() + ", Parameters : "
            // +getTaskListRequest.toString());
            // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
            // ResponseMessages.GenericErrorMessage),
            // HttpStatus.INTERNAL_SERVER_ERROR);

            // }

            // String response = clientResponse.bodyToMono(String.class).block();

            if (clientResponseWorkflow.getStatusCode() == HttpStatus.OK) {

                JSONArray taskList = new JSONArray(responses);
                List<DropdownWithObject> statusDropDown = new ArrayList<>();
                try {
                    for (int i = 0; i < taskList.length(); i++) {
                        org.json.JSONObject taskListInstance = taskList.getJSONObject(i);
                        ResponseEntity<String> bpmnXml = null;
                        try {
                            // System.out.println(taskListInstance.getString("id"));
                            bpmnXml = camundaService.getBPMN(taskListInstance.getString("id"),
                                    loggedInUser);
                        } catch (Exception e) {

                            LOGGER.error(
                                    "Error : " + e + "\nParam : "
                                            + loggerEncoderUtil
                                            .encode(taskListInstance.getString("processDefinitionId")));
                            activityLogService.addActivity(loggedInUser, "failed to status drop down",
                                    "Error : " + e.toString() + ", Parameters : "
                                            + taskListInstance.getString("processDefinitionId"));
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                        String bpmnResponse = bpmnXml.getBody();

                        ObjectMapper mapper1 = new ObjectMapper();

                        try {

                            // JsonNode rootNode = mapper1.readTree(bpmnResponse);

                            // DocumentBuilder builder =
                            // DocumentBuilderFactory.newInstance().newDocumentBuilder();
                            // InputSource src = new InputSource();
                            // src.setCharacterStream(new StringReader(rootNode.get("bpmn20Xml").asText()));

                            // org.w3c.dom.Document doc = builder.parse(src);
                            JsonNode rootNode = mapper1.readTree(bpmnResponse);

                            org.w3c.dom.Document doc = xmlParser.XMLParser(rootNode.get("bpmn20Xml").asText());
                            NodeList userTasklist = doc.getElementsByTagName("bpmn:userTask");

                            if (userTasklist.getLength() > maxFieldLength) {
                                LOGGER.info("\nParam : " + loggerEncoderUtil.encode(taskListInstance.getString("id")));
                                activityLogService.addActivity(loggedInUser,
                                        "failed to get xml parametes length more then  " + maxFieldLength,
                                        taskListInstance.getString("id"));
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, "No of fields should not exceed " + maxFieldLength),
                                        HttpStatus.BAD_REQUEST);
                            }
                            for (int j = 0; j < doc.getElementsByTagName("bpmn:userTask").getLength(); j++) {
                                String label = doc.getElementsByTagName("bpmn:userTask").item(j).getAttributes()
                                        .getNamedItem("name")
                                        .getNodeValue();
                                String id = doc.getElementsByTagName("bpmn:userTask").item(j).getAttributes()
                                        .getNamedItem("id")
                                        .getNodeValue();
                                System.out.println("label " + label + " id " + id);
                                if (statusDropDown.stream().filter(c -> c.getLabel()
                                                .equals(label))
                                        .collect(Collectors.toList()).size() == 0) {

                                    DropdownWithObject dropdowns = DropdownWithObject.builder()
                                            .label(doc.getElementsByTagName("bpmn:userTask").item(j).getAttributes()
                                                    .getNamedItem("name")
                                                    .getNodeValue())
                                            .value(id).build();
                                    statusDropDown.add(dropdowns);
                                }
                                // } else {
                                // statusDropDown.forEach((value) -> {
                                // if (value.getLabel().equals(label)) {
                                // // value.getValue().add(id);
                                // }
                                // });
                                // }

                            }
                        } catch (Exception e) {
                            LOGGER.error("Error : " + e + "\nParam : " + bpmnResponse);
                            activityLogService.addActivity(loggedInUser, "failed to status drop down",
                                    "Error : " + e.toString() + ", Parameters : " + bpmnResponse);
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                    }
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(taskList.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to status drop down",
                            "Error : " + e.toString() + ", Parameters : " + taskList);
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                // Set<DropdownWithObject> removeDuplicates = new HashSet<>();
                // removeDuplicates.addAll(statusDropDown);
                // statusDropDown = new ArrayList<DropdownWithObject>();
                // statusDropDown.addAll(removeDuplicates);

                activityLogService.addActivity(loggedInUser, "Task list accessed",
                        "parameters : " + getTaskListRequest.toString());
                LOGGER.debug("Exiting getStatusDropDown Method in " + TasksServiceImpl.class
                        + " class with response : status list");
                return ResponseEntity.ok(statusDropDown);
            } else {
                activityLogService.addActivity(loggedInUser, "failed to access task list",
                        "Parameters : " + getTaskListRequest.toString());
                LOGGER.debug(
                        "Exiting getStatusDropDown Method in " + TasksServiceImpl.class + " class with response : "
                                + responses);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, responses),
                        clientResponseWorkflow.getStatusCode());
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to status drop down");
            LOGGER.debug("Exiting getStatusDropDown Method in " + TasksServiceImpl.class
                    + " class with response : unauthorized to status drop down");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to status drop down"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> getRelatedTickets(String payervpa, String payeevpa, String day, String max,
                                               Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getRelatedTickets");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            Integer days = Integer.parseInt(day);
            ZoneId timeZone = loggedInUser.getTimeZone() != null ? ZoneId.of(loggedInUser.getTimeZone())
                    : ZoneId.systemDefault();
            LocalDateTime startdate = LocalDate.now().minusDays(days).atTime(LocalTime.MIN);
            LocalDateTime enddate = LocalDate.now().atTime(LocalTime.MAX);

            DateTimeFormatter sdf = DateTimeFormatter.ofPattern("YYYY-MM-dd'T'HH:mm:ss.SSSZZ");

            String stext = startdate.atZone(timeZone).format(sdf);
            String etext = enddate.atZone(timeZone).format(sdf);
            ResponseEntity<String> listOfTickets = null;

            // String body = "{\"startedAfter\": \""+stext+"\", \"startedBefore\" :
            // \""+etext+"\"}";
            // String body="{\n \"startedAfter\": \""+stext+"\",\n \"startedBefore\":
            // \""+etext+"\",\n \"variables\": [\n {\n \"name\": \"payee\",\n \"operator\":
            // \"eq\",\n \"value\": \""+payeevpa+"\"\n },\n {\n \"name\": \"payer\",\n
            // \"operator\": \"eq\",\n \"value\": \""+payervpa+"\"\n }\n ]\n}";
            String body = "{\n  \"startedAfter\": \"" + stext + "\",\n  \"startedBefore\": \"" + etext
                    + "\",\n  \"orQueries\": [\n    {\n      \"variables\": [\n        {\n          \"name\": \"payee\",\n          \"operator\": \"eq\",\n          \"value\": \""
                    + payeevpa
                    + "\"\n        },\n        {\n          \"name\": \"payer\",\n          \"operator\": \"eq\",\n          \"value\": \""
                    + payervpa
                    + "\"\n        },\n        {\n          \"name\": \"payee\",\n          \"operator\": \"eq\",\n          \"value\": \""
                    + payervpa
                    + "\"\n        },\n        {\n          \"name\": \"payer\",\n          \"operator\": \"eq\",\n          \"value\": \""
                    + payeevpa + "\"\n        }\n      ]\n    }\n  ]\n}";
            // System.out.println("request body for get all process instance " + body);
            try {
                listOfTickets = camundaService.getAllProcessInstance(body, max, loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(payeevpa) + " "
                        + loggerEncoderUtil.encode(payeevpa));
                activityLogService.addActivity(loggedInUser, "failed to retrive related tickets",
                        "Error : " + e.toString() + ", Parameters : " + payeevpa + " " + payeevpa);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            // String responses = listOfTickets.bodyToMono(String.class).block();
            String responses = listOfTickets.getBody();
            // listOfTickets.releaseBody();
            // System.out.println("response of get all process instance " + responses);

            if (listOfTickets.getStatusCode() == HttpStatus.OK) {

                Map<String, Object> resMap = new TreeMap<>();
                resMap.put("Days", days);

                List<Map<String, Object>> payeeVpa = new LinkedList<>();
                List<Map<String, Object>> payerVpa = new LinkedList<>();

                JSONArray taskArray = new JSONArray(responses);

                List<String> instaceId = new ArrayList<>();

                List<String> activeId = new ArrayList<>();

                for (int w = 0; w < taskArray.length(); w++) {
                    instaceId.add(taskArray.getJSONObject(w).optString("id"));
                    if (taskArray.getJSONObject(w).optString("state").equalsIgnoreCase("ACTIVE")) {
                        activeId.add(taskArray.getJSONObject(w).optString("id"));
                    }
                }

                ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
                String json = null;
                String activeJson = null;
                try {
                    json = ow.writeValueAsString(instaceId);
                    activeJson = ow.writeValueAsString(activeId);
                } catch (JsonProcessingException e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(instaceId.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get details",
                            "Error : " + e.toString() + ", Parameters : " + instaceId);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                String processInJson = "{\n  \"processInstanceIdIn\":" + json + "\n}";
                String activeProcess = "{\n  \"processInstanceIdIn\":" + activeJson + "\n}";

                ResponseEntity<String> details = null;

                if (taskArray.length() != 0) {
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
                }
                GetTaskListRequest getTask = new GetTaskListRequest();
                getTask.setParameters(activeProcess);
                getTask.setMaxResult(Integer.parseInt(max));

                ResponseEntity<String> activeTaskList = null;

                if (activeId.size() != 0) {
                    try {
                        activeTaskList = camundaService.getTaskListPostHttp(getTask, loggedInUser);
                    } catch (Exception e) {
                        LOGGER.error("Error : " + e + "\nParam : " + processInJson);
                        activityLogService.addActivity(loggedInUser, "failed to get active task",
                                "Error : " + e.toString() + ", Parameters : " + processInJson);
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    if (activeTaskList.getStatusCode() != HttpStatus.OK) {
                        LOGGER.error("Error : " + activeTaskList.getBody());
                        activityLogService.addActivity(loggedInUser, "failed to get active task",
                                "Error : " + activeTaskList.getBody());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                }

                JSONArray actTaskResponse = null;
                Map<String, String> activeTaskMap = new HashMap<>();
                if (activeTaskList != null) {

                    actTaskResponse = new JSONArray(activeTaskList.getBody());

                    for (int d = 0; d < actTaskResponse.length(); d++) {
                        activeTaskMap.put(actTaskResponse.getJSONObject(d).getString("processInstanceId"),
                                actTaskResponse.getJSONObject(d).getString("name"));
                    }

                }

                if (details != null) {

                    if (details.getStatusCode() == HttpStatus.OK) {
                        JSONArray detailList = new JSONArray(details.getBody());

                        for (int i = 0; i < taskArray.length(); i++) {
                            org.json.JSONObject taskListInstance = taskArray.getJSONObject(i);

                            // System.out.println("Task list instance " + taskListInstance);

                            for (int j = 0; j < detailList.length(); j++) {
                                if (taskListInstance.get("id")
                                        .equals(detailList.getJSONObject(j).get("processInstanceId"))) {

                                    if (detailList.getJSONObject(j).opt("variableName") != null) {

                                        if (detailList.getJSONObject(j).opt("variableName").equals("Transaction")
                                                && detailList.getJSONObject(j).opt("revision").equals(0)) {
                                            // System.out.println("revision is 0 ");
                                            if (!taskListInstance.getString("processDefinitionKey")
                                                    .equalsIgnoreCase("doubledebit")) {

                                                org.json.JSONObject transaction = null;
                                                try {
                                                    transaction = new org.json.JSONObject(
                                                            detailList.getJSONObject(j).optString("value"));
                                                } catch (JSONException e) {
                                                    try {
                                                        transaction = new org.json.JSONObject(new JSONArray(
                                                                detailList.getJSONObject(j).optString("value"))
                                                                .optString(0));
                                                    } catch (JSONException e2) {

                                                    }

                                                }
                                                if (transaction != null) {

                                                    String payeeString = (String) transaction
                                                            .optQuery("/observations/payeeVPA/externalId");
                                                    String payerString = (String) transaction
                                                            .optQuery("/observations/payerVPA/externalId");
                                                    // System.out.println(payeeString);
                                                    // System.out.println(payerString);
                                                    if (payeeString != null) {
                                                        if (payeeString.equalsIgnoreCase(payeevpa)
                                                                || payerString
                                                                .equalsIgnoreCase(payeevpa)) {
                                                            Map<String, Object> payeeVpaMap = new TreeMap<>();
                                                            payeeVpaMap.put("CreatedTime",
                                                                    taskListInstance.optString("startTime"));
                                                            payeeVpaMap.put("Transaction", transaction.toMap());
                                                            payeeVpaMap.put("proc", taskListInstance.get("id"));

                                                            if (!taskListInstance.optString("state").toString()
                                                                    .equalsIgnoreCase("ACTIVE")) {
                                                                payeeVpaMap.put("State",
                                                                        taskListInstance.optString("state"));
                                                                payeeVpaMap.put("Completed", true);
                                                                // System.out.println(payeeVpaMap);
                                                            } else {

                                                                payeeVpaMap.put("State",
                                                                        activeTaskMap.get(taskListInstance.get("id")));
                                                                payeeVpaMap.put("Completed", false);
                                                            }

                                                            for (int l = 0; l < detailList.length(); l++) {
                                                                if (taskListInstance.get("id")
                                                                        .equals(detailList.getJSONObject(l)
                                                                                .get("processInstanceId"))) {
                                                                    org.json.JSONObject variable2 = detailList
                                                                            .getJSONObject(l);
                                                                    if (variable2.optString("variableName")
                                                                            .equalsIgnoreCase("TicketID")) {
                                                                        payeeVpaMap.put("TicketID",
                                                                                variable2.opt("value"));
                                                                    } else if (variable2.optString("variableName")
                                                                            .equalsIgnoreCase("WorkflowName")) {
                                                                        payeeVpaMap.put("WorkflowName",
                                                                                variable2.opt("value"));
                                                                    } else if (variable2.optString("variableName")
                                                                            .equalsIgnoreCase("RiskScore")) {
                                                                        payeeVpaMap.put("RiskScore",
                                                                                variable2.opt("value"));
                                                                    } else if (variable2.optString("variableName")
                                                                            .equalsIgnoreCase("AvgRiskScore")) {
                                                                        payeeVpaMap.put("AvgRiskScore",
                                                                                variable2.opt("value"));
                                                                    }
                                                                }

                                                            }
                                                            payeeVpa.add(payeeVpaMap);
                                                        }
                                                    }

                                                    if (payerString != null) {
                                                        if (payerString.equalsIgnoreCase(payervpa)
                                                                || payeeString
                                                                .equalsIgnoreCase(payervpa)) {
                                                            Map<String, Object> payerVpaMap = new TreeMap<>();
                                                            payerVpaMap.put("CreatedTime",
                                                                    taskListInstance.optString("startTime"));
                                                            payerVpaMap.put("Transaction", transaction.toMap());
                                                            payerVpaMap.put("proc", taskListInstance.get("id"));
                                                            if (!taskListInstance.optString("state").toString()
                                                                    .equalsIgnoreCase("ACTIVE")) {
                                                                payerVpaMap.put("State",
                                                                        taskListInstance.optString("state"));
                                                                payerVpaMap.put("Completed", true);
                                                            } else {

                                                                payerVpaMap.put("State",
                                                                        activeTaskMap.get(taskListInstance.get("id")));
                                                                payerVpaMap.put("Completed", false);
                                                            }
                                                            for (int l = 0; l < detailList.length(); l++) {
                                                                if (taskListInstance.get("id")
                                                                        .equals(detailList.getJSONObject(l)
                                                                                .get("processInstanceId"))) {
                                                                    org.json.JSONObject variable2 = detailList
                                                                            .getJSONObject(l);
                                                                    if (variable2.optString("variableName")
                                                                            .equalsIgnoreCase("TicketID")) {
                                                                        payerVpaMap.put("TicketID",
                                                                                variable2.opt("value"));
                                                                    } else if (variable2.optString("variableName")
                                                                            .equalsIgnoreCase("WorkflowName")) {
                                                                        payerVpaMap.put("WorkflowName",
                                                                                variable2.opt("value"));
                                                                    } else if (variable2.optString("variableName")
                                                                            .equalsIgnoreCase("RiskScore")) {
                                                                        payerVpaMap.put("RiskScore",
                                                                                variable2.opt("value"));
                                                                    } else if (variable2.optString("variableName")
                                                                            .equalsIgnoreCase("AvgRiskScore")) {
                                                                        payerVpaMap.put("AvgRiskScore",
                                                                                variable2.opt("value"));
                                                                    }
                                                                }

                                                            }
                                                            payerVpa.add(payerVpaMap);
                                                        }
                                                    }
                                                }

                                            } else {

                                                JSONArray jsonArray = new JSONArray(
                                                        detailList.getJSONObject(j).optJSONArray("value"));
                                                org.json.JSONObject transaction = jsonArray.optJSONObject(0);

                                                if (transaction != null) {

                                                    String payeeString = (String) transaction
                                                            .optQuery("/observations/payeeVPA/externalId");
                                                    String payerString = (String) transaction
                                                            .optQuery("/observations/payerVPA/externalId");
                                                    if (payeeString != null) {
                                                        if (payeeString.equalsIgnoreCase(payeevpa)
                                                                || payerString
                                                                .equalsIgnoreCase(payeevpa)) {
                                                            Map<String, Object> payeeVpaMap = new TreeMap<>();
                                                            payeeVpaMap.put("CreatedTime",
                                                                    taskListInstance.optString("startTime"));
                                                            payeeVpaMap.put("Transaction", transaction.toMap());
                                                            payeeVpaMap.put("proc", taskListInstance.get("id"));
                                                            if (!taskListInstance.optString("state").toString()
                                                                    .equalsIgnoreCase("ACTIVE")) {
                                                                payeeVpaMap.put("State",
                                                                        taskListInstance.optString("state"));
                                                                payeeVpaMap.put("Completed", true);
                                                            } else {

                                                                payeeVpaMap.put("State",
                                                                        activeTaskMap.get(taskListInstance.get("id")));
                                                                payeeVpaMap.put("Completed", false);
                                                            }
                                                            for (int l = 0; l < detailList.length(); l++) {
                                                                if (taskListInstance.get("id")
                                                                        .equals(detailList.getJSONObject(l)
                                                                                .get("processInstanceId"))) {
                                                                    org.json.JSONObject variable2 = detailList
                                                                            .getJSONObject(l);
                                                                    if (variable2.optString("variableName")
                                                                            .equalsIgnoreCase("TicketID")) {
                                                                        payeeVpaMap.put("TicketID",
                                                                                variable2.opt("value"));
                                                                    } else if (variable2.optString("variableName")
                                                                            .equalsIgnoreCase("WorkflowName")) {
                                                                        payeeVpaMap.put("WorkflowName",
                                                                                variable2.opt("value"));
                                                                    } else if (variable2.optString("variableName")
                                                                            .equalsIgnoreCase("RiskScore")) {
                                                                        payeeVpaMap.put("RiskScore",
                                                                                variable2.opt("value"));
                                                                    } else if (variable2.optString("variableName")
                                                                            .equalsIgnoreCase("AvgRiskScore")) {
                                                                        payeeVpaMap.put("AvgRiskScore",
                                                                                variable2.opt("value"));
                                                                    }
                                                                }

                                                            }
                                                            payeeVpa.add(payeeVpaMap);
                                                        }
                                                    }

                                                    if (payerString != null) {
                                                        if (payerString.equalsIgnoreCase(payervpa)
                                                                || payeeString
                                                                .equalsIgnoreCase(payervpa)) {
                                                            Map<String, Object> payerVpaMap = new TreeMap<>();
                                                            payerVpaMap.put("CreatedTime",
                                                                    taskListInstance.optString("startTime"));
                                                            payerVpaMap.put("Transaction", transaction.toMap());
                                                            payerVpaMap.put("proc", taskListInstance.get("id"));
                                                            if (!taskListInstance.optString("state").toString()
                                                                    .equalsIgnoreCase("ACTIVE")) {
                                                                payerVpaMap.put("State",
                                                                        taskListInstance.optString("state"));
                                                                payerVpaMap.put("Completed", true);
                                                            } else {

                                                                payerVpaMap.put("State",
                                                                        activeTaskMap.get(taskListInstance.get("id")));
                                                                payerVpaMap.put("Completed", false);
                                                            }
                                                            for (int l = 0; l < detailList.length(); l++) {
                                                                if (taskListInstance.get("id")
                                                                        .equals(detailList.getJSONObject(l)
                                                                                .get("processInstanceId"))) {
                                                                    org.json.JSONObject variable2 = detailList
                                                                            .getJSONObject(l);
                                                                    if (variable2.optString("variableName")
                                                                            .equalsIgnoreCase("TicketID")) {
                                                                        payerVpaMap.put("TicketID",
                                                                                variable2.opt("value"));
                                                                    } else if (variable2.optString("variableName")
                                                                            .equalsIgnoreCase("WorkflowName")) {
                                                                        payerVpaMap.put("WorkflowName",
                                                                                variable2.opt("value"));
                                                                    } else if (variable2.optString("variableName")
                                                                            .equalsIgnoreCase("RiskScore")) {
                                                                        payerVpaMap.put("RiskScore",
                                                                                variable2.opt("value"));
                                                                    } else if (variable2.optString("variableName")
                                                                            .equalsIgnoreCase("AvgRiskScore")) {
                                                                        payerVpaMap.put("AvgRiskScore",
                                                                                variable2.opt("value"));
                                                                    }
                                                                }

                                                            }
                                                            payerVpa.add(payerVpaMap);
                                                        }
                                                    }
                                                }
                                            }

                                        }
                                    }

                                }
                            }

                        }

                    }
                }

                resMap.put("payer", payerVpa);
                resMap.put("payee", payeeVpa);

                LOGGER.debug("Exiting getRelatedTickets Method in " + TasksServiceImpl.class
                        + " class with response : related tickets");
                return ResponseEntity.ok(resMap);
            } else {
                activityLogService.addActivity(loggedInUser, "failed to access workflow names");
                LOGGER.debug("Exiting getRelatedTickets Method in " + TasksServiceImpl.class + " class with response : "
                        + responses);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, responses),
                        listOfTickets.getStatusCode());
            }

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to status drop down");
            LOGGER.debug("Exiting getRelatedTickets Method in " + TasksServiceImpl.class
                    + " class with response : unauthorized to get related tickets");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get related tickets"),
                    HttpStatus.FORBIDDEN);
        }

    }

    public org.json.JSONObject getRelatedTickets(String body1, String body2, Integer max, LoggedUser loggedUser) {
        ResponseEntity<String> listOfTickets = null;
        System.out.println("body1 " + body1);
        System.out.println("max " + max);
        org.json.JSONObject body = new org.json.JSONObject(body1);
        body.put("tenantIdIn", new JSONArray(loggedUser.getUserTenant().stream().map(String::valueOf).toList()));

        body.put("processDefinitionKeyIn", new JSONArray(loggedUser.getWorkflows()
                .stream()
                .filter(wfl -> wfl.getIsFilterDisplay())
                .map(wfl -> wfl.getWorkflowKey())
                .toList()));

        WebUser loggedInUser = loggedUser.getWebUser();
        long t1 = System.currentTimeMillis();
        try {
            listOfTickets = camundaService.getAllProcessInstance(body.toString(), max, loggedInUser);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : request body : " + body.toString());
            activityLogService.addActivity(loggedInUser, "failed to retrive related tickets",
                    "Error : " + e.toString() + ", Parameters : body " + body.toString());
            return null;
        }
        System.out.println("time for tickets " + (System.currentTimeMillis() - t1));

        // String responses = listOfTickets.bodyToMono(String.class).block();
        String responses = listOfTickets.getBody();
        // listOfTickets.releaseBody();

        if (listOfTickets.getStatusCode() == HttpStatus.OK) {

            // System.out.println("body2 " + body2);
            // long t2 = System.currentTimeMillis();
            // ClientResponse ticketcount = null;
            // ClientResponse countClientResponse = null;
            // try {
            // ticketcount = camundaService.getAllProcessInstanceCount(body1, loggedInUser);
            // countClientResponse = camundaService
            // .getAllProcessInstanceCount(body2, loggedInUser);
            // } catch (Exception e) {
            // LOGGER.error("Error : " + e + "\nParam : request body : " + body1);
            // activityLogService.addActivity(loggedInUser, "failed to retrive related
            // tickets",
            // "Error : " + e.toString() + ", Parameters : body " + body1);
            // return null;
            // }
            // System.out.println("time for count " + (System.currentTimeMillis() - t2));
            // Map<String, Object> countResponse =
            // ticketcount.bodyToMono(Map.class).block();
            // ticketcount.releaseBody();
            //
            // Map<String, Object> open = countClientResponse.bodyToMono(Map.class).block();
            // countClientResponse.releaseBody();

            // Integer totalcount = (Integer) countResponse.get("count");
            // Integer closed = (Integer) open.get("count");

            org.json.JSONObject resMap = new org.json.JSONObject();
            // resMap.put("totalCount", totalcount);
            //
            // resMap.put("openCount", totalcount - closed);
            // resMap.put("closedCount", closed);

            JSONArray ticketlist = new JSONArray();
            // List<Map<String, Object>> payerVpa = new LinkedList<>();

            JSONArray taskArray = new JSONArray(responses);

            List<String> instaceId = new ArrayList<>();

            List<String> activeId = new ArrayList<>();

            for (int w = 0; w < taskArray.length(); w++) {
                instaceId.add(taskArray.getJSONObject(w).optString("id"));
                if (taskArray.getJSONObject(w).optString("state").equalsIgnoreCase("ACTIVE")) {
                    activeId.add(taskArray.getJSONObject(w).optString("id"));
                }
            }

            ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
            String json = null;
            String activeJson = null;
            try {
                json = ow.writeValueAsString(instaceId);
                activeJson = ow.writeValueAsString(activeId);
            } catch (JsonProcessingException e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(instaceId.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get details",
                        "Error : " + e.toString() + ", Parameters : " + instaceId);
                return null;
            }

            TaskVariables varList = taskVariablesRepo.getById(1);
            String processInJson = "{\n  \"processInstanceIdIn\":" + json +
                    ",\"variableNameIn\":" + varList.getVariables() +
                    "\r\n \r\n \r\n}";
            String activeProcess = "{\n  \"processInstanceIdIn\":" + activeJson + "\n}";

            ResponseEntity<String> details = null;

            if (taskArray.length() != 0) {
                try {
                    details = camundaService.postHistoryVarInstance(processInJson, loggedInUser);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + processInJson);
                    activityLogService.addActivity(loggedInUser, "failed to get details",
                            "Error : " + e.toString() + ", Parameters : " + processInJson);
                    return null;
                }
            }
            GetTaskListRequest getTask = new GetTaskListRequest();
            getTask.setParameters(activeProcess);
            getTask.setMaxResult(max);

            ResponseEntity<String> activeTaskList = null;

            if (activeId.size() != 0) {
                try {
                    activeTaskList = camundaService.getTaskListPostHttp(getTask, loggedInUser);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + processInJson);
                    activityLogService.addActivity(loggedInUser, "failed to get active task",
                            "Error : " + e.toString() + ", Parameters : " + processInJson);
                    return null;
                }

                if (activeTaskList.getStatusCode() != HttpStatus.OK) {
                    LOGGER.error("Error : " + activeTaskList.getBody());
                    activityLogService.addActivity(loggedInUser, "failed to get active task",
                            "Error : " + activeTaskList.getBody());
                    return null;
                }
            }

            JSONArray actTaskResponse = null;
            Map<String, String> activeTaskMap = new HashMap<>();
            if (activeTaskList != null) {

                actTaskResponse = new JSONArray(activeTaskList.getBody());

                for (int d = 0; d < actTaskResponse.length(); d++) {
                    activeTaskMap.put(actTaskResponse.getJSONObject(d).getString("processInstanceId"),
                            actTaskResponse.getJSONObject(d).getString("name"));
                }

            }

            List<TaskLHSMap> lhsSchemaAll = null;
            try {
                lhsSchemaAll = taskLHSMapService.findByOption("All Related");
            } catch (Exception e) {
                LOGGER.error(
                        "Error : " + e);
                activityLogService.addActivity(loggedInUser, "failed to get task list",
                        "Error : " + e.toString());
                return null;
            }

            if (details != null) {

                if (details.getStatusCode() == HttpStatus.OK) {
                    Map<String, JSONArray> processVarMap = new HashMap<>();
                    JSONArray detailList = new JSONArray(details.getBody());
                    System.out.println("detail list size " + detailList.length());
                    for (int i = 0; i < detailList.length(); i++) {
                        String procId = detailList.getJSONObject(i).getString("processInstanceId");
                        if (!processVarMap.containsKey(procId)) {
                            processVarMap.put(procId, new JSONArray());
                        }
                        JSONArray varArr = processVarMap.get(procId);
                        varArr.put(detailList.getJSONObject(i));
                    }

                    for (int i = 0; i < taskArray.length(); i++) {
                        org.json.JSONObject taskListInstance = taskArray.getJSONObject(i);
                        JSONArray varArr = processVarMap.get(taskListInstance.getString("id"));
                        Map<String, org.json.JSONObject> camundaVar = new HashMap<>();
                        // Map<String, Object> ticketMap = new TreeMap<>();
                        org.json.JSONObject ticketMap = new org.json.JSONObject();
                        for (int j = 0; j < varArr.length(); j++) {
                            org.json.JSONObject variable = varArr.getJSONObject(j);
                            camundaVar.put(variable.optString("name"),
                                    variable);
                            if (variable.optString("name")
                                    .equalsIgnoreCase("TicketID")) {
                                ticketMap.put("TicketID",
                                        variable.opt("value"));
                            } else if (variable.optString("name")
                                    .equalsIgnoreCase("WorkflowName")) {
                                ticketMap.put("WorkflowName",
                                        variable.opt("value"));
                            } else if (variable.optString("name")
                                    .equalsIgnoreCase("RiskScore")) {
                                ticketMap.put("RiskScore",
                                        variable.opt("value"));
                            } else if (variable.optString("name")
                                    .equalsIgnoreCase("AvgRiskScore")) {
                                ticketMap.put("AvgRiskScore",
                                        variable.opt("value"));
                            } else if (variable.optString("name")
                                    .equals("TransactionAmount")) {
                                String amount = variable.optString("value");
                                ticketMap.put("TransactionAmount",
                                        Double.parseDouble(amount) / 100);
                            }
                        }
                        ticketMap.put("CreatedTime",
                                taskListInstance.optString("startTime"));
                        ticketMap.put("proc", taskListInstance.get("id"));

                        if (!taskListInstance.optString("state").toString()
                                .equalsIgnoreCase("ACTIVE")) {
                            ticketMap.put("State",
                                    taskListInstance.optString("state"));
                            ticketMap.put("Completed", true);
                            taskListInstance.put("State", taskListInstance.optString("state"));
                        } else {
                            ticketMap.put("State",
                                    activeTaskMap.get(taskListInstance.get("id")));
                            ticketMap.put("Completed", false);
                            taskListInstance.put("State",
                                    activeTaskMap.get(taskListInstance.get("id")));
                        }
                        String workflowKey = taskListInstance.getString("processDefinitionKey");
                        Integer workflowTenant = taskListInstance.getInt("tenantId");

                        WorkflowMasters workflow = loggedUser.getWorkflows().stream().filter(wf -> {
                            return wf.getWorkflowKey().equals(workflowKey)
                                    && wf.getItenantId().getItenantid().equals(workflowTenant);
                        }).findFirst().orElse(null);

                        // workflow = workflowMasterService.findByWorkflowAndTenantId(workflowKey,
                        // workflowTenant);
                        List<TaskLHSMap> lhsConfig = new ArrayList<>();
                        if (workflow != null) {
                            lhsConfig = lhsSchemaAll.stream().filter(sc -> {
                                if (sc.getWorkflowId() == workflow.getWorkflowId()
                                        && sc.getItenantId() == workflow.getItenantId().getItenantid()) {
                                    return true;
                                } else {
                                    return false;
                                }
                            }).sorted(new Comparator<TaskLHSMap>() {
                                @Override
                                public int compare(TaskLHSMap t1, TaskLHSMap t2) {
                                    if (t1.getIrow() != t2.getIrow()) {
                                        return t1.getIrow() - t2.getIrow();
                                    } else {
                                        return t1.getIorder() - t2.getIorder();
                                    }
                                }
                            }).collect(Collectors.toList());
                        }
                        JSONArray lhsFields = extractLHSFields(taskListInstance, camundaVar, lhsConfig);

                        ticketMap.put("lhsDisplay", lhsFields);

                        ticketlist.put(ticketMap);
                    }
                }
            }

            resMap.put("tickets", ticketlist);
            return resMap;
        } else {
            LOGGER.error("Error : " + listOfTickets.getStatusCode() + responses);
            activityLogService.addActivity(loggedInUser, "failed to get active task",
                    "Error : " + listOfTickets.getStatusCode() + responses);
            return null;
        }
    }

    public ResponseEntity<?> getRelatedTicketsAccountVPA(RelatedCasesAcVpa request, Authentication pr) {

        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getRelatedTickets");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        System.out.println("ticket id is " + request.getTicketID());
        if (mp.isView()) {
            ZoneId timeZone = loggedInUser.getTimeZone() != null ? ZoneId.of(loggedInUser.getTimeZone())
                    : ZoneId.systemDefault();
            LocalDateTime startdate = LocalDate.now().minusDays(request.getDays()).atTime(LocalTime.MIN);
            LocalDateTime enddate = LocalDate.now().atTime(LocalTime.MAX);

            DateTimeFormatter sdf = DateTimeFormatter.ofPattern("YYYY-MM-dd'T'HH:mm:ss.SSSZZ");

            String stext = startdate.atZone(timeZone).format(sdf);
            String etext = enddate.atZone(timeZone).format(sdf);
            org.json.JSONObject response = new org.json.JSONObject();
            if (request.getPayerVpa() != null) {
                // String body1 = "{\n \"startedAfter\": \"" + stext + "\",\n \"startedBefore\":
                // \"" + etext
                // + "\",\n \"orQueries\": [\n {\n \"variables\": [\n {\n \"name\": \"payee\",\n
                // \"operator\": \"eq\",\n \"value\": \""
                // + request.getPayerVpa()
                // + "\"\n },\n {\n \"name\": \"payer\",\n \"operator\": \"eq\",\n \"value\":
                // \""
                // + request.getPayerVpa()
                // + "\"\n }]}],\n"
                // + "\"variables\":[\n{\n\"name\":\"TicketID\",
                // \"operator\":\"neq\",\"value\":"
                // + request.getTicketID() + "\n}\n]}";

                String newbodypayervpa = "{\n" + "    \"variables\": [\n" +
                        "        {\n" +
                        "            \"name\": \"TicketID\",\n" +
                        "            \"value\": " + request.getTicketID() + ",\n" +
                        "            \"operator\": \"neq\"\n" +
                        "        },\n" +
                        "        {\n" +
                        "            \"name\": \"payer\",\n" +
                        "            \"value\": \"" + request.getPayerVpa() + "\",\n" +
                        "            \"operator\": \"eq\"\n" +
                        "        }\n" +
                        "    ],\n" +
                        "    \"processDefinitionKeyIn\": [],\n" +
                        "    \"startedAfter\": \"" + stext + "\",\n" +
                        "    \"startedBefore\": \"" + etext + "\"\n" +
                        "}";
                String newbodypayervpa2 = "{\n" +
                        "    \"variables\": [\n" +
                        "        {\n" +
                        "            \"name\": \"TicketID\",\n" +
                        "            \"value\": " + request.getTicketID() + ",\n" +
                        "            \"operator\": \"neq\"\n" +
                        "        },\n" +
                        "        {\n" +
                        "            \"name\": \"payer\",\n" +
                        "            \"value\": \"" + request.getPayerVpa() + "\",\n" +
                        "            \"operator\": \"eq\"\n" +
                        "        }\n" +
                        "    ],\n" +
                        "    \"processDefinitionKeyIn\": [],\n" +
                        "    \"startedAfter\": \"" + stext + "\",\n" +
                        "    \"completed\": true,\n" +
                        "    \"startedBefore\": \"" + etext + "\"\n" +
                        "}";

                org.json.JSONObject bodyobj = new org.json.JSONObject(newbodypayervpa);
                // bodyobj.put("processDefinitionKeyIn", roles);
                // System.out.println(bodyobj.toString());

                org.json.JSONObject tickets = getRelatedTickets(bodyobj.toString(), newbodypayervpa2, request.getMax(),
                        loggedUser);
                if (tickets == null) {
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                response.put("payerVpa", tickets);

            }

            if (request.getPayeeVpa() != null) {
                // String body1 = "{\n \"startedAfter\": \"" + stext + "\",\n \"startedBefore\":
                // \"" + etext
                // + "\",\n \"orQueries\": [\n {\n \"variables\": [\n {\n \"name\": \"payee\",\n
                // \"operator\": \"eq\",\n \"value\": \""
                // + request.getPayeeVpa()
                // + "\"\n },\n {\n \"name\": \"payer\",\n \"operator\": \"eq\",\n \"value\":
                // \""
                // + request.getPayeeVpa()
                // + "\"\n }]}],\n"
                // + "\"variables\":[\n{\n\"name\":\"TicketID\",
                // \"operator\":\"neq\",\"value\":"
                // + request.getTicketID() + "\n}\n]}";

                String newbodypayeevpa = "{\n" +
                        "    \"variables\": [\n" +
                        "        {\n" +
                        "            \"name\": \"TicketID\",\n" +
                        "            \"value\": " + request.getTicketID() + ",\n" +
                        "            \"operator\": \"neq\"\n" +
                        "        },\n" +
                        "        {\n" +
                        "            \"name\": \"payee\",\n" +
                        "            \"value\": \"" + request.getPayeeVpa() + "\",\n" +
                        "            \"operator\": \"eq\"\n" +
                        "        }\n" +
                        "    ],\n" +
                        "    \"processDefinitionKeyIn\": [],\n" +
                        "    \"startedAfter\": \"" + stext + "\",\n" +

                        "    \"startedBefore\": \"" + etext + "\"\n" +
                        "}";

                String newbodypayeevpa2 = "{\n" +
                        "    \"variables\": [\n" +
                        "        {\n" +
                        "            \"name\": \"TicketID\",\n" +
                        "            \"value\": " + request.getTicketID() + ",\n" +
                        "            \"operator\": \"neq\"\n" +
                        "        },\n" +
                        "        {\n" +
                        "            \"name\": \"payee\",\n" +
                        "            \"value\": \"" + request.getPayeeVpa() + "\",\n" +
                        "            \"operator\": \"eq\"\n" +
                        "        }\n" +
                        "    ],\n" +
                        "    \"processDefinitionKeyIn\": [],\n" +
                        "    \"startedAfter\": \"" + stext + "\",\n" +
                        "    \"completed\": true,\n" +
                        "    \"startedBefore\": \"" + etext + "\"\n" +
                        "}";

                org.json.JSONObject bodyobj = new org.json.JSONObject(newbodypayeevpa);

                org.json.JSONObject tickets = getRelatedTickets(bodyobj.toString(), newbodypayeevpa2, request.getMax(),
                        loggedUser);
                if (tickets == null) {
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                response.put("payeeVpa", tickets);
            }

            if (request.getPayerAccount() != null) {
                // String body1 = "{\n \"startedAfter\": \"" + stext + "\",\n \"startedBefore\":
                // \"" + etext
                // + "\",\n \"orQueries\": [\n {\n \"variables\": [\n {\n \"name\":
                // \"payeeAccount\",\n \"operator\": \"eq\",\n \"value\": \""
                // + request.getPayerAccount()
                // + "\"\n },\n {\n \"name\": \"payerAccount\",\n \"operator\": \"eq\",\n
                // \"value\": \""
                // + request.getPayerAccount()
                // + "\"\n }]}],\n"
                // + "\"variables\":[\n{\n\"name\":\"TicketID\",
                // \"operator\":\"neq\",\"value\":"
                // + request.getTicketID() + "\n}\n]}";

                String newbodypayeraccount = "{\n" +
                        "    \"variables\": [\n" +
                        "        {\n" +
                        "            \"name\": \"TicketID\",\n" +
                        "            \"value\": " + request.getTicketID() + ",\n" +
                        "            \"operator\": \"neq\"\n" +
                        "        },\n" +
                        "        {\n" +
                        "            \"name\": \"payerAccount\",\n" +
                        "            \"value\": \"" + request.getPayerAccount() + "\",\n" +
                        "            \"operator\": \"eq\"\n" +
                        "        }\n" +
                        "    ],\n" +
                        "    \"processDefinitionKeyIn\": [],\n" +
                        "    \"startedAfter\": \"" + stext + "\",\n" +
                        "    \"startedBefore\": \"" + etext + "\"\n" +
                        "}";

                String newbodypayeraccount2 = "{\n" +
                        "    \"variables\": [\n" +
                        "        {\n" +
                        "            \"name\": \"TicketID\",\n" +
                        "            \"value\": " + request.getTicketID() + ",\n" +
                        "            \"operator\": \"neq\"\n" +
                        "        },\n" +
                        "        {\n" +
                        "            \"name\": \"payerAccount\",\n" +
                        "            \"value\": \"" + request.getPayerAccount() + "\",\n" +
                        "            \"operator\": \"eq\"\n" +
                        "        }\n" +
                        "    ],\n" +
                        "    \"processDefinitionKeyIn\": [],\n" +
                        "    \"startedAfter\": \"" + stext + "\",\n" +
                        "    \"completed\": true,\n" +
                        "    \"startedBefore\": \"" + etext + "\"\n" +
                        "}";

                org.json.JSONObject bodyobj = new org.json.JSONObject(newbodypayeraccount);

                org.json.JSONObject tickets = getRelatedTickets(bodyobj.toString(), newbodypayeraccount2,
                        request.getMax(), loggedUser);
                if (tickets == null) {
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                response.put("payerAccount", tickets);

            }
            if (request.getPayeeAccount() != null) {
                // String body1 = "{\n \"startedAfter\": \"" + stext + "\",\n \"startedBefore\":
                // \"" + etext
                // + "\",\n \"orQueries\": [\n {\n \"variables\": [\n {\n \"name\":
                // \"payeeAccount\",\n \"operator\": \"eq\",\n \"value\": \""
                // + request.getPayeeAccount()
                // + "\"\n },\n {\n \"name\": \"payerAccount\",\n \"operator\": \"eq\",\n
                // \"value\": \""
                // + request.getPayeeAccount()
                // + "\"\n }]}],\n"
                // + "\"variables\":[\n{\n\"name\":\"TicketID\",
                // \"operator\":\"neq\",\"value\":"
                // + request.getTicketID() + "\n}\n]}";

                String newbodypayeeaccount = "{\n" +
                        "    \"variables\": [\n" +
                        "        {\n" +
                        "            \"name\": \"TicketID\",\n" +
                        "            \"value\": " + request.getTicketID() + ",\n" +
                        "            \"operator\": \"neq\"\n" +
                        "        },\n" +
                        "        {\n" +
                        "            \"name\": \"payeeAccount\",\n" +
                        "            \"value\": \"" + request.getPayeeAccount() + "\",\n" +
                        "            \"operator\": \"eq\"\n" +
                        "        }\n" +
                        "    ],\n" +
                        "    \"processDefinitionKeyIn\": [],\n" +
                        "    \"startedAfter\": \"" + stext + "\",\n" +
                        "    \"startedBefore\": \"" + etext + "\"\n" +
                        "}";

                String newbodypayeeaccount2 = "{\n" +
                        "    \"variables\": [\n" +
                        "        {\n" +
                        "            \"name\": \"TicketID\",\n" +
                        "            \"value\": " + request.getTicketID() + ",\n" +
                        "            \"operator\": \"neq\"\n" +
                        "        },\n" +
                        "        {\n" +
                        "            \"name\": \"payeeAccount\",\n" +
                        "            \"value\": \"" + request.getPayeeAccount() + "\",\n" +
                        "            \"operator\": \"eq\"\n" +
                        "        }\n" +
                        "    ],\n" +
                        "    \"processDefinitionKeyIn\": [],\n" +
                        "    \"startedAfter\": \"" + stext + "\",\n" +
                        "    \"completed\": true,\n" +
                        "    \"startedBefore\": \"" + etext + "\"\n" +
                        "}";

                org.json.JSONObject bodyobj = new org.json.JSONObject(newbodypayeeaccount);

                org.json.JSONObject tickets = getRelatedTickets(bodyobj.toString(), newbodypayeeaccount2,
                        request.getMax(), loggedUser);
                if (tickets == null) {
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                response.put("payeeAccount", tickets);

            }
            return ResponseEntity.ok(response.toString());

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to status drop down");
            LOGGER.debug("Exiting getRelatedTickets Method in " + TasksServiceImpl.class
                    + " class with response : unauthorized to get related tickets");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get related tickets"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getRelatedTicketsAddressBased(RelatedCasesAdd request, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getRelatedTickets");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            ZoneId timeZone = loggedInUser.getTimeZone() != null ? ZoneId.of(loggedInUser.getTimeZone())
                    : ZoneId.systemDefault();
            LocalDateTime startdate = LocalDate.now().minusDays(request.getDays()).atTime(LocalTime.MIN);
            LocalDateTime enddate = LocalDate.now().atTime(LocalTime.MAX);

            DateTimeFormatter sdf = DateTimeFormatter.ofPattern("YYYY-MM-dd'T'HH:mm:ss.SSSZZ");

            String stext = startdate.atZone(timeZone).format(sdf);
            String etext = enddate.atZone(timeZone).format(sdf);
            org.json.JSONObject bodyobj = new org.json.JSONObject();

            JSONArray variablelist = new JSONArray();
            org.json.JSONObject variableaddress = new org.json.JSONObject();
            variableaddress.put("name", "address");
            variableaddress.put("operator", "eq");
            variableaddress.put("value", request.getAddress());
            variablelist.put(variableaddress);

            org.json.JSONObject variabletype = new org.json.JSONObject();
            variabletype.put("name", "basedon");
            variabletype.put("operator", "eq");
            variabletype.put("value", request.getType());
            variablelist.put(variabletype);

            org.json.JSONObject variableticket = new org.json.JSONObject();
            variableticket.put("name", "TicketID");
            variableticket.put("operator", "neq");
            variableticket.put("value", request.getTicketID());
            variablelist.put(variableticket);

            bodyobj.put("startedAfter", stext);
            bodyobj.put("startedBefore", etext);
            bodyobj.put("variables", variablelist);
            String body = bodyobj.toString();

            org.json.JSONObject bodyobj2 = new org.json.JSONObject();
            bodyobj2.put("startedAfter", stext);
            bodyobj2.put("startedBefore", etext);
            bodyobj2.put("variables", variablelist);
            bodyobj2.put("completed", true);

            String body2 = bodyobj.toString();

            org.json.JSONObject response = getRelatedTickets(body, body2, request.getMax(), loggedUser);
            if (response == null) {
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            } else {
                return ResponseEntity.ok(response.toString());
            }

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to status drop down");
            LOGGER.debug("Exiting getRelatedTickets Method in " + TasksServiceImpl.class
                    + " class with response : unauthorized to get related tickets");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get related tickets"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> getRelatedTicketsBasedOnAddress(String address, String type, String day, String max,
                                                             Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getRelatedTickets");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);
        if (mp.isView()) {
            Integer days = Integer.parseInt(day);
            ZoneId timeZone = loggedInUser.getTimeZone() != null ? ZoneId.of(loggedInUser.getTimeZone())
                    : ZoneId.systemDefault();
            LocalDateTime startdate = LocalDate.now().minusDays(days).atTime(LocalTime.MIN);
            LocalDateTime enddate = LocalDate.now().atTime(LocalTime.MAX);

            DateTimeFormatter sdf = DateTimeFormatter.ofPattern("YYYY-MM-dd'T'HH:mm:ss.SSSZZ");

            String stext = startdate.atZone(timeZone).format(sdf);
            String etext = enddate.atZone(timeZone).format(sdf);
            ResponseEntity<String> listOfTickets = null;

            // String body = "{\"startedAfter\": \""+stext+"\", \"startedBefore\" :
            // \""+etext+"\"}";
            // String body="{\n \"startedAfter\": \""+stext+"\",\n \"startedBefore\":
            // \""+etext+"\",\n \"variables\": [\n {\n \"name\": \"payee\",\n \"operator\":
            // \"eq\",\n \"value\": \""+payeevpa+"\"\n },\n {\n \"name\": \"payer\",\n
            // \"operator\": \"eq\",\n \"value\": \""+payervpa+"\"\n }\n ]\n}";

            org.json.JSONObject bodyobj = new org.json.JSONObject();

            JSONArray variablelist = new JSONArray();
            org.json.JSONObject variableaddress = new org.json.JSONObject();
            variableaddress.put("name", "address");
            variableaddress.put("operator", "eq");
            variableaddress.put("value", address);
            variablelist.put(variableaddress);

            org.json.JSONObject variabletype = new org.json.JSONObject();
            variabletype.put("name", "basedon");
            variabletype.put("operator", "eq");
            variabletype.put("value", type);
            variablelist.put(variabletype);

            bodyobj.put("startedAfter", stext);
            bodyobj.put("startedBefore", etext);
            bodyobj.put("variables", variablelist);

            // System.out.println(bodyobj.toString());

            String body = bodyobj.toString();
            // String body = "{\n \"startedAfter\": \"" + stext + "\",\n \"startedBefore\":
            // \"" + etext
            // + "\",\n \"orQueries\": [\n {\n \"variables\": [\n {\n \"name\": \"payee\",\n
            // \"operator\": \"eq\",\n \"value\": \""
            // + payeevpa
            // + "\"\n },\n {\n \"name\": \"payer\",\n \"operator\": \"eq\",\n \"value\":
            // \""
            // + payervpa
            // + "\"\n },\n {\n \"name\": \"payee\",\n \"operator\": \"eq\",\n \"value\":
            // \""
            // + payervpa
            // + "\"\n },\n {\n \"name\": \"payer\",\n \"operator\": \"eq\",\n \"value\":
            // \""
            // + payeevpa + "\"\n }\n ]\n }\n ]\n}";
            // System.out.println(body);
            try {
                listOfTickets = camundaService.getAllProcessInstance(body, max, loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : address : " + address + ", type : " + type);
                activityLogService.addActivity(loggedInUser, "failed to retrive related tickets",
                        "Error : " + e.toString() + ", Parameters : address : " + address + ", type :  " + type);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            // String responses = listOfTickets.bodyToMono(String.class).block();
            String responses = listOfTickets.getBody();
            // listOfTickets.releaseBody();
            // System.out.println(responses);

            if (listOfTickets.getStatusCode() == HttpStatus.OK) {

                Map<String, Object> resMap = new TreeMap<>();
                resMap.put("Days", days);

                List<Map<String, Object>> ticketlist = new LinkedList<>();
                // List<Map<String, Object>> payerVpa = new LinkedList<>();

                JSONArray taskArray = new JSONArray(responses);

                List<String> instaceId = new ArrayList<>();

                List<String> activeId = new ArrayList<>();

                for (int w = 0; w < taskArray.length(); w++) {
                    instaceId.add(taskArray.getJSONObject(w).optString("id"));
                    if (taskArray.getJSONObject(w).optString("state").equalsIgnoreCase("ACTIVE")) {
                        activeId.add(taskArray.getJSONObject(w).optString("id"));
                    }
                }

                ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
                String json = null;
                String activeJson = null;
                try {
                    json = ow.writeValueAsString(instaceId);
                    activeJson = ow.writeValueAsString(activeId);
                } catch (JsonProcessingException e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(instaceId.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get details",
                            "Error : " + e.toString() + ", Parameters : " + instaceId);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                String processInJson = "{\n  \"processInstanceIdIn\":" + json +
                        ",\"variableNameIn\":[\"WorkflowName\",\"TicketID\",\"failedRules\",\"TransactionAmount\",\"RiskScore\",\"AvgRiskScore\"]"
                        +
                        "\r\n \r\n \r\n}";
                String activeProcess = "{\n  \"processInstanceIdIn\":" + activeJson + "\n}";

                ResponseEntity<String> details = null;

                if (taskArray.length() != 0) {
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
                }
                GetTaskListRequest getTask = new GetTaskListRequest();
                getTask.setParameters(activeProcess);
                getTask.setMaxResult(Integer.parseInt(max));

                ResponseEntity<String> activeTaskList = null;

                if (activeId.size() != 0) {
                    try {
                        activeTaskList = camundaService.getTaskListPostHttp(getTask, loggedInUser);
                    } catch (Exception e) {
                        LOGGER.error("Error : " + e + "\nParam : " + processInJson);
                        activityLogService.addActivity(loggedInUser, "failed to get active task",
                                "Error : " + e.toString() + ", Parameters : " + processInJson);
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    if (activeTaskList.getStatusCode() != HttpStatus.OK) {
                        LOGGER.error("Error : " + activeTaskList.getBody());
                        activityLogService.addActivity(loggedInUser, "failed to get active task",
                                "Error : " + activeTaskList.getBody());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                }

                JSONArray actTaskResponse = null;
                Map<String, String> activeTaskMap = new HashMap<>();
                if (activeTaskList != null) {

                    actTaskResponse = new JSONArray(activeTaskList.getBody());

                    for (int d = 0; d < actTaskResponse.length(); d++) {
                        activeTaskMap.put(actTaskResponse.getJSONObject(d).getString("processInstanceId"),
                                actTaskResponse.getJSONObject(d).getString("name"));
                    }

                }

                if (details != null) {

                    if (details.getStatusCode() == HttpStatus.OK) {
                        JSONArray detailList = new JSONArray(details.getBody());

                        for (int i = 0; i < taskArray.length(); i++) {
                            org.json.JSONObject taskListInstance = taskArray.getJSONObject(i);

                            for (int j = 0; j < detailList.length(); j++) {
                                if (taskListInstance.get("id")
                                        .equals(detailList.getJSONObject(j).get("processInstanceId"))) {
                                    if (detailList.getJSONObject(j).opt("variableName") != null) {

                                        if (detailList.getJSONObject(j).opt("variableName").equals("Transaction")
                                                && detailList.getJSONObject(j).opt("revision").equals(0)) {

                                            Map<String, Object> ticketMap = new TreeMap<>();
                                            ticketMap.put("CreatedTime",
                                                    taskListInstance.optString("startTime"));
                                            ticketMap.put("Transaction", detailList.getJSONObject(j).opt("value"));
                                            ticketMap.put("proc", taskListInstance.get("id"));

                                            if (!taskListInstance.optString("state").toString()
                                                    .equalsIgnoreCase("ACTIVE")) {
                                                ticketMap.put("State",
                                                        taskListInstance.optString("state"));
                                                ticketMap.put("Completed", true);
                                            } else {
                                                ticketMap.put("State",
                                                        activeTaskMap.get(taskListInstance.get("id")));
                                                ticketMap.put("Completed", false);
                                            }

                                            for (int l = 0; l < detailList.length(); l++) {
                                                if (taskListInstance.get("id")
                                                        .equals(detailList.getJSONObject(l)
                                                                .get("processInstanceId"))) {
                                                    org.json.JSONObject variable2 = detailList
                                                            .getJSONObject(l);
                                                    if (variable2.optString("variableName")
                                                            .equalsIgnoreCase("TicketID")) {
                                                        ticketMap.put("TicketID",
                                                                variable2.opt("value"));
                                                    } else if (variable2.optString("variableName")
                                                            .equalsIgnoreCase("WorkflowName")) {
                                                        ticketMap.put("WorkflowName",
                                                                variable2.opt("value"));
                                                    } else if (variable2.optString("variableName")
                                                            .equalsIgnoreCase("RiskScore")) {
                                                        ticketMap.put("RiskScore",
                                                                variable2.opt("value"));
                                                    } else if (variable2.optString("variableName")
                                                            .equalsIgnoreCase("AvgRiskScore")) {
                                                        ticketMap.put("AvgRiskScore",
                                                                variable2.opt("value"));
                                                    }
                                                }
                                            }
                                            ticketlist.add(ticketMap);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                resMap.put("ticktes", ticketlist);

                LOGGER.debug("Exiting getRelatedTickets Method in " + TasksServiceImpl.class
                        + " class with response : related tickets");
                return ResponseEntity.ok(resMap);
            } else {
                activityLogService.addActivity(loggedInUser, "failed to access workflow names");
                LOGGER.debug("Exiting getRelatedTickets Method in " + TasksServiceImpl.class + " class with response : "
                        + responses);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, responses),
                        listOfTickets.getStatusCode());
            }

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to status drop down");
            LOGGER.debug("Exiting getRelatedTickets Method in " + TasksServiceImpl.class
                    + " class with response : unauthorized to get related tickets");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get related tickets"),
                    HttpStatus.FORBIDDEN);
        }

    }

    public ResponseEntity<?> getContactDetails(String payer, String payee, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getContactDetails");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            Vpa payeeVpa = vpaService.findByExternalid(payee);
            Vpa payerVpa = vpaService.findByExternalid(payer);
            ResponseEntity<String> payerClientResponse = null;
            ResponseEntity<String> payeeClientResponse = null;

            try {
                if (payerVpa != null) {

                    payerClientResponse = frmService.getPaymentAddresses(payerVpa.getVcExternalAddressID());
                }
                if (payeeVpa != null) {

                    payeeClientResponse = frmService.getPaymentAddresses(payeeVpa.getVcExternalAddressID());
                }

            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(payer) + " "
                        + loggerEncoderUtil.encode(payee));
                activityLogService.addActivity(loggedInUser, "failed to get contact details",
                        "Error : " + e.toString() + ", Parameters : " + payer + " " + payee);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            String payerResponseString = "";
            if (payerVpa != null) {

                // payerResponseString = payerClientResponse.bodyToMono(String.class).block();
                // payerClientResponse.releaseBody();
                payerResponseString = payerClientResponse.getBody();
            }
            String payeeResponseString = "";
            if (payeeVpa != null) {
                // payeeResponseString = payeeClientResponse.bodyToMono(String.class).block();
                // payeeClientResponse.releaseBody();
                payeeResponseString = payeeClientResponse.getBody();
            }

            Map<String, Object> response = new TreeMap<>();
            if (payerVpa != null && payeeVpa != null && payerClientResponse.getStatusCode() == HttpStatus.OK
                    && payeeClientResponse.getStatusCode() == HttpStatus.OK) {
                response.put("payer", new org.json.JSONObject(payerResponseString).toMap());
                response.put("payee", new org.json.JSONObject(payeeResponseString).toMap());
                LOGGER.debug("Exiting getContactDetails Method in " + TasksServiceImpl.class
                        + " class with response : contact details");
                return ResponseEntity.ok(response);
            } else if (payerVpa != null && payerClientResponse.getStatusCode() == HttpStatus.OK) {
                response.put("payer", new org.json.JSONObject(payerResponseString).toMap());
                response.put("payee", new org.json.JSONObject("{}").toMap());
                LOGGER.debug("Exiting getContactDetails Method in " + TasksServiceImpl.class
                        + " class with response : contact details");
                return ResponseEntity.ok(response);
            } else if (payeeVpa != null && payeeClientResponse.getStatusCode() == HttpStatus.OK) {
                response.put("payer", new org.json.JSONObject("{}").toMap());
                response.put("payee", new org.json.JSONObject(payeeResponseString).toMap());
                LOGGER.debug("Exiting getContactDetails Method in " + TasksServiceImpl.class
                        + " class with response : contact details");
                return ResponseEntity.ok(response);
            } else {
                activityLogService.addActivity(loggedInUser, "failed to access workflow names");
                LOGGER.debug("Exiting getContactDetails Method in " + TasksServiceImpl.class + " class with response : "
                        + (payerResponseString == null ? "" : loggerEncoderUtil.encode(payerResponseString)));
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "No details found"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get contact details");
            LOGGER.debug("Exiting getContactDetails Method in " + TasksServiceImpl.class
                    + " class with response : unauthorized to get contact details");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get contact details"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> loadMoreTaskList(LoadMoreTaskListRequestGt loadMoreTaskListRequestGt, Authentication pr) {
        LOGGER.debug("entered in class " + TasksServiceImpl.class + " in method getTaskList");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            ResponseEntity<String> clientResponse = null;
            LoadMoreTaskListRequest loadMoreTaskListRequest = new LoadMoreTaskListRequest();
            loadMoreTaskListRequest.setMaxResult(loadMoreTaskListRequestGt.getMaxResult());
            loadMoreTaskListRequest.setNextStartIndex(loadMoreTaskListRequestGt.getNextStartIndex());
            loadMoreTaskListRequest.setParameters(loadMoreTaskListRequestGt.getParameters());
            try {
                clientResponse = camundaService.getTaskListPostLoadMore(loadMoreTaskListRequest, loggedInUser);
                LOGGER.info("get task api response received");
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(loggedInUser.toString()));
                activityLogService.addActivity(loggedInUser, "failed to access task list", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            // String response = clientResponse.bodyToMono(String.class).block();
            String response = clientResponse.getBody();
            // clientResponse.releaseBody();
            if (clientResponse.getStatusCode() == HttpStatus.OK) {

                JSONArray taskList = new JSONArray(response);
                for (int i = 0; i < taskList.length(); i++) {
                    org.json.JSONObject taskListInstance = taskList.getJSONObject(i);
                    ResponseEntity<String> formVariableClientResponse = null;
                    try {
                        formVariableClientResponse = camundaService.getFormVariable(taskListInstance.getString("id"),
                                loggedInUser);
                        LOGGER.info("form variable received");
                    } catch (Exception e) {
                        LOGGER.error("Error : " + e + "\nParam : "
                                + loggerEncoderUtil.encode(loadMoreTaskListRequest.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to access task list", e.toString());
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "failed to get form variable"),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    String riskScoreResponse = null;
                    org.json.JSONObject riskScoreList = null;
                    org.json.JSONObject riskScoreJson = null;
                    org.json.JSONObject TicketID = null;
                    org.json.JSONObject Transaction = null;
                    org.json.JSONObject workflowName = null;

                    try {
                        // riskScoreResponse =
                        // formVariableClientResponse.bodyToMono(String.class).block();
                        riskScoreResponse = formVariableClientResponse.getBody();
                        // formVariableClientResponse.releaseBody();
                        riskScoreList = new org.json.JSONObject(riskScoreResponse);
                        riskScoreJson = riskScoreList.optJSONObject("RiskScore");
                        workflowName = riskScoreList.isNull("WorkflowName") ? null
                                : riskScoreList.optJSONObject("WorkflowName");
                        TicketID = riskScoreList.isNull("TicketID") ? null
                                : riskScoreList.optJSONObject("TicketID");
                        Transaction = riskScoreList.isNull("Transaction") ? null
                                : riskScoreList.optJSONObject("Transaction");
                    } catch (Exception e) {
                        LOGGER.error("Error : " + e + "\nParam : "
                                + loggerEncoderUtil.encode(loadMoreTaskListRequest.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to access task list", e.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, "failed to get parameters from form variables"),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    LOGGER.info("parameters received from form variable");

                    if (riskScoreJson != null) {
                        taskListInstance.put("RiskScore", riskScoreJson.opt("value"));
                        if (riskScoreJson.get("value").equals(0) || riskScoreJson.opt("value").equals(10)) {
                            taskListInstance.put("Status", "Paid");
                        } else if (riskScoreJson.get("value").equals(100)) {
                            taskListInstance.put("Status", "Blocked");
                        }
                    } else {
                        taskListInstance.put("RiskScore", org.json.JSONObject.NULL);
                    }

                    if (workflowName != null)
                        taskListInstance.put("WorkflowName", workflowName.opt("value"));
                    else
                        taskListInstance.put("WorkflowName", org.json.JSONObject.NULL);

                    if (TicketID != null)
                        taskListInstance.put("TicketID", TicketID.opt("value"));
                    else
                        taskListInstance.put("TicketID", org.json.JSONObject.NULL);

                    if (Transaction != null) {
                        if (taskListInstance.get("processDefinitionId").toString().contains("DoubleDebit")) {
                            try {
                                JSONArray jsonArray = new JSONArray((String) Transaction.opt("value"));
                                org.json.JSONObject objectInArray1 = jsonArray.optJSONObject(0);
                                if (!objectInArray1.isEmpty()) {

                                    Long amount = Long
                                            .parseLong(objectInArray1.optQuery("/payee/amount") == null ? "000"
                                                    : objectInArray1.optQuery("/payee/amount").toString());
                                    if (amount == null) {
                                        amount = Long.parseLong(objectInArray1.optQuery("/payer/amount") == null ? "000"
                                                : objectInArray1.optQuery("/payer/amount").toString());
                                    }
                                    taskListInstance.put("TransactionAmount",
                                            amount != null && amount > 0 ? amount / 100 : org.json.JSONObject.NULL);

                                    taskListInstance.put("PayeeVpa",
                                            objectInArray1.optQuery("/payee/addr") == null ? org.json.JSONObject.NULL
                                                    : objectInArray1.optQuery("/payee/addr"));
                                    taskListInstance.put("PayerVpa",
                                            objectInArray1.optQuery("/payer/addr") == null ? org.json.JSONObject.NULL
                                                    : objectInArray1.optQuery("/payer/addr"));

                                }
                            } catch (Exception e) {
                                LOGGER.error("Error : " + e + "\nParam : "
                                        + loggerEncoderUtil.encode(Transaction.toString()));
                                activityLogService.addActivity(loggedInUser, "failed to access task list",
                                        e.toString());
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, "failed to get risk score"),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }
                        } else {
                            try {
                                String transactionString = Transaction.optString("value");
                                org.json.JSONObject rootNode = new org.json.JSONObject(transactionString);

                                if (!rootNode.isEmpty()) {
                                    Long amount = Long.parseLong(rootNode.optQuery("/payee/amount") == null ? "000"
                                            : rootNode.optQuery("/payee/amount").toString());
                                    // Long.parseLong(rootNode.optQuery("/payee/amount").toString());
                                    if (amount == null) {
                                        amount = Long.parseLong(rootNode.optQuery("/payer/amount") == null ? "000"
                                                : rootNode.optQuery("/payer/amount").toString());
                                    }

                                    taskListInstance.put("TransactionAmount",
                                            amount != null && amount > 0 ? amount / 100 : org.json.JSONObject.NULL);

                                    taskListInstance.put("PayeeVpa",
                                            rootNode.optQuery("/payee/addr") == null ? org.json.JSONObject.NULL
                                                    : rootNode.optQuery("/payee/addr"));
                                    taskListInstance.put("PayerVpa",
                                            rootNode.optQuery("/payer/addr") == null ? org.json.JSONObject.NULL
                                                    : rootNode.optQuery("/payer/addr"));
                                }
                            } catch (Exception e) {
                                LOGGER.error("Error : " + e + "\nParam : "
                                        + loggerEncoderUtil.encode(Transaction.toString()));
                                activityLogService.addActivity(loggedInUser, "failed to access task list",
                                        e.toString());
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, "failed to get risk score"),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }
                        }
                    }
                    taskList.put(i, taskListInstance);
                }
                activityLogService.addActivity(loggedInUser, "Task list accessed",
                        "parameters : " + loadMoreTaskListRequest);
                LOGGER.debug("exiting  class " + TasksServiceImpl.class + " and method getTaskList");
                return ResponseEntity.ok(taskList.toString());
            } else {
                activityLogService.addActivity(loggedInUser, "failed to access task list",
                        "Parameters : " + loadMoreTaskListRequest);
                LOGGER.error(loggerEncoderUtil
                        .encode("exiting  class " + TasksServiceImpl.class + " and method getTaskList with response : "
                                + response));
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, response),
                        clientResponse.getStatusCode());
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access list of tasks");
            LOGGER.debug("Exiting getListDropDown Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to access list of tasks");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to access list of tasks"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getRuleDropDowns(String menuName, Integer tenantid, Authentication pr) {
        LOGGER.debug("entered in class " + TasksServiceImpl.class + " in method getListDropDown");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            List<DropdownWithObject> response = new ArrayList<>();
            List<String> rulename = new ArrayList<>();
            try {
                // rulename = rulesTempService.findDistinctRuleName();
                rulename = rulesTempService.findDistinctRuleNameTenant(Arrays.asList(tenantid));
                // System.out.println(rulename);
                rulename.stream().map(
                                c -> response.add(DropdownWithObject.builder().label(c.toString()).value(c.toString()).build()))
                        .collect(Collectors.toList());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(loggedInUser.toString()));
                activityLogService.addActivity(loggedInUser, "failed to access dropdown", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            activityLogService.addActivity(loggedInUser, "Rules Dropdown accessed");
            LOGGER.debug("exiting in class " + TasksServiceImpl.class + " in method getListDropDown");
            return ResponseEntity.ok(response);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access Rules dropdown");
            LOGGER.debug("Exiting getListDropDown Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to access Rules dropdown");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access Rules dropdown"),
                    HttpStatus.FORBIDDEN);
        }
    }

    // @Override
    // public ResponseEntity<?> reassignTask(ReassignTask reassignTask,
    // Authentication
    // pr) {
    // LOGGER.debug("entering class " + TasksServiceImpl.class + " and method
    // unClaimTask");

    // UserAndPermissions userAndPermissions = null;
    // try {
    // userAndPermissions = webUserService.getUserAndPermissions(pr.getName(),
    // MenuNames.Tasks);
    // } catch (Exception e) {
    // LOGGER.error("Error : " + e + "\nParam : " +
    // loggerEncoderUtil.encode(pr.toString()));
    // activityLogService.addActivity("failed to get user and permissions",
    // e.toString());
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
    // ResponseMessages.GenericErrorMessage),
    // HttpStatus.INTERNAL_SERVER_ERROR);
    // }

    // WebUser loggedInUser = userAndPermissions.getUser();
    // MenuPermissions mp = userAndPermissions.getPermissions();

    // if (mp.isView()) {
    // WebUser assignedUser = null;
    // if (reassignTask.getReassignUser() != null) {
    // if (reassignTask.getReassignUser().isBlank() ||
    // reassignTask.getReassignUser().isEmpty()) {
    // activityLogService.addActivity(loggedInUser, "failed to unclaim task",
    // "Parameters : " + reassignTask.getTaskId());
    // LOGGER.error("Exiting unClaimTask Method in " + TasksServiceImpl.class
    // + " class with parma reassigned user is blank");
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Reassign User
    // cannot be blank"),
    // HttpStatus.BAD_REQUEST);
    // }
    // } else {
    // activityLogService.addActivity(loggedInUser, "failed to unclaim task",
    // "Parameters : " + reassignTask.getTaskId());
    // LOGGER.error("Exiting unClaimTask Method in " + TasksServiceImpl.class
    // + " class with parma reassigned user is blank");
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Reassign User
    // cannot be blank"),
    // HttpStatus.BAD_REQUEST);
    // }

    // if (reassignTask.getAssignedUser() != null &&
    // !reassignTask.getAssignedUser().isEmpty()
    // && !reassignTask.getAssignedUser().isBlank()) {
    // try {

    // assignedUser =
    // webUserService.loadUserByUsername(reassignTask.getAssignedUser());
    // } catch (Exception e) {
    // LOGGER.error("Error : " + e + "\nParam : " +
    // loggerEncoderUtil.encode(reassignTask.getTaskId()));
    // activityLogService.addActivity(loggedInUser, "failed to claim task",
    // "Error : " + e.toString() + ", Parameters : " + reassignTask.getTaskId());
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Username not
    // found"),
    // HttpStatus.INTERNAL_SERVER_ERROR);
    // }
    // }
    // if (assignedUser != null) {
    // ClientResponse clientResponse = null;
    // try {
    // clientResponse = camundaService.unClaimTask(reassignTask.getTaskId(),
    // reassignTask.getProcessInstanceId(), assignedUser);
    // } catch (Exception e) {
    // LOGGER.error("Error : " + e + "\nParam : " +
    // loggerEncoderUtil.encode(reassignTask.getTaskId()));
    // activityLogService.addActivity(loggedInUser, "failed to claim task",
    // "Error : " + e.toString() + ", Parameters : " + reassignTask.getTaskId());
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
    // ResponseMessages.GenericErrorMessage),
    // HttpStatus.INTERNAL_SERVER_ERROR);
    // }

    // String response = clientResponse.bodyToMono(String.class).block();

    // if (clientResponse.statusCode() != HttpStatus.NO_CONTENT) {
    // activityLogService.addActivity(loggedInUser, "failed to unclaim task",
    // "Parameters : " + reassignTask.getTaskId());
    // LOGGER.error("Exiting unClaimTask Method in " + TasksServiceImpl.class + "
    // class with response : "
    // + response);
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false, response),
    // clientResponse.statusCode());

    // } else {
    // ClientResponse clientResponseClaim = null;
    // WebUser reassignUser =
    // webUserService.loadUserByUsername(reassignTask.getReassignUser());
    // try {
    // clientResponseClaim = camundaService.claimTask(reassignTask.getTaskId(),
    // reassignTask.getProcessInstanceId(), reassignUser);
    // } catch (Exception e) {
    // LOGGER.error(
    // "Error : " + e + "\nParam : " +
    // loggerEncoderUtil.encode(reassignTask.getTaskId()));
    // activityLogService.addActivity(loggedInUser, "failed to claim task",
    // "Error : " + e.toString() + ", Parameters : " + reassignTask.getTaskId());
    // return new ResponseEntity<ApiResponse>(
    // new ApiResponse(false, ResponseMessages.GenericErrorMessage),
    // HttpStatus.INTERNAL_SERVER_ERROR);
    // }

    // String responseReassign =
    // clientResponseClaim.bodyToMono(String.class).block();

    // if (clientResponseClaim.statusCode() == HttpStatus.NO_CONTENT) {
    // activityLogService.addActivity(loggedInUser, "Task claimed",
    // "parameters : " + reassignTask.getTaskId());
    // LOGGER.debug(
    // "Exiting claimTask Method in " + TasksServiceImpl.class
    // + " class with success response ");
    // return ResponseEntity.ok(responseReassign);
    // } else {
    // activityLogService.addActivity(loggedInUser, "failed to claim task",
    // "Parameters : " + reassignTask.getTaskId());
    // LOGGER.error("Exiting claimTask Method in " + TasksServiceImpl.class
    // + " class with response : "
    // + response);
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
    // responseReassign),
    // clientResponse.statusCode());
    // }
    // }
    // } else {
    // ClientResponse clientResponseClaim = null;
    // WebUser reassignUser =
    // webUserService.loadUserByUsername(reassignTask.getReassignUser());
    // try {
    // clientResponseClaim = camundaService.claimTask(reassignTask.getTaskId(),
    // reassignTask.getProcessInstanceId(), reassignUser);
    // } catch (Exception e) {
    // LOGGER.error("Error : " + e + "\nParam : " +
    // loggerEncoderUtil.encode(reassignTask.getTaskId()));
    // activityLogService.addActivity(loggedInUser, "failed to claim task",
    // "Error : " + e.toString() + ", Parameters : " + reassignTask.getTaskId());
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
    // ResponseMessages.GenericErrorMessage),
    // HttpStatus.INTERNAL_SERVER_ERROR);
    // }

    // String responseReassign =
    // clientResponseClaim.bodyToMono(String.class).block();

    // if (clientResponseClaim.statusCode() == HttpStatus.NO_CONTENT) {
    // activityLogService.addActivity(loggedInUser, "Task claimed",
    // "parameters : " + reassignTask.getTaskId());
    // LOGGER.debug(
    // "Exiting claimTask Method in " + TasksServiceImpl.class + " class with
    // success response ");
    // return ResponseEntity.ok(responseReassign);
    // } else {
    // activityLogService.addActivity(loggedInUser, "failed to claim task",
    // "Parameters : " + reassignTask.getTaskId());
    // LOGGER.error(loggerEncoderUtil
    // .encode("Exiting claimTask Method in " + TasksServiceImpl.class + " class
    // with response : "
    // + responseReassign));
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
    // responseReassign),
    // clientResponseClaim.statusCode());
    // }
    // }
    // } else {
    // activityLogService.addActivity(loggedInUser, "unauthorized to claim task");
    // LOGGER.debug("Exiting unclaimTask Method in " + TasksServiceImpl.class
    // + " class with response : unauthorized to unclaim task");
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized
    // to unclaim task"),
    // HttpStatus.FORBIDDEN);
    // }
    // }
    @Override
    public ResponseEntity<?> reassignTask(ReassignTask reassignTask, Authentication pr) {
        LOGGER.debug("entered in class " + TasksServiceImpl.class + " in method reassignTask");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            WebUser assignedUser = webUserService.loadUserByUsername(reassignTask.getAssignedUser());
            WebUser reassignUser = webUserService.loadUserByUsername(reassignTask.getReassignUser());
            if (assignedUser != null && reassignUser != null) {
                try {
                    ResponseEntity<String> clientReassign = camundaService.reassignTask(reassignTask.getTaskId(),
                            reassignTask.getProcessInstanceId(), assignedUser, reassignUser);
                    // String responseReassign = clientReassign.bodyToMono(String.class).block();
                    String responseReassign = clientReassign.getBody();
                    // clientReassign.releaseBody();
                    if (clientReassign.getStatusCode() == HttpStatus.NO_CONTENT) {
                        activityLogService.addActivity(loggedInUser, "Task reassigned",
                                "parameters : " + reassignTask.getTaskId());
                        LOGGER.debug("Exiting reassignTask Method in " + TasksServiceImpl.class
                                + " class with success response ");
                        return ResponseEntity.ok(responseReassign);
                    } else {
                        activityLogService.addActivity(loggedInUser, "failed to reassign task",
                                "Parameters : " + reassignTask.getTaskId());
                        LOGGER.error(loggerEncoderUtil
                                .encode("Exiting reassignTask Method in " + TasksServiceImpl.class
                                        + " class with response  : "
                                        + responseReassign));
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, responseReassign),
                                clientReassign.getStatusCode());
                    }

                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(reassignTask.getAssignedUser()) + " "
                            + loggerEncoderUtil.encode(reassignTask.getReassignUser()));
                    activityLogService.addActivity(loggedInUser, "failed to reassign task",
                            "Error : " + e.toString() + ", Parameters : " + reassignTask.getAssignedUser() + " "
                                    + reassignTask.getReassignUser());
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
            } else {
                LOGGER.error("Error : Users not found, Param : " + loggerEncoderUtil.encode(loggedInUser.toString()));
                activityLogService.addActivity(loggedInUser, "failed to access reassign task");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access reassign task");
            LOGGER.debug("Exiting reassignTask Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to access reassign task");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access reassign task"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getListOfUsers(Authentication pr) {
        LOGGER.debug("entered in class " + TasksServiceImpl.class + " in method getListOfUsers");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            List<DropdownWithObject> response = new ArrayList<>();
            List<WebUser> users = new ArrayList<>();
            try {
                users = webUserService.findAllActiveUsers("", loggedUser);
                AllUsersMapping allMappingInfo = webuserMappingUtil.getWebUserMappings(
                        users.stream().map(us -> us.getIuserID()).toList(), loggedInUser.getIorgId().getIorgid());
                users = users.stream()
                        .filter(c -> !c.getUsername().equals(loggedInUser.getUsername())
                                && groupDescService.findAllById(allMappingInfo.getUserGroup().get(c.getIuserID()))
                                .stream()
                                .filter(d -> d.getVcGroupID().equals("riskanalyst"))
                                .collect(Collectors.toList()).size() != 0)
                        .collect(Collectors.toList());
                // System.out.println(rulename);
                users.stream().map(
                                c -> response.add(
                                        DropdownWithObject.builder().label(c.getUsername()).value(c.getUsername()).build()))
                        .collect(Collectors.toList());

            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(loggedInUser.toString()));
                activityLogService.addActivity(loggedInUser, "failed to access dropdown", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            activityLogService.addActivity(loggedInUser, "Users Dropdown accessed");
            LOGGER.debug("exiting in class " + TasksServiceImpl.class + " in method getListOfUsers");
            return ResponseEntity.ok(response);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access Rules dropdown");
            LOGGER.debug("Exiting getListDropDown Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to access Rules dropdown");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access users dropdown"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getAccountWiseTask(PriorityQueueTaskRequest priorityQueueTaskRequest, Authentication pr) {
        LOGGER.debug("entered in class " + TasksServiceImpl.class + " in method getAccountWiseTask");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            Map<String, Object> res;
            try {
                List<Integer> itenantids = loggedUser.getUserTenant();
                List<String> keys = loggedUser.getWorkflows().stream().map(wl -> wl.getWorkflowKey()).toList();

                List<String> stenantids = itenantids.stream().map(String::valueOf).toList();

                res = AccountWithTaskIDMapper.AccountWithTaskIDMapper(
                        accountWithCountMapper
                                .findAllOpenTicketsByVariableNames(priorityQueueTaskRequest.getVariablelist(),
                                        env.getProperty("camunda.schema"), keys, stenantids),
                        priorityQueueTaskRequest.getSortOrder(), priorityQueueTaskRequest.getMaxResult());
            } catch (Exception e) {
                // e.printStackTrace();
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(loggedInUser.toString()));
                activityLogService.addActivity(loggedInUser, "failed to access dropdown", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            activityLogService.addActivity(loggedInUser, "Account wise task accessed");
            LOGGER.debug("exiting in class " + TasksServiceImpl.class + " in method getAccountWiseTask");
            return ResponseEntity.ok(res);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to account wise task");
            LOGGER.debug("Exiting getListDropDown Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to access Rules dropdown");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access account wise task"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getRelatedTicketsAccountLevel(String payeraccount, String payeeaccount, String day,
                                                           String max, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getRelatedTickets");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            Integer days = Integer.parseInt(day);
            ZoneId timeZone = loggedInUser.getTimeZone() != null ? ZoneId.of(loggedInUser.getTimeZone())
                    : ZoneId.systemDefault();
            LocalDateTime startdate = LocalDate.now().minusDays(days).atTime(LocalTime.MIN);
            LocalDateTime enddate = LocalDate.now().atTime(LocalTime.MAX);

            DateTimeFormatter sdf = DateTimeFormatter.ofPattern("YYYY-MM-dd'T'HH:mm:ss.SSSZZ");

            String stext = startdate.atZone(timeZone).format(sdf);
            String etext = enddate.atZone(timeZone).format(sdf);
            ResponseEntity<String> listOfTickets = null;

            String body = "{\n  \"startedAfter\": \"" + stext + "\",\n  \"startedBefore\": \"" + etext
                    + "\",\n  \"orQueries\": [\n    {\n      \"variables\": [\n        {\n          \"name\": \"payeeAccount\",\n          \"operator\": \"eq\",\n          \"value\": \""
                    + payeeaccount
                    + "\"\n        },\n        {\n          \"name\": \"payerAccount\",\n          \"operator\": \"eq\",\n          \"value\": \""
                    + payeraccount
                    + "\"\n        },\n        {\n          \"name\": \"payeeAccount\",\n          \"operator\": \"eq\",\n          \"value\": \""
                    + payeraccount
                    + "\"\n        },\n        {\n          \"name\": \"payerAccount\",\n          \"operator\": \"eq\",\n          \"value\": \""
                    + payeeaccount + "\"\n        }\n      ]\n    }\n  ]\n}";
            // System.out.println("request body get all process instance " + body);
            try {
                listOfTickets = camundaService.getAllProcessInstance(body, max, loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(payeeaccount) + " "
                        + loggerEncoderUtil.encode(payeraccount));
                activityLogService.addActivity(loggedInUser, "failed to retrive related tickets",
                        "Error : " + e.toString() + ", Parameters : " + payeeaccount + " " + payeraccount);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            // String responses = listOfTickets.bodyToMono(String.class).block();
            String responses = listOfTickets.getBody();
            // listOfTickets.releaseBody();
            // System.out.println("get list of tickets " + responses);

            if (listOfTickets.getStatusCode() == HttpStatus.OK) {

                Map<String, Object> resMap = new TreeMap<>();
                resMap.put("Days", days);

                List<Map<String, Object>> payeeVpa = new LinkedList<>();
                List<Map<String, Object>> payerVpa = new LinkedList<>();

                JSONArray taskArray = new JSONArray(responses);
                // System.out.println(responses);

                List<String> instaceId = new ArrayList<>();
                List<String> activeId = new ArrayList<>();

                for (int w = 0; w < taskArray.length(); w++) {
                    // System.out.println(taskArray.getJSONObject(w).optString("id"));
                    instaceId.add(taskArray.getJSONObject(w).optString("id"));
                    if (taskArray.getJSONObject(w).optString("state").equalsIgnoreCase("ACTIVE")) {
                        activeId.add(taskArray.getJSONObject(w).optString("id"));
                    }
                }

                ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
                String json = null;
                String activeJson = null;
                try {
                    json = ow.writeValueAsString(instaceId);
                    activeJson = ow.writeValueAsString(activeId);
                } catch (JsonProcessingException e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(instaceId.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get details",
                            "Error : " + e.toString() + ", Parameters : " + instaceId);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                String processInJson = "{\n  \"processInstanceIdIn\":" + json + "\n}";
                String activeProcess = "{\n  \"processInstanceIdIn\":" + activeJson + "\n}";

                // System.out.println(processInJson);

                ResponseEntity<String> details = null;

                if (taskArray.length() != 0) {
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
                }

                GetTaskListRequest getTask = new GetTaskListRequest();
                getTask.setParameters(activeProcess);
                getTask.setMaxResult(Integer.parseInt(max));

                ResponseEntity<String> activeTaskList = null;

                if (activeId.size() != 0) {
                    try {
                        activeTaskList = camundaService.getTaskListPostHttp(getTask, loggedInUser);
                    } catch (Exception e) {
                        LOGGER.error("Error : " + e + "\nParam : " + processInJson);
                        activityLogService.addActivity(loggedInUser, "failed to get active task",
                                "Error : " + e.toString() + ", Parameters : " + processInJson);
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    if (activeTaskList.getStatusCode() != HttpStatus.OK) {
                        LOGGER.error("Error : " + activeTaskList.getBody());
                        activityLogService.addActivity(loggedInUser, "failed to get active task",
                                "Error : " + activeTaskList.getBody());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                }

                JSONArray actTaskResponse = null;
                Map<String, String> activeTaskMap = new HashMap<>();
                if (activeTaskList != null) {

                    actTaskResponse = new JSONArray(activeTaskList.getBody());

                    for (int d = 0; d < actTaskResponse.length(); d++) {
                        activeTaskMap.put(actTaskResponse.getJSONObject(d).getString("processInstanceId"),
                                actTaskResponse.getJSONObject(d).getString("name"));
                    }

                }

                if (details != null && details.getStatusCode() == HttpStatus.OK) {
                    JSONArray detailList = new JSONArray(details.getBody());

                    for (int i = 0; i < taskArray.length(); i++) {
                        org.json.JSONObject taskListInstance = taskArray.getJSONObject(i);
                        String processInstanceId = taskListInstance.getString("id");

                        Optional<org.json.JSONObject> transactionOpt = findTransaction(detailList, processInstanceId);
                        if (transactionOpt.isPresent()) {
                            org.json.JSONObject transaction = transactionOpt.get();
                            String payeeString = (String) transaction
                                    .optQuery("/observations/payeeVPA/account/externalId");
                            String payerString = (String) transaction
                                    .optQuery("/observations/payerVPA/account/externalId");

                            if (payeeString != null && (payeeString.equalsIgnoreCase(payeeaccount) ||
                                    (payerString != null && payerString.equalsIgnoreCase(payeeaccount)))) {
                                Map<String, Object> payeeVpaMap = createVpaMap(taskListInstance, transaction,
                                        activeTaskMap, detailList);
                                payeeVpa.add(payeeVpaMap);
                            }

                            if (payerString != null && (payerString.equalsIgnoreCase(payeraccount) ||
                                    (payeeString != null && payeeString.equalsIgnoreCase(payeraccount)))) {
                                Map<String, Object> payerVpaMap = createVpaMap(taskListInstance, transaction,
                                        activeTaskMap, detailList);
                                payerVpa.add(payerVpaMap);
                            }
                        }
                    }
                }

                resMap.put("payer", payerVpa);
                resMap.put("payee", payeeVpa);

                LOGGER.debug("Exiting getRelatedTickets Method in " + TasksServiceImpl.class
                        + " class with response : related tickets");
                return ResponseEntity.ok(resMap);
            } else {
                activityLogService.addActivity(loggedInUser, "failed to access workflow names");
                LOGGER.debug("Exiting getRelatedTickets Method in " + TasksServiceImpl.class + " class with response : "
                        + responses);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, responses),
                        listOfTickets.getStatusCode());
            }

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to status drop down");
            LOGGER.debug("Exiting getRelatedTickets Method in " + TasksServiceImpl.class
                    + " class with response : unauthorized to get related tickets");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get related tickets"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getParameterType() {
        List<DropDownVo> responses = DropDownVoMapper.parse(validationFieldsListService.findAll());
        LOGGER.debug("Exiting getParameterType Method in " + TasksServiceImpl.class
                + " class with response  : with parameters type dropdown");
        // activityLogService.addActivity(loggedInUser, "field dropdown accessed",
        // "Parameters : " + responses.toString());
        return ResponseEntity.ok(responses);
    }

    @Override
    public ResponseEntity<?> getDeployedForm(String taskid, Authentication pr) {

        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getRenderedForm");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);
        ResponseEntity<String> clientResponse = null;
        ResponseEntity<String> formVariable = null;
        try {
            clientResponse = camundaService.getDeployed(taskid, loggedInUser);
            formVariable = camundaService.getFormVariable(taskid, loggedInUser);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(taskid));
            activityLogService.addActivity(loggedInUser, "failed to get rendered form", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
        // String response = clientResponse.bodyToMono(String.class).block();
        String response = clientResponse.getBody();
        // clientResponse.releaseBody();
        // String formVariableResponse = formVariable.bodyToMono(String.class).block();
        String formVariableResponse = formVariable.getBody();
        // formVariable.releaseBody();
        if (clientResponse.getStatusCode() == HttpStatus.OK && formVariable.getStatusCode() == HttpStatus.OK) {

            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.ok(response);
        }

    }

    @Override
    public ResponseEntity<?> getListOfBranchUsers(Authentication pr) {
        LOGGER.debug("entered in class " + TasksServiceImpl.class + " in method getListOfBranchUsers");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            List<DropdownWithObject> responseAml = new ArrayList<>();
            List<DropdownWithObject> responsePobo = new ArrayList<>();
            Map<String, List<DropdownWithObject>> response = new HashMap<>();
            List<WebUser> users = new ArrayList<>();
            List<WebUser> usersPobo = new ArrayList<>();
            List<WebUser> usersAml = new ArrayList<>();

            try {
                users = webUserService.findAllActiveUsers("", loggedUser);
                AllUsersMapping allMappingInfo = webuserMappingUtil.getWebUserMappings(
                        users.stream().map(us -> us.getIuserID()).toList(), loggedInUser.getIorgId().getIorgid());
                usersAml = users.stream()
                        .filter(c -> !c.getUsername().equals(loggedInUser.getUsername())
                                && groupDescService.findAllById(allMappingInfo.getUserGroup().get(c.getIuserID()))
                                .stream()
                                .filter(d -> d.getVcGroupID().equals("branch"))
                                .collect(Collectors.toList()).size() != 0)
                        .collect(Collectors.toList());
                // System.out.println(rulename);
                usersAml.stream().map(
                                c -> responseAml.add(
                                        DropdownWithObject.builder().label(c.getUsername()).value(c.getIuserID().toString())
                                                .build()))
                        .collect(Collectors.toList());

                usersPobo = users.stream()
                        .filter(c -> !c.getUsername().equals(loggedInUser.getUsername())
                                && groupDescService.findAllById(allMappingInfo.getUserGroup().get(c.getIuserID()))
                                .stream()
                                .filter(d -> d.getVcGroupID().equals("branchpobo"))
                                .collect(Collectors.toList()).size() != 0)
                        .collect(Collectors.toList());

                // System.out.println(rulename);
                usersPobo.stream().map(
                                c -> responsePobo.add(
                                        DropdownWithObject.builder().label(c.getUsername()).value(c.getIuserID().toString())
                                                .build()))
                        .collect(Collectors.toList());
                response.put("amlcases", responseAml);
                response.put("amlcasespobo", responsePobo);

            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(loggedInUser.toString()));
                activityLogService.addActivity(loggedInUser, "failed to access dropdown", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            activityLogService.addActivity(loggedInUser, "Users Dropdown accessed");
            LOGGER.debug("exiting in class " + TasksServiceImpl.class + " in method getListOfUsers");
            return ResponseEntity.ok(response);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access Rules dropdown");
            LOGGER.debug("Exiting getListDropDown Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to access Rules dropdown");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access users dropdown"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getListOfDbUSers(Authentication pr) {
        LOGGER.debug("entered in class " + TasksServiceImpl.class + " in method getListOfDbUSers");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            List<DropdownWithObject> responseAml = new ArrayList<>();
            List<DropdownWithObject> responsePobo = new ArrayList<>();
            Map<String, List<DropdownWithObject>> response = new HashMap<>();
            List<WebUser> users = new ArrayList<>();
            List<WebUser> usersPobo = new ArrayList<>();
            List<WebUser> usersAml = new ArrayList<>();

            try {
                users = webUserService.findAllActiveUsers("", loggedUser);
                AllUsersMapping allMappingInfo = webuserMappingUtil.getWebUserMappings(
                        users.stream().map(us -> us.getIuserID()).toList(), loggedInUser.getIorgId().getIorgid());
                usersAml = users.stream()
                        .filter(c -> !c.getUsername().equals(loggedInUser.getUsername())
                                && groupDescService.findAllById(allMappingInfo.getUserGroup().get(c.getIuserID()))
                                .stream()
                                .filter(d -> d.getVcGroupID().equals("db"))
                                .collect(Collectors.toList()).size() != 0)
                        .collect(Collectors.toList());
                // System.out.println(rulename);
                usersAml.stream().map(
                                c -> responseAml.add(
                                        DropdownWithObject.builder().label(c.getUsername()).value(c.getIuserID().toString())
                                                .build()))
                        .collect(Collectors.toList());

                usersPobo = users.stream()
                        .filter(c -> !c.getUsername().equals(loggedInUser.getUsername())
                                && groupDescService.findAllById(allMappingInfo.getUserGroup().get(c.getIuserID()))
                                .stream()
                                .filter(d -> d.getVcGroupID().equals("dbpobo"))
                                .collect(Collectors.toList()).size() != 0)
                        .collect(Collectors.toList());

                // System.out.println(rulename);
                usersPobo.stream().map(
                                c -> responsePobo.add(
                                        DropdownWithObject.builder().label(c.getUsername()).value(c.getIuserID().toString())
                                                .build()))
                        .collect(Collectors.toList());
                response.put("amlcases", responseAml);
                response.put("amlcasespobo", responsePobo);

            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(loggedInUser.toString()));
                activityLogService.addActivity(loggedInUser, "failed to access dropdown", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            activityLogService.addActivity(loggedInUser, "Users Dropdown accessed");
            LOGGER.debug("exiting in class " + TasksServiceImpl.class + " in method getListOfUsers");
            return ResponseEntity.ok(response);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access Rules dropdown");
            LOGGER.debug("Exiting getListDropDown Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to access Rules dropdown");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access users dropdown"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getAccountWise(String parameters, Authentication pr) {

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (!mp.isView()) {
            activityLogService.addActivity(loggedInUser, "unauthorized to access Task page");
            LOGGER.debug("Exiting getAccountWise Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to access Rules dropdown");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access Task page"),
                    HttpStatus.FORBIDDEN);
        }

        ResponseEntity<String> tasklist = null;

        try {
            tasklist = camundaService.getTaskListPostHttp(parameters, loggedInUser);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to get task list", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);

        }
        // String response = clientResponse.bodyToMono(String.class).block();

        JSONArray jsonArray = new JSONArray(tasklist.getBody());
        JSONArray jsonArrayResponse = new JSONArray("[]");
        List<String> instaceId = new ArrayList<>();
        List<String> lastAndFisrt = new ArrayList<>();

        for (int i = 0; i < jsonArray.length(); i++) {
            instaceId.add(jsonArray.getJSONObject(i).optString("processInstanceId"));
            if (i == 0 || i == jsonArray.length() - 1) {
                lastAndFisrt.add(jsonArray.getJSONObject(i).optString("processInstanceId"));
            }
        }

        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
        String json = null;
        String firstlast = null;
        try {
            json = ow.writeValueAsString(instaceId);
            firstlast = ow.writeValueAsString(lastAndFisrt);
        } catch (JsonProcessingException e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(instaceId.toString()));
            activityLogService.addActivity(loggedInUser, "failed to get details",
                    "Error : " + e.toString() + ", Parameters : " + instaceId);
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        String processInJson = "{\n  \"processInstanceIdIn\":" + json
                + ",\r\n    \"variableNameIn\":[\"WorkflowName\",\"TicketID\",\"Alert\"]\r\n    \r\n   \r\n}";
        String maxTran = "{\n  \"processInstanceIdIn\":" + firstlast
                + ",\r\n    \"variableNameIn\":[\"Transaction\"]\r\n    \r\n   \r\n}";

        ResponseEntity<String> details = null;

        if (instaceId.size() != 0) {
            try {
                details = camundaService.postHistoryVarInstance(processInJson, loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + processInJson);
                activityLogService.addActivity(loggedInUser, "failed to get details",
                        "Error : " + e.toString() + ", Parameters : " + processInJson);
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }

        ResponseEntity<String> detailsFirstAndLast = null;

        if (instaceId.size() != 0) {
            try {
                detailsFirstAndLast = camundaService.postHistoryVarInstance(maxTran, loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + maxTran);
                activityLogService.addActivity(loggedInUser, "failed to get details",
                        "Error : " + e.toString() + ", Parameters : " + maxTran);
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }

        HashMap<String, String> oldestAndNewest = new HashMap<>();

        if (detailsFirstAndLast != null) {
            if (detailsFirstAndLast.getStatusCode() == HttpStatus.OK) {
                JSONArray detailListFirstAndLast = new JSONArray(detailsFirstAndLast.getBody());
                for (int j = 0; j < detailListFirstAndLast.length(); j++) {
                    if (detailListFirstAndLast.getJSONObject(j).opt("name") != null) {
                        if (detailListFirstAndLast.getJSONObject(j).get("name").equals("Transaction")) {
                            ObjectMapper map = new ObjectMapper();
                            try {
                                JsonNode node = map
                                        .readTree(detailListFirstAndLast.getJSONObject(j).get("value").toString());
                                oldestAndNewest.put(
                                        detailListFirstAndLast.getJSONObject(j).getString("processInstanceId"),
                                        node.at("/ts").asText());
                            } catch (Exception e) {
                                LOGGER.error("Error : " + e + "\nParam : " + maxTran);
                                activityLogService.addActivity(loggedInUser, "failed to get details",
                                        "Error : " + e.toString() + ", Parameters : " + maxTran);
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }

                        }
                    }

                }
            }
        }

        if (details != null) {
            if (details.getStatusCode() == HttpStatus.OK) {
                JSONArray detailList = new JSONArray(details.getBody());
                // System.out.println(detailList);

                for (int k = 0; k < jsonArray.length(); k++) {
                    org.json.JSONObject taskListInstance = jsonArray.getJSONObject(k);
                    for (int n = 0; n < detailList.length(); n++) {
                        if (taskListInstance.getString("processInstanceId")
                                .equals(detailList.getJSONObject(n).getString("processInstanceId"))) {
                            if (oldestAndNewest.containsKey(taskListInstance.getString("processInstanceId"))) {
                                taskListInstance.put("transactionTime",
                                        oldestAndNewest.get(taskListInstance.getString("processInstanceId")));
                            }
                            // taskListInstance.put("formVariable", responseMap);
                            if (detailList.getJSONObject(n).opt("name") != null) {
                                if (detailList.getJSONObject(n).get("name").equals("Alert")) {
                                    taskListInstance.put("Alert",
                                            detailList.getJSONObject(n).get("value").toString());
                                }

                                if (detailList.getJSONObject(n).get("name").equals("TicketID")) {
                                    taskListInstance.put("TicketID",
                                            detailList.getJSONObject(n).get("value").toString());
                                }

                                if (detailList.getJSONObject(n).get("name")
                                        .equals("WorkflowName")) {
                                    taskListInstance.put("WorkflowName",
                                            detailList.getJSONObject(n).get("value").toString());
                                }
                            }

                            taskListInstance.put("selected", false);
                        }
                    }

                    jsonArray.put(k, taskListInstance);

                }

                activityLogService.addActivity(loggedInUser, "Task list accessed",
                        "parameters : " + parameters);
                LOGGER.debug("exiting  class " + TasksServiceImpl.class + " and method getTaskList");
                return ResponseEntity.ok(jsonArray.toString());
            }
        }

        activityLogService.addActivity(loggedInUser, "Task list accessed", "parameters : " + parameters);
        LOGGER.debug("exiting  class " + TasksServiceImpl.class + " and method getTaskList");
        return ResponseEntity.ok(jsonArrayResponse.toString());
    }

    @Override
    public ResponseEntity<?> getTaskPanelTemplate(String workFlowName, Integer tenantid, Authentication pr) {
        LOGGER.debug("entered in class " + TasksServiceImpl.class + " in method getTaskPanelTemplate");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            List<Integer> groupIds = loggedUser.getGroups().stream().map(gp -> gp.getIgroupID()).toList();

            // LOGGER.info("groups " + loggerEncoderUtil.encode(groupIds.toString()));
            List<PanelAccessMap> accessMaps = new ArrayList<>();
            JSONObject masterJson = new JSONObject();

            try {
                accessMaps = panelAccessMapRepositoryService.findByGroupandWorkflowName(groupIds, workFlowName,
                        tenantid, loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            accessMaps.sort(
                    (c1, c2) -> c1.getTaskPanelTemplate().getSequence() - c2.getTaskPanelTemplate().getSequence());

            // System.out.println(accessMaps);

            for (int i = 0; i < accessMaps.size(); i++) {
                // System.out.println(accessMaps.get(i).getTaskPanelTemplate().getSectionMasters());
                JSONObject innerJson = new JSONObject();
                innerJson.put("view", true);
                JSONObject componentJson = new JSONObject();

                for (int j = 0; j < accessMaps.get(i).getTaskPanelTemplate().getSectionMasters().size(); j++) {
                    JSONObject componentViewJson = new JSONObject();
                    componentViewJson.put("view", true);
                    JsonNode valueConfig = null;

                    if (accessMaps.get(i).getTaskPanelTemplate().getSectionMasters().get(j).getValueConfig() != null) {
                        if (accessMaps.get(i).getTaskPanelTemplate().getSectionMasters().get(j).getValueConfig()
                                .has("default")) {
                            valueConfig = accessMaps.get(i).getTaskPanelTemplate().getSectionMasters().get(j)
                                    .getValueConfig().get("default");
                        }

                        if (accessMaps.get(i).getTaskPanelTemplate().getSectionMasters().get(j).getValueConfig()
                                .has(workFlowName)) {
                            if (accessMaps.get(i).getTaskPanelTemplate().getSectionMasters().get(j).getValueConfig()
                                    .get(workFlowName).has(tenantid.toString())) {
                                valueConfig = accessMaps.get(i).getTaskPanelTemplate().getSectionMasters().get(j)
                                        .getValueConfig().get(workFlowName).get(tenantid.toString());
                            }
                        }
                    }

                    componentViewJson.put("value_config", valueConfig);
                    componentJson.put(
                            accessMaps.get(i).getTaskPanelTemplate().getSectionMasters().get(j).getSectionName(),
                            componentViewJson);

                }

                innerJson.put("component", componentJson);
                masterJson.put(accessMaps.get(i).getTaskPanelTemplate().getPanelName(), innerJson);

            }
            activityLogService.addActivity(loggedInUser, "Task list accessed",
                    "parameters : workflowName " + workFlowName);
            LOGGER.debug("exiting  class " + TasksServiceImpl.class + " and method getTaskList");

            // System.out.println(masterJson);
            return ResponseEntity.ok(masterJson);

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access task templates");
            LOGGER.debug("Exiting getTaskPanelTemplate Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to access task templates");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access task templates"),
                    HttpStatus.FORBIDDEN);
        }

    }

    public ResponseEntity<?> getSummary(SectionRequestBody summaryRequestBody, Integer tenantid, Authentication pr) {

        LOGGER.debug("entered in class " + TasksServiceImpl.class + " in method getSummary");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            List<String> summarynamelist = summaryRequestBody.getSectionNameList();
            Map<String, List<Map<String, Object>>> res = new HashMap<>();
            for (String summaryname : summarynamelist) {
                List<SectionParameters> listsummaryparam = null;
                try {
                    listsummaryparam = summaryParametersService.findBySummaryName(summaryname, tenantid);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to find entries by summary name",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                List<Map<String, Object>> templist = new ArrayList<>();
                for (SectionParameters summaryParameter : listsummaryparam) {
                    Integer id = summaryParameter.getIDashboardQueryID();
                    System.out.println("query id aggregated " + id);
                    if (summaryParameter.getIDashboardQueryID() != null) {
                        List<Map<String, Object>> rs = new ArrayList<>();
                        // try {
                        // rs = new
                        // DashboardQueryExecutor().execute(summaryParameter.getIDashboardQueryID(),
                        // summaryRequestBody.getParameters(), summaryRequestBody.getTimeZone());

                        String jsonparamstring = summaryRequestBody.getParameters();
                        String timezone = summaryRequestBody.getTimeZone();
                        DashboardQuery dashboardQuery = dashboardQueryService
                                .findById(summaryParameter.getIDashboardQueryID(), tenantid);

                        List<DashboardQueryParameters> listParametersoriginal = dashboardQueryParmeterService
                                .findByidAndTenant(dashboardQuery.getIDashboardQueryID(), tenantid);
                        MapSqlParameterSource parameters = new MapSqlParameterSource();
                        String queryString = dashboardQuery.getVcDashboardQuery();
                        try {
                            if (jsonparamstring != null) {

                                ObjectMapper mapper = new ObjectMapper();
                                Map<String, Object> map = null;
                                map = mapper.readValue(jsonparamstring, Map.class);

                                try {
                                    mapper.readTree(queryString);
                                    org.json.JSONObject jsonTemp = new org.json.JSONObject(queryString);
                                    HashMap<Integer, DashboardQueryParameters> t = (HashMap<Integer, DashboardQueryParameters>) listParametersoriginal
                                            .stream()
                                            .filter(c -> c.getVcParameterType().equals("JsonPath"))
                                            .collect(Collectors.toMap(DashboardQueryParameters::getIOrder,
                                                    Function.identity()));

                                    List<DashboardQueryParameters> listParameterjsonpath = new ArrayList<DashboardQueryParameters>(
                                            t.values());

                                    String path = "";
                                    org.json.JSONObject js = jsonTemp;
                                    for (DashboardQueryParameters item : listParameterjsonpath) {
                                        Object temp = new Object();
                                        temp = map.get(item.getVcParameterName());
                                        if (js.optString((String) temp) != null && js.optString((String) temp) != "") {
                                            try {
                                                js = js.optJSONObject((String) temp);
                                            } catch (ClassCastException e) {

                                            }
                                            path += "/" + temp;
                                        } else {
                                            try {
                                                js = js.optJSONObject("Other");
                                            } catch (ClassCastException e) {

                                            }
                                            path += "/" + "Other";
                                            parameters.addValue(item.getVcParameterName(), temp);
                                        }
                                    }
                                    queryString = (String) jsonTemp.optQuery(path);
                                } catch (Exception e) {

                                }
                                List<DashboardQueryParameters> listParameters = listParametersoriginal
                                        .stream()
                                        .filter(c -> !c.getVcParameterType().equals("JsonPath"))
                                        .collect(Collectors.toList());

                                for (DashboardQueryParameters item : listParameters) {
                                    String parameterName = item.getVcParameterName();
                                    switch (item.getVcParameterType()) {
                                        case "Integer":
                                            parameters.addValue(parameterName,
                                                    Integer.parseInt(map.get(parameterName).toString()));
                                            break;
                                        case "String":
                                            parameters.addValue(parameterName, (String) map.get(parameterName));
                                            break;
                                        case "Boolean":
                                            parameters.addValue(parameterName, (Boolean) map.get(parameterName));
                                            break;
                                        case "Date":
                                            TemporalAccessor ta = DateTimeFormatter.ISO_ZONED_DATE_TIME
                                                    .parse((String) map.get(parameterName));
                                            Instant i = Instant.from(ta);
                                            Date d = Date.from(i);
                                            try {
                                                parameters.addValue(parameterName, d);
                                            } catch (Exception e) {
                                                LOGGER.error(String.valueOf(e.getStackTrace()));
                                            }
                                            break;
                                        case "DateRange":
                                            ArrayList<String> myList = (ArrayList<String>) map.get(parameterName);
                                            LocalDateTime startLocalDate = LocalDate
                                                    .parse(myList.get(0),
                                                            DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSX"))
                                                    .atTime(LocalTime.MAX);
                                            LocalDateTime endLocalDate = LocalDate
                                                    .parse(myList.get(1),
                                                            DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSX"))
                                                    .atTime(LocalTime.MAX);
                                            parameters.addValue("StartDate", startLocalDate);
                                            parameters.addValue("EndDate", endLocalDate);

                                            break;
                                        case "TableName":
                                            String temp = queryString;
                                            temp = temp.replace(":" + parameterName, (String) map.get(parameterName));
                                            queryString = temp;
                                            break;
                                    }
                                }
                            }
                            if (timezone != null) {
                                parameters.addValue("timeZone", timezone);

                            }
                            parameters.addValue("tenantid", tenantid);
                            parameters.addValue("loggedinuser", loggedInUser.getIuserID());
                            parameters.addValue("orgid", loggedInUser.getIorgId().getIorgid());
                        } catch (IllegalArgumentException e) {
                            LOGGER.error(String.valueOf(e.getStackTrace()));
                        } catch (JsonMappingException e) {
                            throw new RuntimeException(e);
                        } catch (JsonProcessingException e) {
                            throw new RuntimeException(e);
                        }

                        Boolean isFormattingRequired = dashboardQuery.getFormattingRequiered();
                        List<Map<String, Object>> test = null;
                        System.out.println("query is " + queryString);

                        DatabaseType dbType;
                        try {
                            dbType = DatabaseType.fromValue(dashboardQuery.getDbType());
                        } catch (IllegalArgumentException e) {
                            LOGGER.error("Invalid database type: " + dashboardQuery.getDbType(), e);
                            throw new RuntimeException(e);
                        }

                        JdbcTemplate selectedJdbcTemplate = jdbcTemplateMap.get(dbType);
                        if (selectedJdbcTemplate == null) {
                            throw new IllegalArgumentException("No JdbcTemplate found for database type: " + dbType);
                        }

                        if (parameters.getValues().size() != 0) {
                            NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(
                                    selectedJdbcTemplate.getDataSource());
                            test = jdbcTemplateObject.queryForList(queryString, parameters);
                        } else {
                            test = selectedJdbcTemplate.queryForList(queryString);
                        }
                        // if (isanalytics != null) {
                        // if (isanalytics) {
                        // if (parameters.getValues().size() != 0) {
//                                    NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(
                        // jdbcTemplateAnalytics.getDataSource());
                        // test = jdbcTemplateObject.queryForList(queryString, parameters);
                        // } else {
                        // test = jdbcTemplateAnalytics.queryForList(queryString);
                        // }
                        // } else {
                        // if (parameters.getValues().size() != 0) {
//                                    NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(
                        // jdbcTemplateTransactional.getDataSource());
                        // test = jdbcTemplateObject.queryForList(queryString, parameters);
                        // } else {
                        // test = jdbcTemplateTransactional.queryForList(queryString);
                        // }
                        // }
                        // } else {
                        // if (parameters.getValues().size() != 0) {
//                                NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(
                        // jdbcTemplateTransactional.getDataSource());
                        // test = jdbcTemplateObject.queryForList(queryString, parameters);
                        // } else {
                        // test = jdbcTemplateTransactional.queryForList(queryString);
                        // }
                        // }
                        templist.addAll(test);
                    }
                }
                res.put(summaryname, templist);
            }
            return ResponseEntity.ok(res);

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access summary");
            LOGGER.debug("Exiting getSummary Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to access summary");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access getSummary"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> getAMLStatusDropDowns(Integer tenantid, String workflowKey, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getChangeStatusDropDown");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);
        List<DropdownWithObject> changeStatusDropDown = new ArrayList<>();

        if (mp.isView()) {

            // List<DropdownWithObject> changeStatusDropDown = new ArrayList<>();
            ResponseEntity<String> bpmnXml = null;
            try {

                bpmnXml = camundaService.getBPMN(
                        "key/" + workflowKey + "/tenant-id/" + tenantid,
                        loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + "AMLCases");
                activityLogService.addActivity(loggedInUser, "failed to get BPMN XML",
                        "Error : " + e.toString() + ", Parameters : " + "AMLCases");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            String bpmnResponse = bpmnXml.getBody();

            // System.out.println(bpmnXml.statusCode());

            ObjectMapper mapper1 = new ObjectMapper();

            try {

                JsonNode rootNode = mapper1.readTree(bpmnResponse);

                DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
                InputSource src = new InputSource();
                src.setCharacterStream(new StringReader(rootNode.get("bpmn20Xml").asText()));

                org.w3c.dom.Document doc = builder.parse(src);

                for (int j = 0; j < doc.getElementsByTagName("bpmn:userTask").getLength(); j++) {

                    if (doc.getElementsByTagName("bpmn:userTask").item(j).getAttributes().getNamedItem("name")
                            .getNodeValue().contains("Review Case By L1/ L2")) {

                        for (int k = 0; k < doc.getElementsByTagName("bpmn:userTask").item(j).getChildNodes()
                                .item(1)
                                .getChildNodes().item(1).getChildNodes().getLength(); k++) {
                            if (doc.getElementsByTagName("bpmn:userTask").item(j).getChildNodes().item(1)
                                    .getChildNodes().item(1).getChildNodes().item(k).getNodeName()
                                    .equals("camunda:formField")) {
                                if (doc.getElementsByTagName("bpmn:userTask").item(j).getChildNodes().item(1)
                                        .getChildNodes().item(1).getChildNodes().item(k).getAttributes()
                                        .getNamedItem("id").getNodeValue().equals("statusoptions")) {
                                    for (int h = 0; h < doc.getElementsByTagName("bpmn:userTask").item(j)
                                            .getChildNodes().item(1).getChildNodes().item(1).getChildNodes().item(k)
                                            .getChildNodes().getLength(); h++) {
                                        if (doc.getElementsByTagName("bpmn:userTask").item(j).getChildNodes()
                                                .item(1)
                                                .getChildNodes().item(1).getChildNodes().item(k).getChildNodes()
                                                .item(h)
                                                .getNodeName().equals("camunda:value")) {

                                            if (!doc.getElementsByTagName("bpmn:userTask").item(j)
                                                    .getChildNodes().item(1).getChildNodes().item(1)
                                                    .getChildNodes().item(k).getChildNodes().item(h)
                                                    .getAttributes().getNamedItem("name").getNodeValue()
                                                    .equalsIgnoreCase("none")) {
                                                changeStatusDropDown.add(DropdownWithObject.builder()
                                                        .label(doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                .getChildNodes().item(1).getChildNodes().item(1)
                                                                .getChildNodes().item(k).getChildNodes().item(h)
                                                                .getAttributes().getNamedItem("name")
                                                                .getNodeValue())
                                                        .value(doc.getElementsByTagName("bpmn:userTask").item(j)
                                                                .getChildNodes().item(1).getChildNodes().item(1)
                                                                .getChildNodes().item(k).getChildNodes().item(h)
                                                                .getAttributes().getNamedItem("name")
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
                LOGGER.error("Error : " + e + "\nParam : " + bpmnResponse);
                activityLogService.addActivity(loggedInUser, "failed to get Values from BPMN XML",
                        "Error : " + e.toString() + ", Parameters : " + bpmnResponse);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);

            }

            // Collections.reverse(changeStatusDropDown);
            // changeStatusAll.put(key, changeStatusDropDown);
            Collections.reverse(changeStatusDropDown);
            activityLogService.addActivity(loggedInUser, "Rejection Reason Values Obtained",
                    "parameters : " + changeStatusDropDown);
            LOGGER.debug("Exiting getDocumentRejectionReason Method in " + TasksServiceImpl.class
                    + " class with response : status list");
            // Collections.reverse(changeStatusDropDown);
            return ResponseEntity.ok(changeStatusDropDown);
        } else {
            activityLogService.addActivity(loggedInUser, "Failed to get values of Rejection Reason");
            LOGGER.debug("Exiting getChangeStatusDropDown Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get form variable");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Failed to get values of Rejection Reason"),
                    HttpStatus.FORBIDDEN);
        }

    }

    public ResponseEntity<?> getSTRForm(String formname, Integer tenantid, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getSTRForm");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            FormMasterDTO response = formMasterDTOMapper
                    .apply(formMasterService.findByFormName(formname, loggedInUser, tenantid));
            return ResponseEntity.ok(response);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get str form");
            LOGGER.debug("Exiting getSTRForm Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get str form");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Unauthorized to get str form"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> getSTRFormValue(Integer form_value_id, Integer tenantid, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method getSTRFormValue");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            FormValueDTO response = formValueDTOMapper
                    .apply(formValueService.findByID(form_value_id, loggedInUser, tenantid));
            return ResponseEntity.ok(response);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get str form value");
            LOGGER.debug("Exiting getSTRForm Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get str form value");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Unauthorized to get str form value"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Transactional(rollbackFor = Throwable.class)
    public ResponseEntity<?> addSTRForm(AddFormValue add_form_value, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method addSTRFrom");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isAdd()) {
            FormMaster form_master = formMasterService.findByID(add_form_value.getIformid(), loggedInUser,
                    add_form_value.getItenantId());
            FormValue form_value = FormValue.builder()
                    .iFormID(form_master.getIformID())
                    .valuesJson(add_form_value.getValuesjson())
                    .itenantId(add_form_value.getItenantId())
                    .build();

            form_value = formValueService.save(form_value);

            if (form_master.getActionAfterCreation() != null) {
                try {
                    return strFromActionAfterCreation.validate(form_value, add_form_value, loggedInUser, "POST");
                } catch (Exception e) {
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to form value", e.toString());
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

            }
            return new ResponseEntity<ApiResponse>(new ApiResponse(true, "form added successfully"), HttpStatus.OK);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to add str form");
            LOGGER.debug("Exiting addSTRForm Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to add str form");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Unauthorized to add str form"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getUsersQc(Authentication pr, String vcgroupid, Integer tenantid) {
        List<WebUser> usersRole = new ArrayList<>();
        try {
            usersRole = webUserService.findByVcGroupIDsTenant(Arrays.asList(vcgroupid), tenantid);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + pr + " vcgroupid : " + vcgroupid + " itenantid " + tenantid);
            // activityLogService.addActivity(loggedInUser, "db query exception ",
            // e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "db query exception"),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        List<QcResponse> res = new ArrayList<>();
        usersRole.stream()
                .map(wb -> res.add(QcResponse.builder().user(wb.getVcUserName()).emailId(wb.getVcEmailID()).build()))
                .collect(Collectors.toList());

        return ResponseEntity.ok(res);
    }

    @Transactional(rollbackFor = Throwable.class)
    public ResponseEntity<?> editSTRForm(Integer form_value_id, AddFormValue add_form_value, Authentication pr) {
        LOGGER.debug("entering  class " + TasksServiceImpl.class + " and method addSTRFrom");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isAdd()) {

            FormValue form_value_to_be_edited = formValueService.findByID(form_value_id, loggedInUser,
                    add_form_value.getItenantId());

            FormMaster form_master = add_form_value.getIformid() == form_value_to_be_edited.getIFormID()
                    ? formMasterService.findByID(form_value_to_be_edited.getIFormID(), loggedInUser,
                    add_form_value.getItenantId())
                    : formMasterService.findByID(add_form_value.getIformid(), loggedInUser,
                    add_form_value.getItenantId());

            FormValue form_value = FormValue.builder()
                    .ivalueID(form_value_to_be_edited.getIvalueID())
                    .iFormID(form_master.getIformID())
                    .valuesJson(add_form_value.getValuesjson())
                    .itenantId(add_form_value.getItenantId())
                    .build();

            formValueService.save(form_value);
            if (form_master.getActionAfterCreation() != null) {
                try {
                    strFromActionAfterCreation.validate(form_value, add_form_value, loggedInUser, "PUT");
                } catch (Exception e) {
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to form value", e.toString());
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

            }

            return new ResponseEntity<ApiResponse>(new ApiResponse(true, "form edited successfully"), HttpStatus.OK);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to edit str form");
            LOGGER.debug("Exiting editSTRForm Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to edit str form");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Unauthorized to edit str form"),
                    HttpStatus.FORBIDDEN);
        }
    }

    private Map<String, Object> createVpaMap(org.json.JSONObject taskListInstance, org.json.JSONObject transaction,
                                             Map<String, String> activeTaskMap, JSONArray detailList) {
        Map<String, Object> vpaMap = new TreeMap<>();
        vpaMap.put("CreatedTime", taskListInstance.optString("startTime"));
        vpaMap.put("Transaction", transaction.toMap());

        if (!taskListInstance.optString("state").toString().equalsIgnoreCase("ACTIVE")) {
            vpaMap.put("State", taskListInstance.optString("state"));
            vpaMap.put("Completed", true);
        } else {
            vpaMap.put("State", activeTaskMap.get(taskListInstance.get("id")));
            vpaMap.put("Completed", false);
        }

        for (int l = 0; l < detailList.length(); l++) {
            if (taskListInstance.get("id").equals(detailList.getJSONObject(l).get("processInstanceId"))) {
                org.json.JSONObject variable2 = detailList.getJSONObject(l);
                String variableName = variable2.optString("variableName");
                Object value = variable2.opt("value");

                switch (variableName) {
                    case "TicketID":
                        vpaMap.put("TicketID", value);
                        break;
                    case "WorkflowName":
                        vpaMap.put("WorkflowName", value);
                        break;
                    case "RiskScore":
                        vpaMap.put("RiskScore", value);
                        break;
                    case "AvgRiskScore":
                        vpaMap.put("AvgRiskScore", value);
                        break;
                }
            }
        }

        return vpaMap;
    }

    private Optional<org.json.JSONObject> findTransaction(JSONArray detailList, String processInstanceId) {
        for (int j = 0; j < detailList.length(); j++) {
            org.json.JSONObject detail = detailList.getJSONObject(j);
            if (processInstanceId.equals(detail.get("processInstanceId")) &&
                    detail.opt("variableName") != null && detail.opt("variableName").equals("Transaction") &&
                    detail.opt("revision").equals(0)) {
                try {
                    JSONArray valueArray = detail.optJSONArray("value");
                    if (valueArray != null && valueArray.length() > 0) {
                        return Optional.of(valueArray.getJSONObject(0));
                    } else {
                        return Optional.of(new org.json.JSONObject(detail.optString("value")));
                    }
                } catch (JSONException e) {
                    return Optional.empty();
                }
            }
        }
        return Optional.empty();
    }

    @Override
    public ResponseEntity<?> sanctionSearch(String proc_inst_id, Authentication pr) throws Exception {

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            String processInJson = "{\n  \"processInstanceId\":\"" + proc_inst_id
                    + "\",\r\n    \"variableNameIn\":[\"field\",\"term\",\"name\",\"source\",\"onboardingData\"]\r\n    \r\n   \r\n}";

            ResponseEntity<String> details = null;

            try {

                details = camundaService.postHistoryVarInstance(processInJson, loggedInUser);

            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + processInJson);
                activityLogService.addActivity(loggedInUser, "failed to get details",
                        "Error : " + e.toString() + ", Parameters : " + processInJson);
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (details != null) {
                if (details.getStatusCode() == HttpStatus.OK) {
                    org.json.JSONObject res_body = new org.json.JSONObject();
                    org.json.JSONObject search_body = new org.json.JSONObject();
                    org.json.JSONObject query_body = new org.json.JSONObject();
                    search_body.put("id", UUID.randomUUID().toString());
                    JSONArray detailList = new JSONArray(details.getBody());

                    for (int n = 0; n < detailList.length(); n++) {
                        if (detailList.getJSONObject(n).getString("name").equals("name")) {
                            res_body.put("name", detailList.getJSONObject(n).get("value"));
                        }

                        if (detailList.getJSONObject(n).getString("name").equals("field")) {
                            res_body.put("field", detailList.getJSONObject(n).get("value"));
                            query_body.put("type", detailList.getJSONObject(n).get("value"));
                        }

                        if (detailList.getJSONObject(n).getString("name").equals("onboardingData")) {
                            res_body.put("onboardingData", detailList.getJSONObject(n).get("value"));

                        }

                        if (detailList.getJSONObject(n).getString("name").equals("term")) {
                            query_body.put("term", detailList.getJSONObject(n).get("value"));
                        }

                        if (detailList.getJSONObject(n).getString("name").equals("source")) {
                            res_body.put("source", detailList.getJSONObject(n).get("value"));
                            search_body.put("criteria",
                                    new org.json.JSONObject().put("source", detailList.getJSONObject(n).get("value")));
                        }
                    }

                    search_body.put("query", query_body);

                    ResponseEntity<String> search_response = sanctionApiService.search(search_body.toString());

                    if (search_response.getStatusCode() == HttpStatus.OK) {
                        res_body.put("search_result", new org.json.JSONObject(search_response.getBody()));
                        LOGGER.info("Exiting santion search method with response " + res_body);
                        activityLogService.addActivity(loggedInUser, "sanction search api called successfully ");
                        return ResponseEntity.ok(res_body.toMap());

                    } else {
                        LOGGER.info("Exiting santion search method with response " + res_body);
                        activityLogService.addActivity(loggedInUser,
                                "sanction search api call failed with response " + res_body);
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, search_response.getBody()),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                } else {
                    LOGGER.error("Exiting santion search method ");
                    activityLogService.addActivity(loggedInUser, "sanction search api call failed ");
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Camunda API call failed"),
                            HttpStatus.INTERNAL_SERVER_ERROR);

                }
            } else {
                LOGGER.error("Exiting santion search method ");
                activityLogService.addActivity(loggedInUser, "sanction search api call failed ");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Camunda API call failed"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to search sanctions");
            LOGGER.debug("Exiting sanctionSearch Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to search sanction");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Unauthorized to search sanction"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> sanctionFetch(String search_id, String source, Authentication pr) throws Exception {
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);
        if (mp.isView()) {
            org.json.JSONObject req_body = new org.json.JSONObject();
            req_body.put("doc_ref", source);
            req_body.put("source", search_id);

            LOGGER.info("req body " + loggerEncoderUtil.encode(req_body.toString()));

            ResponseEntity<String> fetch_response = sanctionApiService.fetch(req_body.toString());

            if (fetch_response.getStatusCode() == HttpStatus.OK) {

                LOGGER.info("Exiting sanction fetch method with response " + fetch_response.getBody());
                activityLogService.addActivity(loggedInUser, "sanction fetch api called successfully ");
                return ResponseEntity.ok(fetch_response.getBody());
            } else {
                LOGGER.error("Exiting sanction fetch  method ");
                activityLogService.addActivity(loggedInUser, "sanction fetch api call failed ");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, fetch_response.getBody()),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to fetch sanction details");
            LOGGER.debug("Exiting sanctionFetch Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to fetch sanction details");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Unauthorized to fetch sanction details"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getUsersTask(String taskid, Integer tenantid, Authentication pr) {
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            ResponseEntity<String> clientResponse = null;
            try {
                clientResponse = camundaService.getTaskGroups(taskid, loggedInUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(taskid));
                activityLogService.addActivity(loggedInUser, "failed to get groups of task",
                        "Error : " + e.toString() + ", Parameters : " + taskid);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            // String responses = clientResponse.bodyToMono(String.class).block();
            String responses = clientResponse.getBody();
            // clientResponse.releaseBody();
            Set<String> users = new HashSet<>();
            HttpStatusCode status = HttpStatusCode.valueOf(400);
            if (clientResponse.getStatusCode() == HttpStatus.OK) {
                JSONArray jsonArray = new JSONArray(responses);
                List<String> groups = new ArrayList<>();
                for (int i = 0; i < jsonArray.length(); i++) {
                    org.json.JSONObject obj = jsonArray.getJSONObject(i);
                    System.out.println("gr" + obj.optString("groupId"));
                    if (obj.getString("type").equals("candidate") && !obj.optString("groupId").isBlank()) {
                        groups.add(obj.getString("groupId"));
                    } else if (obj.getString("type").equals("candidate") && obj.optString("groupId").isBlank()) {
                        users.add(obj.optString("userId"));
                    }
                }
                List<DropdownWithObject> retRes = new ArrayList<>();
                try {

                    List<WebUser> webUsers = webUserService.findByVcGroupIDsTenant(groups, tenantid);
                    List<String> origUsers = webUsers.stream().map(x -> x.getIuserID().toString())
                            .collect(Collectors.toList());

                    users.addAll(origUsers);
                    users.remove(loggedInUser.getIuserID().toString());

                    users.stream().map(
                                    c -> retRes.add(
                                            DropdownWithObject.builder().label(webUserService.findByIUserID(c)).value(c)
                                                    .build()))
                            .collect(Collectors.toList());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to execute db query ", e.toString());
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                return ResponseEntity.ok(retRes);
            } else if (responses.contains("Cannot find task with id " + taskid + ": task is null")) {
                responses = "Task already closed";
                LOGGER.info("Exiting getUsersTask Method in " + TasksServiceImpl.class
                        + " class with response  : " + responses);
            } else {
                status = clientResponse.getStatusCode();
                LOGGER.error("Exiting unClaimTask Method in " + TasksServiceImpl.class
                        + " class with response  : " + responses);
            }

            activityLogService.addActivity(loggedInUser, "Camunda API call failed",
                    "Parameters : " + taskid);

            return new ResponseEntity<ApiResponse>(new ApiResponse(false, responses),
                    status);

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to fetch users of task");
            LOGGER.debug("Exiting getUsersTask Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to fetch users of task");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Unauthorized to fetch users of task"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> downloadAttachmentFromFileStorage(String transactionID, String fileName, Authentication pr,
                                                               HttpServletRequest request, Integer tenantid)
            throws Exception {
        LOGGER.debug("entered in class " + TasksServiceImpl.class
                + " in method downloadAttachmentFromFileStorage by user " + pr.getName());

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            String upload_DIR = env.getProperty("file.upload-dir");

            Path path = Paths
                    .get(upload_DIR + File.separator + tenantid + File.separator + transactionID + File.separator
                            + fileName)
                    .toAbsolutePath().normalize();

            if (!Files.exists(path)) {
                System.out.println("reached here ");
                path = Paths
                        .get(upload_DIR + File.separator + transactionID + File.separator
                                + fileName)
                        .toAbsolutePath().normalize();
            }

            Resource resource = null;

            resource = new UrlResource(path.toUri());

            String contentType = null;
            try {
                contentType = request.getServletContext().getMimeType(resource.getFile().getAbsolutePath());
            } catch (Exception e) {
                LOGGER.error("Error : " + e);
                activityLogService.addActivity(loggedInUser, "failed to download file",
                        "Error : " + e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (contentType == null) {
                contentType = "application/octet-stream";
            }

            activityLogService.addActivity(loggedInUser, "download attachment",
                    "Parameters : " + resource.getFile().getAbsolutePath());
            LOGGER.debug("Exiting downloadAttachmentFromFileStorage Method in " + TasksServiceImpl.class
                    + " class with response  : download attachment");
            return ResponseEntity.ok().contentType(MediaType.parseMediaType(contentType))
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
                    .body(resource);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to download file");
            LOGGER.debug("Exiting downloadAttachmentFromFileStorage Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to download file");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to download file"),
                    HttpStatus.FORBIDDEN);
        }
    }

    private Map<String, Object> getParameterValues(List<MetadataUi> metadata, String address, String type,
                                                   Integer tenantid) {
        Map<String, Object> listParameters = new HashMap<>();
        MapSqlParameterSource parameters = new MapSqlParameterSource();
        String queryString = "";
        parameters.addValue("id", address);
        parameters.addValue("tenantid", tenantid);
        if (type.equals("account")) {
            queryString = "select prof.val from masters.accounts mas join profiles.account prof on mas.iaccountid=prof.iaccountid where mas.vcexternalaccountid=:id and mas.itenantid = :tenantid order by prof.tdate desc limit 1";
        } else if (type.equals("vpa")) {
            queryString = "select prof.val from masters.vpa mas join profiles.vpa prof on mas.ivpaid=prof.ivpaid where mas.vcexternaladdressid=:id and mas.itenantid = :tenantid order by prof.tdate desc limit 1";
        }
        JdbcTemplate selectedJdbcTemplate = jdbcTemplateMap.get(DatabaseType.POSTGRESQL_ANALYTICS);
        NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(
                selectedJdbcTemplate.getDataSource());
//        NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(
        // jdbcTemplateAnalytics.getDataSource());
        List<Map<String, Object>> res = jdbcTemplateObject.queryForList(queryString, parameters);
        jdbcTemplateObject = null;
        if (res == null || res.size() != 1) {
            LOGGER.info("No data found from profiles in analytics db for type " + loggerEncoderUtil.encode(type)
                    + " address " + loggerEncoderUtil.encode(address));
            return listParameters;
        }

        String txnJsonStr = res.get(0).get("val").toString();
        System.out.println("Json obtained from anadb for address " + address + " is " + txnJsonStr);
        ObjectMapper mapper = new ObjectMapper();
        mapper.enable(JsonGenerator.Feature.WRITE_BIGDECIMAL_AS_PLAIN);
        JsonNode txnNode = null;
        try {
            txnNode = mapper.readTree(txnJsonStr);
        } catch (Exception e) {
            LOGGER.error("Error " + e.toString() + " parsing txn parameter values");
            return listParameters;
        }

        for (MetadataUi md : metadata) {
            String pathString = md.getVcpath();
            JsonNode config = md.getConfig();
            String[] path = pathString.split("\\.");
            for (int i = 0; i < path.length; i++) {
                String elem = path[i];
                if (elem.startsWith("{") && elem.endsWith("}")) {
                    String name = elem.substring(1, elem.length() - 1);
                    path[i] = config.path(name).asText();
                }
            }
            System.out.println("Searching for path " + "/" + String.join("/", path));
            JsonNode value = txnNode.at("/" + String.join("/", path));
            if (!value.isMissingNode()) {
                listParameters.put(md.getVccolumnname(), value.asText());
            }
        }
        return listParameters;

    }

    @Override
    public ResponseEntity<?> getProfileParameters(ProfileParameters request, Authentication pr) throws Exception {
        LOGGER.debug("entered in class " + TasksServiceImpl.class
                + " in method getProfileParameters by user " + pr.getName());

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);
        if (!mp.isView()) {
            activityLogService.addActivity(loggedInUser, "unauthorized to download file");
            LOGGER.debug("Exiting getProfileParameters Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get profile parameters");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to get profile parameters"),
                    HttpStatus.FORBIDDEN);
        }

        List<MetadataUi> metadataVpa = null;
        List<MetadataUi> metadataAccount = null;
        List<String> columnsVpa = null;
        List<String> columnsAccount = null;
        Integer tenantid = request.getTenantid();
        System.out.println("tenantid is " + tenantid);
        try {
            columnsVpa = profileParamsService.findByWorkflowAndType(request.getWorkflowKey(), "vpa",
                    request.getTenantid());
            columnsAccount = profileParamsService.findByWorkflowAndType(request.getWorkflowKey(), "account",
                    request.getTenantid());

            System.out.println("size of columsn from config for vpa " + columnsVpa.size());
            System.out.println("size of columns frm config for account " + columnsAccount.size());

            // tenantid =
            // workflowMasterService.findWorkflowTenantId(request.getWorkflowKey());

            metadataVpa = metadataUiService.findByColumnAndRootTenant(columnsVpa, "vpa", tenantid);
            metadataAccount = metadataUiService.findByColumnAndRootTenant(columnsAccount, "account", tenantid);

            System.out.println("size of metadatavpa " + metadataVpa.size());
            System.out.println("size of metadataaccount" + metadataAccount.size());
        } catch (Exception e) {

            activityLogService.addActivity(loggedInUser, "unauthorized to download file");
            LOGGER.error("Exiting getProfileParameters Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get profile parameters" + e);
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
        ProfileParametersRes res = new ProfileParametersRes();
        if (request.getPayeeAccount() != null) {
            res.setPayeeAccount(getParameterValues(metadataAccount, request.getPayeeAccount(), "account", tenantid));
        }

        if (request.getPayerAccount() != null) {
            res.setPayerAccount(getParameterValues(metadataAccount, request.getPayerAccount(), "account", tenantid));
        }

        if (request.getPayeeVpa() != null) {
            res.setPayeeVpa(getParameterValues(metadataVpa, request.getPayeeVpa(), "vpa", tenantid));
        }

        if (request.getPayerVpa() != null) {
            res.setPayerVpa(getParameterValues(metadataVpa, request.getPayerVpa(), "vpa", tenantid));
        }
        return ResponseEntity.ok(res);
    }

    @Override
    public ResponseEntity<?> getManualWorkflows(Integer tenantid, Authentication pr) {
        LOGGER.debug("entered in class " + TasksServiceImpl.class
                + " in method getManualWorkflows by user " + pr.getName());

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name_manual);

        if (!mp.isAdd() || !loggedUser.allowTenants(Arrays.asList(tenantid))) {
            activityLogService.addActivity(loggedInUser, "unauthorized to download file");
            LOGGER.debug("Exiting getManualWorkflows Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get profile parameters");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to get list of workflows"),
                    HttpStatus.FORBIDDEN);
        }

        List<WorkflowMasters> workflows = loggedUser.getWorkflows().stream()
                .filter(wf -> (wf.getItenantId().getItenantid().equals(tenantid) && wf.getIsManualCreation() != null
                        && wf.getIsManualCreation()))
                .toList();

        List<DropdownWithObject> res = DropdownWithObjectMapper.parseManualWorkflows(workflows);
        return ResponseEntity.ok(res);
    }

    @Override
    public ResponseEntity<?> getBatchDecisions(Authentication pr) {
        LOGGER.debug("entered in class " + TasksServiceImpl.class
                + " in method getManualWorkflows by user " + pr.getName());

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name_manual);
        if (!mp.isAdd()) {
            activityLogService.addActivity(loggedInUser, "unauthorized to download file");
            LOGGER.debug("Exiting getManualWorkflows Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get profile parameters");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to get list of workflows"),
                    HttpStatus.FORBIDDEN);
        }

        List<DecisionUi> decisionUis = new ArrayList<>();
        try {
            decisionUis = decisionUiService.findActiveBatchDecisions();
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + pr);
            activityLogService.addActivity(loggedInUser, "failed to execute query", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        List<DropdownWithObject> res = DropdownWithObjectMapper.parseManualDecisions(decisionUis);

        return ResponseEntity.ok(res);

    }

    @Override
    public ResponseEntity<?> getBatchTrans(String address, String level, String frequency, String date,
                                           Integer workflowid, Integer tenantid, Authentication pr) {
        LOGGER.debug("entered in class " + TasksServiceImpl.class
                + " in method getBatchTrans by user " + pr.getName());

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name_manual);
        if (!mp.isAdd()) {
            activityLogService.addActivity(loggedInUser, "unauthorized to get batch trans");
            LOGGER.debug("Exiting getManualWorkflows Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get profile parameters");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to get batch trans"),
                    HttpStatus.FORBIDDEN);
        }

        String queryString = "";

        WorkflowMasters wfl = null;
        try {
            wfl = workflowMasterService.findByWorkflowID(workflowid, tenantid);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + pr);
            activityLogService.addActivity(loggedInUser, "failed to parse observations and/or result", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        String selecPart = "SELECT cast(observations as text), cast(result as text) FROM analytics.batchtrans ";
        if ("account".equalsIgnoreCase(level)) {
            queryString = selecPart
                    + "WHERE vcaccountexternalid = :address AND itenantid = :tenantid AND cast(dttrxntime as date) = cast(:date as date) AND observations->'observations'->'decisionclass'->'attribs'->>'tablename' = :tablename";
        } else if ("vpa".equalsIgnoreCase(level)) {
            queryString = selecPart
                    + "WHERE vcaddr = :address AND itenantid = :tenantid AND cast(dttrxntime as date) = cast(:date as date) AND observations->'observations'->'decisionclass'->'attribs'->>'tablename' = :tablename";
        } else {
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Level should be account or vpa"),
                    HttpStatus.BAD_REQUEST);
        }

        String tablename = "";
        if (frequency.equalsIgnoreCase("daily")) {
            tablename = level;
        } else if (frequency.equalsIgnoreCase("weekly")) {
            tablename = level + "_weekly";
        } else if (frequency.equalsIgnoreCase("monthly")) {
            tablename = level + "_monthly";
        }
        MapSqlParameterSource parameters = new MapSqlParameterSource();
        parameters.addValue("address", address);
        parameters.addValue("date", date);
        parameters.addValue("tablename", tablename);
        parameters.addValue("tenantid", tenantid);

        System.out.println("parameters are " + parameters);
        JdbcTemplate selectedJdbcTemplate = jdbcTemplateMap.get(DatabaseType.POSTGRESQL_ANALYTICS);
        List<Map<String, Object>> txn = new NamedParameterJdbcTemplate(
                selectedJdbcTemplate.getDataSource())
                .queryForList(queryString, parameters);
        // List<Map<String, Object>> txn = new NamedParameterJdbcTemplate(
        // jdbcTemplateAnalytics.getDataSource())
        // .queryForList(queryString, parameters);

        if (txn.size() > 0) {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode trans, result;
            try {
                trans = mapper.readTree((String) txn.get(0).get("observations"));
                result = mapper.readTree((String) txn.get(0).get("result"));
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + pr);
                activityLogService.addActivity(loggedInUser, "failed to parse observations and/or result",
                        e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            Map<String, Object> response = new HashMap<>();
            response.put("Transaction", trans);
            response.put("Result", result);
            return ResponseEntity.ok(response);
        } else {
            activityLogService.addActivity(loggedInUser, "No record found");
            LOGGER.debug("Exiting getBatchTrans Method in " + TasksServiceImpl.class
                    + " class with response  : No record found");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false,
                            "No record can be found for this combination"),
                    HttpStatus.BAD_REQUEST);
        }

    }

    @Override
    public ResponseEntity<?> getRulesDecision(Integer workflowid, Integer tenantid, Authentication pr) {
        LOGGER.debug("entered in class " + TasksServiceImpl.class
                + " in method getRulesDecision by user " + pr.getName());

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name_manual);
        if (!mp.isAdd() || !loggedUser.allowWorkflowId(workflowid)) {
            activityLogService.addActivity(loggedInUser, "unauthorized to get batch trans");
            LOGGER.debug("Exiting getManualWorkflows Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get profile parameters");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to load mapped rules"),
                    HttpStatus.FORBIDDEN);
        }

        DecisionUi decision = null;
        List<Rules> rulesAll = null;
        try {
            WorkflowMasters wfl = workflowMasterService.findByWorkflowID(workflowid, tenantid);
            Integer decInt = wfl.getDecisionId();
            rulesAll = rulesTempService.findAllByIDecisionID(decInt, tenantid);
            decision = decisionUiService.findByiDecisionID(decInt, tenantid);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + pr);
            activityLogService.addActivity(loggedInUser, "failed to parse workflow and/or decision", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        if (decision == null) {
            LOGGER.info("Matching decision not found");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        DecRulesVO response = new DecRulesVO();
        response.setRulesDropDown(RulesDropDownVOMapper.parse(rulesAll));
        response.setAggregateType(decision.getVcResultParams().get("score_agg") != null
                ? decision.getVcResultParams().get("score_agg").asText()
                : "");
        return ResponseEntity.ok(response);
    }

    @Override
    public ResponseEntity<?> getWorkflowParams(Integer workflowid, Integer tenantid, Authentication pr) {
        LOGGER.debug("entered in class " + TasksServiceImpl.class
                + " in method getRulesDecision by user " + pr.getName());

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name_manual);
        if (!mp.isAdd() || !loggedUser.allowWorkflowId(workflowid)) {
            activityLogService.addActivity(loggedInUser, "unauthorized to get batch trans");
            LOGGER.debug("Exiting getManualWorkflows Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get profile parameters");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to get batch trans"),
                    HttpStatus.FORBIDDEN);
        }

        WorkflowMasters workflow = null;
        try {
            workflow = workflowMasterService.findByWorkflowID(workflowid, tenantid);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + pr);
            activityLogService.addActivity(loggedInUser, "failed to parse observations and/or result", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return ResponseEntity.ok(workflow.getAttribs().get("display"));
    }

    @Override
    public ResponseEntity<?> getProfileDates(String address, String level, String frequency, Integer workflowid,
                                             Integer tenantid,
                                             Authentication pr) {
        LOGGER.debug("entered in class " + TasksServiceImpl.class
                + " in method getProfileDates by user " + pr.getName());

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        Integer iuserid = loggedInUser.getIuserID();
        Integer iorgid = loggedInUser.getIorgId().getIorgid();
        UserMapping classid = loggedUser.getUserClass();

        MenuPermissions mp = loggedUser.getPermissions().get(menu_name_manual);
        if (!mp.isView()) {
            activityLogService.addActivity(loggedInUser, "unauthorized to get batch trans");
            LOGGER.debug("Exiting getManualWorkflows Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get profile parameters");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to get batch trans"),
                    HttpStatus.FORBIDDEN);
        }

        WorkflowMasters wfl = null;
        try {
            wfl = workflowMasterService.findByWorkflowID(workflowid, tenantid);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + pr);
            activityLogService.addActivity(loggedInUser, "failed to parse observations and/or result", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        DashboardQueryRequest dashboardQueryRequest = new DashboardQueryRequest();
        dashboardQueryRequest.setQueryID(153);
        dashboardQueryRequest.setIuserid(iuserid);
        dashboardQueryRequest.setIorgid(iorgid);
        dashboardQueryRequest.setClassIds(classid);
        dashboardQueryRequest.setItenantID(tenantid);

        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> params = new HashMap<>();

        String levelParam = "";

        if ("account".equalsIgnoreCase(level)) {
            levelParam = "Account";
        } else if ("vpa".equalsIgnoreCase(level)) {
            levelParam = "VPA";
        } else {
            LOGGER.debug("Exiting getProfileDates Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get profile parameters");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Level should be account or vpa"),
                    HttpStatus.BAD_REQUEST);
        }

        params.put("Level", levelParam);
        params.put("address", address);

        DashboardDataService temp = new DashboardDataService(dashboardQueryService, dashboardQueryParmeterService,
                loggerEncoderUtil,
                activityLogService, jdbcTemplateMap, transactionClassesUiService, dashboardErrorUtil);

        try {
            dashboardQueryRequest.setParametersJson(mapper.writeValueAsString(params));
        } catch (Exception e) {
            LOGGER.error("Error serializing params to JSON: " + e.getMessage());
        }

        List<Map<String, Object>> output = new ArrayList<>();

        ResponseEntity<?> result = temp.getResultSetDataService(dashboardQueryRequest);
        if (result.getBody() instanceof ApiResponse) {
            return result;
        } else {
            ResultSetResponse resultSetResponse = (ResultSetResponse) result.getBody();
            output = (List<Map<String, Object>>) resultSetResponse.data();
        }

        // String queryString = "";
        // if ("account".equalsIgnoreCase(level)) {
        // queryString = "SELECT iaccountid FROM masters.accounts WHERE
        // vcexternalaccountid = :address and itenantid = :tenantid";
        // } else if ("vpa".equalsIgnoreCase(level)) {
        // queryString = "SELECT ivpaid FROM masters.vpa WHERE vcexternaladdressid =
        // :address and itenantid = :tenantid";
        // } else {
        // LOGGER.debug("Exiting getProfileDates Method in " + TasksServiceImpl.class
        // + " class with response : unauthorized to get profile parameters");
        // return new ResponseEntity<ApiResponse>(
        // new ApiResponse(false, "Level should be account or vpa"),
        // HttpStatus.BAD_REQUEST);
        // }
        //
        // MapSqlParameterSource parameters = new MapSqlParameterSource();
        // parameters.addValue("address", address);
        // parameters.addValue("tenantid", tenantid);
        //
        // System.out.println("parameters are " + parameters);
        // List<Map<String, Object>> output = new NamedParameterJdbcTemplate(
        // jdbcTemplateTransactional.getDataSource())
        // .queryForList(queryString, parameters);
        if (output.size() == 0) {
            activityLogService.addActivity(loggedInUser, "vpa or account not present");
            LOGGER.debug("Exiting getManualWorkflows Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get profile parameters");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "VPA/Account not found for the entered address"),
                    HttpStatus.BAD_REQUEST);
        }

        DashboardQueryRequest dashboardQueryRequest2 = new DashboardQueryRequest();
        dashboardQueryRequest2.setQueryID(154);
        dashboardQueryRequest2.setIuserid(iuserid);
        dashboardQueryRequest2.setIorgid(iorgid);
        dashboardQueryRequest2.setClassIds(classid);
        dashboardQueryRequest2.setItenantID(tenantid);

        Map<String, Object> params2 = new HashMap<>();

        // derive for profiles schema tables
        String tablename = "";
        if (frequency.equalsIgnoreCase("daily")) {
            tablename = level;
        } else if (frequency.equalsIgnoreCase("weekly")) {
            tablename = level + "_weekly";
        } else if (frequency.equalsIgnoreCase("monthly")) {
            tablename = level + "_monthly";
        }

        Long id = null;
        if (level.equalsIgnoreCase("vpa")) {
            id = (Long) output.get(0).get("ivpaid");
            // queryString = "SELECT tdate from profiles." + tablename
            // + " WHERE ivpaid = :id order by tdate desc limit 6";
        } else if (level.equalsIgnoreCase("account")) {
            id = (Long) output.get(0).get("iaccountid");
            // queryString = "SELECT tdate from profiles." + tablename
            // + " WHERE iaccountid = :id order by tdate desc limit 6";
        }

        params2.put("Level", levelParam);
        params2.put("tablename", tablename);
        params2.put("id", id);

        try {
            dashboardQueryRequest2.setParametersJson(mapper.writeValueAsString(params2));
        } catch (Exception e) {
            LOGGER.error("Error serializing params to JSON: " + e.getMessage());
        }

        result = temp.getResultSetDataService(dashboardQueryRequest2);
        if (result.getBody() instanceof ApiResponse) {
            return result;
        } else {
            ResultSetResponse resultSetResponse = (ResultSetResponse) result.getBody();
            output = (List<Map<String, Object>>) resultSetResponse.data();
        }

        // parameters = new MapSqlParameterSource();
        // parameters.addValue("id", id);
        //
        // System.out.println("parameters are " + parameters);
        // output = new NamedParameterJdbcTemplate(
        // jdbcTemplateTransactional.getDataSource())
        // .queryForList(queryString, parameters);

        if (output.size() == 0) {
            activityLogService.addActivity(loggedInUser, "profiles data not present");
            LOGGER.debug("Exiting getManualWorkflows Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get profile parameters");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Profiles not present for the VPA/Account address"),
                    HttpStatus.BAD_REQUEST);
        }
        List<DropDownVo> response = new ArrayList<>();
        output.stream().filter(row -> {
            response.add(
                    DropDownVo.builder().label(row.get("tdate").toString()).value(row.get("tdate").toString()).build());
            return true;
        }).collect(Collectors.toList());

        return ResponseEntity.ok(response);
    }

    @Override
    public ResponseEntity<?> createManualTicket(Integer workflowid, Integer tenantid, String requestbody,
                                                Authentication pr) {
        LOGGER.debug("entered in class " + TasksServiceImpl.class
                + " in method createmanualticket by user " + pr.getName());

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name_manual);
        if (!mp.isAdd() || !loggedUser.allowWorkflowId(workflowid)) {
            activityLogService.addActivity(loggedInUser, "unauthorized to get batch trans");
            LOGGER.debug("Exiting getManualWorkflows Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get profile parameters");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to get batch trans"),
                    HttpStatus.FORBIDDEN);
        }

        org.json.JSONObject camundaReq = new org.json.JSONObject(requestbody);

        camundaReq.put("withVariablesInReturn", true);
        ResponseEntity<String> response = null;
        try {
            WorkflowMasters wflroot = workflowMasterService.findByWorkflowID(workflowid, tenantid);
            WorkflowMasters wfl = workflowMasterService.findByWorkflowID(wflroot.getManualWorkflow(), tenantid);
            response = camundaService.createTicket(camundaReq.toString(), wfl.getWorkflowKey(),
                    tenantid.toString());
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + pr);
            activityLogService.addActivity(loggedInUser, "failed to call camunda ", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
        // String responseBody = response.bodyToMono(String.class).block();
        String responseBody = response.getBody();

        // response.releaseBody();
        if (response.getStatusCode() != HttpStatus.OK) {
            LOGGER.error("Response code from camunda " + response.getStatusCode());
            LOGGER.error("Response body from camunda " + responseBody);
            activityLogService.addActivity(loggedInUser, "camunda API failed", responseBody);
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
        org.json.JSONObject resp = new org.json.JSONObject(responseBody);
        String ticketID = resp.optQuery("/variables/TicketID/value") != null
                ? resp.optQuery("/variables/TicketID/value").toString()
                : "";
        return new ResponseEntity<ApiResponse>(new ApiResponse(true,
                "Case ID: " + ticketID), HttpStatus.OK);
    }

    @Override
    public ResponseEntity<?> getRealTimeTrans(String address, String level, String transId, Integer workflowId,
                                              Integer tenantid,
                                              Authentication pr) {
        LOGGER.debug("entered in class " + TasksServiceImpl.class
                + " in method getRealTimeTrans by user " + pr.getName());

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();

        Integer iuserid = loggedInUser.getIuserID();
        Integer iorgid = loggedInUser.getIorgId().getIorgid();
        UserMapping classid = loggedUser.getUserClass();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name_manual);
        if (!mp.isAdd()) {
            activityLogService.addActivity(loggedInUser, "unauthorized to get real time trans");
            LOGGER.debug("Exiting getManualWorkflows Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get profile parameters");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to get real time trans"),
                    HttpStatus.FORBIDDEN);
        }

        WorkflowMasters wflroot = null, wfl = null;
        try {
            wflroot = workflowMasterService.findByWorkflowID(workflowId, tenantid);
            wfl = workflowMasterService.findByWorkflowID(wflroot.getManualWorkflow(), tenantid);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + pr);
            activityLogService.addActivity(loggedInUser, "failed to parse observations and/or result", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        String party = "";

//        String queryString = "";
        if ("account".equalsIgnoreCase(level)) {
//            queryString = "SELECT iaccountid FROM masters.accounts WHERE vcexternalaccountid = :address and itenantid = :tenantid";
            party = "Account";
        } else if ("vpa".equalsIgnoreCase(level)) {
//            queryString = "SELECT ivpaid FROM masters.vpa WHERE vcexternaladdressid = :address and itenantid = :tenantid";
            party = "VPA";
        } else {
            LOGGER.debug("Exiting getRealTimeTrans Method in " + TasksServiceImpl.class
                    + " class with response  : level should be account or vpa");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Level should be account or vpa"),
                    HttpStatus.BAD_REQUEST);
        }

        DashboardDataService temp = new DashboardDataService(dashboardQueryService, dashboardQueryParmeterService,
                loggerEncoderUtil,
                activityLogService, jdbcTemplateMap, transactionClassesUiService, dashboardErrorUtil);

        DashboardQueryRequest dashboardQueryRequest = new DashboardQueryRequest();
        dashboardQueryRequest.setQueryID(169);
        dashboardQueryRequest.setIuserid(iuserid);
        dashboardQueryRequest.setIorgid(iorgid);
        dashboardQueryRequest.setClassIds(classid);
        dashboardQueryRequest.setItenantID(tenantid);

        ObjectMapper objMapper = new ObjectMapper();
        Map<String, Object> params = new HashMap<>();

//        List<QueryParams> qParams = new ArrayList<>();
//        qParams.add(QueryParams.builder().parameterName("address")
//                .parameterType("String").value(address).build());
//        qParams.add(QueryParams.builder().parameterName("tenantid")
//                .parameterType("Integer").value(tenantid).build());
//
//        List<Map<String, Object>> output = analyticalDBQueryExecution.executeQueryOnAnalytic(queryString, qParams);

        params.put("Party", party);
        params.put("address", address);

        try{
            dashboardQueryRequest.setParametersJson(objMapper.writeValueAsString(params));
        }catch(Exception e){
            LOGGER.error("Error serializing params to JSON: " + e.getMessage());
        }

        ResponseEntity<?> result1 = temp.getResultSetDataService(dashboardQueryRequest);

        List<Map<String, Object>> output = new ArrayList<>();

        if (result1.getBody() instanceof ApiResponse) {
            return result1;
        } else{
            ResultSetResponse resultSetResponse = (ResultSetResponse) result1.getBody();
            output = (List<Map<String, Object>>) resultSetResponse.data();
        }

        if (output.size() == 0) {
            activityLogService.addActivity(loggedInUser, "vpa or account not present");
            LOGGER.debug("Exiting getRealTimeTrans Method in " + TasksServiceImpl.class
                    + " class with response  : vpa/account not found found for the entered address");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "VPA/Account not found for the entered address"),
                    HttpStatus.BAD_REQUEST);

        }

//        String query = "SELECT cast(observations as text), cast(result as text), vcpayeeaddr, vcpayeraddr, vcpayeeaccountexternalid, vcpayeraccountexternalid, risk_override, risk_context->>'caseId' as \"caseId\" FROM analytics.trans WHERE ";
//
//        if (level.equalsIgnoreCase("account")) {
//            query += "(vcpayeeaccountexternalid = :address OR vcpayeraccountexternalid = :address) AND vcuniquetransid = :transid and itenantid = :tenantid";
//        } else if (level.equalsIgnoreCase("vpa")) {
//            query += "(vcpayeeaddr = :address OR vcpayeraddr = :address) AND vcuniquetransid = :transid and itenantid = :tenantid";
//        }

//        List<QueryParams> params = new ArrayList<>();
//        params.add(QueryParams.builder()
//                .parameterName("transid")
//                .parameterType("String")
//                .value(transId).build());
//        params.add(QueryParams.builder()
//                .parameterName("address")
//                .parameterType("String")
//                .value(address).build());
//        params.add(QueryParams.builder().parameterName("tenantid")
//                .parameterType("Integer").value(tenantid).build());

        DashboardQueryRequest dashboardQueryRequest2 = new DashboardQueryRequest();
        dashboardQueryRequest2.setQueryID(170);
        dashboardQueryRequest2.setIuserid(iuserid);
        dashboardQueryRequest2.setIorgid(iorgid);
        dashboardQueryRequest2.setClassIds(classid);
        dashboardQueryRequest2.setItenantID(tenantid);

        params.put("transid", transId);

        try{
            dashboardQueryRequest2.setParametersJson(objMapper.writeValueAsString(params));
        }catch(Exception e){
            LOGGER.error("Error serializing params to JSON: " + e.getMessage());
        }

        ResponseEntity<?> result2 = temp.getResultSetDataService(dashboardQueryRequest2);

        List<Map<String, Object>> qresult = new ArrayList<>();

        if (result2.getBody() instanceof ApiResponse) {
            return result2;
        } else{
            ResultSetResponse resultSetResponse = (ResultSetResponse) result2.getBody();
            qresult = (List<Map<String, Object>>) resultSetResponse.data();
        }

        String side = null;
        Map<String, Object> trans = null;
//        List<Map<String, Object>> qresult = analyticalDBQueryExecution.executeQueryOnAnalytic(query, params);
        if (qresult.size() > 0) {
            trans = qresult.get(0);
        if (level.equalsIgnoreCase("account")) {
                if (address.equals((String) trans.get("vcpayeeaccountexternalid"))) {
                    side = "payee";
                } else if (address.equals(((String) trans.get("vcpayeraccountexternalid")))) {
                    side = "payer";
                }
        } else if (level.equalsIgnoreCase("vpa")) {
                if (address.equals(((String) trans.get("vcpayeeaddr")))) {
                    side = "payee";
                } else if (address.equals(((String) trans.get("vcpayeraddr")))) {
                    side = "payer";
                }
            }
        }

        if (trans != null && side != null) {

            org.json.JSONObject req = new org.json.JSONObject();
            req.put("processDefinitionKey", wfl.getWorkflowKey());
            req.put("processInstanceBusinessKey", transId);
            req.put("tenantIdIn", Arrays.asList(wfl.getItenantId().getItenantid()));
            try {
                ResponseEntity<String> clientResponse = camundaService.getHistoryProcessInstance(req.toString(),
                        loggedInUser);

                if (clientResponse.getStatusCode() != HttpStatus.OK) {
                    LOGGER.error("Response code from camunda " + clientResponse.getStatusCode());
                    LOGGER.error("Response body from camunda " + clientResponse.getBody());
                    activityLogService.addActivity(loggedInUser, "camunda API failed", clientResponse.getBody());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                JSONArray resp = new JSONArray(clientResponse.getBody());
                if (resp.length() > 0) {
                    req = new org.json.JSONObject();
                    req.put("processInstanceId", resp.getJSONObject(0).getString("id"));
                    req.put("variableName", "TicketID");
                    clientResponse = camundaService.postHistoryVarInstance(req.toString(), loggedInUser);
                    if (clientResponse.getStatusCode() != HttpStatus.OK) {
                        LOGGER.error("Response code from camunda " + clientResponse.getStatusCode());
                        LOGGER.error("Response body from camunda " + clientResponse.getBody());
                        activityLogService.addActivity(loggedInUser, "camunda API failed", clientResponse.getBody());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                    resp = new JSONArray(clientResponse.getBody());
                    String ticketId = resp.getJSONObject(0).get("value").toString();
                    LOGGER.info("transaction ticket found in camunda ");
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                            "Txn ID already covered in Case ID " + ticketId + " Please choose a different Txn ID"),
                            HttpStatus.BAD_REQUEST);
                }

            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to call camunda ", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            // check if this transaction was acted upon by another ticket
            if (wfl.getAttribs().get("type").asText().equalsIgnoreCase("realtime-multitrans")) {

                if ((Integer) trans.get("risk_override") > 0) {
                    // this transaction has been handled in other ticket
                    LOGGER.info("transaction actioned in another ticket");
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                            "Txn ID already covered in Case ID " + trans.get("caseId")
                                    + " Please choose a different Txn ID"),
                            HttpStatus.BAD_REQUEST);
                }
            }

            ObjectMapper mapper = new ObjectMapper();
            JsonNode transaction, result;
            try {
                transaction = mapper.readTree((String) trans.get("observations"));
                result = mapper.readTree((String) trans.get("result"));
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to parse observations and/or result",
                        e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            Map<String, Object> response = new HashMap<>();
            response.put("Transaction", transaction);
            response.put("Result", result);
            response.put("side", side);
            return ResponseEntity.ok(response);
        } else {
            activityLogService.addActivity(loggedInUser, "No record found");
            LOGGER.debug("Exiting getRealTimeTrans Method in " + TasksServiceImpl.class
                    + " class with response  : No record found");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false,
                            "Matching transaction not found"),
                    HttpStatus.BAD_REQUEST);
        }
        }

    @Override
    public ResponseEntity<?> getRealTimeTrans(String address, String level, String transId, Integer workflowId,
                                              String starttime, String endtime,
                                              Integer tenantid,
                                              Authentication pr) {
        LOGGER.debug("entered in class " + TasksServiceImpl.class
                + " in method getRealTimeTrans by user " + pr.getName());

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();

        Integer iuserid = loggedInUser.getIuserID();
        Integer iorgid = loggedInUser.getIorgId().getIorgid();
        UserMapping classid = loggedUser.getUserClass();

        MenuPermissions mp = loggedUser.getPermissions().get(menu_name_manual);
        if (!mp.isAdd()) {
            activityLogService.addActivity(loggedInUser, "unauthorized to get real time trans");
            LOGGER.debug("Exiting getManualWorkflows Method in " + TasksServiceImpl.class
                    + " class with response  : unauthorized to get profile parameters");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to get real time trans"),
                    HttpStatus.FORBIDDEN);
        }

        WorkflowMasters wflroot = null, wfl = null;
        try {
            wflroot = workflowMasterService.findByWorkflowID(workflowId, tenantid);
            wfl = workflowMasterService.findByWorkflowID(wflroot.getManualWorkflow(), tenantid);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + pr);
            activityLogService.addActivity(loggedInUser, "failed to parse observations and/or result", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        String party = "";

//        String queryString = "";
        if ("account".equalsIgnoreCase(level)) {
//            queryString = "SELECT iaccountid FROM masters.accounts WHERE vcexternalaccountid = :address and itenantid = :tenantid";
            party = "Account";
        } else if ("vpa".equalsIgnoreCase(level)) {
//            queryString = "SELECT ivpaid FROM masters.vpa WHERE vcexternaladdressid = :address and itenantid = :tenantid";
            party = "VPA";
        } else {
            LOGGER.debug("Exiting getRealTimeTrans Method in " + TasksServiceImpl.class
                    + " class with response  : level should be account or vpa");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Level should be account or vpa"),
                    HttpStatus.BAD_REQUEST);
        }

        DashboardDataService temp = new DashboardDataService(dashboardQueryService, dashboardQueryParmeterService,
                loggerEncoderUtil,
                activityLogService, jdbcTemplateMap, transactionClassesUiService, dashboardErrorUtil);

        DashboardQueryRequest dashboardQueryRequest = new DashboardQueryRequest();
        dashboardQueryRequest.setQueryID(169);
        dashboardQueryRequest.setIuserid(iuserid);
        dashboardQueryRequest.setIorgid(iorgid);
        dashboardQueryRequest.setClassIds(classid);
        dashboardQueryRequest.setItenantID(tenantid);

        ObjectMapper objMapper = new ObjectMapper();
        Map<String, Object> params = new HashMap<>();

//        List<QueryParams> qParams = new ArrayList<>();
//        qParams.add(QueryParams.builder().parameterName("address")
//                .parameterType("String").value(address).build());
//        qParams.add(QueryParams.builder().parameterName("tenantid")
//                .parameterType("Integer").value(tenantid).build());
//
//        List<Map<String, Object>> output = analyticalDBQueryExecution.executeQueryOnAnalytic(queryString, qParams);

        params.put("Party", party);
        params.put("address", address);

        try{
            dashboardQueryRequest.setParametersJson(objMapper.writeValueAsString(params));
        }catch(Exception e){
            LOGGER.error("Error serializing params to JSON: " + e.getMessage());
        }

        ResponseEntity<?> result1 = temp.getResultSetDataService(dashboardQueryRequest);

        List<Map<String, Object>> output = new ArrayList<>();

        if (result1.getBody() instanceof ApiResponse) {
            return result1;
        } else{
            ResultSetResponse resultSetResponse = (ResultSetResponse) result1.getBody();
            output = (List<Map<String, Object>>) resultSetResponse.data();
        }

        if (output.size() == 0) {
            activityLogService.addActivity(loggedInUser, "vpa or account not present");
            LOGGER.debug("Exiting getRealTimeTrans Method in " + TasksServiceImpl.class
                    + " class with response  : vpa/account not found found for the entered address");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "VPA/Account not found for the entered address"),
                    HttpStatus.BAD_REQUEST);

        }

        Integer addressid = null;
        if ("account".equalsIgnoreCase(level)) {
//            queryString = "SELECT iaccountid FROM masters.accounts WHERE vcexternalaccountid = :address and itenantid = :tenantid";
          addressid = Integer.parseInt( output.get(0).get("iaccountid").toString());
        } else if ("vpa".equalsIgnoreCase(level)) {
//            queryString = "SELECT ivpaid FROM masters.vpa WHERE vcexternaladdressid = :address and itenantid = :tenantid";
            addressid = Integer.parseInt( output.get(0).get("ivpaid").toString());
        }


//        String query = "SELECT cast(observations as text), cast(result as text), vcpayeeaddr, vcpayeraddr, vcpayeeaccountexternalid, vcpayeraccountexternalid, risk_override, risk_context->>'caseId' as \"caseId\" FROM analytics.trans WHERE ";
//
//        if (level.equalsIgnoreCase("account")) {
//            query += "(vcpayeeaccountexternalid = :address OR vcpayeraccountexternalid = :address) AND vcuniquetransid = :transid and itenantid = :tenantid";
//        } else if (level.equalsIgnoreCase("vpa")) {
//            query += "(vcpayeeaddr = :address OR vcpayeraddr = :address) AND vcuniquetransid = :transid and itenantid = :tenantid";
//        }

//        List<QueryParams> params = new ArrayList<>();
//        params.add(QueryParams.builder()
//                .parameterName("transid")
//                .parameterType("String")
//                .value(transId).build());
//        params.add(QueryParams.builder()
//                .parameterName("address")
//                .parameterType("String")
//                .value(address).build());
//        params.add(QueryParams.builder().parameterName("tenantid")
//                .parameterType("Integer").value(tenantid).build());

        DashboardQueryRequest dashboardQueryRequest2 = new DashboardQueryRequest();
        dashboardQueryRequest2.setQueryID(170);
        dashboardQueryRequest2.setIuserid(iuserid);
        dashboardQueryRequest2.setIorgid(iorgid);
        dashboardQueryRequest2.setClassIds(classid);
        dashboardQueryRequest2.setItenantID(tenantid);


        params.put("transid", transId);

        ArrayList<String> daterange = new ArrayList<>();
        daterange.add(0,starttime);
        daterange.add(1, endtime);
        params.put("DateRange", daterange);
        params.put("address", addressid);


        try{
            dashboardQueryRequest2.setParametersJson(objMapper.writeValueAsString(params));
        }catch(Exception e){
            LOGGER.error("Error serializing params to JSON: " + e.getMessage());
        }

        System.out.println(dashboardQueryRequest2.getParametersJson());

        ResponseEntity<?> result2 = temp.getResultSetDataService(dashboardQueryRequest2);
        List<Map<String, Object>> qresult = new ArrayList<>();

        if (result2.getBody() instanceof ApiResponse) {
            return result2;
        } else{
            ResultSetResponse resultSetResponse = (ResultSetResponse) result2.getBody();
            qresult = (List<Map<String, Object>>) resultSetResponse.data();
        }

        String side = null;
        Map<String, Object> trans = null;
//        List<Map<String, Object>> qresult = analyticalDBQueryExecution.executeQueryOnAnalytic(query, params);
        if (qresult.size() > 0) {
            trans = qresult.get(0);
            if (level.equalsIgnoreCase("account")) {
                if (address.equals((String) trans.get("vcpayeeaccountexternalid"))) {
                    side = "payee";
                } else if (address.equals(((String) trans.get("vcpayeraccountexternalid")))) {
                    side = "payer";
                }
            } else if (level.equalsIgnoreCase("vpa")) {
                if (address.equals(((String) trans.get("vcpayeeaddr")))) {
                    side = "payee";
                } else if (address.equals(((String) trans.get("vcpayeraddr")))) {
                    side = "payer";
                }
            }
        }

        if (trans != null && side != null) {

            org.json.JSONObject req = new org.json.JSONObject();
            req.put("processDefinitionKey", wfl.getWorkflowKey());
            req.put("processInstanceBusinessKey", transId);
            req.put("tenantIdIn", Arrays.asList(wfl.getItenantId().getItenantid()));
            try {
                ResponseEntity<String> clientResponse = camundaService.getHistoryProcessInstance(req.toString(),
                        loggedInUser);

                if (clientResponse.getStatusCode() != HttpStatus.OK) {
                    LOGGER.error("Response code from camunda " + clientResponse.getStatusCode());
                    LOGGER.error("Response body from camunda " + clientResponse.getBody());
                    activityLogService.addActivity(loggedInUser, "camunda API failed", clientResponse.getBody());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                JSONArray resp = new JSONArray(clientResponse.getBody());
                if (resp.length() > 0) {
                    req = new org.json.JSONObject();
                    req.put("processInstanceId", resp.getJSONObject(0).getString("id"));
                    req.put("variableName", "TicketID");
                    clientResponse = camundaService.postHistoryVarInstance(req.toString(), loggedInUser);
                    if (clientResponse.getStatusCode() != HttpStatus.OK) {
                        LOGGER.error("Response code from camunda " + clientResponse.getStatusCode());
                        LOGGER.error("Response body from camunda " + clientResponse.getBody());
                        activityLogService.addActivity(loggedInUser, "camunda API failed", clientResponse.getBody());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                    resp = new JSONArray(clientResponse.getBody());
                    String ticketId = resp.getJSONObject(0).get("value").toString();
                    LOGGER.info("transaction ticket found in camunda ");
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                            "Txn ID already covered in Case ID " + ticketId + " Please choose a different Txn ID"),
                            HttpStatus.BAD_REQUEST);
                }

            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to call camunda ", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            // check if this transaction was acted upon by another ticket
            if (wfl.getAttribs().get("type").asText().equalsIgnoreCase("realtime-multitrans")) {

                if ((Integer) trans.get("risk_override") > 0) {
                    // this transaction has been handled in other ticket
                    LOGGER.info("transaction actioned in another ticket");
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                            "Txn ID already covered in Case ID " + trans.get("caseId")
                                    + " Please choose a different Txn ID"),
                            HttpStatus.BAD_REQUEST);
                }
            }

            ObjectMapper mapper = new ObjectMapper();
            JsonNode transaction, result;
            try {
                transaction = mapper.readTree((String) trans.get("observations"));
                result = mapper.readTree((String) trans.get("result"));
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to parse observations and/or result",
                        e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            Map<String, Object> response = new HashMap<>();
            response.put("Transaction", transaction);
            response.put("Result", result);
            response.put("side", side);
            return ResponseEntity.ok(response);
        } else {
            activityLogService.addActivity(loggedInUser, "No record found");
            LOGGER.debug("Exiting getRealTimeTrans Method in " + TasksServiceImpl.class
                    + " class with response  : No record found");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false,
                            "Matching transaction not found"),
                    HttpStatus.BAD_REQUEST);
        }
    }
}
