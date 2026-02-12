package com.DronaPay.UIServer.service.ApiServices;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Base64;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;

import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.DronaPay.UIServer.util.RestTemplateUtil;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class SanctionApiServiceImpl implements SanctionApiService {

    @Value("${sanctions.api.url}")
    private String sanction_url;

    @Value("${sanctions.api.username}")
    private String sanction_username;

    @Value("${sanctions.api.password}")
    private String sanction_password;

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Override
    public ResponseEntity<String> search(String search_body) throws Exception {
        log.info("search sacntion api call initiated");
        String basic = this.sanction_username + ":"
                + this.sanction_password;
        String basic_encoded = "Basic " + Base64.getEncoder().encodeToString(basic.getBytes());
//        HttpResponse<String> search_response = null;
//        HttpRequest search_request = HttpRequest.newBuilder()
//                .uri(URI.create(this.sanction_url + "/search"))
//                .header("Content-Type", "application/json")
//                .header("Authorization", basic_encoded)
//                .POST(HttpRequest.BodyPublishers.ofString(search_body)).build();
//
//        HttpClient clientTenant = HttpClient.newHttpClient();
//        search_response = clientTenant.send(search_request, HttpResponse.BodyHandlers.ofString());
//        log.info("search sacntion api response " + search_response.body().toString());
//        log.info("search sacntion api status " + search_response.statusCode());
//        return search_response;
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");
        headers.set("Authorization", basic_encoded);
        HttpEntity<String> entity = new HttpEntity<>(search_body, headers);
        ResponseEntity<String> search_response = restTemplate.exchange(
                this.sanction_url + "/search",
                HttpMethod.POST,
                entity,
                String.class
        );
        log.info("search sanction api response " + search_response.getBody());
        log.info("search sanction api status " + search_response.getStatusCode());
        return search_response;
    }

    @Override
    public ResponseEntity<String> fetch(String search_body) throws Exception {
//        log.info("sanction fetch api intitated");
//        log.info("url " + URI.create(this.sanction_url + "/fetch"));
//        String basic = this.sanction_username + ":"
//                + this.sanction_password;
//        String basic_encoded = "Basic " + Base64.getEncoder().encodeToString(basic.getBytes());
//        HttpResponse<String> fetch_response = null;
//        HttpRequest fetch_request = HttpRequest.newBuilder()
//                .uri(URI.create(this.sanction_url + "/fetch"))
//                .header("Content-Type", "application/json")
//                .header("Authorization", basic_encoded)
//                .POST(HttpRequest.BodyPublishers.ofString(search_body)).build();
//
//        HttpClient clientTenant = HttpClient.newHttpClient();
//        fetch_response = clientTenant.send(fetch_request, HttpResponse.BodyHandlers.ofString());
//
//        log.info("sanction fetch api response " + fetch_response.body());
//        log.info("sanction fetch api status " + fetch_response.statusCode());
//
//        return fetch_response;
        log.info("sanction fetch api initiated");
        log.info("url " + this.sanction_url + "/fetch");
        String basic = this.sanction_username + ":" + this.sanction_password;
        String basic_encoded = "Basic " + Base64.getEncoder().encodeToString(basic.getBytes());
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");
        headers.set("Authorization", basic_encoded);
        HttpEntity<String> entity = new HttpEntity<>(search_body, headers);
        ResponseEntity<String> fetch_response = restTemplate.exchange(
                this.sanction_url + "/fetch",
                HttpMethod.POST,
                entity,
                String.class
        );
        log.info("sanction fetch api response " + fetch_response.getBody());
        log.info("sanction fetch api status " + fetch_response.getStatusCode());
        return fetch_response;
    }

}
