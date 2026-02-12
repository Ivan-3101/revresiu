package com.DronaPay.UIServer.service.ControllerService.JPBAPIController;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.reactive.function.client.ClientResponse;

import com.DronaPay.UIServer.model.TemplateResponse;
import com.DronaPay.UIServer.service.CamundaService;
import com.DronaPay.UIServer.service.RepositoryService.TemplateResponseService;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class JPBAPIControllerServiceImpl implements JPBAPIControllerService {

    @Value("${pinelab.url}")
    private String jpb_ivr_url;

    @Autowired
    private CamundaService camundaService;

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Autowired
    private TemplateResponseService templateResponseService;

    @Override
    public ResponseEntity<String> invokeIVR(String ivrRequest) throws Exception {
        // call dummy api in uiserver
        SimpleClientHttpRequestFactory rf = new SimpleClientHttpRequestFactory();
        rf.setBufferRequestBody(false);
        RestTemplate temp = new RestTemplate(rf);

        HttpEntity<Object> entity = new HttpEntity<>(ivrRequest);
        ResponseEntity<String> res = temp.exchange(jpb_ivr_url + "/dummy-ivr-callback",
                HttpMethod.POST, entity, String.class);
        return res;
    }

    @Override
    public void dummyIVRCallback(String ivrRequest) throws Exception {
        new Thread(() -> {

            try {
                Thread.sleep(10000);

            } catch (InterruptedException e) {
                log.error("Error in thread sleep" + e);
            }
            TemplateResponse templateResponse = null;
            JSONObject jsonResponse = null;
            JSONObject reqBody = new JSONObject(ivrRequest);

            templateResponse = templateResponseService.getByTemplateName("JPB_IVRTemplate");
            jsonResponse = new JSONObject(templateResponse.getJsonResponse());
            JSONObject proceesVar = jsonResponse.getJSONObject("processVariables");
            jsonResponse.put("businessKey", reqBody.getString("businessKey"));
            jsonResponse.put("processVariables", proceesVar);
            log.info("send message request body " + loggerEncoderUtil.encode(jsonResponse.toString()));

            ResponseEntity<String> response;
            try {
                response = camundaService.sendMessage(jsonResponse.toString());
                log.info("send message status " + response.getStatusCode());
//                log.info("send message response " + response.bodyToMono(String.class).block());
                log.info("send message response " + response.getBody());
//                response.releaseBody();
            } catch (Exception e) {
                log.error("Error in send message " + e);
            }

        }).start();

    }

    @Override
    public ResponseEntity<String> blockAccount(String blockRequest) throws Exception {
        return ResponseEntity.ok("Block Account API called");
    }
}
