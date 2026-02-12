package com.DronaPay.UIServer.service.ApiServices;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.Enum.DatabaseType;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.model.DashboardQuery;
import com.DronaPay.UIServer.model.TemplateResponse;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.requests.DashboardQueryRequest;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.ResultSetResponse;
import com.DronaPay.UIServer.service.CamundaService;
import com.DronaPay.UIServer.service.ControllerService.CaseManagement.TasksServiceImpl;
import com.DronaPay.UIServer.service.ControllerService.ListManagement.ListManagementServiceImpl;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.*;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.hypersistence.utils.common.StringUtils;
import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.HttpClientBuilder;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.ResponseErrorHandler;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.springframework.security.core.Authentication;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.nio.charset.StandardCharsets;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.*;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import static io.hypersistence.utils.common.LogUtils.LOGGER;

@Service
@Slf4j
public class PineLabAPIServiceImpl implements PineLabAPIService {

    private static final Logger LOGGER = LoggerFactory.getLogger(PineLabAPIServiceImpl.class);

//    @Qualifier("jdbcAnalyticsService")
//    @Autowired
//    JdbcTemplate jdbcTemplateAnalytics;
//
//    @Qualifier("jdbcTransactionalService")
//    @Autowired
//    JdbcTemplate jdbcTemplateTransactional;
    private Map<DatabaseType, JdbcTemplate> jdbcTemplateMap;

    @Autowired
    public PineLabAPIServiceImpl(Map<DatabaseType, JdbcTemplate> jdbcTemplateMap) {
        this.jdbcTemplateMap = jdbcTemplateMap;
    }

    @Value("${pinelab.url}")
    private String pine_lab_url;

    // @Value("${pinelab.api.version}")
    // private String pine_lab_api_version;
    @Value("${pinelab.auth.url}")
    private String pine_lab_auth_url;

    // @Value("${pinelab.api.version}")
    // private String pine_lab_api_version;

    @Value("${pinelab.tenant.id}")
    private String pine_lab_tenant_id;

    @Value("${pinelab.x.source}")
    private String pine_lab_x_source;

    @Value("${pinelab.x.operation.type}")
    private String pine_lab_x_operation_type;

    @Value("${pinelab.enquiry.operation.type}")
    private String pine_lab_enquiry_operation_type;

    @Value("${pinelab.x.request.type}")
    private String pine_lab_x_request_type;

    @Value("${pinelab.auth.client.id}")
    private String pine_lab_auth_client_id;

    @Value("${pinelab.auth.client.secret}")
    private String pine_lab_auth_client_secret;

    @Value("${pinelab.auth.grant.type}")
    private String pine_lab_auth_grant_type;

    // @Value("${pinelab.auth.scope}")
    // private String pine_lab_auth_scope;

    // @Value("${pinelab.auth.api.key.name}")
    // private String pine_lab_auth_api_key_name;

    // @Value("${pinelab.auth.api.key.value}")
    // private String pine_lab_auth_api_key_value;
    ;

    @Autowired
    private CamundaService camundaService;

    @Autowired
    private TemplateResponseService templateResponseService;

    @Autowired
    private WebUserService webUserService;

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Autowired
    private ActivityLogService activityLogService;

    @Autowired
    private WorkflowMasterService workflowMasterService;

    @Autowired
    private DashboardQueryService dashboardQueryService;
    @Autowired
    private TransactionClassesUiService transactionClassesUiService;

    @Autowired
    private DashboardQueryParmeterService dashboardQueryParmeterService;

    @Autowired
    private DashboardErrorUtil dashboardErrorUtil;

    @Autowired
    ThreadPoolTaskScheduler taskScheduler;

    private ResponseEntity<String> pinelabAuth() {
        RestTemplate temp = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/x-www-form-urlencoded");
        headers.set("X-requestId", UUID.randomUUID().toString());
        headers.set("Accept", "application/json");
        // headers.set(pine_lab_auth_api_key_name, pine_lab_auth_api_key_value);
        MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
        map.add("client_id", pine_lab_auth_client_id);
        map.add("client_secret", pine_lab_auth_client_secret);
        map.add("grant_type", pine_lab_auth_grant_type);
        // map.add("scope", pine_lab_auth_scope);
        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(map, headers);
        ResponseEntity<String> res = temp.exchange(pine_lab_auth_url + "/v1/identity/oauth/token",
                HttpMethod.POST, entity, String.class);
        log.info("pine_lab_auth_api res " + res.getBody());
        log.info("pine_lab_auth_api status " + res.getStatusCode().toString());
        return res;
    }

    @Override
    public ResponseEntity<String> holdAndUnholdTransaction(String body) throws Exception {
        ResponseEntity<String> response = pinelabAuth();
        String token = "";
        if (response.getStatusCode() == HttpStatus.OK) {
            JSONObject responseObj = new JSONObject(response.getBody());
            token = responseObj.getString("access_token");
        } else {
            log.error("Pine Lab Authentication API failed  with status " + response.getStatusCode() + " and response "
                    + response.getBody());
            return response;
        }
        JSONObject reqBody = new JSONObject(body);
        String buissness_key = reqBody.getString("buissness_key");
        reqBody.remove("buissness_key");
        System.out.println("entered service");

        RestTemplate temp = RestTemplateUtil.createRestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");
        headers.set("X-requestId", buissness_key);
        headers.set("X-source", pine_lab_x_source);
        headers.set("X-operationType", pine_lab_x_operation_type);
        headers.set("X-requestType", pine_lab_x_request_type);
        headers.set("Accept", "application/json");
        headers.set("Authorization", "Bearer " + token);
        HttpEntity<Object> entity = new HttpEntity<>(reqBody.toString(), headers);
        ResponseEntity<String> res = temp.exchange(pine_lab_url + "/api/risk/transaction",
                HttpMethod.POST, entity, String.class);
        return res;
    }

