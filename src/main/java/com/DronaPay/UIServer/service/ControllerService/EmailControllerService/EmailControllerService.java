package com.DronaPay.UIServer.service.ControllerService.EmailControllerService;

import org.springframework.http.ResponseEntity;

import com.DronaPay.UIServer.requests.EmailRequest;

public interface EmailControllerService {
    public ResponseEntity<?> sendEmail(EmailRequest emailRequest) throws Exception;
}
