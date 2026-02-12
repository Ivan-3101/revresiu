package com.DronaPay.UIServer.service.ControllerService.ScoreBatchFlow;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.model.Rules;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.QueryParams;
import com.DronaPay.UIServer.response.ScoreBatchQueryParam;
import com.DronaPay.UIServer.service.RepositoryService.ActivityLogService;
import com.DronaPay.UIServer.service.RepositoryService.RulesTempServiceImpl;
import com.DronaPay.UIServer.util.AnalyticalDBQueryExecution;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ScoreBatchFlowServiceImpl implements ScoreBatchFlowService {

        @Autowired
        private RulesTempServiceImpl rulesTempServiceImpl;

        @Autowired
        private AnalyticalDBQueryExecution analyticalDBQueryExecution;

        @Autowired
        private ActivityLogService activityLogService;

        @Autowired
        private LoggerEncoderUtil loggerEncoderUtil;

        @Value(value = "${response.callback.api.url}")
        private String response_callback_api_url;


        private static ObjectMapper getObjectMapper() {
                return new ObjectMapper();
        }

        @Override
        public ResponseEntity<?> findByRuleIdAndExecuteQuery(Integer iRulId, String event, Integer tenantid) {

                Rules rule = null;
                JSONObject response = new JSONObject();
                response.put("api_call", true);
                try {
                        rule = rulesTempServiceImpl.findRuleForQueryExecution(iRulId);
                } catch (Exception e) {
                        // TODO Auto-generated catch block
                        // e.printStackTrace();
                }
                if (rule == null) {
                        log.error("Error : Rule not found for id " + loggerEncoderUtil.encode(iRulId.toString()) + "\nParam : "
                                        + loggerEncoderUtil.encode(event));
                        // activityLogService.addActivity(loggedInUser, "Find and execute query ",
                        //                 "Error : Rule not found for id " + iRulId + "\nParam : "
                        //                                 + loggerEncoderUtil.encode(event));
                        response.put("api_call", false);
                        response.put("message", "Rule not found " + iRulId);
                        return new ResponseEntity<Map>(
                                        response.toMap(),
                                        HttpStatus.NOT_FOUND);
                }

                if (!rule.isBactive() || !rule.getBapicall() || rule.isBdelete()) {
                        response.put("api_call", false);
                        log.info("Rule id " + loggerEncoderUtil.encode(iRulId.toString()) + " is not configured to call response API");
                        // activityLogService.addActivity("Find and execute query ",
                        //                 "Rule id " + iRulId + " is not configured to call response API");
                        return ResponseEntity.ok(response.toMap());
                }

                response.put("attribs", rule.getVcResponseApiAttribs());

                JSONObject query_result = new JSONObject();
                query_result.put("keys", rule.getVcQueryResultMap());
                query_result.put("data", new JSONArray());

                if (rule.getBexecutequery()) {
                        JSONObject eventObj = new JSONObject(event);
                        JSONObject transObj = new JSONObject(eventObj.get("transaction").toString());
                        JSONObject resultObj = new JSONObject(eventObj.get("result").toString());

                        List<ScoreBatchQueryParam> filterParameters;
                        try {
                                filterParameters = getObjectMapper().readerForListOf(ScoreBatchQueryParam.class)
                                                .readValue(rule.getVcQueryFilterParams());
                                List<QueryParams> queryParams = filterParameters.stream()
                                                .map(fp -> fp.getValue() != null ? QueryParams.builder()
                                                                .parameterName(fp.getParameter_name())
                                                                .parameterType(fp.getParameter_type())
                                                                .value(fp.getValue()).build()
                                                                : fp.getTrans_json_pointer() != null ? QueryParams
                                                                                .builder()
                                                                                .parameterName(fp
                                                                                                .getParameter_name())
                                                                                .parameterType(fp
                                                                                                .getParameter_type())
                                                                                .value(transObj.optQuery(
                                                                                                fp
                                                                                                                .getTrans_json_pointer()))
                                                                                .calcType(fp.getCalculate() != null ? fp
                                                                                                .getCalculate()
                                                                                                .getOperator() : null)
                                                                                .calcUnit(fp.getCalculate() != null ? fp
                                                                                                .getCalculate()
                                                                                                .getUnit() : null)
                                                                                .calcValue(fp.getCalculate() != null
                                                                                                ? fp.getCalculate()
                                                                                                                .getValue()
                                                                                                : null)
                                                                                .parameterName(fp
                                                                                                .getParameter_name())
                                                                                .parameterType(fp
                                                                                                .getParameter_type())
                                                                                .value(transObj.optQuery(
                                                                                                fp
                                                                                                                .getTrans_json_pointer()))
                                                                                .calcType(fp.getCalculate() != null ? fp
                                                                                                .getCalculate()
                                                                                                .getOperator() : null)
                                                                                .calcUnit(fp.getCalculate() != null ? fp
                                                                                                .getCalculate()
                                                                                                .getUnit() : null)
                                                                                .calcValue(fp.getCalculate() != null
                                                                                                ? fp.getCalculate()
                                                                                                                .getValue()
                                                                                                : null)
                                                                                .build()
                                                                                : fp.getResult_json_pointer() != null
                                                                                                ? QueryParams.builder()
                                                                                                                .parameterName(fp
                                                                                                                                .getParameter_name())
                                                                                                                .parameterType(fp
                                                                                                                                .getParameter_type())
                                                                                                                .value(resultObj.optQuery(
                                                                                                                                fp.getResult_json_pointer()))
                                                                                                                .calcType(fp.getCalculate() != null
                                                                                                                                ? fp.getCalculate()
                                                                                                                                                .getOperator()
                                                                                                                                : null)
                                                                                                                .calcUnit(fp.getCalculate() != null
                                                                                                                                ? fp.getCalculate()
                                                                                                                                                .getUnit()
                                                                                                                                : null)
                                                                                                                .calcValue(fp.getCalculate() != null
                                                                                                                                ? fp.getCalculate()
                                                                                                                                                .getValue()
                                                                                                                                : null)
                                                                                                                .calcType(fp.getCalculate() != null
                                                                                                                                ? fp.getCalculate()
                                                                                                                                                .getOperator()
                                                                                                                                : null)
                                                                                                                .calcUnit(fp.getCalculate() != null
                                                                                                                                ? fp.getCalculate()
                                                                                                                                                .getUnit()
                                                                                                                                : null)
                                                                                                                .calcValue(fp.getCalculate() != null
                                                                                                                                ? fp.getCalculate()
                                                                                                                                                .getValue()
                                                                                                                                : null)
                                                                                                                .build()
                                                                                                : null)
                                                .collect(Collectors.toList());

                                queryParams.add(QueryParams.builder().parameterName("tenantid")
                                .parameterType("Integer")
                                .value(tenantid).build());

                                log.info("query Params "+loggerEncoderUtil.encode(queryParams.toString()));
                                log.info("iaccount id "+loggerEncoderUtil.encode(transObj.toString()));

                                log.info("query Params "+loggerEncoderUtil.encode(queryParams.toString()));
                                log.info("iaccount id "+loggerEncoderUtil.encode(transObj.toString()));

                                List<Map<String, Object>> extracted_data = analyticalDBQueryExecution
                                                .executeQueryOnAnalytic(
                                                                rule.getVcQuery(),
                                                                queryParams);
                                query_result.put("data", extracted_data);

                        } catch (IOException e) {
                                // TODO Auto-generated catch block
                                // e.printStackTrace();
                        }

                }

                response.put("query_result", query_result);
                response.put("execute_query", rule.getBexecutequery());

                return ResponseEntity.ok(response.toMap());
        }


        @Override
        public ResponseEntity<?> callResponseAPI(String reqBody) throws Exception {
                log.debug(loggerEncoderUtil.encode("Call Back response API req body " + reqBody));
                SimpleClientHttpRequestFactory rf = new SimpleClientHttpRequestFactory();
                rf.setBufferRequestBody(false);
                RestTemplate temp = new RestTemplate(rf);
                HttpHeaders headers = new HttpHeaders();
                headers.set("Content-Type", "application/json");
                HttpEntity<Object> entity = new HttpEntity<>(reqBody, headers);
                ResponseEntity<String> res = temp.exchange(response_callback_api_url,
                                HttpMethod.POST, entity, String.class);

                log.debug(loggerEncoderUtil.encode("Call Back response API status " + res.getStatusCode()));
                log.debug(loggerEncoderUtil.encode("Call Back response API response " + res.getBody()));
                return res;
        }


}
