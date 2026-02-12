package com.DronaPay.UIServer.service.ApiServices;

import com.DronaPay.UIServer.service.RepositoryService.TenantRepositoryService;
import com.DronaPay.UIServer.util.RestTemplateUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.Collections;

@Component
@Slf4j
public class MastersApiServiceImpl implements MastersApiService {

    @Value("${springapi.server.url}")
    private String spring_api_url;

    @Value("${springapi.server.key.name}")
    private String spring_server_key_name;


    @Autowired
    private TenantRepositoryService tenantRepositoryService;

    @Override
    public ResponseEntity<String> addSimpleCustomer(String body, Integer itenantid) {
//        return WebClient.create(spring_api_url).post().uri("/simple_customers")
//                .header(spring_server_key_name, tenantRepositoryService.findAPIKeyTenant(itenantid))
//                .header("{ \"Content-Type\":\"application/json\"}").contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON).body(BodyInserters.fromValue(body)).exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-API-Key", tenantRepositoryService.findAPIKeyTenant(itenantid));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(body, headers);
        return restTemplate.exchange(
                spring_api_url + "/simple_customers",
                HttpMethod.POST,
                entity,
                String.class
        );
    }
}
