package com.DronaPay.UIServer.service.ControllerService.BatchProcessor;

import com.DronaPay.UIServer.requests.CreateBatchJob;
import com.fasterxml.jackson.databind.JsonNode;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

import java.util.List;

public interface BatchProcessorService {

    ResponseEntity<?> getBatchTypes(Authentication pr);

    ResponseEntity<?> getAllJobs(Integer itenantId, int page, int size, List<Integer> jobtype, Authentication pr);

    ResponseEntity<?> createJob(CreateBatchJob createBatchJob, Authentication pr);

    ResponseEntity<?> createList(JsonNode createBatchJob);

    ResponseEntity<?> getErrorLogs(Integer jobid, HttpServletRequest request);
    ResponseEntity<?> createCustomer(JsonNode createBatchJob);


}
