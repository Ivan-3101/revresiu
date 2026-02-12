package com.DronaPay.UIServer.service.ApiServices;

import com.DronaPay.UIServer.util.CamundaBasicAuthUtil;
import com.DronaPay.UIServer.util.RestTemplateUtil;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;

@Slf4j
@Service
public class AgentsApiServiceImpl implements AgentsApiService {

    @Value("${dia.server.url}")
    private String dia_server_url;

    @Value(value = "${dia.server.username}")
    private String dia_server_username;

    @Value(value = "${dia.server.password}")
    private String dia_server_password;

    @Autowired
    private CamundaBasicAuthUtil camundaBasicAuthUtil;

    @Override
    public ResponseEntity<String> getAgentResponse(Integer itenantid, Integer iuserid, String userMessage, String agentid, JsonNode agentConfig) throws Exception{
        log.debug("Preparing request for agent: {}", agentid);

        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        String url = dia_server_url + "/agent";
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(dia_server_username, dia_server_password));
        headers.setContentType(MediaType.APPLICATION_JSON);

        ObjectMapper mapper = new ObjectMapper();
        ObjectNode requestBody = mapper.createObjectNode();
        ObjectNode dataNode = mapper.createObjectNode();

        for (JsonNode fieldNode : agentConfig.get("input_data")) {
            String field = fieldNode.asText();
            switch (field) {
                case "itenantid":
                    dataNode.put("itenantid", itenantid);
                    break;
                case "iuserid":
                    dataNode.put("iuserid", iuserid);
                    break;
                default:
                    dataNode.put(field, userMessage);  // dynamic based on input_data like "user_query", "rule_expectation"
            }
        }

        requestBody.set("data", dataNode);
        requestBody.put("agentid", agentid);

        HttpEntity<String> requestEntity = new HttpEntity<>(mapper.writeValueAsString(requestBody), headers);

        ResponseEntity<String> response = restTemplate.exchange(
                url,
                HttpMethod.POST,
                requestEntity,
                String.class
        );

        if (!response.getStatusCode().is2xxSuccessful()) {
            return response;
        }

        log.info("Agent response status: {}", response.getStatusCode());
        log.info("Agent response body: {}", response.getBody());

        JsonNode responseJson = mapper.readTree(response.getBody());

        if (responseJson.has("agentid") && responseJson.has("data")) {
            ObjectNode nestedRequest = mapper.createObjectNode();
            nestedRequest.put("agentid", responseJson.get("agentid").asText());
            nestedRequest.set("data", responseJson.get("data"));

            HttpEntity<String> nestedEntity = new HttpEntity<>(mapper.writeValueAsString(nestedRequest), headers);

            ResponseEntity<String> finalResponse = restTemplate.exchange(
                    url,
                    HttpMethod.POST,
                    nestedEntity,
                    String.class
            );

            log.info("Nested agent response status: {}", finalResponse.getStatusCode());
            log.info("Nested agent response body: {}", finalResponse.getBody());

            return finalResponse;

        } else {
            return response;
        }
    }

    @Override
    public ResponseEntity<String> reloadConfig(String agentId) throws Exception{
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
//        String url = dia_server_url + "/reloadconfig";
        String url = dia_server_url + "/reloadconfig/?agentname=" + agentId;

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(dia_server_username, dia_server_password));
        HttpEntity<Void> entity = new HttpEntity<>(headers);

        return restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
    }
}
