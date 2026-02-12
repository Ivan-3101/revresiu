package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.model.DecisionUiWorkflowAudit;
import com.DronaPay.UIServer.service.Audit;

public abstract class DecisionUiWorkflowAuditService implements Audit<DecisionUiWorkflowAudit> {

    abstract List<DecisionUiWorkflowAudit> findPendingEntries() throws Exception;

    abstract List<DecisionUiWorkflowAudit> findPendingEntriesTenant(List<Integer> tenantid) throws Exception;

    abstract DecisionUiWorkflowAudit findPendingDecisionByID(Integer decisionID,Integer tenantId) throws Exception;

    // abstract DecisionUiWorkflowAudit findPendingDecisionByAuditID(Integer auditID) throws Exception;
    
    abstract DecisionUiWorkflowAudit findPendingDecisionByAuditIDAndTenant(Integer auditID,Integer tenantId) throws Exception;
}
