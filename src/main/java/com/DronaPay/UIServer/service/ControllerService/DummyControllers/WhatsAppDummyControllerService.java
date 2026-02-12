package com.DronaPay.UIServer.service.ControllerService.DummyControllers;

import com.DronaPay.UIServer.requests.MerchantRiskScoreControllerRequest.ReleaseHoldRequest;
import org.springframework.http.ResponseEntity;

public interface WhatsAppDummyControllerService {
    public ResponseEntity<?> releaseHold(String releaseHoldRequest);

    public ResponseEntity<?> refundClient( String releaseHoldRequest);

    public ResponseEntity<?> kubernetes( ReleaseHoldRequest releaseHoldRequest);

    public ResponseEntity<?> intimateMerchant( String jsonString);

    public ResponseEntity<?> intimateMerchantViaWhatsapp();

    public ResponseEntity<?> intimateMerchantChargeBack( String parameters);

}
