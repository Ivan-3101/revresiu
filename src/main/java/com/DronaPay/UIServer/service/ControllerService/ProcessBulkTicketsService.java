package com.DronaPay.UIServer.service.ControllerService;

import com.DronaPay.UIServer.requests.ChangeStatusDropDownRequest;
import com.DronaPay.UIServer.requests.GetWorkflowState;
import com.DronaPay.UIServer.requests.LoadMoreTaskListRequestGt;
import com.DronaPay.UIServer.requests.ProcessBulkReassignRequest;
import com.DronaPay.UIServer.requests.ProcessBulkReassignRequestOpen;
import com.DronaPay.UIServer.requests.SubmitTaskOpen;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

public interface ProcessBulkTicketsService {

    public ResponseEntity<?> getCaseTypeDropDown(Authentication pr);

    public ResponseEntity<?> getTaskList(LoadMoreTaskListRequestGt loadMoreTaskListRequest, Authentication pr);

    public ResponseEntity<?> getTaskListCount(String paramater, Authentication pr);

    public ResponseEntity<?> claimTask(String body, Authentication pr);

    public ResponseEntity<?> reassignTask(ProcessBulkReassignRequest ProcessBulkReassignRequest, Authentication pr);

    public ResponseEntity<?> reassignTaskOpen(ProcessBulkReassignRequestOpen ProcessBulkReassignRequest);

    public ResponseEntity<?> submitFormOpen(SubmitTaskOpen submitTaskOpen);

    public ResponseEntity<?> submitForm(String body, Authentication pr);

    public ResponseEntity<?> getVpaDropdown(String type, Authentication pr);

    public ResponseEntity<?> getStatusDropDown(GetWorkflowState req, Authentication pr);

    public ResponseEntity<?> getRuleDropDowns(Authentication pr);

    public ResponseEntity<?> getChangeStatusDropDown(ChangeStatusDropDownRequest changeStatusDropDownRequest,
                                                     Authentication pr);

    public ResponseEntity<?> getDocumentRejectionReason(ChangeStatusDropDownRequest changeStatusDropDownRequest,
                                                        Authentication pr);

    public ResponseEntity<?> getDocumentListToBeSubmited(ChangeStatusDropDownRequest changeStatusDropDownRequest,
                                                         Authentication pr);

    public ResponseEntity<?> getListOfUsers(Integer tenantid, Authentication pr);


    public ResponseEntity<?> getDecisionAndRules(Authentication pr, Integer tenantid);

}
