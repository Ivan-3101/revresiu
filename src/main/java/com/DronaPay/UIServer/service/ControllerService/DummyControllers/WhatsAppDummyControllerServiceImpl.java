package com.DronaPay.UIServer.service.ControllerService.DummyControllers;

import com.DronaPay.UIServer.requests.APICall;
import com.DronaPay.UIServer.requests.MerchantRiskScoreControllerRequest.ReleaseHoldRequest;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.MerchantRiskScoreResponse.ReleaseHoldResponse;
import com.DronaPay.UIServer.service.CamundaService;
import com.DronaPay.UIServer.service.RepositoryService.TemplateResponseService;
import com.DronaPay.UIServer.model.TemplateResponse;
import com.DronaPay.UIServer.util.CamundaBasicAuthUtil;
import com.DronaPay.UIServer.util.RestTemplateUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.SneakyThrows;
//
//import org.apache.velocity.VelocityContext;
//import org.apache.velocity.app.Velocity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.*;
import org.springframework.stereotype.Service;

import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.springframework.web.reactive.function.client.WebClient;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import org.springframework.web.client.RestTemplate;

import java.util.Collections;
import java.util.concurrent.TimeUnit;
import java.util.function.Consumer;

@Service
public class WhatsAppDummyControllerServiceImpl implements WhatsAppDummyControllerService {

    private static final Logger LOGGER = LoggerFactory.getLogger(WhatsAppDummyControllerServiceImpl.class);

    @Autowired
    private TemplateResponseService templateResponseService;

    @Autowired
    private Environment env;

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Autowired
    private CamundaBasicAuthUtil camundaBasicAuthUtil;

    @Autowired
    private CamundaService camundaService;

    public ResponseEntity<?> releaseHold(String releaseHoldRequest) {
        ReleaseHoldResponse response = new ReleaseHoldResponse();
        response.setStatus(true);
        response.setMessage("api called ");
        return ResponseEntity.ok(response);
    }

    public ResponseEntity<?> refundClient(String releaseHoldRequest) {
        ReleaseHoldResponse response = new ReleaseHoldResponse();
        response.setStatus(true);
        response.setMessage("api called ");
        return ResponseEntity.ok(response);
    }

    public ResponseEntity<?> kubernetes(ReleaseHoldRequest releaseHoldRequest) {
        ReleaseHoldResponse response = new ReleaseHoldResponse();
        response.setStatus(true);
        response.setMessage("api called ");
        return ResponseEntity.ok(response);
    }

    @SneakyThrows
    public ResponseEntity<?> intimateMerchant(String jsonString) {

        ObjectMapper mapper = new ObjectMapper();
        JsonNode rootNode = mapper.readTree(jsonString);
        String tempName = rootNode.get("body").get("template").get("name").asText();
        if (tempName != null & !tempName.equalsIgnoreCase("null") & !tempName.equalsIgnoreCase("")) {
            TemplateResponse templateResponse = templateResponseService.getByTemplateName(tempName);
            Object obj = JSONValue.parse(templateResponse.getJsonResponse());
            JSONObject jsonObject = (JSONObject) obj;
            jsonObject.replace("messageName", rootNode.get("body").get("messagename").asText());
            jsonObject.replace("businessKey", rootNode.get("body").get("bussinesskey").asText());

            try {
                TimeUnit.SECONDS.sleep(10);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + " Parameters : " + loggerEncoderUtil.encode(jsonString));
            }

            ResponseEntity<String> clientResponse = null;
            try {

//                clientResponse = WebClient.create(env.getProperty("camunda.server.url"))
//                        .post()
//                        .uri("/engine-rest/message")
//                        .header("Authorization", camundaBasicAuthUtil.getFrmuser())
//                        .contentType(MediaType.APPLICATION_JSON)
//                        .accept(MediaType.APPLICATION_JSON)
//                        .body(BodyInserters.fromValue(jsonObject))
//                        .exchange()
//                        .block();
                RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
                HttpHeaders headers = new HttpHeaders();
                headers.set("Authorization", camundaBasicAuthUtil.getFrmuser());
                headers.setContentType(MediaType.APPLICATION_JSON);
                headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
                HttpEntity<String> entity = new HttpEntity<>(jsonObject.toString(), headers);
                clientResponse = restTemplate.exchange(
                        env.getProperty("camunda.server.url") + "/engine-rest/message",
                        HttpMethod.POST,
                        entity,
                        String.class
                );
            } catch (Exception e) {

                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);

            }
//            String response = clientResponse.bodyToMono(String.class).block();
            String response = clientResponse.getBody();
//            clientResponse.releaseBody();
            if (clientResponse.getStatusCode() != HttpStatus.CREATED
                    || clientResponse.getStatusCode() != HttpStatus.ACCEPTED) {
                LOGGER.info(loggerEncoderUtil.encode(response));
            }

