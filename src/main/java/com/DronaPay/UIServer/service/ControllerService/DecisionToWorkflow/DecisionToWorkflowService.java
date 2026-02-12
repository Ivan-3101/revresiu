package com.DronaPay.UIServer.service.ControllerService.DecisionToWorkflow;


import com.DronaPay.UIServer.requests.*;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

public interface DecisionToWorkflowService {

    public ResponseEntity<?> getAllDecision(Authentication pr);

    public ResponseEntity<?> getDecisionDetails(Integer idecisionid, Boolean audit, Integer tenantid, Authentication pr);

    public ResponseEntity<?> addDecisionDetails(AddNewDecisionRequestGt addDecisionRequest, Authentication pr);

    public ResponseEntity<?> editDecisionDetails(EditDecisionRequest editDecisionRequest, Authentication pr);

    public ResponseEntity<?> approveDeicison(ApproveDecisionDetails approveDecisionDetails, Authentication pr);

    public ResponseEntity<?> editResultParam(Integer classID, EditResultParamOfTransaction eResultParamOfTransaction, Authentication pr);

    public ResponseEntity<?> disableResultParam(Integer classID, Authentication pr);

    public ResponseEntity<?> getWorkFlowName(Authentication pr);

    public ResponseEntity<?> deleteDecision(DeleteDecisionRequest decisionRequest, Authentication pr);
}