    @Override
    public ResponseEntity<?> dummyCallBackResponse(JSONObject body, String buissness_key) throws Exception {

        TemplateResponse templateResponse = templateResponseService.getByTemplateName("RMS_Settlement");

        List<String> validresponse = new ArrayList<>();
        validresponse.add("Success");
        validresponse.add("Failed");
        validresponse.add("Partial");
        validresponse.add("No Response");

        JSONObject responses = new JSONObject(templateResponse.getJsonResponse());

        if (!validresponse.contains(templateResponse.getResponses())) {

            return new ResponseEntity<>(responses.optString("body"),
                    HttpStatus.valueOf(responses.getInt("responsecode")));
        } else {

            new Thread(() -> {

                JSONObject jsonResponse = null;
                String[] requestids = buissness_key.split("-");

                if (body.getJSONArray("riskTransactions").getJSONObject(0).getString("status").equals("HOLD")) {

                    log.info("template for HOLD transaction");
                    boolean status = true;
                    if (templateResponse.getResponses().equalsIgnoreCase("Success")) {
                        body.put("status", "SUCCESS");
                        body.put("message", "All transactions holded successfully");
                        status = true;
                    } else {
                        body.put("status", "FAILED");
                        body.put("message", "All Transactions already released to merchant");
                        status = false;
                    }

                    jsonResponse = responses.getJSONObject("HOLD");
                    jsonResponse.put("businessKey", requestids[0]);
                    jsonResponse.put("messageName", "response_from_settlement_1");
                    JSONObject proceesVar = jsonResponse.getJSONObject("processVariables");
                    body.put("status", proceesVar.getJSONObject("status").getString("value"));
                    body.put("message", proceesVar.getJSONObject("message").getString("value"));
                    JSONArray innerRiskTan = new JSONArray();

                    for (int i = 0; i < body.getJSONArray("riskTransactions").length(); i++) {
                        status = templateResponse.getResponses().equalsIgnoreCase("Partial") ? !status : status;
                        JSONObject innerTranObj = new JSONObject();
                        innerTranObj.put("riskTransaction", body.getJSONArray("riskTransactions").getJSONObject(i));
                        if (!status) {
                            JSONObject error = new JSONObject(
                                    "{ \"type\": \"HoldException\", \"message\": \"Transaction already released to merchant\" }");
                            innerTranObj.put("error", error);
                        }
                        innerTranObj.put("status", status ? "SUCCESS" : "FAILED");

                        innerRiskTan.put(innerTranObj);
                    }

                    body.put("riskTransactions", innerRiskTan);
                    JSONObject callObjCam = new JSONObject();
                    callObjCam.put("value", body.toString());
                    callObjCam.put("type", "json");
                    proceesVar.put("callBackResponse", callObjCam);

                    jsonResponse.put("processVariables", proceesVar);

                    JSONObject correlation_keys = new JSONObject();
                    JSONObject correlation_key1 = new JSONObject();
                    correlation_key1.put("value", requestids[1]);
                    correlation_key1.put("type", "String");
                    correlation_keys.put("correlation_key1", correlation_key1);
                    jsonResponse.put("correlationKeys", correlation_keys);

                } else {

                    log.info("template for RELEASE transaction");

                    jsonResponse = responses.getJSONObject("RELEASE");
                    jsonResponse.put("businessKey", requestids[0]);
                    jsonResponse.put("messageName", "receive_response_settlement_2");
                    JSONObject proceesVar = jsonResponse.getJSONObject("processVariables");

                    boolean status = true;
                    if (templateResponse.getResponses().equalsIgnoreCase("Success")) {
                        body.put("status", "SUCCESS");
                        body.put("message", "All transactions released successfully");
                        status = true;
                    } else {
                        body.put("status", "FAILED");
                        body.put("message", "All Transactions already released to merchant");
                        status = false;
                    }

                    JSONObject statusobj = proceesVar.getJSONObject("status");
                    statusobj.put("value", body.get("status"));
                    JSONObject msg = proceesVar.getJSONObject("message");
                    msg.put("value", body.get("message"));

                    proceesVar.put("releasestatus", statusobj);
                    proceesVar.put("releasemessage", msg);

                    JSONArray innerRiskTan = new JSONArray();
                    for (int i = 0; i < body.getJSONArray("riskTransactions").length(); i++) {

                        status = templateResponse.getResponses().equalsIgnoreCase("Partial") ? !status : status;
                        JSONObject innerTranObj = new JSONObject();

                        innerTranObj.put("riskTransaction", body.getJSONArray("riskTransactions").getJSONObject(i));
                        if (!status) {
                            JSONObject error = new JSONObject(
                                    "{ \"type\": \"HoldException\", \"message\": \"Transaction already released to merchant\" }");
                            innerTranObj.put("error", error);
                        }
                        innerTranObj.put("status", status ? "SUCCESS" : "FAILED");

                        innerRiskTan.put(innerTranObj);
                    }
                    body.put("riskTransactions", innerRiskTan);
                    JSONObject callObjCam = new JSONObject();
                    callObjCam.put("value", body.toString());
                    callObjCam.put("type", "json");
                    proceesVar.put("callBackResponse", callObjCam);
                    proceesVar.remove("status");
                    proceesVar.remove("message");

                    jsonResponse.put("processVariables", proceesVar);

                    JSONObject correlation_keys = new JSONObject();
                    JSONObject correlation_key1 = new JSONObject();
                    correlation_key1.put("value", requestids[1]);
                    correlation_key1.put("type", "String");
                    correlation_keys.put("correlation_key1", correlation_key1);
                    jsonResponse.put("correlationKeys", correlation_keys);
                }

                if (!templateResponse.getResponses().equalsIgnoreCase("No Response")) {
                    try {
                        callBackAPI(body.toString(), buissness_key);
                    } catch (Exception e) {
                        log.error("Error in send message " + e);
                    }
                }
            }).start();
            return ResponseEntity.ok(body.toMap());
        }

    }

