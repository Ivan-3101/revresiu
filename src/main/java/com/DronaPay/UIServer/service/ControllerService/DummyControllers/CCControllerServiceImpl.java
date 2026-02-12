package com.DronaPay.UIServer.service.ControllerService.DummyControllers;

import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.util.CamundaBasicAuthUtil;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.DronaPay.UIServer.util.RestTemplateUtil;
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
import com.DronaPay.UIServer.util.LoggerEncoderUtil;

import java.util.Collections;
import java.util.concurrent.TimeUnit;

@Service
public class CCControllerServiceImpl implements CCControllerService {

    private static final Logger LOGGER = LoggerFactory.getLogger(CCControllerServiceImpl.class);

    @Autowired
    private CamundaBasicAuthUtil camundaBasicAuthUtil;

    @Autowired
    private Environment env;

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    public ResponseEntity<?> ccCall(String jsonString) {

        LOGGER.debug("CC dummy api called");

        try {
            TimeUnit.SECONDS.sleep(10);
        } catch (Exception e) {
            LOGGER.error("Error : " + e);
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
            LOGGER.error("Error : " + e + " Parameters : " + loggerEncoderUtil.encode(jsonString));
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
//        String response = clientResponse.bodyToMono(String.class).block();
        String response = clientResponse.getBody();
//        clientResponse.releaseBody();
        return ResponseEntity.ok(jsonString);
    }
}