            org.json.JSONObject objectInArray1 = new org.json.JSONObject(templateResponse.getJsonResponse());
            if (tempName.equalsIgnoreCase("DD_ReqInfo")) {

                if (objectInArray1.getJSONObject("processVariables").getJSONObject("separate").getString("value")
                        .equalsIgnoreCase("Yes")) {
                    TemplateResponse templateResponse1 = templateResponseService.getByTemplateName("DD_ReqDoc");
                    Object obj1 = JSONValue.parse(templateResponse1.getJsonResponse());
                    JSONObject jsonObject1 = (JSONObject) obj1;
                    jsonObject1.replace("messageName", "doubledebitmessage2");
                    jsonObject1.replace("businessKey", rootNode.get("body").get("bussinesskey").asText());

                    try {
                        TimeUnit.SECONDS.sleep(10);
                    } catch (Exception e) {
                        LOGGER.error("Error : " + e + " Parameters : " + loggerEncoderUtil.encode(jsonString));
                    }

                    ResponseEntity<String> clientResponse1 = null;
                    try {

//                        clientResponse1 = WebClient.create(env.getProperty("camunda.server.url"))
//                                .post()
//                                .uri("/engine-rest/message")
//                                .header("Authorization", camundaBasicAuthUtil.getFrmuser())
//                                .contentType(MediaType.APPLICATION_JSON)
//                                .accept(MediaType.APPLICATION_JSON)
//                                .body(BodyInserters.fromValue(jsonObject1))
//                                .exchange()
//                                .block();
                        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
                        HttpHeaders headers = new HttpHeaders();
                        headers.set("Authorization", camundaBasicAuthUtil.getFrmuser());
                        headers.setContentType(MediaType.APPLICATION_JSON);
                        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
                        HttpEntity<String> entity1 = new HttpEntity<>(jsonObject1.toString(), headers);
                        clientResponse1 = restTemplate.exchange(
                                env.getProperty("camunda.server.url") + "/engine-rest/message",
                                HttpMethod.POST,
                                entity1,
                                String.class
                        );

                    } catch (Exception e) {
                        LOGGER.error("Error : " + e + " Parameters : " + loggerEncoderUtil.encode(jsonString));
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
//                    String response1 = clientResponse1.bodyToMono(String.class).block();
                    String response1 = clientResponse1.getBody();
//                    clientResponse1.releaseBody();
                    if (clientResponse1.getStatusCode() != HttpStatus.CREATED
                            || clientResponse1.getStatusCode() != HttpStatus.ACCEPTED) {
                        LOGGER.info(loggerEncoderUtil.encode(response1));
                    }

                }
            }

        }
        return ResponseEntity.ok(jsonString);
    }

    public ResponseEntity<?> intimateMerchantViaWhatsapp() {

        // ScriptEngineManager manager = new ScriptEngineManager();
        // ScriptEngine engine = manager.getEngineByName("JavaScript");
        //
        //
        // String stringfunction = " function callJavaMethod()\n" +
        // " {\n" +
        // " var headers = new org.springframework.util.LinkedMultiValueMap();\n" +
        // " headers.add(\"Content-Type\", \"application/json\");\n" +
        // " var body = new java.util.HashMap();\n" +
        // " body.put(\"name\", \"hello\");\n" +
        // " body.put(\"age\", 123);var apicall = new
        // com.DronaPay.UIServer.requests.APICall();\n" +
        // " apicall.setType(\"GET\");\n" +
        // " apicall.setPath(\"/users\");\n" +
        // " apicall.setBaseURL(\"$CamundaURL\");\n" +
        // " apicall.setBody(body);\n" +
        // " apicall.setHeaders(headers);\n" +
        // " var t = cb.myJavaMethod(apicall);\n" +
        // " t= JSON.parse(t);\n" +
        // "\n" +
        // " for (var i = 0; i < t.length; i++) {\n" +
        // " t[i].newkey = cb.myJavaMethod(apicall); \n" +
        // " }\n" +
        // " return t;\n" +
        // " \n" +
        // " }";
        //
        // VelocityContext context = new VelocityContext();
        // context.put("CamundaURL", "https://jsonplaceholder.typicode.com");
        //
        // StringWriter writer = new StringWriter();
        //
        // engine.put("cb", new WhatsAppDummyControllerServiceImpl());
        // Object result = null;
        //
        //
        // Velocity.init();
        // Velocity.evaluate(context, writer, "TemplateName", stringfunction);
        //
        // System.out.println(writer);
        //
        // try {
        // engine.eval(String.valueOf(writer));
        // Invocable invocable = (Invocable) engine;
        // result = invocable.invokeFunction("callJavaMethod");
        //
        // } catch (ScriptException e) {
        // throw new RuntimeException(e);
        // } catch (NoSuchMethodException e) {
        // throw new RuntimeException(e);
        // }

        LOGGER.debug("whatsapp called successfully");
        return ResponseEntity.ok(true);
    }

    public String myJavaMethod(APICall message) throws JsonProcessingException {
//        Consumer<HttpHeaders> consumer = it -> it.addAll(message.getHeaders());
//        ClientResponse temp = WebClient.create(message.getBaseURL())
//                .method(HttpMethod.valueOf(message.getType().toUpperCase()))
//                .uri(message.getPath())
//                .headers(consumer)
//                .body(BodyInserters.fromValue(message.getBody()))
//                .exchange()
//                .block();
//        String res = temp.bodyToMono(String.class).block();
//        temp.releaseBody();
//        return res;
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.addAll(message.getHeaders());
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonBody = objectMapper.writeValueAsString(message.getBody());
        HttpEntity<String> entity = new HttpEntity<>(jsonBody, headers);
        ResponseEntity<String> response = restTemplate.exchange(
                message.getBaseURL() + message.getPath(),
                HttpMethod.valueOf(message.getType().toUpperCase()),
                entity,
                String.class
        );
        return response.getBody();
    }

    public ResponseEntity<?> intimateMerchantChargeBack(String parameters) {
        LOGGER.debug("Intimate Merchant ChargeBack " + loggerEncoderUtil.encode(parameters));
        return ResponseEntity.ok(true);
    }

}
