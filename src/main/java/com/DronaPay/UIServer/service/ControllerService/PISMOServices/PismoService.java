package com.DronaPay.UIServer.service.ControllerService.PISMOServices;


import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

public interface PismoService {

    public ResponseEntity<?> contactNumber(Authentication pr, String account_id, String class_name, Integer itenantid) throws Exception;
}
