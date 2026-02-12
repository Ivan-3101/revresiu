package com.DronaPay.UIServer.service.ControllerService.ScoreBatchFlow;

import org.springframework.http.ResponseEntity;

public interface ScoreBatchFlowService {

    ResponseEntity<?> findByRuleIdAndExecuteQuery(Integer iRulId, String event, Integer tenantid) throws Exception;

    ResponseEntity<?> callResponseAPI(String reqBody) throws Exception;

}
