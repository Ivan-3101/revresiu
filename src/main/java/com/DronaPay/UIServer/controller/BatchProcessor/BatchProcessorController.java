package com.DronaPay.UIServer.controller.BatchProcessor;

import com.DronaPay.UIServer.requests.CreateBatchJob;
import com.DronaPay.UIServer.service.ControllerService.BatchProcessor.BatchProcessorService;
import com.fasterxml.jackson.databind.JsonNode;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/testing/batch")
public class BatchProcessorController {

    @Autowired
    private BatchProcessorService batchProcessorService;

    @GetMapping("/job/types")
    public ResponseEntity<?> getBatchJobType(Authentication pr) {
        return batchProcessorService.getBatchTypes(pr);
    }

    @GetMapping("/jobs/{tenantid}/{jobtype}")
    public ResponseEntity<?> getBatchJobs(@PathVariable("tenantid") Integer tenantid,
                                          @PathVariable("jobtype") List<Integer> jobtype,
                                          @RequestParam(required = false, defaultValue = "0") int page,
                                          @RequestParam(required = false, defaultValue = "50") int size, Authentication pr) {
        return batchProcessorService.getAllJobs(tenantid, page, size, jobtype, pr);
    }

    @PostMapping("/job/create")
    public ResponseEntity<?> createBatchJob(@Valid @RequestBody CreateBatchJob createBatchJob, Authentication pr) {
        return batchProcessorService.createJob(createBatchJob, pr);
    }

    @PostMapping("/job/list")
    public ResponseEntity<?> createList(@RequestBody JsonNode createBatchJob) {
        return batchProcessorService.createList(createBatchJob);
    }

    @GetMapping("/job/errorlogdownload/{jobid}")
    public ResponseEntity<?> getErrorLogs(@PathVariable Integer jobid, HttpServletRequest request)
    {
        return batchProcessorService.getErrorLogs(jobid,request);
    }



    @PostMapping("/job/customer")
    public ResponseEntity<?> createCustomer(@RequestBody JsonNode createBatchJob) {
        return batchProcessorService.createCustomer(createBatchJob);
    }

}
