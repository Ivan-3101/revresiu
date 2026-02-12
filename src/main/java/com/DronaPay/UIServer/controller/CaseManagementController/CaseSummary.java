package com.DronaPay.UIServer.controller.CaseManagementController;


import com.DronaPay.UIServer.requests.LoadMoreTaskListRequestGt;
import com.DronaPay.UIServer.service.ControllerService.CaseManagement.CaseSummaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/v1/case-management/case-summary")
public class    CaseSummary {

    @Autowired
    private CaseSummaryService caseSummaryService;

    @PostMapping("/get-task")
    public ResponseEntity<?> getTaskList(@RequestBody LoadMoreTaskListRequestGt loadMoreTaskListRequest, Authentication pr) {
        return caseSummaryService.getTaskList(loadMoreTaskListRequest, pr);
    }

    @PostMapping("/get-task-count")
    public ResponseEntity<?> getTaskListCount(@RequestBody String count, Authentication pr) {
        return caseSummaryService.getTaskListCount(count, pr);
    }

    @GetMapping("/get-workflow-names")
    public ResponseEntity<?> getWorkFlowNames(Authentication pr) {
        return caseSummaryService.getWorkFlowName(pr);
    }

    @PostMapping("/download-case-summary")
    public ResponseEntity<?> downloadCaseSummary(@RequestBody String parameter, Authentication pr) {
        return caseSummaryService.exportSummary(parameter, pr);
    }
}
