package com.DronaPay.UIServer.service.ControllerService.DummyControllers;

import org.springframework.http.ResponseEntity;

public interface CCControllerService {
    public ResponseEntity<?> ccCall(String jsonString);
}
