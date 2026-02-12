package com.DronaPay.UIServer.controller.EmailReportController;

import com.DronaPay.UIServer.requests.EmailReportAdd;
import com.DronaPay.UIServer.requests.EmailReportEdit;
import com.DronaPay.UIServer.service.ControllerService.EmailReportController.EmailReportService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/v1/reports/")
public class EmailReportController {

    @Autowired
    private EmailReportService emailReportService;

    @PostMapping("/generate-and-send-report/{reportid}/tenant-id/{tenantid}")
    public ResponseEntity<?> sendReport(@PathVariable("reportid") Integer reportId, @PathVariable("tenantid") Integer tenantid) {
        return emailReportService.sendReport(reportId, tenantid);
    }

    @GetMapping("/get-available-reports/tenant-id/{tenantid}")
    public ResponseEntity<?> getAvailableReports(Authentication pr, @PathVariable("tenantid") Integer tenantid) {
        return emailReportService.getAvailableReports(pr, tenantid);
    }

    @GetMapping("/get-filters-available-reports/{dashboardid}/tenant-id/{tenantid}")
    public ResponseEntity<?> getFiltersAvailableReports(@PathVariable("dashboardid") Integer dashboardid, 
    @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        System.out.println("entered filters");
        return emailReportService.getFiltersAvailableReports(dashboardid, tenantid, pr);
    }

    @PostMapping("/add-report")
    public ResponseEntity<?> addEmailReport(@RequestBody @Valid EmailReportAdd request, Authentication pr) {
        return emailReportService.addEmailReport(request, pr);
    }

    @PutMapping("/edit-report")
    public ResponseEntity<?> editEmailReport(@RequestBody @Valid EmailReportEdit request, Authentication pr) {
        return emailReportService.editEmailReport(request, pr);
    }

    @DeleteMapping("/delete-report/{reportid}/tenant-id/{tenantid}")
    public ResponseEntity<?> deleteEmailReport(@PathVariable("reportid") Integer reportId,  @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return emailReportService.deleteEmailReport(reportId, tenantid, pr);
    }

    @GetMapping("/get-scheduled-reports")
    public ResponseEntity<?> getScheduledReportsUI(Authentication pr) {
        return emailReportService.getScheduledReportServiceUI(pr);
    }

    @GetMapping("/get-active-scheduled-reports/tenant-id/{tenantid}")
    public ResponseEntity<?> getScheduledReportsCron(@PathVariable("tenantid") Integer tenantid) {
        return emailReportService.getScheduledReportServiceCron(tenantid);
    }

}
