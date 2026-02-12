package com.DronaPay.UIServer.service.ControllerService.CaseManagement;

import com.DronaPay.UIServer.requests.DateRange;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;


public interface CaseReportsService {

    public ResponseEntity<?> getDataForCaseStatusSummary(DateRange dateRange, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getDataForCaseTypeWiseSummary(DateRange dateRange, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getWorkFlowName(Authentication pr);
}