    @Override
    @Async("threadPoolTaskExecutor")
    public void callBackAPI(String body, String buissness_key) throws Exception {

        log.info("request body received from settlement engine " + loggerEncoderUtil.encode(body));
        log.info("X-requestId received from settlement engine " + loggerEncoderUtil.encode(buissness_key));

        JSONObject reqBody = new JSONObject(body);

        if (StringUtils.isBlank(buissness_key)) {
            log.error("Skipping callback due to malformed buissness_key: {}", buissness_key);
            return;
        }
//        String[] requestids = buissness_key.split("-");

        int lastDash = buissness_key.lastIndexOf("-");

        if (lastDash <= 0 || lastDash == buissness_key.length() - 1) {
            // No dash, dash at start, or dash at end → invalid
            log.error("Skipping callback due to malformed buissness_key: {}", buissness_key);
            return;
        }

        String part1 = buissness_key.substring(0, lastDash);
        String part2 = buissness_key.substring(lastDash + 1);

        if (part2.length() != 32) {
            log.error("Skipping callback due to malformed buissness_key: {}", buissness_key);
            return;
        }

        JSONObject sendMessageReqBody = new JSONObject();
        sendMessageReqBody.put("businessKey", part1);

        JSONObject processVariables = new JSONObject();
        JSONObject statusObj = new JSONObject();
        statusObj.put("type", "string");
        statusObj.put("value", reqBody.getString("status"));

        JSONObject messageObj = new JSONObject();
        messageObj.put("type", "string");
        messageObj.put("value", reqBody.getString("message"));

        processVariables.put("message", messageObj);
        JSONObject callBackResponse = new JSONObject();
        callBackResponse.put("type", "json");
        callBackResponse.put("value", reqBody.toString());
        processVariables.put("callBackResponse", callBackResponse);
        sendMessageReqBody.put("processVariables", processVariables);

        JSONObject correlation_keys = new JSONObject();
        JSONObject correlation_key1 = new JSONObject();
        correlation_key1.put("value", part2);
        correlation_key1.put("type", "String");

        correlation_keys.put("correlation_key1", correlation_key1);
        sendMessageReqBody.put("correlationKeys", correlation_keys);

        if (reqBody.getJSONArray("riskTransactions").getJSONObject(0).getJSONObject("riskTransaction")
                .getString("status").equals("HOLD")) {

            sendMessageReqBody.put("messageName", "response_from_settlement_1");
            processVariables.put("status", statusObj);
            processVariables.put("message", messageObj);

        } else {
            sendMessageReqBody.put("messageName", "receive_response_settlement_2");
            processVariables.put("releasestatus", statusObj);
            processVariables.put("releasemessage", messageObj);
        }

        log.info("send message req body " + loggerEncoderUtil.encode(sendMessageReqBody.toString()));
        retrySendMessage(sendMessageReqBody, 0, 5, buissness_key);
    }


    @Override
    @Async("threadPoolTaskExecutor")
    public void callBackAPIMerchant(String body) throws Exception {
        JSONObject reqBody = new JSONObject(body);

        JSONObject sendMessageReqBody = new JSONObject();
        sendMessageReqBody.put("businessKey", reqBody.getString("correlation_key"));
        JSONObject processVariables = new JSONObject();
        JSONObject attachmentList = new JSONObject();
        attachmentList.put("type", "json");
        attachmentList.put("value", reqBody.getJSONObject("attribs").getJSONArray("attachments").toString());
        processVariables.put("attachmentList", attachmentList);
        sendMessageReqBody.put("processVariables", processVariables);
        sendMessageReqBody.put("messageName", "response_from_merchant");

        log.info("send message req body " + loggerEncoderUtil.encode(sendMessageReqBody.toString()));

        ResponseEntity<String> clientResponse = camundaService.sendMessage(sendMessageReqBody.toString());

//        log.info("send message status " + clientResponse.statusCode());
//        log.info("send message response " + clientResponse.bodyToMono(String.class).block());
        log.info("send message status " + clientResponse.getStatusCode());
        log.info("send message response " + clientResponse.getBody());
//        clientResponse.releaseBody();
    }

    public ResponseEntity<?> getTrans(String address, String level, String date, String workflowkey, Integer tenantid,
            String txnid, Integer limit, Authentication pr) {

        LoggedUser t = (LoggedUser) pr.getPrincipal();

        Integer iuserid = t.getWebUser().getIuserID();
        Integer iorgid = t.getWebUser().getIorgId().getIorgid();
        UserMapping classid = t.getUserClass();

        DashboardQueryRequest dashboardQueryRequest = new DashboardQueryRequest();
        dashboardQueryRequest.setQueryID(168);
        dashboardQueryRequest.setIuserid(iuserid);
        dashboardQueryRequest.setIorgid(iorgid);
        dashboardQueryRequest.setClassIds(classid);
        dashboardQueryRequest.setItenantID(tenantid);


        DashboardQueryRequest dashboardQueryRequest2 = new DashboardQueryRequest();
        dashboardQueryRequest2.setQueryID(168);
        dashboardQueryRequest2.setIuserid(iuserid);
        dashboardQueryRequest2.setIorgid(iorgid);
        dashboardQueryRequest2.setClassIds(classid);
        dashboardQueryRequest2.setItenantID(tenantid);


        String role = "";

        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> params = new HashMap<>();
        Map<String, Object> params2 = new HashMap<>();

        if ("payervpa".equalsIgnoreCase(level)) {
            role = "Payer";
        } else if ("payeevpa".equalsIgnoreCase(level)) {
            role = "Payee";
        } else {
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Level should be payervpa or payeevpa"),
                    HttpStatus.BAD_REQUEST);
        }

        params.put("QueryType", "Multiple");
        params.put("Role", role);
        params.put("address", address);
        params.put("date", date);
        params.put("vcuniquetransid", txnid);
        params.put("limit", limit);

        params2.put("QueryType", "Single");
        params2.put("Role", role);
        params2.put("address", address);
        params2.put("date", date);
        params2.put("vcuniquetransid", txnid);
        params2.put("limit", 0);

        DashboardDataService temp = new DashboardDataService(dashboardQueryService, dashboardQueryParmeterService,
                loggerEncoderUtil,
                activityLogService, jdbcTemplateMap, transactionClassesUiService,dashboardErrorUtil);

        try{
            dashboardQueryRequest.setParametersJson(mapper.writeValueAsString(params));
        }catch(Exception e){
            LOGGER.error("Error serializing params to JSON: " + e.getMessage());
        }

        List<Map<String, Object>> txn = new ArrayList<>();
        List<Map<String, Object>> txn1 = new ArrayList<>();

        try{
            dashboardQueryRequest2.setParametersJson(mapper.writeValueAsString(params2));
        }catch(Exception e){
            LOGGER.error("Error serializing params2 to JSON: " + e.getMessage());
        }


