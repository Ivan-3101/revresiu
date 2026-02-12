package com.DronaPay.UIServer.service.ControllerService.TryOut;

import com.DronaPay.UIServer.requests.AddRulesAvailableRequest;
import com.DronaPay.UIServer.requests.TestRule;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

public interface RuleBuilderControllerService {
    public ResponseEntity<?> addToRulesAvailable(AddRulesAvailableRequest req, Authentication pr);

    public ResponseEntity<?> addToRulesDraft(AddRulesAvailableRequest req, Authentication pr);

    public ResponseEntity<?> getRulesDraft(Authentication pr);

    public ResponseEntity<?> getRulesAvailable(String menuname, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getMetaDataAndObservations(Authentication pr);

    public ResponseEntity<?> getRuleBuilderData(Integer tenantId,Authentication pr);

    public ResponseEntity<?> testRule(TestRule testRule, Authentication pr);
}
