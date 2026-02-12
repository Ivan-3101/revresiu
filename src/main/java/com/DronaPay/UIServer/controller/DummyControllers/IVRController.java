package com.DronaPay.UIServer.controller.DummyControllers;

import com.DronaPay.UIServer.service.ControllerService.DummyControllers.IVRControllerService;


import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/dummy/ivr")
public class IVRController {


    @Autowired
    private IVRControllerService ivrControllerService;

    @SneakyThrows
    @PostMapping("/notification-ivr-call")
    public ResponseEntity<?> intimateMerchant(@RequestBody String jsonString){
        return ivrControllerService.intimateMerchant(jsonString);
    }

    @SneakyThrows
    @PostMapping("/decline-transaction-ivr")
    public ResponseEntity<?> ivrCall(@RequestBody String jsonString){
        return ivrControllerService.ivrCall(jsonString);
    }


    @SneakyThrows
    @GetMapping("/risk-notification-ivr-call/{buissnesskey}/{template}")
    public ResponseEntity<?> intiamteCustomer(@PathVariable("buissnesskey") String buissnesskey,@PathVariable("template") String template){
        return ivrControllerService.ivrIntimateCall(buissnesskey, template);
    }


}
