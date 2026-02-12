package com.DronaPay.UIServer.controller.CaseManagementController;

import com.DronaPay.UIServer.requests.*;
import com.DronaPay.UIServer.requests.CamundaRequests.AddCommentGt;
import com.DronaPay.UIServer.requests.CamundaRequests.PriorityQueueTaskRequest;
import com.DronaPay.UIServer.service.ControllerService.CaseManagement.TasksService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

import jakarta.ws.rs.Path;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/api/v1/case-management/tasks")
public class TasksController {

    @Autowired
    private TasksService tasksService;

    @GetMapping("/")
    public ResponseEntity<?> getListDropDown(Authentication pr) {
        return tasksService.getListDropDown(pr);
    }

    @GetMapping("/workflows/manual-creation/tenant-id/{tenantid}")
    public ResponseEntity<?> getManualCreationList(@PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return tasksService.getManualWorkflows(tenantid, pr);
    }

    @GetMapping("/workflows/batch-decisions")
    public ResponseEntity<?> getBatchDecisions(Authentication pr) {
        return tasksService.getBatchDecisions(pr);
    }

    @GetMapping("/workflows/manual-creation/get-batch-trans/{address}/{level}/{frequency}/{date}/{workflowid}/{tenantid}")
    public ResponseEntity<?> getBatchTrans(@PathVariable("address") String address,
                                           @PathVariable("level") String level, @PathVariable("frequency") String frequency,
                                           @PathVariable("date") String date, 
                                           @PathVariable("workflowid") Integer workflowid, 
                                           @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return tasksService.getBatchTrans(address, level, frequency, date, workflowid, tenantid, pr);
    }

    @GetMapping("/workflows/manual-creation/get-realtime-trans/{address}/{level}/{transid}/{workflowid}/{tenantid}")
    public ResponseEntity<?> getRealTimeTrans(@PathVariable("address") String address,
                                              @PathVariable("level") String level, @PathVariable("transid") String transid, @PathVariable("workflowid") Integer workflowId, @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return tasksService.getRealTimeTrans(address, level, transid, workflowId, tenantid, pr);
    }

    @GetMapping("/workflows/manual-creation/get-realtime-trans/{address}/{level}/{transid}/{workflowid}/{tenantid}/{startdate}/{enddate}")
    public ResponseEntity<?> getRealTimeTrans(@PathVariable("address") String address,
                                              @PathVariable("level") String level, @PathVariable("transid") String transid, @PathVariable("workflowid") Integer workflowId,
                                              @PathVariable("tenantid") Integer tenantid,
                                              @PathVariable("startdate") String startdate,
                                              @PathVariable("enddate") String enddate,
                                              Authentication pr) {
        return tasksService.getRealTimeTrans(address, level, transid, workflowId, startdate, enddate, tenantid, pr);
    }


    @GetMapping("workflows/manual-creation/get-rules-decision/{workflowid}/{tenantid}")
    public ResponseEntity<?> getRulesData(@PathVariable("workflowid") Integer workflowid, @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return tasksService.getRulesDecision(workflowid, tenantid, pr);
    }

    @GetMapping("workflows/manual-creation/profile-dates/{address}/{level}/{frequency}/{workflowid}/{tenantid}")
    public ResponseEntity<?> getProfileDates(@PathVariable("address") String address, @PathVariable("level") String level, @PathVariable("frequency")
     String frequency, @PathVariable("workflowid") Integer workflowid, @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return tasksService.getProfileDates(address, level, frequency, workflowid, tenantid, pr);
    }

    @GetMapping("workflows/manual-creation/params/{workflowid}/{tenantid}")
    public ResponseEntity<?> getWorkflowParams(@PathVariable("workflowid") Integer workflowid, @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return tasksService.getWorkflowParams(workflowid, tenantid, pr);
    }

    @PostMapping("workflows/manual-creation/create/{workflowid}/{tenantid}")
    public ResponseEntity<?> createManualTicket(@PathVariable("workflowid") Integer workflowid,
                                                @PathVariable("tenantid") Integer tenantid,
                                                @RequestBody String request, Authentication pr) {
        return tasksService.createManualTicket(workflowid, tenantid, request, pr);
    }

    @PostMapping("/get-task")
    public ResponseEntity<?> getTaskList(@RequestBody GetTaskListRequestGt getTaskListRequest, Authentication pr) {
        return tasksService.getTaskList(getTaskListRequest, pr);
    }

    @PostMapping("/get-task-lhs")
    public ResponseEntity<?> getTaskListLhs(@RequestBody GetTaskListRequestGt req, Authentication pr) {
        return tasksService.getTaskListLHS(req, pr);
    }

    @PostMapping("/load-more-task")
    public ResponseEntity<?> loadMoreTaskList(@RequestBody LoadMoreTaskListRequestGt loadMoreTaskListRequest,
                                              Authentication pr) {
        return tasksService.loadMoreTaskList(loadMoreTaskListRequest, pr);
    }

