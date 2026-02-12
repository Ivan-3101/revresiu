package com.DronaPay.UIServer.service.ControllerService.TicketClose;

import com.DronaPay.UIServer.util.RestTemplateUtil;
import org.springframework.http.*;
import org.springframework.security.core.Authentication;

import java.util.HashMap;
import java.util.Map;
import java.util.function.Consumer;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.codec.ClientCodecConfigurer;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.BodyInserters;

import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.service.CamundaService;
import com.DronaPay.UIServer.service.RepositoryService.WebUserService;
import com.DronaPay.UIServer.util.CamundaBasicAuthUtil;

@Service
public class TicketCloseServiceImpl implements TicketCloseService {

    @Autowired
    private Environment env;
    final Consumer<ClientCodecConfigurer> consumer = configurer -> {
        final ClientCodecConfigurer.ClientDefaultCodecs codecs = configurer.defaultCodecs();
        codecs.maxInMemorySize(Integer.parseInt(env.getProperty("codec.buffer.size")) * 1024 * 1024);
    };
    @Autowired
    private CamundaBasicAuthUtil camundaBasicAuthUtil;
    @Autowired
    private CamundaService camundaService;
    @Autowired
    private WebUserService webUserService;

    public ResponseEntity<String> getAllTaskToClose(String parameter, WebUser user) throws Exception {
        // System.out.println(getTaskListRequest.getParameters());
        // WebClient.builder().codecs(consumer).baseUrl(env.getProperty("camunda.server.url")).build()
//        return WebClient.builder().codecs(consumer).baseUrl(env.getProperty("camunda.server.url")).build()
//                .post()
//                .uri("/engine-rest/task?maxResults=1000")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(parameter))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(parameter, headers);
        return restTemplate.exchange(
                env.getProperty("camunda.server.url") + "/engine-rest/task?maxResults=1000",
                HttpMethod.POST,
                entity,
                String.class
        );
    }

    @Override
    public ResponseEntity<?> closeAllTicket(String parameter, Authentication pr) {
        // TODO Auto-generated method
        WebUser user = webUserService.loadUserByUsername(pr.getName());

        Map<String, String> task = new HashMap<>();

        JSONObject params = new JSONObject(parameter);

        params.put("assignee", pr.getName());

        ResponseEntity<String> taskList = null;

        try {
            taskList = getAllTaskToClose(params.toString(), user);
        } catch (Exception e) {
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

//        String response = taskList.bodyToMono(String.class).block();
        String response = taskList.getBody();
//        taskList.releaseBody();

        JSONArray jsonArray = new JSONArray(response);
        for (int i = 0, size = jsonArray.length(); i < size; i++) {
            JSONObject objectInArray = jsonArray.getJSONObject(i);

            ResponseEntity<String> submit = null;
            try {
                submit = camundaService.submitForm(objectInArray.getString("id"),
                        objectInArray.getString("processInstanceId"), "{}", user);
            } catch (Exception e) {
                // TODO: handle exception
                task.put(objectInArray.getString("processInstanceId"), "Failed");
            }
//            submit.releaseBody();
            if (submit.getStatusCode() != HttpStatus.OK && submit.getStatusCode() != HttpStatus.NO_CONTENT) {
                task.put(objectInArray.getString("processInstanceId"), "Failed");
            } else {
                task.put(objectInArray.getString("processInstanceId"), "Submitted");
            }
        }
        return ResponseEntity.ok(task);
    }

    @Override
    public ResponseEntity<?> claimAllTicket(String parameter, Authentication pr) {
        WebUser user = webUserService.loadUserByUsername(pr.getName());

        Map<String, String> task = new HashMap<>();

        JSONObject params = new JSONObject(parameter);

        params.put("unassigned", true);

        ResponseEntity<String> taskList = null;

        try {
            taskList = getAllTaskToClose(params.toString(), user);
        } catch (Exception e) {
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

//        String response = taskList.bodyToMono(String.class).block();
        String response = taskList.getBody();
//        taskList.releaseBody();
        System.out.println("Task list response " + response);
        JSONArray jsonArray = new JSONArray(response);
        for (int i = 0, size = jsonArray.length(); i < size; i++) {
            JSONObject objectInArray = jsonArray.getJSONObject(i);

            ResponseEntity<String> submit = null;
            try {
                submit = camundaService.claimTask(objectInArray.getString("id"),
                        objectInArray.getString("processInstanceId"), user);
            } catch (Exception e) {
                // TODO: handle exception
                task.put(objectInArray.getString("processInstanceId"), "Failed");
            }
//            submit.releaseBody();
            if (submit.getStatusCode() != HttpStatus.OK && submit.getStatusCode() != HttpStatus.NO_CONTENT) {
                task.put(objectInArray.getString("processInstanceId"), "Failed");
            } else {
                task.put(objectInArray.getString("processInstanceId"), "Claimed");
            }
        }
        return ResponseEntity.ok(task);
    }

}