        ResponseEntity<?> result = temp.getResultSetDataService(dashboardQueryRequest);
        ResponseEntity<?> result2 = temp.getResultSetDataService(dashboardQueryRequest2);

        if (result.getBody() instanceof ApiResponse) {
            return result;
        } else{
            ResultSetResponse resultSetResponse = (ResultSetResponse) result.getBody();
            txn = (List<Map<String, Object>>) resultSetResponse.data();
        }

        if (result2.getBody() instanceof ApiResponse) {
            return result2;
        } else{
            ResultSetResponse resultSetResponse = (ResultSetResponse) result2.getBody();
            txn1 = (List<Map<String, Object>>) resultSetResponse.data();
        }

//        String queryString = "";
//        String queryString2 = "";
//
//        String selecPart = "SELECT vcmsgid, observations->'txn'->>'id' as \"transactionid\", observations->'txn'->'attribs'->>'txn_type' as \"txn_type\","
//                + "observations->'txn'->'attribs'->>'acquirer_name' as \"acquirer_name\", observations->'txn'->>'class' as \"class\","
//                + "observations->'txn'->>'ts' as \"transaction_timestamp\", round(cast(observations->'payee'->>'amount' as integer)/100, 2) as \"transaction_amount\","
//                + "observations->'payee'->>'addr' as \"payee_vpa\", observations->'payer'->>'addr' as \"payer_vpa\","
//                + " risk_override as \"statuscode\", risk_context as \"statusinfo\", observations->'observations'->'payerVPA'->>'vpaName' as \"payer_name\", score";
//        if ("payervpa".equalsIgnoreCase(level)) {
//            queryString = selecPart
//                    + " FROM analytics.trans WHERE itenantid = :tenantid and vcpayeraddr = :address AND dttrxntime BETWEEN cast(cast(:date as date) as timestamp) AND cast((cast(:date as date) +1) as timestamp) AND risk_override != 1 and vcuniquetransid != :vcuniquetransid order by dttrxntime limit :limit";
//            queryString2 = selecPart
//                    + " FROM analytics.trans WHERE itenantid = :tenantid and vcpayeraddr = :address AND dttrxntime BETWEEN cast(cast(:date as date) as timestamp) AND cast((cast(:date as date) +1) as timestamp) AND risk_override != 1 and vcuniquetransid = :vcuniquetransid ";
//        } else if ("payeevpa".equalsIgnoreCase(level)) {
//            queryString = selecPart
//                    + " FROM analytics.trans WHERE itenantid = :tenantid and vcpayeeaddr = :address AND dttrxntime BETWEEN cast(cast(:date as date) as timestamp) AND cast((cast(:date as date) +1) as timestamp) AND risk_override != 1 and vcuniquetransid != :vcuniquetransid order by dttrxntime limit :limit";
//            queryString2 = selecPart
//                    + " FROM analytics.trans WHERE itenantid = :tenantid and vcpayeeaddr = :address AND dttrxntime BETWEEN cast(cast(:date as date) as timestamp) AND cast((cast(:date as date) +1) as timestamp) AND risk_override != 1 and vcuniquetransid = :vcuniquetransid ";
//        } else {
//            return new ResponseEntity<ApiResponse>(
//                    new ApiResponse(false, "Level should be payervpa or payeevpa"),
//                    HttpStatus.BAD_REQUEST);
//        }
//
//        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH);
//
//        Date date1;
//        try {
//            date1 = formatter.parse(date);
//        } catch (ParseException e) {
//            throw new RuntimeException(e);
//        }
//
//        MapSqlParameterSource parameters = new MapSqlParameterSource();
//        parameters.addValue("address", address);
//        parameters.addValue("date", date);
//        parameters.addValue("tenantid", tenantid);
//        parameters.addValue("vcuniquetransid", txnid);
//        parameters.addValue("limit", limit);
//
//        JdbcTemplate selectedJdbcTemplate = jdbcTemplateMap.get(DatabaseType.POSTGRESQL_TRANSACTIONAL);
//        List<Map<String, Object>> txn = new NamedParameterJdbcTemplate(
//                selectedJdbcTemplate.getDataSource())
//                .queryForList(queryString, parameters);
////        List<Map<String, Object>> txn = new NamedParameterJdbcTemplate(
////                jdbcTemplateTransactional.getDataSource())
////                .queryForList(queryString, parameters);
//
//        List<Map<String, Object>> txn1 = new NamedParameterJdbcTemplate(
//                selectedJdbcTemplate.getDataSource())
//                .queryForList(queryString2, parameters);
//        List<Map<String, Object>> txn1 = new NamedParameterJdbcTemplate(
//                jdbcTemplateTransactional.getDataSource())
//                .queryForList(queryString2, parameters);

        txn.addAll(txn1);

        if (txn.size() == 0) {
            return ResponseEntity.ok(txn);
        }

//        List<String> txnids = txn.stream().map(a -> (String) a.get("transactionid")).collect(Collectors.toList());
//
//        String query = "select proinst.business_key_ as \"txnid\", proinst.id_ as \"processid\",task.task_def_key_ as \"taskdefkey\", task.id_ as \"taskid\", ticketid.long_ as \"ticketid\"\n"
//                +
//                "from \n" +
//                "camunda.act_hi_procinst proinst \n" +
//                "inner join camunda.act_ru_task task on task.proc_inst_id_ = proinst.id_ \n" +
//                "inner join camunda.act_ru_variable ticketid  on ticketid.proc_inst_id_ = proinst.id_ and ticketid.name_ = 'TicketID'\n"
//                +
//                "where proinst.business_key_ in (:businesskey) and proinst.state_ = 'ACTIVE' and proinst.proc_def_key_ = '"
//                + workflowkey + "'";
//
//        MapSqlParameterSource parameters2 = new MapSqlParameterSource();
//        parameters2.addValue("businesskey", txnids);
//
//        List<Map<String, Object>> camunda_cases = new NamedParameterJdbcTemplate(
//                selectedJdbcTemplate.getDataSource())
//                .queryForList(query, parameters2);
        List<String> txnids = txn.stream()
                .map(a -> (String) a.get("transactionid"))
                .collect(Collectors.toList());

        int batchSize = 50000;
        List<Map<String, Object>> camunda_cases = new ArrayList<>();

