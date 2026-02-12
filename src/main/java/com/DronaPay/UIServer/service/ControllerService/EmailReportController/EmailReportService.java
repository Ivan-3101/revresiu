package com.DronaPay.UIServer.service.ControllerService.EmailReportController;


import com.DronaPay.UIServer.ResponseVO.ScheduledReportsVO;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.requests.EmailReportAdd;
import com.DronaPay.UIServer.requests.EmailReportEdit;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

import java.util.List;

public interface EmailReportService {
    public ResponseEntity<?> sendReport(Integer reportId, Integer tenantid);

    public ResponseEntity<?> getAvailableReports(Authentication pr, Integer tenantid);

    public ResponseEntity<?> addEmailReport(EmailReportAdd request, Authentication pr);

    public ResponseEntity<?> editEmailReport(EmailReportEdit request, Authentication pr);

    public ResponseEntity<?> getScheduledReportServiceUI(Authentication pr);

    public ResponseEntity<?> deleteEmailReport(Integer reportId, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getScheduledReportServiceCron(Integer tenantid);

    public ResponseEntity<?> getFiltersAvailableReports(Integer dashboardId, Integer tenantid, Authentication pr);
}
