package com.DronaPay.UIServer.service.ControllerService.DummyControllers;

import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.util.CamundaBasicAuthUtil;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.DronaPay.UIServer.util.RestTemplateUtil;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.SneakyThrows;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.*;
import org.springframework.stereotype.Service;

import org.springframework.web.client.RestTemplate;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.springframework.web.reactive.function.client.WebClient;


import java.util.Collections;
import java.util.concurrent.ThreadLocalRandom;
import java.util.concurrent.TimeUnit;

@Service
public class DPControllerServiceImpl implements DPControllerService{

    private static final Logger LOGGER = LoggerFactory.getLogger(DPControllerServiceImpl.class);

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Autowired
    private Environment env;

    @Autowired
    private CamundaBasicAuthUtil camundaBasicAuthUtil;

    @SneakyThrows
    public ResponseEntity<?> blockFund( String jsonString) {

        LOGGER.debug("block fund called");
        ObjectMapper mapper = new ObjectMapper();
        JsonNode rootNode = mapper.readTree(jsonString);


        Integer amountToBeBlocked = Integer.parseInt(rootNode.get("chargeback_payload").get("amount").toString());
        Integer amountBlocked = 0;


        Integer parts = 10; // the number of parts to divide the number into
        Integer size = amountToBeBlocked / parts; // the size of each part
        Integer extra = amountToBeBlocked % parts; // the extra amount to distribute

        for (int i = 1; i <= parts && amountToBeBlocked > amountBlocked ; i++) {

            Integer randomAmountBlocked = size + (extra > 0 ? 1 : 0); // adjust the part size if there's extra amount left
            extra--;

            amountBlocked = amountBlocked + randomAmountBlocked;

            String status = null;
            if(amountToBeBlocked > amountBlocked)
            {
                status = "Recovery in Progress";
            }
            else if(amountToBeBlocked == amountBlocked)
            {
                status = "Recovery Completed";
            }
            String jsonbody = "{\n" +
                    "    \"messageName\": \"" + rootNode.get("chargeback_payload").get("messageName").asText() + "\",\n" +
                    "    \"businessKey\": \"" + rootNode.get("chargeback_payload").get("businessKey").asText() + "\",\n" +
                    "    \"processVariables\": {\n" +
                    "        \"chargeback_id\": {\n" +
                    "            \"type\": \"string\",\n" +
                    "            \"value\": \""+rootNode.get("chargeback_payload").get("chargeback_id").asText()+"\"\n" +
                    "        },\n" +
                    "        \"txn_id\": {\n" +
                    "            \"type\": \"string\",\n" +
                    "            \"value\": \"Transaction"+amountBlocked+"\"\n" +
                    "        },\n" +
                    "        \"amount\": {\n" +
                    "            \"type\": \"string\",\n" +
                    "            \"value\": \""+randomAmountBlocked+"\"\n" +
                    "        },\n" +
                    "        \"chargeback_amount\": {\n" +
                    "            \"type\": \"string\",\n" +
                    "            \"value\": \""+amountToBeBlocked+"\"\n" +
                    "        },\n" +
                    "        \"recovered_amount\": {\n" +
                    "            \"type\": \"string\",\n" +
                    "            \"value\": \""+amountBlocked+"\"\n" +
                    "        },\n" +
                    "        \"status\": {\n" +
                    "            \"type\": \"string\",\n" +
                    "            \"value\": \""+status+"\"\n" +
                    "        }\n" +
                    "    }\n" +
                    "}\n";


            try {
                TimeUnit.SECONDS.sleep(10);
            } catch (Exception e) {
                LOGGER.error("Error : "+ e + " Parameters : " + loggerEncoderUtil.encode(jsonString));
            }

            ResponseEntity<String> clientResponse = null;
            try {

//                clientResponse = WebClient.create(env.getProperty("camunda.server.url"))
//                        .post()
//                        .uri("/engine-rest/message")
//                        .header("Authorization", camundaBasicAuthUtil.getFrmuser())
//                        .contentType(MediaType.APPLICATION_JSON)
//                        .accept(MediaType.APPLICATION_JSON)
//                        .body(BodyInserters.fromValue(jsonbody))
//                        .exchange()
//                        .block();
                RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
                HttpHeaders headers = new HttpHeaders();
                headers.set("Authorization", camundaBasicAuthUtil.getFrmuser());
                headers.setContentType(MediaType.APPLICATION_JSON);
                headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
                HttpEntity<String> entity = new HttpEntity<>(jsonbody, headers);
                clientResponse = restTemplate.exchange(
                        env.getProperty("camunda.server.url") + "/engine-rest/message",
                        HttpMethod.POST,
                        entity,
                        String.class
                );
            } catch (Exception e) {
                LOGGER.error("Error : "+ e + " Parameters : " + loggerEncoderUtil.encode(jsonString));
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"), HttpStatus.INTERNAL_SERVER_ERROR);
            }

//            String response = clientResponse.bodyToMono(String.class).block();
            String response = clientResponse.getBody();
//            clientResponse.releaseBody();
            LOGGER.info(response);

            if(clientResponse.getStatusCode() != HttpStatus.NO_CONTENT)
            {
                break;
            }
        }
        return ResponseEntity.ok(jsonString);
    }
}
