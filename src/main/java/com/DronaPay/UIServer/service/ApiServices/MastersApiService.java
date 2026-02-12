package com.DronaPay.UIServer.service.ApiServices;

import org.springframework.http.ResponseEntity;
import org.springframework.web.reactive.function.client.ClientResponse;

public interface MastersApiService {

    public ResponseEntity<String> addSimpleCustomer(String body, Integer itenantid);

}
