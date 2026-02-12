package com.DronaPay.UIServer.service.ApiServices;

import com.DronaPay.UIServer.requests.AddRunRequest;
import com.DronaPay.UIServer.requests.AddSimulationApiRequest;
import com.DronaPay.UIServer.requests.TestRule;
import com.fasterxml.jackson.databind.JsonNode;
import com.DronaPay.UIServer.util.CamundaBasicAuthUtil;
import com.DronaPay.UIServer.util.RestTemplateUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.yaml.snakeyaml.util.UriEncoder;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;


@Service
public class SimulationApiServiceImpl implements SimulationApiService {

    @Value(value = "${simulation.server.url}")
    private String simulation_server_url;

    @Value(value = "${simulation.server.username}")
    private String simulation_server_username;

    @Value(value = "${simulation.server.password}")
    private String simulation_server_password;


    @Autowired
    private CamundaBasicAuthUtil camundaBasicAuthUtil;

    @Autowired
    private Environment env;


    public ResponseEntity<String> addSimulation(AddSimulationApiRequest addSimulationRequest, String simid) throws Exception {
//        HttpClient client = HttpClient.newHttpClient();
//        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
//        String json = ow.writeValueAsString(addSimulationRequest);
//
//        System.out.println("add simulation request body " + json);
//        HttpRequest request = HttpRequest.newBuilder()
//                .uri(URI.create(simulation_server_url + "/sim/" + UriEncoder.encode(simid)))
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(simulation_server_username, simulation_server_password))
//                .header("Content-Type", "application/json")
//                .POST(HttpRequest.BodyPublishers
//                        .ofString(json))
//                .build();
//        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
//        return response;
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
        String json = ow.writeValueAsString(addSimulationRequest);
        System.out.println("add simulation request body " + json);
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(simulation_server_username, simulation_server_password));
        headers.set("Content-Type", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(json, headers);
        ResponseEntity<String> response = restTemplate.exchange(
                simulation_server_url + "/sim/" + simid,
                HttpMethod.POST,
                entity,
                String.class
        );
        return response;
    }

    public ResponseEntity<String> addRun(AddRunRequest addRunRequest, String simid) throws Exception {
//        HttpClient client = HttpClient.newHttpClient();
//        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
//        String json = ow.writeValueAsString(addRunRequest);
//        System.out.println(json);
//        HttpRequest request = HttpRequest.newBuilder()
//                .uri(URI.create(simulation_server_url + "/sim/run/" + UriEncoder.encode(simid)))
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(simulation_server_username, simulation_server_password))
//                .header("Content-Type", "application/json")
//                .POST(HttpRequest.BodyPublishers
//                        .ofString(json))
//                .build();
//        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
//        return response;
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
        String json = ow.writeValueAsString(addRunRequest);
        System.out.println(json);
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(simulation_server_username, simulation_server_password));
        headers.set("Content-Type", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(json, headers);
        ResponseEntity<String> response = restTemplate.exchange(
                simulation_server_url + "/sim/run/" + simid,
                HttpMethod.POST,
                entity,
                String.class
        );
        return response;
    }

    public ResponseEntity<String> testRule(TestRule addRunRequest) throws Exception {
//        HttpClient client = HttpClient.newHttpClient();
//        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
//        String json = ow.writeValueAsString(addRunRequest);
//        HttpRequest request = HttpRequest.newBuilder()
//                .uri(URI.create(simulation_server_url + "/sim/test"))
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(simulation_server_username, simulation_server_password))
//                .header("Content-Type", "application/json")
//                .POST(HttpRequest.BodyPublishers
//                        .ofString(json))
//                .build();
//        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
//        return response;
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
        String json = ow.writeValueAsString(addRunRequest);
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(simulation_server_username, simulation_server_password));
        headers.set("Content-Type", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(json, headers);
        ResponseEntity<String> response = restTemplate.exchange(
                simulation_server_url + "/sim/test",
                HttpMethod.POST,
                entity,
                String.class
        );
        return response;
    }

    public ResponseEntity<String> validateSimulation(AddRunRequest addRunRequest, String simid) throws Exception{
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
        String json = ow.writeValueAsString(addRunRequest);
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(simulation_server_username, simulation_server_password));
        headers.set("Content-Type", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(json, headers);

        System.out.println("Validate simulation, simid " + simid);
        ResponseEntity<String> response = restTemplate.exchange(
                simulation_server_url + "/sim/check/" + simid,
                HttpMethod.POST,
                entity,
                String.class
        );
        return response;
    }
}
