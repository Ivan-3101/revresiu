package com.DronaPay.UIServer.service;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;

import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.DronaPay.UIServer.util.PISMOBodyBuilder;
import com.DronaPay.UIServer.util.RestTemplateUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PISMOApiServiceImpl implements PISMOApiService {

        @Value(value = "${pismo.url}")
        private String pismourl;

        @Autowired
        private PISMOBodyBuilder pismoBodyBuilder;

        @Autowired
        private LoggerEncoderUtil loggerEncoderUtil;

        @Override
        public ResponseEntity<String> getAccessToken(String server_key, String server_secret, String account_id)
                        throws IOException, InterruptedException {
                log.info("Acces token Request Body " + loggerEncoderUtil.encode(pismoBodyBuilder
                                .accessTokenRequestBody(server_key,server_secret,account_id)));
                URI uri = URI.create(pismourl + "/passport/v2/s2s/access-token");
//                HttpRequest request = HttpRequest.newBuilder()
//                                .uri(uri)
//                                .header("Content-Type", "application/json")
//                                .POST(HttpRequest.BodyPublishers.ofString(pismoBodyBuilder
//                                                .accessTokenRequestBody(server_key,server_secret, account_id)))
//                                .build();
//                HttpClient client = HttpClient.newHttpClient();
//                return client.send(request, HttpResponse.BodyHandlers.ofString());
                RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
                HttpHeaders headers = new HttpHeaders();
                headers.set("Content-Type", "application/json");
                String requestBody = pismoBodyBuilder.accessTokenRequestBody(server_key, server_secret, account_id);
                HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);
                System.out.println("abc86");
                ResponseEntity<String> response = restTemplate.exchange(
                        uri,
                        HttpMethod.POST,
                        entity,
                        String.class
                );
                return response;
        }

        @Override
        public ResponseEntity<String> getAccountDetails(String token, String account_id)
                        throws IOException, InterruptedException {
                URI uri = URI.create(pismourl + "/accounts/v1/accounts/" + account_id);
//                HttpRequest request = HttpRequest.newBuilder()
//                                .uri(uri)
//                                .header("Content-Type", "application/json")
//                                .header("Authorization", token)
//                                .GET()
//                                .build();
//
//                HttpClient client = HttpClient.newHttpClient();
//                return client.send(request, HttpResponse.BodyHandlers.ofString())
                RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
                HttpHeaders headers = new HttpHeaders();
                headers.set("Content-Type", "application/json");
                headers.set("Authorization", token);
                HttpEntity<String> entity = new HttpEntity<>(headers);
                System.out.println("abc87");
                ResponseEntity<String> response = restTemplate.exchange(
                        uri,
                        HttpMethod.GET,
                        entity,
                        String.class
                );
                return response;
        }

        @Override
        public ResponseEntity<String> getCustomerDetails(String token, String customre_id)
                        throws IOException, InterruptedException {
                URI uri = URI.create(pismourl + "/accounts/v2/customers/" + customre_id);
//                HttpRequest request = HttpRequest.newBuilder()
//                                .uri(uri)
//                                .header("Content-Type", "application/json")
//                                .header("Authorization", token)
//                                .GET()
//                                .build();
//
//                HttpClient client = HttpClient.newHttpClient();
//                return client.send(request, HttpResponse.BodyHandlers.ofString());
                RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
                HttpHeaders headers = new HttpHeaders();
                headers.set("Content-Type", "application/json");
                headers.set("Authorization", token);
                HttpEntity<String> entity = new HttpEntity<>(headers);
                System.out.println("abc88");
                ResponseEntity<String> response = restTemplate.exchange(
                        uri,
                        HttpMethod.GET,
                        entity,
                        String.class
                );
                return response;
        }

        @Override
        public ResponseEntity<String> getPhoneDetails(String token, String account_id, String phone_id)
                        throws IOException, InterruptedException {
                URI uri = URI.create(pismourl + "/accounts/v1/accounts/" + account_id + "/phones/" + phone_id);
//                HttpRequest request = HttpRequest.newBuilder()
//                                .uri(uri)
//                                .header("Content-Type", "application/json")
//                                .header("Authorization", token)
//                                .GET()
//                                .build();
//
//                HttpClient client = HttpClient.newHttpClient();
//                return client.send(request, HttpResponse.BodyHandlers.ofString());
                RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
                HttpHeaders headers = new HttpHeaders();
                headers.set("Content-Type", "application/json");
                headers.set("Authorization", token);
                HttpEntity<String> entity = new HttpEntity<>(headers);
                System.out.println("abc89");
                ResponseEntity<String> response = restTemplate.exchange(
                        uri,
                        HttpMethod.GET,
                        entity,
                        String.class
                );
                return response;
        }

}
