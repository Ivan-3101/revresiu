package com.DronaPay.UIServer.controller.TryOut;


import com.DronaPay.UIServer.requests.AddRunRequest;
import com.DronaPay.UIServer.requests.AddSimulationRequest;
import com.DronaPay.UIServer.service.ControllerService.TryOut.RunSimulationControllerService;
import jakarta.validation.Valid;
import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/v1/try-out/run-simulation")
public class RunSimulationController {

    @Autowired
    private RunSimulationControllerService simulatorControllerService;

    @GetMapping("/get-simulation-decision-and-rule-dropdown/tenant-id/{tenantid}")
    public ResponseEntity<?> getSimulationDropDown(Authentication pr, @PathVariable("tenantid") Integer tenantid) {
        return simulatorControllerService.getSimulationDropDown(pr, tenantid);
    }

    @PostMapping("/add-simulation/{simid}")
    public ResponseEntity<?> addSimulation(@PathVariable("simid") String simid, @Valid @RequestBody AddSimulationRequest addSimulationRequest, Authentication pr) {
        return simulatorControllerService.addSimulation(simid, addSimulationRequest, pr);
    }

    @PostMapping("/add-run/{simid}")
    public ResponseEntity<?> addRun(@PathVariable("simid") String simid, @RequestBody AddRunRequest addRunRequest, Authentication pr) {
        return simulatorControllerService.addRun(simid, addRunRequest, pr);
    }

    @PostMapping("/validate-simulation/{simid}")
    public ResponseEntity<?> validateSimulation(@PathVariable("simid") String simid,@RequestBody AddRunRequest requestBody, Authentication pr) {
        return simulatorControllerService.validateSimulation(requestBody,simid, pr);
    }

}