    @GetMapping("/claim-task/{taskid}/{processinstanceid}")
    public ResponseEntity<?> claimTask(@PathVariable("taskid") String taskid,
                                       @PathVariable("processinstanceid") String processInstanceId, Authentication pr) {
        return tasksService.claimTask(taskid, processInstanceId, pr);
    }

    @PostMapping("/claim-task-bulk")
    public ResponseEntity<?> claimBulkTask(@RequestBody List<ClaimBulkRequest> taskidlist, Authentication pr) {
        return tasksService.claimBulkTask(taskidlist, pr);
    }

    @GetMapping("/unclaim-task/{taskid}/{processinstanceid}")
    public ResponseEntity<?> unClaimTask(@PathVariable("taskid") String taskid,
                                         @PathVariable("processinstanceid") String processInstanceId, Authentication pr) {
        return tasksService.unClaimTask(taskid, processInstanceId, pr);
    }

    @PostMapping("/reasssign-task")
    public ResponseEntity<?> reassignTask(@RequestBody ReassignTask reassignTask, Authentication pr) {
        return tasksService.reassignTask(reassignTask, pr);
    }

    @GetMapping("/get-comment/{processinstanceid}")
    public ResponseEntity<?> getComments(@PathVariable("processinstanceid") String processinstanceid, Authentication pr) {
        return tasksService.getComments(processinstanceid, pr);
    }

    @GetMapping("/get-case-history/{processinstanceid}/{processdefid}/{tenantid}")
    public ResponseEntity<?> getCaseHistory(@PathVariable("processinstanceid") String processinstanceid,
                                            @PathVariable("processdefid") String processDefId,
                                            @PathVariable("tenantid") Integer tenantid,Authentication pr) {
        return tasksService.getCaseHistory(processinstanceid, processDefId, tenantid, pr);
    }

    @GetMapping("/get-form-variable/{taskid}")
    public ResponseEntity<?> getFormVariable(@PathVariable("taskid") String taskid, Authentication pr) {
        return tasksService.getFormVariable(taskid, pr);
    }

    @GetMapping("/get-rendered-form/{taskid}/{closed}")
    public ResponseEntity<?> getRenderedForm(@PathVariable("taskid") String taskid,
                                             @PathVariable("closed") Boolean closed, Authentication pr) {
        return tasksService.getRenderedForm(taskid, closed, pr);
    }

    @PostMapping("/submit-form/{taskid}/{processinstanceid}")
    public ResponseEntity<?> submitForm(@PathVariable("taskid") String taskid,
                                        @PathVariable("processinstanceid") String processinstanceid, @RequestBody String body, Authentication pr) {
        return tasksService.submitForm(taskid, processinstanceid, body, pr);
    }

    @PostMapping("/add-comment")
    public ResponseEntity<?> addComment(@RequestBody AddCommentGt addComment, Authentication pr) {
        return tasksService.addComment(addComment, pr);
    }

    @PostMapping("/add-attachment")
    public ResponseEntity<?> addA(
            @RequestParam(value = "file", required = true) MultipartFile file,
            @RequestParam(value = "id", required = true) String id,
            @RequestParam(value = "attachment-name", required = false) String attachmentName,
            @RequestParam(value = "attachment-description", required = false) String attachmentDescription,
            @RequestParam(value = "attachment-type", required = false) String attachmentType,
            @RequestParam(value = "url", required = false) String url,
            Authentication pr) {
        return tasksService.addA(file, id, attachmentName, attachmentDescription, attachmentType, url, pr);
    }

    @GetMapping("/get-attachment-list/{processinstanceid}")
    public ResponseEntity<?> getAttachment(@PathVariable("processinstanceid") String processinstanceid, Authentication pr) {
        return tasksService.getAttachment(processinstanceid, pr);
    }

    @GetMapping("/get-user-operation/{taskid}")
    public ResponseEntity<?> getUserOperation(@PathVariable("taskid") String taskid, Authentication pr) {
        return tasksService.getUserOperation(taskid, pr);
    }

    @GetMapping("/download-attachment/{taskid}/{attachmentid}")
    public ResponseEntity<?> downloadAttachment(@PathVariable("taskid") String taskid,
                                                @PathVariable("attachmentid") String attachmentid, Authentication pr) {
        return tasksService.downloadAttachment(taskid, attachmentid, pr);
    }

    @GetMapping("/get-activity-instance/{parameters}")
    public ResponseEntity<?> getActivityInstance(@PathVariable("parameters") String parameters, Authentication pr) {
        return tasksService.getActivityInstance(parameters, pr);
    }

