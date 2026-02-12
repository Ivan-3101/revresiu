package com.DronaPay.UIServer.service.ControllerService.DummyControllers;

import org.springframework.http.ResponseEntity;

public interface DPControllerService {
    public ResponseEntity<?> blockFund(String jsonString);
}
