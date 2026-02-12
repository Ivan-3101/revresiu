package com.DronaPay.UIServer.service.ControllerService.Tenant;

import org.springframework.http.ResponseEntity;

public interface TenantControllerService {

    public ResponseEntity<?> getByTenantId(String class_name) throws Exception;
    
}