    @GetMapping("/get-variable-data/{taskid}/{variabledata}")
    public ResponseEntity<?> getVariableName(@PathVariable("taskid") String taskid,
                                             @PathVariable("variabledata") String variabledata, Authentication pr) {
        return tasksService.getVariableName(taskid, variabledata, pr);
    }

    @GetMapping("/get-task-history/{taskid}")
    public ResponseEntity<?> getTaskHistory(@PathVariable("taskid") String taskid,
                                            Authentication pr) {
        return tasksService.getTaskHistory(taskid, pr);
    }

    @GetMapping("/get-workflow-names")
    public ResponseEntity<?> getWorkFlowNames(Authentication pr) {
        return tasksService.getWorkFlowName(pr);
    }

    @PostMapping("/get-payee-vpa")
    public ResponseEntity<?> getPayeeNames(@RequestBody String path, Authentication pr) {
        return tasksService.getPayeeNames(path, pr);
    }

    @PostMapping("/get-payer-vpa")
    public ResponseEntity<?> getPayerNames(@RequestBody String path, Authentication pr) {
        return tasksService.getPayerNames(path, pr);
    }

    @PostMapping("/get-status/tenant-id/{tenantid}/workflow-key/{workflowkey}")
    public ResponseEntity<?> getStatusDropDown(@RequestBody GetTaskListRequestGt getTaskListRequest,
    @PathVariable("tenantid") Integer tenantid, @PathVariable("workflowkey") String workflowkey, Authentication pr) {
        return tasksService.getStatusDropDown(getTaskListRequest, tenantid, workflowkey, pr);
    }

    @GetMapping("/get-related-tickets/{payervpa}/{payeevpa}/{day}/{max}")
    public ResponseEntity<?> getRelatedTickets(@PathVariable("payervpa") String payervpa,
                                               @PathVariable("payeevpa") String type, @PathVariable("day") String days, @PathVariable("max") String max,
                                               Authentication pr) {
        return tasksService.getRelatedTickets(payervpa, type, days, max, pr);
    }

    @PostMapping("/get-related-tickets-account-vpa")
    public ResponseEntity<?> getRelatedTicketsAccountVPA(@RequestBody RelatedCasesAcVpa request, Authentication pr) {
        return tasksService.getRelatedTicketsAccountVPA(request, pr);
    }

    @PostMapping("/get-related-tickets-address-based")
    public ResponseEntity<?> getRelatedTicketsAddressBased(@RequestBody RelatedCasesAdd request, Authentication pr) {
        return tasksService.getRelatedTicketsAddressBased(request, pr);
    }

    @GetMapping("/get-related-tickets-address-based/{address}/{type}/{day}/{max}")
    public ResponseEntity<?> getRelatedTicketsBasedOnAddress(@PathVariable("address") String address,
                                                             @PathVariable("type") String type,
                                                             @PathVariable("day") String days, @PathVariable("max") String max,
                                                             Authentication pr) {
        return tasksService.getRelatedTicketsBasedOnAddress(address, type, days, max, pr);
    }

    @GetMapping("/get-contact-details/{payer}/{payee}")
    public ResponseEntity<?> getContactDetails(@PathVariable("payer") String payer, @PathVariable("payee") String payee,
                                               Authentication pr) {
        return tasksService.getContactDetails(payer, payee, pr);
    }

    @GetMapping("/get-rules-dropdown/{menuName}/tenant-id/{tenantid}")
    public ResponseEntity<?> getRulesDropDown(@PathVariable("menuName") String menuName, @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return tasksService.getRuleDropDowns(menuName, tenantid, pr);
    }

    @GetMapping("/get-users-task/{taskid}/tenant-id/{tenantid}")
    public ResponseEntity<?> getUsersTask(@PathVariable("taskid") String taskid, 
    @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return tasksService.getUsersTask(taskid, tenantid, pr);
    }

    @GetMapping("/get-users-dropdown")
    public ResponseEntity<?> getUsersDropDown(Authentication pr) {
        return tasksService.getListOfUsers(pr);
    }

    @GetMapping("/get-db-users-dropdown")
    public ResponseEntity<?> getDbUsersDropDown(Authentication pr) {
        return tasksService.getListOfDbUSers(pr);
    }

    @GetMapping("/get-branch-users-dropdown")
    public ResponseEntity<?> getbranchUsersDropDown(Authentication pr) {
        return tasksService.getListOfBranchUsers(pr);
    }

    @PostMapping("/get-accountwise")
    public ResponseEntity<?> getAccountWiseTask(@RequestBody PriorityQueueTaskRequest priorityQueueTaskRequest,
                                                Authentication pr) {
        return tasksService.getAccountWiseTask(priorityQueueTaskRequest, pr);
    }

