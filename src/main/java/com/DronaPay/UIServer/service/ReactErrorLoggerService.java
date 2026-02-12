package com.DronaPay.UIServer.service;


import com.DronaPay.UIServer.requests.ErrorLogRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

public interface ReactErrorLoggerService {

    public ResponseEntity<?> logErrors(ErrorLogRequest errorLogRequest, Authentication user);

}
