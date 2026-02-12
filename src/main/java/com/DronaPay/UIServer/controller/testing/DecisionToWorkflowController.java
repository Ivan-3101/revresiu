package com.DronaPay.UIServer.controller.testing;

import com.DronaPay.UIServer.requests.*;
import com.DronaPay.UIServer.service.ControllerService.DecisionToWorkflow.DecisionToWorkflowService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/v1/testing/decision-to-workflow")
public class DecisionToWorkflowController {

    @Autowired
    private DecisionToWorkflowService decisionToWorkflowService;

    @GetMapping("/get-decisions")
    public ResponseEntity<?> getRulesAvailableByDecisionID(Authentication pr) {
        return decisionToWorkflowService.getAllDecision(pr);
    }

    @GetMapping("/get-decision-details/{idecisionid}/{audit}/tenant-id/{tenantid}")
    public ResponseEntity<?> getDecisionDetails(@PathVariable(name = "idecisionid") Integer idecisionid, @PathVariable(name = "audit") Boolean audit, 
    @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return decisionToWorkflowService.getDecisionDetails(idecisionid, audit, tenantid, pr);
    }

    @PostMapping("/add-decision-details")
    public ResponseEntity<?> addDecisionDetails(@Valid @RequestBody AddNewDecisionRequestGt addNewDecisionRequest, Authentication pr) {
        return decisionToWorkflowService.addDecisionDetails(addNewDecisionRequest, pr);
    }

    @PostMapping("/edit-decision-details")
    public ResponseEntity<?> editDecisionDetails(@Valid @RequestBody EditDecisionRequest editDecisionRequest, Authentication pr) {
        return decisionToWorkflowService.editDecisionDetails(editDecisionRequest, pr);
    }

    @PostMapping("/approve-decision-details")
    public ResponseEntity<?> approveDecisionDetails(@Valid @RequestBody ApproveDecisionDetails approveDecisionDetails, Authentication pr) {
        return decisionToWorkflowService.approveDeicison(approveDecisionDetails, pr);
    }


    @PutMapping("/edit-transaction-class-result-param/{iClassID}")
    public ResponseEntity<?> editTransactionClassResultParam(@PathVariable(name = "iClassID") Integer classID, @RequestBody EditResultParamOfTransaction editResultParamOfTransaction, Authentication pr) {
        return decisionToWorkflowService.editResultParam(classID, editResultParamOfTransaction, pr);
    }


    @PutMapping("/disable-result-params/{iClassID}")
    public ResponseEntity<?> disableResultParams(@PathVariable(name = "iClassID") Integer classID, Authentication pr) {
        return decisionToWorkflowService.disableResultParam(classID, pr);
    }

    @GetMapping("/get-workflow-names")
    public ResponseEntity<?> getWorkFlowNames(Authentication pr) {
        return decisionToWorkflowService.getWorkFlowName(pr);
    }

    @PostMapping("/delete-decision")
    public ResponseEntity<?> deleteDecision(@Valid @RequestBody DeleteDecisionRequest decisionRequest, Authentication pr) {
        return decisionToWorkflowService.deleteDecision(decisionRequest, pr);
    }

}
