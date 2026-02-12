package com.DronaPay.UIServer.service.ControllerService.DummyControllers;

import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.service.RepositoryService.TemplateResponseService;
import com.DronaPay.UIServer.model.TemplateResponse;
import com.DronaPay.UIServer.util.CamundaBasicAuthUtil;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.DronaPay.UIServer.util.RestTemplateUtil;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.SneakyThrows;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.http.*;

import org.springframework.web.client.RestTemplate;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.Collections;
import java.util.concurrent.TimeUnit;

@Service
public class IVRControllerServiceImpl implements IVRControllerService {

    private static final Logger LOGGER = LoggerFactory.getLogger(IVRControllerServiceImpl.class);

    @Autowired
    private TemplateResponseService templateResponseService;

    @Autowired
    private Environment env;

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Autowired
    private CamundaBasicAuthUtil camundaBasicAuthUtil;

    @SneakyThrows
    public ResponseEntity<?> intimateMerchant(String jsonString) {
        LOGGER.debug("ivr-call api call");
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
                LOGGER.error("Error : ", e + " Parameters : " + loggerEncoderUtil.encode(jsonString));
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
//            String response = clientResponse.bodyToMono(String.class).block();
            String response = clientResponse.getBody();
//            clientResponse.releaseBody();
            LOGGER.error(response);
        }
        return ResponseEntity.ok(jsonString);

    }

    @SneakyThrows
    public ResponseEntity<?> ivrCall(String jsonString) {

        try {
            TimeUnit.SECONDS.sleep(10);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + " Parameters : " + loggerEncoderUtil.encode(jsonString));
        }

        ResponseEntity<String> clientResponse = null;
        try {

//            clientResponse = WebClient.create(env.getProperty("camunda.server.url"))
//                    .post()
//                    .uri("/engine-rest/message")
//                    .header("Authorization", camundaBasicAuthUtil.getFrmuser())
//                    .contentType(MediaType.APPLICATION_JSON)
//                    .accept(MediaType.APPLICATION_JSON)
//                    .body(BodyInserters.fromValue(jsonString))
//                    .exchange()
//                    .block();
            RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
            HttpHeaders headers = new HttpHeaders();
            headers.set("Authorization", camundaBasicAuthUtil.getFrmuser());
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
            HttpEntity<String> entity = new HttpEntity<>(jsonString, headers);
            clientResponse = restTemplate.exchange(
                    env.getProperty("camunda.server.url") + "/engine-rest/message",
                    HttpMethod.POST,
                    entity,
                    String.class
            );
        } catch (Exception e) {
            LOGGER.error("Error : ", e + " Parameters : " + loggerEncoderUtil.encode(jsonString));
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
//        String response = clientResponse.bodyToMono(String.class).block();
        String response = clientResponse.getBody();
//        clientResponse.releaseBody();
        return ResponseEntity.ok(jsonString);
    }

    @Override
    public ResponseEntity<?> ivrIntimateCall(String buissnessKey, String templateName) {

        System.out.println("Dummy Stub for IVR Called with buissnesskey " + buissnessKey);
        TemplateResponse templateResponse1 = templateResponseService.getByTemplateName(templateName);
        Object obj1 = JSONValue.parse(templateResponse1.getJsonResponse());
        JSONObject jsonObject1 = (JSONObject) obj1;
        jsonObject1.replace("businessKey", buissnessKey);

        try {
            System.out.println("Timer intiated");
            TimeUnit.SECONDS.sleep(10);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + " Parameters : buissnesskey " + loggerEncoderUtil.encode(buissnessKey)
                    + " template name " + loggerEncoderUtil.encode(templateName));
        }

        System.out.println("Timer Closed");
        System.out.println("Camunda API call intiated");

        ResponseEntity<String> clientResponse1 = null;
        try {

//            clientResponse1 = WebClient.create(env.getProperty("camunda.server.url"))
//                    .post()
//                    .uri("/engine-rest/message")
//                    .header("Authorization", camundaBasicAuthUtil.getFrmuser())
//                    .contentType(MediaType.APPLICATION_JSON)
//                    .accept(MediaType.APPLICATION_JSON)
//                    .body(BodyInserters.fromValue(jsonObject1))
//                    .exchange()
//                    .block();
            RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
            HttpHeaders headers = new HttpHeaders();
            headers.set("Authorization", camundaBasicAuthUtil.getFrmuser());
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

            HttpEntity<String> entity = new HttpEntity<>(jsonObject1.toString(), headers);

            clientResponse1 = restTemplate.exchange(
                    env.getProperty("camunda.server.url") + "/engine-rest/message",
                    HttpMethod.POST,
                    entity,
                    String.class
            );
        } catch (Exception e) {
            LOGGER.error("Error : " + e + " Parameters : buissnesskey " + loggerEncoderUtil.encode(buissnessKey)
                    + " template name " + loggerEncoderUtil.encode(templateName));
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                    HttpStatus.INTERNAL_SERVER_ERROR);

        }
//        String response1 = clientResponse1.bodyToMono(String.class).block();
        String response1 = clientResponse1.getBody();
//        clientResponse1.releaseBody();
        if (clientResponse1.getStatusCode() != HttpStatus.CREATED || clientResponse1.getStatusCode() != HttpStatus.ACCEPTED) {
            if (response1 != null) {

                LOGGER.info(loggerEncoderUtil.encode(response1));
            }
            // return new ResponseEntity<ApiResponse>(new ApiResponse(true, response1),
            // HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Feedback sent successfully"),
                HttpStatus.ACCEPTED);
    }

}
