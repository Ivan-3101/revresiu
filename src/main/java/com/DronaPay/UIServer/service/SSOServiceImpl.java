package com.DronaPay.UIServer.service;

import com.DronaPay.UIServer.requests.CodeBody;
import com.DronaPay.UIServer.requests.RefreshToken;
import com.DronaPay.UIServer.service.RepositoryService.TenantRepositoryService;
import com.DronaPay.UIServer.util.RestTemplateUtil;
import com.fasterxml.jackson.databind.JsonNode;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.http.*;

import java.util.Base64;

@Service
@Slf4j
public class SSOServiceImpl implements SSOService {


    @Autowired
    private TenantRepositoryService tenantRepositoryService;

    String getAuth(String username, String password) {
        String res = username + ":" + password;
        return "Basic " + Base64.getEncoder().encodeToString(res.getBytes());
    }


    public ResponseEntity<String> getToken(CodeBody body, JsonNode settings) throws Exception {

        String scope = "";
        String dronauiurl = "";
        String clientid = null;
        String clientsec = null;
        String tokenurl = null;

        scope = settings.at("/ssoConfig/drona.ui.scope").asText();
        dronauiurl = settings.at("/ssoConfig/drona.ui.redirect.url").asText();
        clientid = settings.at("/ssoConfig/drona.ui.clientid").asText();
        tokenurl = settings.at("/ssoConfig/drona.ui.token.url").asText();
        // clientsec = settings.at("/ssoConfig/drona.ui.client.secret").asText();
        clientsec = tenantRepositoryService.decryptCipherText(settings.at("/ssoConfig/drona.ui.client.secret").asText());

        MultiValueMap<String, String> formData = new LinkedMultiValueMap<>();
        formData.add("grant_type", "authorization_code");
        formData.add("redirect_uri", dronauiurl);
        formData.add("code", body.getCode());
        formData.add("scope", scope);

//        return WebClient
//                .builder().baseUrl(tokenurl)
//                .build()
//                .post()
//                .contentType(MediaType.APPLICATION_FORM_URLENCODED)
//                .header("Authorization", getAuth(clientid, clientsec))
//                .body(BodyInserters.fromFormData(formData)).exchange().block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.set("Authorization", getAuth(clientid, clientsec));
        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(formData, headers);

        ResponseEntity<String> clientResponse = restTemplate.exchange(
                tokenurl,
                HttpMethod.POST,
                entity,
                String.class
        );

        if (clientResponse.getStatusCode() != HttpStatus.OK) {
            log.error("Token request failed. Status: {}, Form Data: {}",
                    clientResponse.getStatusCode(), headers);
        }

        return clientResponse;
    }

    public ResponseEntity<String> getRefresh(RefreshToken body, JsonNode settings) throws Exception {

        String scope = "";
        String clientid = null;
        String clientsec = null;
        String tokenurl = null;


        clientid = settings.at("/ssoConfig/drona.ui.clientid").asText();
        tokenurl = settings.at("/ssoConfig/drona.ui.token.url").asText();
        scope = settings.at("/ssoConfig/drona.ui.scope").asText();
        // clientsec = settings.at("/ssoConfig/drona.ui.client.secret").asText();
        clientsec = tenantRepositoryService.decryptCipherText(settings.at("/ssoConfig/drona.ui.client.secret").asText());
        MultiValueMap<String, String> formData = new LinkedMultiValueMap<>();
        formData.add("grant_type", "refresh_token");
        formData.add("client_id", clientid);
        formData.add("refresh_token", body.getRefreshToken());
        formData.add("client_secret", clientsec);
        formData.add("scope", scope);

//        return WebClient
//                .builder().baseUrl(tokenurl)
//                .build()
//                .post()
//                .contentType(MediaType.APPLICATION_FORM_URLENCODED)
//                .body(BodyInserters.fromFormData(formData)).exchange().block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(formData, headers);

        return restTemplate.exchange(
                tokenurl,
                HttpMethod.POST,
                entity,
                String.class
        );
    }


}
