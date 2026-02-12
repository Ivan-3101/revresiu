package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.RulesAudit;
import com.DronaPay.UIServer.service.Audit;

import java.util.List;

public abstract class RuleTempAuditService implements Audit<RulesAudit> {

    abstract Integer getCountByIRuleAvailableIDAndIDecisionId(int iRuleAvailableID, int iDecisionId) throws Exception;

    abstract List<RulesAudit> getSequenceByiDecisionID(int iDecisionID, Integer tenantid) throws Exception;

    abstract List<RulesAudit> findAllByIDecisionID(int iDecisionID, Integer tenantid) throws Exception;

    abstract List<RulesAudit> findAllPending(int iDecisionID, Integer tenantid) throws Exception;

    abstract RulesAudit findById(Integer auditID, Integer tenantid) throws Exception;

    abstract List<RulesAudit> findPendingEntriesByDecisionID(Integer iDecisionID, Integer tenantid) throws Exception;
}
