package com.DronaPay.UIServer.service.ControllerService.TryOut;

import com.DronaPay.UIServer.requests.AddRunRequest;
import com.DronaPay.UIServer.requests.AddSimulationRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;


public interface RunSimulationControllerService {

    public ResponseEntity<?> getSimulationDropDown(Authentication pr, Integer tenantid);


    public ResponseEntity<?> addSimulation(String simid, AddSimulationRequest addSimulationRequest, Authentication pr);

    public ResponseEntity<?> addRun(String simid, AddRunRequest addRunRequest, Authentication pr);

    public ResponseEntity<?> validateSimulation(AddRunRequest addRunRequest, String simid, Authentication pr);

}
