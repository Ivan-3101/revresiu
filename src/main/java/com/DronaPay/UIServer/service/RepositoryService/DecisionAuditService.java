package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.model.DecisionUiAudit;
import com.DronaPay.UIServer.service.Audit;

public abstract class DecisionAuditService implements Audit<DecisionUiAudit> {
    
    abstract List<DecisionUiAudit> findPendingEntries() throws Exception;

    abstract List<DecisionUiAudit> findPendingEntriesTenant(List<Integer> tenants) throws Exception;

    abstract DecisionUiAudit findPendingDecisionByID(Integer decisionID, Integer tenantid) throws Exception;

    abstract DecisionUiAudit findByAuditIdAndTenantId(Integer auditId,Integer tenantId) throws Exception;

    abstract DecisionUiAudit saveDeicisonUiAudit(DecisionUiAudit decisionUiAudit) throws Exception;
}
