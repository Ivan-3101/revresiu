package com.DronaPay.UIServer.service.ApiServices;

import com.DronaPay.UIServer.model.TransactionClassesUI;
import com.DronaPay.UIServer.requests.AddTranasctionClassApiRequest;
import com.DronaPay.UIServer.requests.EditTrasnsactionClassApiRequest;
import com.DronaPay.UIServer.service.RepositoryService.TenantRepositoryService;
import com.DronaPay.UIServer.util.RestTemplateUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.yaml.snakeyaml.util.UriEncoder;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

@Service
public class TransactionClassApiServiceImpl implements TransactionClassApiService {

    @Value("${springapi.server.url}")
    private String spring_api_url;

    @Autowired
    private TenantRepositoryService tenantRepositoryService;

    @Override
    public ResponseEntity<String> addTransactionClass(TransactionClassesUI transactionClassesUI) throws Exception {
//        HttpClient client = HttpClient.newHttpClient();
//        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
//        String json = ow.writeValueAsString(AddTranasctionClassApiRequest.parseTransactionClassUi(transactionClassesUI));
//        System.out.println(json);
//        // System.out.println(json.toString());
//        String apikey = tenantRepositoryService.findAPIKeyTenant(transactionClassesUI.getItenantId());
//        HttpRequest request = HttpRequest.newBuilder()
//                .uri(URI.create(
//                        spring_api_url + "/transaction_class"))
//                // .header("X-API-Key", env.getProperty("score.server.key"))
//                .header("X-API-Key", apikey)
//                .header("Content-Type", "application/json")
//                .POST(HttpRequest.BodyPublishers
//                        .ofString(json))
//                .build();
//        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
//        return response;
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
        String json = ow.writeValueAsString(AddTranasctionClassApiRequest.parseTransactionClassUi(transactionClassesUI));
        System.out.println(json);
        String apikey = tenantRepositoryService.findAPIKeyTenant(transactionClassesUI.getItenantId());
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-API-Key", apikey);
        headers.set("Content-Type", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(json, headers);
        ResponseEntity<String> response = restTemplate.exchange(
                spring_api_url + "/transaction_class",
                HttpMethod.POST,
                entity,
                String.class
        );
        return response;
    }

    @Override
    public ResponseEntity<String> editTransactionClass(TransactionClassesUI transactionClassesUI) throws Exception {
//        HttpClient client = HttpClient.newHttpClient();
//        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
//        String json = ow.writeValueAsString(EditTrasnsactionClassApiRequest.parseTransactionClassUi(transactionClassesUI));
//        System.out.println(json);
//        // System.out.println(json.toString());
//        HttpRequest request = HttpRequest.newBuilder()
//                .uri(URI.create(
//                        spring_api_url + "/transaction_class/" + UriEncoder.encode(transactionClassesUI.getVcClassName())))
//                // .header("X-API-Key", env.getProperty("score.server.key"))
//                .header("X-API-Key", tenantRepositoryService.findAPIKeyTenant(transactionClassesUI.getItenantId()))
//                .header("Content-Type", "application/json")
//                .PUT(HttpRequest.BodyPublishers
//                        .ofString(json))
//                .build();
//        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
//        return response;
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
        String json = ow.writeValueAsString(EditTrasnsactionClassApiRequest.parseTransactionClassUi(transactionClassesUI));
        System.out.println(json);
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-API-Key", tenantRepositoryService.findAPIKeyTenant(transactionClassesUI.getItenantId()));
        headers.set("Content-Type", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(json, headers);
        ResponseEntity<String> response = restTemplate.exchange(
                spring_api_url + "/transaction_class/" + transactionClassesUI.getVcClassName(),
                HttpMethod.PUT,
                entity,
                String.class
        );
        return response;
    }

    @Override
    public ResponseEntity<String> getTransactionClass(String apikey, String classname) throws Exception {
//        HttpClient client = HttpClient.newHttpClient();
//        HttpRequest request = HttpRequest.newBuilder()
//                .uri(URI.create(
//                        spring_api_url + "/transaction_class/" + UriEncoder.encode(classname)))
//                // .header("X-API-Key", env.getProperty("score.server.key"))
//                .header("X-API-Key", apikey)
//                .header("Content-Type", "application/json")
//                .GET()
//                .build();
//        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
//        return response;
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-API-Key", apikey);
        headers.set("Content-Type", "application/json");
        HttpEntity<Void> entity = new HttpEntity<>(headers);
        System.out.println("abc95");
        ResponseEntity<String> response = restTemplate.exchange(
                spring_api_url + "/transaction_class/" + classname,
                HttpMethod.GET,
                entity,
                String.class
        );
        return response;
    }

    @Override
    public ResponseEntity<String> deleteTransactionClass(String apikey, String classname) throws Exception {
//        HttpClient client = HttpClient.newHttpClient();
//        HttpRequest request = HttpRequest.newBuilder()
//                .uri(URI.create(
//                        spring_api_url + "/transaction_class/" + UriEncoder.encode(classname)))
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
                spring_api_url + "/transaction_class/" + classname,
                HttpMethod.DELETE,
                entity,
                String.class
        );
        return response;
    }

}
