package com.DronaPay.UIServer.controller.testing;

import com.DronaPay.UIServer.requests.AddRuleRequest;
import com.DronaPay.UIServer.requests.ParameterRequset;
import com.DronaPay.UIServer.service.ControllerService.testing.RuleManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/v1/testing/rule-management")
public class RuleManagementController {

    @Autowired
    private RuleManagementService ruleManagementService;

    @GetMapping("/")
    public ResponseEntity<?> getRuleManagement(Authentication pr) {

        return ruleManagementService.getRuleManagement(pr);
    }

    @GetMapping("/get-classes-and-decision")
    public ResponseEntity<?> getTransactionClassesAndDecision(Authentication pr) {

        return ruleManagementService.getTransactionClassesAndDecision(pr);
    }

    @GetMapping("/get-parameter-type/{productid}")
    public ResponseEntity<?> getParameterType(@PathVariable(name = "productid", required = true) int iProductID,
                                              Authentication pr) {

        return ruleManagementService.getParameterType(iProductID, pr);
    }

    @GetMapping("/get-rule-sequence/{idecisionid}")
    public ResponseEntity<?> getSequenceByiDecisionID(
            @PathVariable(name = "idecisionid", required = true) int iDecisionID, Authentication pr) {
        return ruleManagementService.getSequenceByiDecisionID(iDecisionID, pr);
    }

    @PostMapping("/get-parameter-list")
    public ResponseEntity<?> getParameterType(@RequestBody ParameterRequset parameterRequset, Authentication pr) {
        return ruleManagementService.getParameterType(parameterRequset, pr);
    }

    @PostMapping("/add-rule")
    public ResponseEntity<?> addRule(@RequestBody AddRuleRequest addRuleRequest, Authentication pr) {

        return ruleManagementService.addRule(addRuleRequest, pr);
    }

    @DeleteMapping("/delete-rule/{iRuleID}")
    public ResponseEntity<?> deleteRule(@PathVariable(name = "iRuleID") Integer iRuleID, Authentication pr) {
        return ruleManagementService.deleteRule(iRuleID, pr);
    }

    @PostMapping("/test-rule")
    public ResponseEntity<?> getParameterType(@RequestBody(required = false) String rule, Authentication pr) {

        return ruleManagementService.getParameterType(rule, pr);
    }

    //Default rule method

    @GetMapping("/get-default-rule/{idecisionid}")
    public ResponseEntity<?> getDefaultRuleByClass(
            @PathVariable(name = "idecisionid", required = true) int iDecisionID, Authentication pr) {
        return ruleManagementService.getRulesByIDecisionId(iDecisionID, pr);
    }

    @PutMapping("/edit-default-rule/{iRuleID}")
    public ResponseEntity<?> editDefaultRule(@PathVariable(name = "iRuleID") Integer iRuleID, @RequestBody String vcParam, Authentication pr) {
        return ruleManagementService.editDefaultRule(iRuleID, vcParam, pr);
    }


}
