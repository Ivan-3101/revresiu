package com.DronaPay.UIServer.service.ControllerService.CustomTransctionClasses;


import com.DronaPay.UIServer.requests.*;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

public interface CustomTransactionClasses {

    public ResponseEntity<?> getInitialData(Authentication pr);

    public ResponseEntity<?> getAllDecision(Integer itenantid, Authentication pr);

    public ResponseEntity<?> getListOfTransactionClasses(Authentication pr);

    public ResponseEntity<?> getTransactionClassDetail(Integer iclassId, Boolean audit, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getListOfParameters(Authentication pr);

    public ResponseEntity<?> editTransactionClass(EditTransactionClassRequest editTransactionClassRequest, Authentication pr);

    public ResponseEntity<?> addNewTransactionClass(AddTransactionClassRequest addTransactionClassRequest, Authentication pr);

    // public ResponseEntity<?> saveNewTransactionClass(AddNewCustomTransactionClassRequest actcr, Authentication pr);

    public ResponseEntity<?> editDecisionRules(Integer classID, EditDecisionRuleOfTransaction editDecisionRuleOfTransaction, Authentication pr);

    public ResponseEntity<?> approveTransactionClass(ApproveTransactionClass approveTransactionClass, Authentication pr);

    // public ResponseEntity<?> editResultParam(Integer classID,EditResultParamOfTransaction eResultParamOfTransaction,Authentication pr);

    public ResponseEntity<?> inactivatedTransactionClass(Integer classID, Authentication pr);

    public ResponseEntity<?> getAllProducts(Authentication pr);

    public ResponseEntity<?> getAllChannels(Authentication pr);

    public ResponseEntity<?> saveNewDecision(AddNewDecisionRequestGt addNewDecisionRequest, Authentication pr);

    public ResponseEntity<?> deleteTransactionClass(DeleteTransactionClassRequest deleteTransactionClassRequest, Authentication pr);

    // public ResponseEntity<?> disableResultParam(Integer classID,Authentication pr);

    // public ResponseEntity<?> getWorkFlowName(Authentication pr);

}