        for (int start = 0; start < txnids.size(); start += batchSize) {
            List<String> batch = txnids.subList(start, Math.min(start + batchSize, txnids.size()));

            DashboardQueryRequest dashboardQueryRequest3 = new DashboardQueryRequest();
            dashboardQueryRequest3.setQueryID(145);
            dashboardQueryRequest3.setIuserid(iuserid);
            dashboardQueryRequest3.setIorgid(iorgid);
            dashboardQueryRequest3.setClassIds(classid);
            dashboardQueryRequest3.setItenantID(tenantid);

            Map<String, Object> paramsCamunda = new HashMap<>();

            paramsCamunda.put("placeholders", batch);
            paramsCamunda.put("workflowkey", workflowkey);

            try{
                dashboardQueryRequest3.setParametersJson(mapper.writeValueAsString(paramsCamunda));
            }catch(Exception e){
                LOGGER.error("Error serializing paramsCamunda to JSON: " + e.getMessage());
            }


            ResponseEntity<?> result3 = temp.getResultSetDataService(dashboardQueryRequest3);

            List<Map<String, Object>> batchResults = new ArrayList<>();

            if (result3.getBody() instanceof ApiResponse) {
                return result3;
            } else{
                ResultSetResponse resultSetResponse = (ResultSetResponse) result3.getBody();
                batchResults = (List<Map<String, Object>>) resultSetResponse.data();
            }

            camunda_cases.addAll(batchResults);
        }

        Map<String, Map<String, Object>> parsed_list = camunda_cases.stream().collect(Collectors.toMap(
                map -> (String) map.get("txnid"), // Key extractor
                map -> map, // Value mapper (identity)
                (existing, replacement) -> existing // Merge function (in case of key collisions)
        ));

        txn = txn.stream().map(map -> {
            Map<String, Object> parsedMap = parsed_list.get(map.get("transactionid"));
            if (parsedMap != null) {
                map.putAll(parsedMap);
            }
            return map;
        })
                .collect(Collectors.toList());

        // return ResponseEntity.ok(response);
        return ResponseEntity.ok(txn);
    }

    public ResponseEntity<?> getTransNew(String address, String level, String date, String workflowkey,
                                         Integer tenantid,
                                         String txnid, String limit, String settlementType, Boolean exceptionCase, Authentication pr) {

        LoggedUser t = (LoggedUser) pr.getPrincipal();
        WebUser loggedInUser = t.getWebUser();

        Integer iuserid = loggedInUser.getIuserID();
        Integer iorgid = loggedInUser.getIorgId().getIorgid();
        UserMapping classid = t.getUserClass();

        DashboardQueryRequest dashboardQueryRequest = new DashboardQueryRequest();
        dashboardQueryRequest.setQueryID(140);
        dashboardQueryRequest.setIuserid(iuserid);
        dashboardQueryRequest.setIorgid(iorgid);
        dashboardQueryRequest.setClassIds(classid);
        dashboardQueryRequest.setItenantID(tenantid);


        DashboardQueryRequest dashboardQueryRequest2 = new DashboardQueryRequest();
        dashboardQueryRequest2.setQueryID(140);
        dashboardQueryRequest2.setIuserid(iuserid);
        dashboardQueryRequest2.setIorgid(iorgid);
        dashboardQueryRequest2.setClassIds(classid);
        dashboardQueryRequest2.setItenantID(tenantid);

        String role = "";

        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> params = new HashMap<>();
        Map<String, Object> params2 = new HashMap<>();

        if ("payervpa".equalsIgnoreCase(level)) {
            role = "Payer";
        } else if ("payeevpa".equalsIgnoreCase(level)) {
            role = "Payee";
        } else {
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Level should be payervpa or payeevpa"),
                    HttpStatus.BAD_REQUEST);
        }

        params.put("QueryType", "Multiple");
        params.put("Role", role);
        params.put("Scope", limit.equalsIgnoreCase("all") ? "All" : "Other");
        params.put("address", address);
        params.put("date", date);
        params.put("settlementType", settlementType);
        params.put("exceptionCase", exceptionCase);
        params.put("vcuniquetransid", "");
        params.put("limit", 0);
        if (!limit.equalsIgnoreCase("all")) {
            params.put("vcuniquetransid", txnid);
            params.put("limit", Integer.parseInt(limit));

            params2.put("QueryType", "Single");
            params2.put("Role", role);
            params2.put("Scope", "All");
            params2.put("address", address);
            params2.put("date", date);
            params2.put("vcuniquetransid", txnid);
            params2.put("settlementType", settlementType);
            params2.put("exceptionCase", exceptionCase);
            params2.put("limit", 0);
        }

        DashboardDataService temp = new DashboardDataService(dashboardQueryService, dashboardQueryParmeterService,
                loggerEncoderUtil,
                activityLogService, jdbcTemplateMap, transactionClassesUiService, dashboardErrorUtil);

        try{
            dashboardQueryRequest.setParametersJson(mapper.writeValueAsString(params));
        }catch(Exception e){
            LOGGER.error("Error serializing params to JSON: " + e.getMessage());
        }

        List<Map<String, Object>> txn = new ArrayList<>();
        List<Map<String, Object>> txn1 = new ArrayList<>();



        if(limit.equalsIgnoreCase("all")) {

            ResponseEntity<?> result = temp.getResultSetDataService(dashboardQueryRequest);
            if (result.getBody() instanceof ApiResponse) {
                return result;
            } else{
                ResultSetResponse resultSetResponse = (ResultSetResponse) result.getBody();
                txn = (List<Map<String, Object>>) resultSetResponse.data();
            }
        }
        else{

            try{
                dashboardQueryRequest2.setParametersJson(mapper.writeValueAsString(params2));
            }catch(Exception e){
                LOGGER.error("Error serializing params2 to JSON: " + e.getMessage());
            }

            ResponseEntity<?> result = temp.getResultSetDataService(dashboardQueryRequest);


            ResponseEntity<?> result2 = temp.getResultSetDataService(dashboardQueryRequest2);

            if (result.getBody() instanceof ApiResponse) {
                return result;
            } else{
                ResultSetResponse resultSetResponse = (ResultSetResponse) result.getBody();
                txn = (List<Map<String, Object>>) resultSetResponse.data();
//                System.out.println("TXN :-" + txn);
            }

            if (result2.getBody() instanceof ApiResponse) {
                return result2;
            } else{
                ResultSetResponse resultSetResponse = (ResultSetResponse) result2.getBody();
                txn1 = (List<Map<String, Object>>) resultSetResponse.data();
//                System.out.println("TXN1 :-" + txn1);
            }
        }



