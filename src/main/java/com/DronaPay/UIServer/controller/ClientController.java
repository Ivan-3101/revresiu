package com.DronaPay.UIServer.controller;

import com.DronaPay.UIServer.requests.ClientUserLoginRequest;
import com.DronaPay.UIServer.requests.NewClientUserRequest;
import com.DronaPay.UIServer.service.ControllerService.ClientControllerService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

@RestController
@RequestMapping("/api/v1/client")
public class ClientController {

    private final ClientControllerService clientControllerService;

    public ClientController(ClientControllerService clientControllerService) {
        this.clientControllerService = clientControllerService;
    }

    @PostMapping("/token")
    public ResponseEntity<?> login(@RequestBody ClientUserLoginRequest authenticationRequest,
                                   HttpServletRequest request)
            throws InvalidKeySpecException, NoSuchAlgorithmException {
        return clientControllerService.login(authenticationRequest, request);
    }

    @PostMapping("/new-client")
    public ResponseEntity<?> newClient(
            @RequestBody NewClientUserRequest clientName
    ) {
        return clientControllerService.newClient(clientName.getClientname());
    }


}
