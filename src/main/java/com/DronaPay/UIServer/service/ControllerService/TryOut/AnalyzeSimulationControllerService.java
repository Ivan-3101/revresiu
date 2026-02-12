package com.DronaPay.UIServer.service.ControllerService.TryOut;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;


public interface AnalyzeSimulationControllerService {

    public ResponseEntity<?> getSimulationAndRunDropDown(Authentication pr, Integer tenantid);

}