//        String queryString = "";
//        String queryString2 = "";
//
//        String selecPart = "SELECT vcmsgid, observations->'txn'->>'id' as \"transactionid\", observations->'txn'->'attribs'->>'txn_type' as \"txn_type\","
//                + "observations->'txn'->'attribs'->>'acquirer_name' as \"acquirer_name\", observations->'txn'->>'class' as \"class\","
//                + "observations->'txn'->>'ts' as \"transaction_timestamp\", round(cast(observations->'payee'->>'amount' as integer)/100, 2) as \"transaction_amount\","
//                + "observations->'payee'->>'addr' as \"payee_vpa\", observations->'payer'->>'addr' as \"payer_vpa\","
//                + " risk_override as \"statuscode\", risk_context as \"statusinfo\", observations->'observations'->'payerVPA'->>'vpaName' as \"payer_name\", score";
//        if ("payervpa".equalsIgnoreCase(level)) {
//            queryString = selecPart
//                    + " FROM analytics.trans WHERE itenantid = :tenantid and vcpayeraddr = :address AND dttrxntime BETWEEN cast(cast(:date as date) as timestamp) AND cast((cast(:date as date) +1) as timestamp) AND risk_override != 1 and vcuniquetransid != :vcuniquetransid order by dttrxntime limit :limit";
//            queryString2 = selecPart
//                    + " FROM analytics.trans WHERE itenantid = :tenantid and vcpayeraddr = :address AND dttrxntime BETWEEN cast(cast(:date as date) as timestamp) AND cast((cast(:date as date) +1) as timestamp) AND risk_override != 1 and vcuniquetransid = :vcuniquetransid ";
//        } else if ("payeevpa".equalsIgnoreCase(level)) {
//            queryString = selecPart
//                    + " FROM analytics.trans WHERE itenantid = :tenantid and vcpayeeaddr = :address AND dttrxntime BETWEEN cast(cast(:date as date) as timestamp) AND cast((cast(:date as date) +1) as timestamp) AND risk_override != 1 and vcuniquetransid != :vcuniquetransid order by dttrxntime limit :limit";
//            queryString2 = selecPart
//                    + " FROM analytics.trans WHERE itenantid = :tenantid and vcpayeeaddr = :address AND dttrxntime BETWEEN cast(cast(:date as date) as timestamp) AND cast((cast(:date as date) +1) as timestamp) AND risk_override != 1 and vcuniquetransid = :vcuniquetransid ";
//        } else {
//            return new ResponseEntity<ApiResponse>(
//                    new ApiResponse(false, "Level should be payervpa or payeevpa"),
//                    HttpStatus.BAD_REQUEST);
//        }
//
//        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH);
//
//        Date date1;
//        try {
//            date1 = formatter.parse(date);
//        } catch (ParseException e) {
//            throw new RuntimeException(e);
//        }
//
//        MapSqlParameterSource parameters = new MapSqlParameterSource();
//        parameters.addValue("address", address);
//        parameters.addValue("date", date);
//        parameters.addValue("tenantid", tenantid);
//        parameters.addValue("vcuniquetransid", txnid);
//        parameters.addValue("limit", limit);
//
//        parameters.addValue("settlementType", settlementType);
//        parameters.addValue("exceptionCase", exceptionCase);
//
//        System.out.println("QueryString :-" + queryString);
//        System.out.println("QueryString2 :-" + queryString2);
//
//        List<Map<String, Object>> txn = new NamedParameterJdbcTemplate(
//                jdbcTemplateTransactional.getDataSource())
//                .queryForList(queryString, parameters);
//
//        List<Map<String, Object>> txn1 = new NamedParameterJdbcTemplate(
//                jdbcTemplateTransactional.getDataSource())
//                .queryForList(queryString2, parameters);

        txn.addAll(txn1);

        if (txn.size() == 0) {
            return ResponseEntity.ok(txn);
        }

//        List<String> txnids = txn.stream().map(a -> (String) a.get("transactionid")).collect(Collectors.toList());
//
//        String query = "select proinst.business_key_ as \"txnid\", proinst.id_ as \"processid\",task.task_def_key_ as \"taskdefkey\", task.id_ as \"taskid\", ticketid.long_ as \"ticketid\"\n"
//                +
//                "from \n" +
//                "camunda.act_hi_procinst proinst \n" +
//                "inner join camunda.act_ru_task task on task.proc_inst_id_ = proinst.id_ \n" +
//                "inner join camunda.act_ru_variable ticketid  on ticketid.proc_inst_id_ = proinst.id_ and ticketid.name_ = 'TicketID'\n"
//                +
//                "where proinst.business_key_ in (:businesskey) and proinst.state_ = 'ACTIVE' and proinst.proc_def_key_ = '"
//                + workflowkey + "'";
//
//        MapSqlParameterSource parameters2 = new MapSqlParameterSource();
//        parameters2.addValue("businesskey", txnids);
//
//        System.out.println(txnids);
//        System.out.println(query);
//
//        List<Map<String, Object>> camunda_cases = new NamedParameterJdbcTemplate(
//                jdbcTemplateTransactional.getDataSource())
//                .queryForList(query, parameters2);
        List<String> txnids = txn.stream()
                .map(a -> (String) a.get("transactionid"))
                .collect(Collectors.toList());

        int batchSize = 50000;
        List<Map<String, Object>> camunda_cases = new ArrayList<>();

        for (int start = 0; start < txnids.size(); start += batchSize) {
            List<String> batch = txnids.subList(start, Math.min(start + batchSize, txnids.size()));

            DashboardQueryRequest dashboardQueryRequest3 = new DashboardQueryRequest();
            dashboardQueryRequest3.setQueryID(145);
            dashboardQueryRequest3.setIuserid(iuserid);
            dashboardQueryRequest3.setIorgid(iorgid);
            dashboardQueryRequest3.setClassIds(classid);
            dashboardQueryRequest3.setItenantID(tenantid);

            Map<String, Object> paramsCamunda = new HashMap<>();

            paramsCamunda.put("placeholders", batch);
            paramsCamunda.put("workflowkey", workflowkey);

            try{
                dashboardQueryRequest3.setParametersJson(mapper.writeValueAsString(paramsCamunda));
            }catch(Exception e){
                LOGGER.error("Error serializing paramsCamunda to JSON: " + e.getMessage());
            }

            ResponseEntity<?> result = temp.getResultSetDataService(dashboardQueryRequest3);

            List<Map<String, Object>> batchResults = new ArrayList<>();

            if (result.getBody() instanceof ApiResponse) {
                return result;
            } else{
                ResultSetResponse resultSetResponse = (ResultSetResponse) result.getBody();
                batchResults = (List<Map<String, Object>>) resultSetResponse.data();
            }

            camunda_cases.addAll(batchResults);
        }

        Map<String, Map<String, Object>> parsed_list = camunda_cases.stream().collect(Collectors.toMap(
                map -> (String) map.get("txnid"),
                map -> map,
                (existing, replacement) -> existing
        ));

        txn = txn.stream().map(map -> {
            Map<String, Object> parsedMap = parsed_list.get(map.get("transactionid"));
            if (parsedMap != null) {
                map.putAll(parsedMap);
            }
            return map;
        })
                .collect(Collectors.toList());

