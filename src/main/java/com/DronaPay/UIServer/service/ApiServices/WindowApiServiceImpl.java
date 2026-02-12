package com.DronaPay.UIServer.service.ApiServices;

import com.DronaPay.UIServer.requests.AddWindowApiRequest;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;
import com.DronaPay.UIServer.util.RestTemplateUtil;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

@Service
public class WindowApiServiceImpl implements WindowApiService {

    @Value("${springapi.server.url}")
    private String spring_api_url;


    @Override
    public ResponseEntity<String> addWindowApi(String apikey, AddWindowApiRequest addWindowApiRequest) throws Exception {
        // TODO Auto-generated method stub
//        HttpClient client = HttpClient.newHttpClient();
//        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
//        String json = ow.writeValueAsString(addWindowApiRequest);
//        HttpRequest request = HttpRequest.newBuilder()
//                .uri(URI.create(
//                        spring_api_url + "/observer/windows"))
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
        String json = ow.writeValueAsString(addWindowApiRequest);
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-API-Key", apikey);
        headers.set("Content-Type", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(json, headers);
        ResponseEntity<String> response = restTemplate.exchange(
                spring_api_url + "/observer/windows",
                HttpMethod.POST,
                entity,
                String.class
        );
        return response;
    }


    @Override
    public ResponseEntity<String> deactivateWindow(String apikey, Integer id) throws Exception {
//        HttpClient client = HttpClient.newHttpClient();
//        HttpRequest request = HttpRequest.newBuilder()
//                .uri(URI.create(
//                        spring_api_url + "/observer/windows/" + id))
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
                spring_api_url + "/observer/windows/" + id,
                HttpMethod.DELETE,
                entity,
                String.class
        );
        return response;

    }

}
