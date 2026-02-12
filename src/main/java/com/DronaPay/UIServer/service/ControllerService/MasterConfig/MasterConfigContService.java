package com.DronaPay.UIServer.service.ControllerService.MasterConfig;


import com.DronaPay.UIServer.requests.MasterConfigRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

public interface MasterConfigContService {
    public ResponseEntity<?> getMasterConfig(MasterConfigRequest req, String menuname, Authentication pr);
}