//        txn = txn.stream().filter(tx -> {
//            log.info(tx.toString());
//            if (tx.get("statusinfo") == null && settlementType.equals("HOLD") && !exceptionCase) {
//                System.out.println("Status info is null and settlement type is HOLD");
//
//                return true;
//            } else if (tx.get("statusinfo") != null && settlementType.equals("HOLD") && !exceptionCase) {
//                if (tx.get("statusinfo") != null) {
//                    System.out.println("statusinfo found");
//                    try {
//                        JSONObject statusinfo = new JSONObject(tx.get("statusinfo").toString());
//
//                        if (statusinfo.opt("status") != null) {
//                            System.out.println("Status found in value of statusinfo");
//                            if (statusinfo.getString("status").equals("HOLD Failed")) {
//                                System.out.println("Status is hold requested");
//                                return true;
//                            }
//                        }
//
//                    } catch (Exception e) {
//                        e.printStackTrace();
//                        return false;
//                    }
//
//                }
//                return false;
//            } else if ((settlementType.equals("HOLD") && tx.get("statusinfo") != null) && exceptionCase) {
//                System.out.println("Exception case and settlement type is HOLD");
//                if (tx.get("statusinfo") != null) {
//                    System.out.println("statusinfo found");
//                    try {
//                        JSONObject statusinfo = new JSONObject(tx.get("statusinfo").toString());
//
//                        if (statusinfo.opt("status") != null) {
//                            System.out.println("Status found in value of statusinfo");
//                            if (statusinfo.getString("status").equals("HOLD Failed")) {
//                                System.out.println("Status is hold requested");
//                                return true;
//                            }
//                        }
//
//                    } catch (Exception e) {
//                        e.printStackTrace();
//                        return false;
//                    }
//
//                }
//                return false;
//            } else if ((settlementType.equals("PARTIAL") && tx.get("statusinfo") != null) && exceptionCase) {
//                System.out.println("Exception case and settlement type is HOLD");
//                if (tx.get("statusinfo") != null) {
//                    System.out.println("statusinfo found");
//                    try {
//                        JSONObject statusinfo = new JSONObject(tx.get("statusinfo").toString());
//
//
//                        if (statusinfo.opt("status") != null) {
//                            System.out.println("Status found in value of statusinfo");
//                            System.out.println(statusinfo.getString("status"));
//                            if ( statusinfo.getString("status").equals("HOLD Success")) {
//                                System.out.println("Status is hold requested");
//                                return true;
//                            }
//                        }
//
//                    } catch (Exception e) {
//                        e.printStackTrace();
//                        return false;
//                    }
//
//                }
//                return false;
//            } else if (settlementType.equals("RELEASE") && tx.get("statusinfo") != null && !exceptionCase) {
//                if (tx.get("statusinfo") != null) {
//                    try {
//
//                        JSONObject statusinfo = new JSONObject(tx.get("statusinfo").toString());
//
//                        if (statusinfo.opt("status") != null) {
//                            System.out.println("Status found in value of statusinfo");
//                            if (statusinfo.getString("status").equals("HOLD Success")
//                                    || statusinfo.getString("status").equals("RELEASE Failed")) {
//                                System.out.println("Status is hold requested");
//                                return true;
//                            }
//                        }
//
//                    } catch (Exception e) {
//                        return false;
//                    }
//
//                }
//                return false;
//            } else if (settlementType.equals("RELEASE") && tx.get("statusinfo") != null && exceptionCase) {
//                if (tx.get("statusinfo") != null) {
//                    try {
//
//                        JSONObject statusinfo = new JSONObject(tx.get("statusinfo").toString());
//
//                        if (statusinfo.opt("status") != null) {
//                            System.out.println("Status found in value of statusinfo");
//                            if (statusinfo.getString("status").equals("RELEASE Failed")) {
//                                System.out.println("Status is hold requested");
//                                return true;
//                            }
//                        }
//
//                    } catch (Exception e) {
//                        return false;
//                    }
//
//                }
//                return false;
//            } else {
//                return false;
//            }
//
//        }).collect(Collectors.toList());

