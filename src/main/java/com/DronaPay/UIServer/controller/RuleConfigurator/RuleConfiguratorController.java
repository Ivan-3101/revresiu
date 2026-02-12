package com.DronaPay.UIServer.controller.RuleConfigurator;


import com.DronaPay.UIServer.requests.ApproveRuleRequest;
import com.DronaPay.UIServer.requests.EditDefaultRuleRequest;
import com.DronaPay.UIServer.service.ControllerService.RuleConfigurator.RuleConfiguratorService;
import com.fasterxml.jackson.core.JsonProcessingException;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/v1/testing/rule-configurator")
public class RuleConfiguratorController {

    @Autowired
    private RuleConfiguratorService ruleConfiguratorService;

    @GetMapping("/get-decisions")
    public ResponseEntity<?> getRulesAvailableByDecisionID(Authentication pr) {
        return ruleConfiguratorService.getAllDecision(pr);
    }

    @GetMapping("/get-modes")
    public ResponseEntity<?> getRuleModes(Authentication pr) {
        return ruleConfiguratorService.getModeDropDowns(pr);
    }

    @GetMapping("/get-rules-available/{idecisionid}/{audit}")
    public ResponseEntity<?> getRulesAvailableByDecisionID(
            @PathVariable(name = "idecisionid", required = true) int iDecisionID, @PathVariable(name = "audit", required = true) Boolean audit, Authentication pr) {
        return ruleConfiguratorService.getRulesAvailableByIDecisionId(iDecisionID, audit, pr);
    }


    @GetMapping("/get-rule-sequence/{idecisionid}/{audit}")
    public ResponseEntity<?> getSequenceByiDecisionID(
            @PathVariable(name = "idecisionid", required = true) int iDecisionID, @PathVariable(name = "audit", required = true) Boolean audit, Authentication pr) {
        return ruleConfiguratorService.getSequenceByiDecisionID(iDecisionID, audit, pr);
    }


    @GetMapping("/get-rule/{idecisionid}")
    public ResponseEntity<?> getRules(
            @PathVariable(name = "idecisionid", required = true) int iDecisionID) {
        return ruleConfiguratorService.getRules(iDecisionID);
    }

    @GetMapping("/get-custom-rule/{idecisionid}/{audit}")
    public ResponseEntity<?> getCustomRule(
            @PathVariable(name = "idecisionid", required = true) int iDecisionID, @PathVariable(name = "audit", required = true) Boolean audit, Authentication pr) {
        return ruleConfiguratorService.getCustomRulesByDecisionId(iDecisionID, audit, pr);
    }

    @PostMapping("/edit-rule")
    public ResponseEntity<?> editRule(@Valid @RequestBody EditDefaultRuleRequest editDefaultRuleRequest, Authentication pr) throws JsonProcessingException {
        return ruleConfiguratorService.editNewDefaultRule(editDefaultRuleRequest, pr);
    }

    @PostMapping("/approve-rule")
    public ResponseEntity<?> approveRule(@Valid @RequestBody ApproveRuleRequest approveRuleRequest, Authentication pr) throws JsonProcessingException {
        return ruleConfiguratorService.approveRule(approveRuleRequest, pr);
    }

    @GetMapping("/get-labels")
    public ResponseEntity<?> getRuleLabels(Authentication pr) {
        return ruleConfiguratorService.getRuleLabels(pr);
    }

    @GetMapping("/get-metadata-observations/{menuname}/tenant-id/{tenantid}")
    public ResponseEntity<?> getMetaDataAndObservations(@PathVariable("tenantid") Integer tenantid,
                                                        @PathVariable("menuname") String menuname, Authentication pr) {
        return ruleConfiguratorService.getMetaDataAndObservations(tenantid, menuname, pr);
    }

    @GetMapping("/get-all-rules-data-decision/{idecisionid}/{audit}/tenant-id/{tenantid}")
    public ResponseEntity<?> getAllRulesDataDecision(@PathVariable(name = "idecisionid", required = true) int iDecisionID, @PathVariable(name = "audit", required = true) Boolean audit,
                                                     @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return ruleConfiguratorService.getAllRulesDataDecision(iDecisionID, audit, tenantid, pr);
    }

}
