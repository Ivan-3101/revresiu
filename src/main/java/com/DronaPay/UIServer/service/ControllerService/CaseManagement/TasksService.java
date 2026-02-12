package com.DronaPay.UIServer.service.ControllerService.CaseManagement;

import com.DronaPay.UIServer.requests.*;
import com.DronaPay.UIServer.requests.CamundaRequests.AddCommentGt;
import com.DronaPay.UIServer.requests.CamundaRequests.PriorityQueueTaskRequest;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface TasksService {
    public ResponseEntity<?> getListDropDown(Authentication pr);

    public ResponseEntity<?> getTaskList(GetTaskListRequestGt getTaskListRequest, Authentication pr);

    public ResponseEntity<?> getTaskListLHS(GetTaskListRequestGt getTaskListRequest, Authentication pr);

    public ResponseEntity<?> loadMoreTaskList(LoadMoreTaskListRequestGt loadMoreTaskListRequest, Authentication pr);

    public ResponseEntity<?> claimTask(String taskid, String processInstanceId, Authentication pr);

    public ResponseEntity<?> claimBulkTask(List<ClaimBulkRequest> taskidlist, Authentication pr);

    public ResponseEntity<?> unClaimTask(String taskid, String processInstanceId, Authentication pr);

    public ResponseEntity<?> reassignTask(ReassignTask reassignTask, Authentication pr);

    public ResponseEntity<?> getComments(String processinstanceid, Authentication pr);

    public ResponseEntity<?> getCaseHistory(String processinstanceid, String processDefId, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getFormVariable(String taskid, Authentication pr);

    public ResponseEntity<?> getRenderedForm(String taskid, Boolean closed, Authentication pr);

    public ResponseEntity<?> submitForm(String taskid, String processInstanceId, String body, Authentication pr);

    public ResponseEntity<?> addComment(AddCommentGt addComment, Authentication pr);

    public ResponseEntity<?> addA(MultipartFile file, String id, String attachmentName,
                                  String attachmentDescription,
                                  String attachmentType, String url, Authentication pr);

    public ResponseEntity<?> getAttachment(String processinstanceid, Authentication pr);

    public ResponseEntity<?> getUserOperation(String taskid, Authentication pr);

    public ResponseEntity<?> downloadAttachment(String taskid, String attachmentid, Authentication pr);

    public ResponseEntity<?> getActivityInstance(String parameters, Authentication pr);

    public ResponseEntity<?> getVariableName(String taskid, String variabledata, Authentication pr);

    public ResponseEntity<?> getTaskHistory(String taskid, Authentication pr);

    public ResponseEntity<?> getUsersTask(String taskid, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getWorkFlowName(Authentication pr);

    public ResponseEntity<?> getPayeeNames(String path, Authentication pr);

    public ResponseEntity<?> getPayerNames(String path, Authentication pr);

    public ResponseEntity<?> getStatusDropDown(GetTaskListRequestGt getTaskListRequest, Integer tenantid, String workflowKey, Authentication pr);

    public ResponseEntity<?> getRelatedTickets(String payervpa, String type, String days, String max, Authentication pr);

    public ResponseEntity<?> getRelatedTicketsAccountVPA(RelatedCasesAcVpa request, Authentication pr);

    public ResponseEntity<?> getRelatedTicketsAddressBased(RelatedCasesAdd request, Authentication pr);

    public ResponseEntity<?> getRelatedTicketsBasedOnAddress(String address, String type, String days, String max,
                                                             Authentication pr);

    public ResponseEntity<?> getRelatedTicketsAccountLevel(String payeraccount, String payeeaccount, String days,
                                                           String max, Authentication pr);

    public ResponseEntity<?> getContactDetails(String payer, String payee, Authentication pr);

    public ResponseEntity<?> getRuleDropDowns(String menuName, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getListOfUsers(Authentication pr);

    public ResponseEntity<?> getAccountWiseTask(PriorityQueueTaskRequest priorityQueueTaskRequest, Authentication pr);

    public ResponseEntity<?> getParameterType();

    public ResponseEntity<?> getDeployedForm(String taskid, Authentication pr);

    public ResponseEntity<?> getListOfBranchUsers(Authentication pr);

    public ResponseEntity<?> getListOfDbUSers(Authentication pr);

    public ResponseEntity<?> getAccountWise(String parameters, Authentication pr);

    public ResponseEntity<?> getTaskPanelTemplate(String workFlowName, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getSummary(SectionRequestBody summaryRequestBody, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getAMLStatusDropDowns(Integer tenantid, String workflowKey, Authentication pr);

    public ResponseEntity<?> getSTRForm(String formname, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getSTRFormValue(Integer form_value_id, Integer tenantid, Authentication pr);

    public ResponseEntity<?> addSTRForm(AddFormValue formValue, Authentication pr);

    public ResponseEntity<?> editSTRForm(Integer form_value_id, AddFormValue addFormValue, Authentication pr);

    public ResponseEntity<?> getUsersQc(Authentication pr, String vcgroupid, Integer tenantid);

    public ResponseEntity<?> sanctionSearch(String proc_inst_id, Authentication pr) throws Exception;

    public ResponseEntity<?> sanctionFetch(String search_id, String source, Authentication pr) throws Exception;

    public ResponseEntity<?> downloadAttachmentFromFileStorage(String transactionID, String fileName, Authentication pr,
                                                               HttpServletRequest request, Integer tenantid) throws Exception;

    public ResponseEntity<?> getProfileParameters(ProfileParameters request, Authentication pr) throws Exception;

    public ResponseEntity<?> getManualWorkflows(Integer tenantid, Authentication pr);

    public ResponseEntity<?> getBatchDecisions(Authentication pr);

    public ResponseEntity<?> getBatchTrans(String address, String level, String frequency, String date, Integer workflowid, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getRulesDecision(Integer workflowid, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getWorkflowParams(Integer workflowid, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getProfileDates(String address, String level, String frequency, Integer workflowid, Integer tenantid, Authentication pr);

    public ResponseEntity<?> createManualTicket(Integer workflowid, Integer tenantid, String requestbody, Authentication pr);

    public ResponseEntity<?> getRealTimeTrans(String address, String level, String transId, Integer workflowId, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getRealTimeTrans(String address, String level, String transid, Integer workflowId, String startdate, String enddate, Integer tenantid, Authentication pr);
}
