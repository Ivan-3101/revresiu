package com.DronaPay.UIServer.controller.DummyControllers;


import com.DronaPay.UIServer.requests.MerchantRiskScoreControllerRequest.ReleaseHoldRequest;
import com.DronaPay.UIServer.service.ControllerService.DummyControllers.WhatsAppDummyControllerService;


import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/dummy")
public class WhatsAppDummyController {

    @Autowired
    private WhatsAppDummyControllerService whatsAppDummyControllerService;

    @PostMapping("/ae-release-hold")
    public ResponseEntity<?> releaseHold(@RequestBody String releaseHoldRequest) {
        return whatsAppDummyControllerService.releaseHold(releaseHoldRequest);
    }

    @PostMapping("/ae-refund-client")
    public ResponseEntity<?> refundClient(@RequestBody String releaseHoldRequest) {
        return whatsAppDummyControllerService.refundClient(releaseHoldRequest);
    }


    @PostMapping("/verify-kubernetes")
    public ResponseEntity<?> kubernetes(@RequestBody ReleaseHoldRequest releaseHoldRequest) {
        return whatsAppDummyControllerService.kubernetes(releaseHoldRequest);
    }

    @SneakyThrows
    @PostMapping("/ae-intimate-merchant")
    public ResponseEntity<?> intimateMerchant(@RequestBody String jsonString) {
        return whatsAppDummyControllerService.intimateMerchant(jsonString);
    }


    @GetMapping("/intimate-merchant-via-whatsapp")
    public ResponseEntity<?> intimateMerchantViaWhatsapp() {
        return whatsAppDummyControllerService.intimateMerchantViaWhatsapp();
    }

    @GetMapping("/intimate-merchant-chargeback/{parameter}")
    public ResponseEntity<?> intimateMerchantChargeBack(@PathVariable(value = "parameter", required = true) String parameters) {
        return whatsAppDummyControllerService.intimateMerchantChargeBack(parameters);
    }

}
