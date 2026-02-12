package com.DronaPay.UIServer.service.ControllerService.testing;

import com.DronaPay.UIServer.requests.AddRuleRequest;
import com.DronaPay.UIServer.requests.ParameterRequset;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;


public interface RuleManagementService {

    public ResponseEntity<?> getRuleManagement(Authentication pr);

    public ResponseEntity<?> getTransactionClassesAndDecision(Authentication pr);

    public ResponseEntity<?> getParameterType(int iProductID, Authentication pr);

    public ResponseEntity<?> getSequenceByiDecisionID(int iDecisionID, Authentication pr);

    public ResponseEntity<?> getParameterType(ParameterRequset parameterRequset, Authentication pr);

    public ResponseEntity<?> addRule(AddRuleRequest addRuleRequest, Authentication pr);

//	public ResponseEntity<?> editRule(EditRuleRequest editRuleRequest, Authentication pr);

    public ResponseEntity<?> deleteRule(Integer iRuleID, Authentication pr);

    public ResponseEntity<?> getParameterType(String rule, Authentication pr);

    //Default Rule Methods
    public ResponseEntity<?> getRulesByIDecisionId(Integer iDecisionId, Authentication pr);

    public ResponseEntity<?> editDefaultRule(Integer iRuleId, String vcParam, Authentication pr);


}
