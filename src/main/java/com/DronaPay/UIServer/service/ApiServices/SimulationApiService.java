package com.DronaPay.UIServer.service.ApiServices;

import com.DronaPay.UIServer.requests.AddRunRequest;
import com.DronaPay.UIServer.requests.AddSimulationApiRequest;
import com.fasterxml.jackson.databind.JsonNode;
import com.DronaPay.UIServer.requests.TestRule;
import org.springframework.http.ResponseEntity;

import java.net.http.HttpResponse;

public interface SimulationApiService {

    public ResponseEntity<String> addSimulation(AddSimulationApiRequest addSimulationRequest, String simid) throws Exception;

    public ResponseEntity<String> addRun(AddRunRequest addRunRequest, String simid) throws Exception;

    public ResponseEntity<String> testRule(TestRule addRunRequest) throws Exception;

    public ResponseEntity<String> validateSimulation(AddRunRequest requestBody, String simid) throws Exception;
}
