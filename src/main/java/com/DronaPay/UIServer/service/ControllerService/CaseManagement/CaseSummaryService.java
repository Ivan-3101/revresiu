package com.DronaPay.UIServer.service.ControllerService.CaseManagement;


import com.DronaPay.UIServer.requests.LoadMoreTaskListRequest;
import com.DronaPay.UIServer.requests.LoadMoreTaskListRequestGt;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;


public interface CaseSummaryService {
    public ResponseEntity<?> getTaskList(LoadMoreTaskListRequestGt loadMoreTaskListRequest, Authentication pr);

    public ResponseEntity<?> getWorkFlowName(Authentication pr);

    public ResponseEntity<?> getTaskListCount(String paramater, Authentication pr);

    public ResponseEntity<?> getTaskNew(LoadMoreTaskListRequest loadMoreTaskListRequest, Authentication pr);

    public ResponseEntity<?> exportSummary(String paramater, Authentication pr);
}
