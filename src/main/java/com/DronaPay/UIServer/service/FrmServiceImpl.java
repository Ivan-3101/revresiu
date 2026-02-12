package com.DronaPay.UIServer.service;

import com.DronaPay.UIServer.util.RestTemplateUtil;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;
import org.springframework.web.reactive.function.client.WebClient;

@Service
public class FrmServiceImpl implements FrmService {

    @Value("${springapi.server.url}")
    private String spring_api_url;

    @Value("${springapi.server.key.name}")
    private String springapi_key_name;


    @Override
    public ResponseEntity<String> getPaymentAddresses(String paramters) throws Exception {

//        return WebClient.create(spring_api_url)
//                .get()
//                .uri("/payment_addresses/" + paramters)
//                .header(springapi_key_name, "")
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set(springapi_key_name, "");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(null, headers);
        ResponseEntity<String> response = restTemplate.exchange(
                spring_api_url + "/payment_addresses/" + paramters,
                HttpMethod.GET,
                entity,
                String.class
        );
        return response;
    }
}