    @GetMapping("/get-related-tickets-account/{payervpa}/{payeevpa}/{days}/{max}")
    public ResponseEntity<?> getRelatedTicketsAccount(@PathVariable("payervpa") String payervpa,
                                                      @PathVariable("payeevpa") String type, @PathVariable("days") String days, @PathVariable("max") String max,
                                                      Authentication pr) {
        return tasksService.getRelatedTicketsAccountLevel(payervpa, type, days, max, pr);
    }

    @GetMapping("/get-field-list")
    public ResponseEntity<?> getParameterType() {
        return tasksService.getParameterType();
    }

    @GetMapping("/get-deployed-form/{taskid}")
    public ResponseEntity<?> getDeployedForm(@PathVariable("taskid") String taskid, Authentication pr) {
        return tasksService.getDeployedForm(taskid, pr);
    }

    @PostMapping("/get-account-tasklist")
    public ResponseEntity<?> getTaskListOnAddress(@RequestBody String parameter, Authentication pr) {
        return tasksService.getAccountWise(parameter, pr);
    }

    @GetMapping("/get-panel-templates/{workflowname}/tenant-id/{tenantid}")
    public ResponseEntity<?> getPanelTemplates(@PathVariable("workflowname") String workflowName, 
    @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return tasksService.getTaskPanelTemplate(workflowName, tenantid, pr);
    }

    @PostMapping("/get-summary/tenant-id/{tenantid}")
    public ResponseEntity<?> getSummary(@RequestBody SectionRequestBody summaryRequestBody, @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return tasksService.getSummary(summaryRequestBody, tenantid, pr);
    }

    @GetMapping("/get-aml-status-dropdown/tenant-id/{tenantid}/workflow-key/{workflowkey}")
    public ResponseEntity<?> getAmlStatusDropDown(@PathVariable("tenantid") Integer tenantid, @PathVariable("workflowkey") String workflowKey, Authentication pr) {
        return tasksService.getAMLStatusDropDowns(tenantid, workflowKey, pr);
    }

    @PostMapping("/add-str-form-value")
    public ResponseEntity<?> addFormValue(@Valid @RequestBody AddFormValue addFormValue, Authentication pr) {
        return tasksService.addSTRForm(addFormValue, pr);
    }

    @GetMapping("/get-str-form-value/{formvalueid}/tenant-id/{tenantid}")
    public ResponseEntity<?> getFormValue(@PathVariable(name = "formvalueid", required = true) Integer form_value_id,
                                          @PathVariable(name = "tenantid") Integer tenantid,
                                          Authentication pr) {
        return tasksService.getSTRFormValue(form_value_id, tenantid, pr);
    }

    @GetMapping("/get-str-form/{formname}/tenant-id/{tenantid}")
    public ResponseEntity<?> getForm(@PathVariable(name = "formname", required = true) String formname, @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return tasksService.getSTRForm(formname, tenantid, pr);
    }

    @PutMapping("/edit-str-form-value/{formvalueid}")
    public ResponseEntity<?> addFormValue(@PathVariable(name = "formvalueid", required = true) Integer form_value_id,
                                          @Valid @RequestBody AddFormValue addFormValue, Authentication pr) {
        return tasksService.editSTRForm(form_value_id, addFormValue, pr);
    }

    @GetMapping("/get-users-qc/{vcgroupid}/tenant-id/{tenantid}")
    public ResponseEntity<?> getUsersQc(Authentication pr, @PathVariable("vcgroupid") String vcgroupid, @PathVariable("tenantid") Integer tenantid) {
        return tasksService.getUsersQc(pr, vcgroupid, tenantid);
    }

    @GetMapping("/sanctions/search/{proc_inst_id}")
    public ResponseEntity<?> santcionSearch(@PathVariable String proc_inst_id,
                                            Authentication pr) throws Exception {
        return tasksService.sanctionSearch(proc_inst_id, pr);
    }

    @GetMapping("/sanctions/fetch/{search_id}/source/{source_name}")
    public ResponseEntity<?> santcionFetch(@PathVariable String search_id,
                                           @PathVariable String source_name, Authentication pr) throws Exception {
        return tasksService.sanctionFetch(search_id, source_name, pr);
    }

    @GetMapping("/download/attachment/{transactionId}/{fileName}/tenant-id/{tenantid}")
    public ResponseEntity<?> downloadAttachmentFromFileStorage(@PathVariable String transactionId,
                                                               @PathVariable String fileName, Authentication pr, 
                                                               @PathVariable("tenantid") Integer tenantid,
                                                               HttpServletRequest httpRequest) throws Exception {
        return tasksService.downloadAttachmentFromFileStorage(transactionId, fileName, pr, httpRequest, tenantid);
    }

    @PostMapping("/get-profile-parameters")
    public ResponseEntity<?> getProfileParameters(@RequestBody ProfileParameters request, Authentication pr) throws Exception {
        return tasksService.getProfileParameters(request, pr);
    }

}
