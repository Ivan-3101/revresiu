package com.DronaPay.UIServer.service.ControllerService.JPBAPIController;

import org.springframework.http.ResponseEntity;


public interface JPBAPIControllerService {

    public ResponseEntity<String> invokeIVR(String ivrRequest) throws Exception;

    public void dummyIVRCallback(String ivrRequest) throws Exception;

    public ResponseEntity<String> blockAccount(String blockRequest) throws Exception;
    
}
