package com.DronaPay.UIServer.service.ControllerService.DummyControllers;

import org.springframework.http.ResponseEntity;

public interface FRMControllerService {

    public ResponseEntity<?> blockFund(String jsonString);
}
