package com.DronaPay.UIServer.controller.TryOut;

import com.DronaPay.UIServer.requests.AddRulesAvailableRequest;
import com.DronaPay.UIServer.requests.TestRule;
import com.DronaPay.UIServer.service.ControllerService.TryOut.RuleBuilderControllerService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/v1/try-out/rule-builder")
public class RuleBuilder {
    @Autowired
    private RuleBuilderControllerService ruleBuilderService;

    @PostMapping("/add-to-draft")
    public ResponseEntity<?> addToDrafts(@Valid @RequestBody AddRulesAvailableRequest addReq, Authentication pr) {
        return ruleBuilderService.addToRulesDraft(addReq, pr);
    }

    @PostMapping("/add-to-available")
    public ResponseEntity<?> addToAvailable(@Valid @RequestBody AddRulesAvailableRequest addReq, Authentication pr) {
        return ruleBuilderService.addToRulesAvailable(addReq, pr);
    }

    @GetMapping("/get-all-rules/{tenantId}")
    public ResponseEntity<?> getAllRuleData(@PathVariable("tenantId") Integer tenantId, Authentication pr) {
        return ruleBuilderService.getRuleBuilderData(tenantId,pr);
    }

    @GetMapping("/get-all-available/{menuname}/tenant-id/{tenantid}")
    public ResponseEntity<?> getAvailable(@PathVariable("menuname") String menuname, 
    @PathVariable("tenantid") Integer tenantid,
    Authentication pr) {
        return ruleBuilderService.getRulesAvailable(menuname, tenantid, pr);
    }

    @GetMapping("/get-all-draft")
    public ResponseEntity<?> getDraft(Authentication pr) {
        return ruleBuilderService.getRulesDraft(pr);
    }

    @GetMapping("/get-metadata-observations")
    public ResponseEntity<?> getMetadataObservations(Authentication pr) {
        return ruleBuilderService.getMetaDataAndObservations(pr);
    }


    @PostMapping("/test-rule")
    public ResponseEntity<?> testRule(@Valid @RequestBody TestRule testRule, Authentication pr) {
        return ruleBuilderService.testRule(testRule, pr);
    }
}
