package com.DronaPay.UIServer.service;

import com.DronaPay.UIServer.requests.CodeBody;
import com.DronaPay.UIServer.requests.RefreshToken;
import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.reactive.function.client.ClientResponse;

public interface SSOService {

    public ResponseEntity<String> getToken(CodeBody body, JsonNode settings) throws Exception;

    public ResponseEntity<String> getRefresh(RefreshToken body, JsonNode settings) throws Exception;

}