//         return ResponseEntity.ok(response);
        return ResponseEntity.ok(txn);
    }

    @Override
    public ResponseEntity<String> holdAndUnholdEnquiry(String body) throws Exception {
        ResponseEntity<String> response = pinelabAuth();
        String token = "";
        if (response.getStatusCode() == HttpStatus.OK) {
            JSONObject responseObj = new JSONObject(response.getBody());
            token = responseObj.getString("access_token");
        } else {
            log.error("Pine Lab Authentication API failed  with status " + response.getStatusCode() + " and response "
                    + response.getBody());
            return response;
        }
        JSONObject reqBody = new JSONObject(body);
        String buissness_key = reqBody.getString("reqid");
        reqBody.remove("buissness_key");
        System.out.println("entered service");
        RestTemplate temp = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-requestId", buissness_key);
        headers.set("X-source", pine_lab_x_source);
        headers.set("X-operationType", pine_lab_enquiry_operation_type);
        headers.set("X-requestType", pine_lab_x_request_type);
        headers.set("Accept-Encoding", "identity");
        headers.set("Authorization", "Bearer " + token);
        HttpEntity<Object> entity = new HttpEntity<>(headers);
        ResponseEntity<String> res = temp.exchange(pine_lab_url + "/api/risk/transaction/enquiry",
                HttpMethod.GET, entity, String.class);
        return res;
    }

    public ResponseEntity<?> dummyEnquiry(String requestid) {
        TemplateResponse templateResponse = templateResponseService.getByTemplateName("Enquire_RMS");

        List<String> validresponse = new ArrayList<>();
        validresponse.add("Success");
        validresponse.add("Failed");
        validresponse.add("Partial");

        if (!validresponse.contains(templateResponse.getResponses())) {
            JSONObject response = new JSONObject(templateResponse.getJsonResponse());
            return new ResponseEntity<>(response.optString("body"),
                    HttpStatus.valueOf(response.getInt("responsecode")));
        }

        String[] requestids = requestid.split("-");

        String query = "SELECT bh.bytes_, var.name_, p.id_\n" +
                "FROM camunda.act_hi_procinst p \n" +
                "LEFT JOIN camunda.act_hi_varinst var ON var.proc_inst_id_ = p.id_ \n" +
                "AND (var.name_ = 'holdRequestBody' OR var.name_ = 'releaseRequestBody')\n" +
                "LEFT JOIN camunda.act_ge_bytearray bh ON bh.id_ = var.bytearray_id_\n" +
                "WHERE p.business_key_ = :txnid AND p.state_ = 'ACTIVE' order by var.create_time_ desc limit 1;";

        MapSqlParameterSource parameters = new MapSqlParameterSource();
        parameters.addValue("txnid", requestids[0]);

        JdbcTemplate selectedJdbcTemplate = jdbcTemplateMap.get(DatabaseType.POSTGRESQL_TRANSACTIONAL);
        List<Map<String, Object>> camunda_cases = new NamedParameterJdbcTemplate(
                selectedJdbcTemplate.getDataSource())
                .queryForList(query, parameters);

//        List<Map<String, Object>> camunda_cases = new NamedParameterJdbcTemplate(
//                jdbcTemplateTransactional.getDataSource())
//                .queryForList(query, parameters);

        ObjectInputStream objectInputStream;
        JSONArray holdedTrans = null;
        String action6 = "";
        try {
            byte[] data = (byte[]) camunda_cases.get(0).get("bytes_");
            action6 = camunda_cases.get(0).get("name_") != null ? (String) camunda_cases.get(0).get("name_") : "";

            String jsonString = new String(data, StandardCharsets.UTF_8);
            JSONObject obj = new JSONObject(
                    jsonString.substring(1, jsonString.length() - 1).replaceAll("\\\\\"", "\""));
            holdedTrans = obj.getJSONArray("riskTransactions");

        } catch (Exception e) {
            System.out.println(e);
        }

        JSONObject body = new JSONObject();
        body.put("riskTransactions", holdedTrans);

        boolean status = true;
        if (templateResponse.getResponses().equalsIgnoreCase("Success")) {
            body.put("status", "SUCCESS");
            status = true;
        } else {
            body.put("status", "FAILED");
            status = false;
        }

        String msg;
        if (action6.equals("releaseRequestBody")) {
            msg = "RELEASED";
        } else {
            msg = "HOLDED";
        }

        body.put("message",
                status ? "All transactions " + msg + " successfully" : "All Transactions already released to merchant");
        JSONArray innerRiskTan = new JSONArray();
        for (int i = 0; i < body.getJSONArray("riskTransactions").length(); i++) {
            status = templateResponse.getResponses().equalsIgnoreCase("Partial") ? !status : status;
            JSONObject innerTranObj = new JSONObject();
            JSONObject temp = body.getJSONArray("riskTransactions").getJSONObject(i);
            temp.put("status", action6.equals("releaseRequestBody") ? "RELEASE" : "HOLD");
            if (!status) {
                JSONObject error = new JSONObject(
                        "{ \"type\": \"HoldException\", \"message\": \"Transaction already released to merchant\" }");
                innerTranObj.put("error", error);
            }
            innerTranObj.put("status", status ? "SUCCESS" : "FAILED");

            innerTranObj.put("riskTransaction", temp);
            innerRiskTan.put(innerTranObj);
        }
        body.put("riskTransactions", innerRiskTan);
        return ResponseEntity.ok(body.toString());
    }

    private ResponseErrorHandler customResponseErrorHandler() {
        return new ResponseErrorHandler() {
            @Override
            public boolean hasError(ClientHttpResponse response) throws IOException {
                return false;
            }

            @Override
            public void handleError(ClientHttpResponse response) throws IOException {
            }
        };
    }

    private void retrySendMessage(JSONObject sendMessageReqBody, int attempt,  int retryDelaySeconds, String business_key) {
        if (attempt >= 15) {
            log.error("Max retry attempts reached, giving up. for request id {}", business_key);
            return;
        }

        taskScheduler.schedule(() -> {
            log.info("Attempt {} - Sending message for {}", attempt + 1, business_key);
            ResponseEntity<String> clientResponse = null;
            try {
                clientResponse = camundaService.sendMessage(sendMessageReqBody.toString());
            } catch (Exception e) {
                log.error(e.getMessage(), e);
            }

            log.info("Attempt {} - Send message status: {}, for {}", attempt + 1, clientResponse.getStatusCode(), business_key);
            log.info("Attempt {} - Send message response: {}, for {}", attempt + 1, clientResponse.getBody(), business_key);

            if (clientResponse.getStatusCode() != HttpStatusCode.valueOf(204)) {
                retrySendMessage(sendMessageReqBody, attempt + 1, 60, business_key);// fixed 60-second retry interval
            }
        }, Instant.now().plusSeconds(retryDelaySeconds)); // Initial delay for the first attempt, then fixed 60-second retry interval

    }

}
