package com.DronaPay.UIServer.controller.CaseManagementController;


import com.DronaPay.UIServer.requests.DateRange;
import com.DronaPay.UIServer.service.ControllerService.CaseManagement.CaseReportsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/v1/case-management/case-reports")
public class CaseReportsController {

    @Autowired
    private CaseReportsService caseReportsService;

    @PostMapping("/get-data-for-case-status-summary/tenant-id/{tenantid}")
    public ResponseEntity<?> getDataForCaseStatussummary(@RequestBody DateRange dateRange, @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return caseReportsService.getDataForCaseStatusSummary(dateRange, tenantid, pr);
    }

    @PostMapping("/get-data-for-case-type-wise-summary/tenant-id/{tenantid}")
    public ResponseEntity<?> getDataForCaseTypeWiseSummary(@RequestBody DateRange dateRange, @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return caseReportsService.getDataForCaseTypeWiseSummary(dateRange, tenantid, pr);
    }

    @GetMapping("/get-workflow-names")
    public ResponseEntity<?> getWorkFlowNames(Authentication pr) {
        return caseReportsService.getWorkFlowName(pr);
    }

}
