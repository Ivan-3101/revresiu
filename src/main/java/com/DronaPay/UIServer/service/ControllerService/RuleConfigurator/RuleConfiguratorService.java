package com.DronaPay.UIServer.service.ControllerService.RuleConfigurator;


import com.DronaPay.UIServer.requests.ApproveRuleRequest;
import com.DronaPay.UIServer.requests.EditDefaultRuleRequest;
import com.fasterxml.jackson.core.JsonProcessingException;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

public interface RuleConfiguratorService {

    public ResponseEntity<?> getAllDecision(Authentication pr);

    // public ResponseEntity<?>  getRulesAvailableByIDecisionId(Integer iDecisionId,Authentication pr,String mode,String label);

    public ResponseEntity<?> getRulesAvailableByIDecisionId(Integer iDecisionId, Boolean audit, Authentication pr);

    public ResponseEntity<?> getModeDropDowns(Authentication pr);

    public ResponseEntity<?> getSequenceByiDecisionID(int iDecisionID, Boolean audit, Authentication pr);

    public ResponseEntity<?> getRules(int iDecisionID);

    public ResponseEntity<?> getCustomRulesByDecisionId(int iDecisionID, Boolean audit, Authentication pr);

    public ResponseEntity<?> editNewDefaultRule(EditDefaultRuleRequest editDefaultRuleRequest, Authentication pr) throws JsonProcessingException;

    public ResponseEntity<?> approveRule(ApproveRuleRequest approveRuleRequest, Authentication pr) throws JsonProcessingException;

    public ResponseEntity<?> getRuleLabels(Authentication pr);

    public ResponseEntity<?> getMetaDataAndObservations(Integer tenantid, String menuname, Authentication pr);

    public ResponseEntity<?> getAllRulesDataDecision(int iDecisionID, Boolean audit, Integer tenantid, Authentication pr);

}
