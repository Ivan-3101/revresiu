package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.DecisionUiWorkflowAudit;
import com.DronaPay.UIServer.repository.DecisionUiWorkflowAuditRepository;

@Service
public class DecisionUiWorkflowAuditServiceImpl extends DecisionUiWorkflowAuditService {

    @Autowired
    private DecisionUiWorkflowAuditRepository decisionUiWorkflowAuditRepository;


    @Override
    public DecisionUiWorkflowAudit saveAudit(DecisionUiWorkflowAudit input) {
        
        return decisionUiWorkflowAuditRepository.save(input);
    }

    @Override
    public List<DecisionUiWorkflowAudit> findPendingEntries() throws Exception {
        
        //return decisionUiWorkflowAuditRepository.findAllPendingEntries();
        return decisionUiWorkflowAuditRepository.findByIstatusIsNullAndBclosedFalse();
    }

    
    @Override
    public DecisionUiWorkflowAudit findPendingDecisionByID(Integer decisionID,Integer tenantId) throws Exception {
        //return decisionUiWorkflowAuditRepository.findPendingByDecisionId(decisionID);
        return decisionUiWorkflowAuditRepository.findByBclosedFalseAndIdecisionUiIdAndItenantId(decisionID,tenantId);
    }

    // @Override
    // public DecisionUiWorkflowAudit findPendingDecisionByAuditID(Integer auditID) throws Exception {
    //    return decisionUiWorkflowAuditRepository.findByBclosedFalseAndIdecisionAuditID(auditID);
    // }

    @Override
    public
    List<DecisionUiWorkflowAudit> findPendingEntriesTenant(List<Integer> tenantid) throws Exception {
        return decisionUiWorkflowAuditRepository.findByIstatusIsNullAndBclosedFalseAndItenantIdIn(tenantid);
    }

    @Override
   public DecisionUiWorkflowAudit findPendingDecisionByAuditIDAndTenant(Integer auditID, Integer tenantId) throws Exception {
        return decisionUiWorkflowAuditRepository.findByBclosedFalseAndIdecisionAuditIDAndItenantId(auditID, tenantId);
    }
    
}
