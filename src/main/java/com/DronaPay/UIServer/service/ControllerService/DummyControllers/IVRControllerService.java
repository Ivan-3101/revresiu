package com.DronaPay.UIServer.service.ControllerService.DummyControllers;

import lombok.SneakyThrows;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

public interface IVRControllerService {

    public ResponseEntity<?> intimateMerchant(@RequestBody String jsonString);

    public ResponseEntity<?> ivrCall(@RequestBody String jsonString);

    public ResponseEntity<?> ivrIntimateCall(String buissnessKey,String templateName);
}
