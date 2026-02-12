package com.DronaPay.UIServer.controller.CaseManagementController;


import com.DronaPay.UIServer.requests.ChangeStatusDropDownRequest;
import com.DronaPay.UIServer.requests.GetWorkflowState;
import com.DronaPay.UIServer.requests.LoadMoreTaskListRequestGt;
import com.DronaPay.UIServer.requests.ProcessBulkReassignRequest;
import com.DronaPay.UIServer.requests.ProcessBulkReassignRequestOpen;
import com.DronaPay.UIServer.requests.SubmitTaskOpen;
import com.DronaPay.UIServer.service.ControllerService.ProcessBulkTicketsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/case-management/process-bulk-tickets")
public class ProcessBulkTickets {

    @Autowired
    private ProcessBulkTicketsService processBulkTicketsService;

    @GetMapping("/")
    public ResponseEntity<?> getCaseTypeDropDown(Authentication pr) {
        return processBulkTicketsService.getCaseTypeDropDown(pr);
    }

    @PostMapping("/get-task")
    public ResponseEntity<?> getTaskList(@RequestBody LoadMoreTaskListRequestGt loadMoreTaskListRequest, Authentication pr) {
        return processBulkTicketsService.getTaskList(loadMoreTaskListRequest, pr);
    }

    @PostMapping("/get-task-count")
    public ResponseEntity<?> getTaskListCount(@RequestBody String count, Authentication pr) {
        return processBulkTicketsService.getTaskListCount(count, pr);
    }

    @PostMapping("/claim-task")
    public ResponseEntity<?> claimTask(@RequestBody String body, Authentication pr) {
        return processBulkTicketsService.claimTask(body, pr);
    }

    @PostMapping("/submit-bulk")
    public ResponseEntity<?> submitForm(@RequestBody String body, Authentication pr) {
        return processBulkTicketsService.submitForm(body, pr);
    }

    @GetMapping("/get-workflow-names")
    public ResponseEntity<?> getWorkFlowNames(Authentication pr) {
        return processBulkTicketsService.getCaseTypeDropDown(pr);
    }


    @GetMapping("/get-vpa-dropdown/{type}")
    public ResponseEntity<?> getVpaDropdown(@PathVariable(name = "type") String type, Authentication pr) {
        return processBulkTicketsService.getVpaDropdown(type, pr);
    }

    @PostMapping("/get-workflow-state")
    public ResponseEntity<?> getWorkFlowState(@RequestBody GetWorkflowState req, Authentication pr) {
        return processBulkTicketsService.getStatusDropDown(req, pr);
    }

    @PostMapping("/get-change-status")
    public ResponseEntity<?> getChangeStatus(@RequestBody ChangeStatusDropDownRequest changeStatusDropDownRequest,
                                             Authentication pr) {
        return processBulkTicketsService.getChangeStatusDropDown(changeStatusDropDownRequest, pr);
    }

    @PostMapping("/get-doc-rej")
    public ResponseEntity<?> getDocRejReason(@RequestBody ChangeStatusDropDownRequest changeStatusDropDownRequest,
                                             Authentication pr) {
        return processBulkTicketsService.getDocumentRejectionReason(changeStatusDropDownRequest, pr);
    }

    @PostMapping("/get-doc-list")
    public ResponseEntity<?> getDocListToSubmit(@RequestBody ChangeStatusDropDownRequest changeStatusDropDownRequest,
                                                Authentication pr) {
        return processBulkTicketsService.getDocumentListToBeSubmited(changeStatusDropDownRequest, pr);
    }

    @GetMapping("/get-rules")
    public ResponseEntity<?> getRuleDropDown(Authentication pr) {
        return processBulkTicketsService.getRuleDropDowns(pr);
    }

    @GetMapping("/get-users/tenant-id/{tenantid}")
    public ResponseEntity<?> getUserDropDown(@PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return processBulkTicketsService.getListOfUsers(tenantid, pr);
    }

    @PostMapping("/reassign-task")
    public ResponseEntity<?> reassignTickets(@RequestBody ProcessBulkReassignRequest processBulkReassignRequest,
                                             Authentication pr) {
        return processBulkTicketsService.reassignTask(processBulkReassignRequest, pr);
    }

     @PostMapping("/reassign-task/external")
    public ResponseEntity<?> reassignTicketsOpen(
            @RequestBody ProcessBulkReassignRequestOpen processBulkReassignRequest) {
        return processBulkTicketsService.reassignTaskOpen(processBulkReassignRequest);
    }

    @PostMapping("/submit-bulk/external")
    public ResponseEntity<?> submitFormOpen(@RequestBody SubmitTaskOpen submitTaskOpen) {
        return processBulkTicketsService.submitFormOpen(submitTaskOpen);
    }

    @GetMapping("/get-decision-and-rules/tenant-id/{tenantid}")
     public ResponseEntity<?>
     getDecisionAndRules(Authentication pr,
                         @PathVariable("tenantid") Integer tenantid) {
       return processBulkTicketsService.getDecisionAndRules(pr, tenantid);
    }

}
