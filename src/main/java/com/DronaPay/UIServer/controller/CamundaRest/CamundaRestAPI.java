package com.DronaPay.UIServer.controller.CamundaRest;

import com.DronaPay.UIServer.requests.CallBackSendMessageRequest;
import com.DronaPay.UIServer.service.ControllerService.CamundaRest.CamundaRestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/api/v1/camunda-rest")
public class CamundaRestAPI {

    @Autowired
    private CamundaRestService camundaRestService;

    @PostMapping("/send-message")
    public ResponseEntity<?> sendMessage(@RequestBody String body) {
        return camundaRestService.sendMessage(body);
    }

    @PostMapping("/process-definition/key/{key}/start")
    public ResponseEntity<?> createTicket(@RequestBody String body, @PathVariable("key") String key, Authentication pr) {
        return camundaRestService.createTicket(body, key, pr);
    }

    @PostMapping(value = "/callback/send-message/tenant-id/{tenantid}")
    public ResponseEntity<?> callBackSendMessage(
            @RequestPart("response") CallBackSendMessageRequest callBackSendMessageRequest,
            @RequestPart(value = "attachments", required = false) List<MultipartFile> attachments,
            @PathVariable("tenantid") Integer tenantid) throws Exception {
        return camundaRestService.sendMessage(callBackSendMessageRequest, attachments, tenantid);
    }
}
