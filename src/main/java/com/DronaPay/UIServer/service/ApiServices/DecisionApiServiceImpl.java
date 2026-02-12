package com.DronaPay.UIServer.service.ApiServices;

import com.DronaPay.UIServer.model.DecisionUi;
import com.DronaPay.UIServer.requests.AddDecisionApiRequest;
import com.DronaPay.UIServer.requests.EditDecisionApiRequest;
import com.DronaPay.UIServer.service.RepositoryService.TenantRepositoryService;
import com.DronaPay.UIServer.util.RestTemplateUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

@Service
public class DecisionApiServiceImpl implements DecisionApiService {

    @Value("${springapi.server.url}")
    private String spring_api_url;

    @Autowired
    private TenantRepositoryService tenantRepositoryService;

    @Override
    public ResponseEntity<String> addDecision(DecisionUi decisionUi) throws Exception {
//        HttpClient client = HttpClient.newHttpClient();
//        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
//        String json = ow.writeValueAsString(AddDecisionApiRequest.parseDecisionUi(decisionUi));
//        System.out.println(json);
//        // System.out.println(json.toString());
//        HttpRequest request = HttpRequest.newBuilder()
//                .uri(URI.create(
//                        spring_api_url + "/decision"))
//                // .header("X-API-Key", env.getProperty("score.server.key"))
//                .header("X-API-Key", tenantRepositoryService.findAPIKeyTenant(decisionUi.getItenantId()))
//                .header("Content-Type", "application/json")
//                .POST(HttpRequest.BodyPublishers
//                        .ofString(json))
//                .build();
//        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
//        return response;
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
        String json = ow.writeValueAsString(AddDecisionApiRequest.parseDecisionUi(decisionUi));
        System.out.println(json);
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-API-Key", tenantRepositoryService.findAPIKeyTenant(decisionUi.getItenantId()));
        headers.set("Content-Type", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(json, headers);
        ResponseEntity<String> response = restTemplate.exchange(
                spring_api_url + "/decision",
                HttpMethod.POST,
                entity,
                String.class
        );
        return response;
    }

    @Override
    public ResponseEntity<String> editDecision(DecisionUi decisionUi) throws Exception {
//        HttpClient client = HttpClient.newHttpClient();
//        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
//        String json = ow.writeValueAsString(EditDecisionApiRequest.parseDecisionUi(decisionUi));
//        System.out.println(json);
//        // System.out.println(json.toString());
//        HttpRequest request = HttpRequest.newBuilder()
//                .uri(URI.create(
//                        spring_api_url + "/decision/" + decisionUi.getMasterDecisionId()))
//                // .header("X-API-Key", env.getProperty("score.server.key"))
//                .header("X-API-Key", tenantRepositoryService.findAPIKeyTenant(decisionUi.getItenantId()))
//                .header("Content-Type", "application/json")
//                .PUT(HttpRequest.BodyPublishers
//                        .ofString(json))
//                .build();
//        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
//        return response;
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
        String json = ow.writeValueAsString(EditDecisionApiRequest.parseDecisionUi(decisionUi));
        System.out.println(json);
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-API-Key", tenantRepositoryService.findAPIKeyTenant(decisionUi.getItenantId()));
        headers.set("Content-Type", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(json, headers);
        ResponseEntity<String> response = restTemplate.exchange(
                spring_api_url + "/decision/" + decisionUi.getMasterDecisionId(),
                HttpMethod.PUT,
                entity,
                String.class
        );
        return response;
    }

//    @Override
//    public HttpResponse<String> getDecision(Integer decisionid) throws Exception {
//        HttpClient client = HttpClient.newHttpClient();
//        
//        HttpRequest request = HttpRequest.newBuilder()
//                .uri(URI.create(spring_api_url + "/decision/" + decisionid))
//                .header("X-API-Key", env.getProperty("score.server.key"))
//                .header("Content-Type", "application/json")
//                .GET()
//                .build();
//        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
//        return response;
//    }

    @Override
    public ResponseEntity<String> deleteDecision(String apikey, Integer decisionid) throws Exception {
//        HttpClient client = HttpClient.newHttpClient();
//
//        HttpRequest request = HttpRequest.newBuilder()
//                .uri(URI.create(spring_api_url + "/decision/" + decisionid))
//                //.header("X-API-Key", env.getProperty("score.server.key"))
//                .header("X-API-Key", apikey)
//                .header("Content-Type", "application/json")
//                .DELETE()
//                .build();
//        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
//        return response;
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-API-Key", apikey);
        headers.set("Content-Type", "application/json");
        HttpEntity<Void> entity = new HttpEntity<>(headers);
        ResponseEntity<String> response = restTemplate.exchange(
                spring_api_url + "/decision/" + decisionid,
                HttpMethod.DELETE,
                entity,
                String.class
        );
        return response;
    }

}
