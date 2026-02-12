package com.DronaPay.UIServer.service.ApiServices;

import com.DronaPay.UIServer.requests.AddObservationApiRequest;
import com.DronaPay.UIServer.util.RestTemplateUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

@Service
public class ObservationApiServiceImpl implements ObservationApiService {

//    @Autowired
//    private Environment env;

    @Value("${springapi.server.url}")
    private String spring_api_url;

    @Override
    public ResponseEntity<String> addObservation(String apikey, AddObservationApiRequest addObservationApiRequest, Integer wId) throws Exception {
//        HttpClient client = HttpClient.newHttpClient();
//        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
//        String json = ow.writeValueAsString(addObservationApiRequest);
//        HttpRequest request = HttpRequest.newBuilder()
//                .uri(URI.create(
//                        spring_api_url + "/observer/windows/" + wId + "/observations"))
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
        String json = ow.writeValueAsString(addObservationApiRequest);
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-API-Key", apikey);
        headers.set("Content-Type", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(json, headers);
        ResponseEntity<String> response = restTemplate.exchange(
                spring_api_url + "/observer/windows/" + wId + "/observations",
                HttpMethod.POST,
                entity,
                String.class);
        return response;
    }

    @Override
    public ResponseEntity<String> deleteObservation(String apikey, Integer oId, Integer wId) throws Exception {
//        HttpClient client = HttpClient.newHttpClient();
//
//        HttpRequest request = HttpRequest.newBuilder()
//                .uri(URI.create(
//                        spring_api_url + "/observer/windows/" + wId + "/observations/" + oId))
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
                spring_api_url + "/observer/windows/" + wId + "/observations/" + oId,
                HttpMethod.DELETE,
                entity,
                String.class
        );return response;
    }

}
