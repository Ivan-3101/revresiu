package com.DronaPay.UIServer.controller.testing;

import com.DronaPay.UIServer.requests.*;
import com.DronaPay.UIServer.service.ControllerService.CustomTransctionClasses.CustomTransactionClasses;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/v1/testing/transaction-classes")
public class CustomTransactionClassesController {

    @Autowired
    private CustomTransactionClasses customTransactionClasses;

    @GetMapping("/get-initial-data")
    public ResponseEntity<?> getInitialData(Authentication pr) {
        return customTransactionClasses.getInitialData(pr);
    }

    @GetMapping("/get-decisions/{tenantid}")
    public ResponseEntity<?> getDecisionsForTenant(@PathVariable("tenantid") Integer itenantid, Authentication pr) {
        return customTransactionClasses.getAllDecision(itenantid, pr);
    }

    @GetMapping("/get-transaction-classes")
    public ResponseEntity<?> getTransactionClasses(Authentication pr) {
        return customTransactionClasses.getListOfTransactionClasses(pr);
    }

    @GetMapping("/get-transaction-class-details/{iclassid}/{audit}/tenant-id/{tenantid}")
    public ResponseEntity<?> getTransactionClassDetail(@PathVariable(name = "iclassid") Integer iClassId, @PathVariable(name = "audit") Boolean audit, 
    @PathVariable("tenantid") Integer itenantid, Authentication pr) {
        return customTransactionClasses.getTransactionClassDetail(iClassId, audit, itenantid, pr);
    }

    @PostMapping("/edit-transaction-class")
    public ResponseEntity<?> editTransactionClass(@Valid @RequestBody EditTransactionClassRequest editTransactionClassRequest, Authentication pr) {
        return customTransactionClasses.editTransactionClass(editTransactionClassRequest, pr);
    }

    @GetMapping("/get-parameter-type")
    public ResponseEntity<?> getParameterType(Authentication pr) {

        return customTransactionClasses.getListOfParameters(pr);
    }

    @PostMapping("/add-transaction-class")
    public ResponseEntity<?> addTransactionClass(@Valid @RequestBody AddTransactionClassRequest addTransactionClassRequest, Authentication pr) {
        return customTransactionClasses.addNewTransactionClass(addTransactionClassRequest, pr);
    }

    @PostMapping("/approve-transaction-class")
    public ResponseEntity<?> approveTransactionClass(@Valid @RequestBody ApproveTransactionClass approveTransactionClass, Authentication pr) {
        return customTransactionClasses.approveTransactionClass(approveTransactionClass, pr);
    }

    @PutMapping("/edit-transaction-class-decision-param/{iClassID}")
    public ResponseEntity<?> editTransactionClass(@PathVariable(name = "iClassID") Integer classID, @RequestBody EditDecisionRuleOfTransaction editDecisionRuleOfTransaction, Authentication pr) {
        return customTransactionClasses.editDecisionRules(classID, editDecisionRuleOfTransaction, pr);
    }

    // @PutMapping("/edit-transaction-class-result-param/{iClassID}")
    // public ResponseEntity<?> editTransactionClassResultParam(@PathVariable(name = "iClassID") Integer classID,@RequestBody EditResultParamOfTransaction editResultParamOfTransaction, Authentication pr) {
    // 	return customTransactionClasses.editResultParam(classID, editResultParamOfTransaction, pr);
    // }

    @PutMapping("/disable-transaction-class/{iClassID}")
    public ResponseEntity<?> inactivateTransactionClass(@PathVariable(name = "iClassID") Integer classID, Authentication pr) {
        return customTransactionClasses.inactivatedTransactionClass(classID, pr);
    }

    @GetMapping("/get-products")
    public ResponseEntity<?> getProducts(Authentication pr) {
        return customTransactionClasses.getAllProducts(pr);
    }

    @GetMapping("/get-channels")
    public ResponseEntity<?> getChannels(Authentication pr) {
        return customTransactionClasses.getAllChannels(pr);
    }

    @PostMapping("/add-decision-class")
    public ResponseEntity<?> addDecision(@RequestBody AddNewDecisionRequestGt addNewDecisionRequest, Authentication pr) {
        return customTransactionClasses.saveNewDecision(addNewDecisionRequest, pr);
    }

    @PostMapping("/delete-transaction-class")
    public ResponseEntity<?> deleteTransactionClass(@Valid @RequestBody DeleteTransactionClassRequest deleteTransactionClassRequest, Authentication pr) {
        return customTransactionClasses.deleteTransactionClass(deleteTransactionClassRequest, pr);
    }


    // @PutMapping("/disable-result-params/{iClassID}")
    // public ResponseEntity<?> disableResultParams(@PathVariable(name = "iClassID") Integer classID, Authentication pr) {
    // 	return customTransactionClasses.disableResultParam(classID, pr);
    // }

    // @GetMapping("/get-workflow-names")
    // public ResponseEntity<?> getWorkFlowNames(Authentication pr) {
    //     return customTransactionClasses.getWorkFlowName(pr);
    // }


}
