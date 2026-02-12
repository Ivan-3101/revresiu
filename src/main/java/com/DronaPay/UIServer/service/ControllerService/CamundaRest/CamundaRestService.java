package com.DronaPay.UIServer.service.ControllerService.CamundaRest;

import com.DronaPay.UIServer.requests.CallBackSendMessageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface CamundaRestService {

    public ResponseEntity<?> sendMessage(String body);

    public ResponseEntity<?> createTicket(String body, String key, Authentication pr);

    public ResponseEntity<?> sendMessage(CallBackSendMessageRequest callBackSendMessageRequest,
                                         List<MultipartFile> attachments, Integer tenantid) throws Exception;

}
