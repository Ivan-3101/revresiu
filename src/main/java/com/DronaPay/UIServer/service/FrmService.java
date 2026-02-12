package com.DronaPay.UIServer.service;

import org.springframework.http.ResponseEntity;
import org.springframework.web.reactive.function.client.ClientResponse;

public interface FrmService {

    public ResponseEntity<String> getPaymentAddresses(String paramters) throws Exception;
}
