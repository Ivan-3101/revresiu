package com.DronaPay.UIServer.service.ControllerService;

import com.DronaPay.UIServer.requests.ClientUserLoginRequest;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

public interface ClientControllerService {


    public ResponseEntity<?> login(ClientUserLoginRequest authenticationRequest,
                                   HttpServletRequest request)
            throws InvalidKeySpecException, NoSuchAlgorithmException;

    public ResponseEntity<?> newClient(String clientName);

}
