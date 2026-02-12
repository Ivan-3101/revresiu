package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.repository.DecisionAuditRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.DecisionUiAudit;

@Service
public class DecisionAuditServiceImpl extends DecisionAuditService {

    @Autowired
    private DecisionAuditRepository decisionAuditRepository;

    @Override
    public DecisionUiAudit saveAudit(DecisionUiAudit input) {
        return decisionAuditRepository.save(input);
    }

    @Override
    public List<DecisionUiAudit> findPendingEntriesTenant(List<Integer> tenants) throws Exception {
        return decisionAuditRepository.findAllByIstatusIsNullAndBclosedFalseAndItenantIdIn(tenants);
    }

    @Override
    public List<DecisionUiAudit> findPendingEntries() throws Exception {
        //return decisionAuditRepository.findAllPendingEntries();
        return decisionAuditRepository.findByIstatusIsNullAndBclosedFalse();
    }

    @Override
    public DecisionUiAudit findPendingDecisionByID(Integer decisionID, Integer tenantid) throws Exception {
        //return decisionAuditRepository.findPendingByDecisionId(decisionID);
        return decisionAuditRepository.findByBclosedFalseAndIdecisionUiIdAndItenantId(decisionID, tenantid);
    }

    public DecisionUiAudit saveDeicisonUiAudit(DecisionUiAudit decisionUiAudit) throws Exception{
        return decisionAuditRepository.save(decisionUiAudit);
    }

    @Override
    public DecisionUiAudit findByAuditIdAndTenantId(Integer auditId, Integer tenantId) throws Exception {
        return decisionAuditRepository.findByBclosedFalseAndIdecisionUiIdAndItenantId(auditId, tenantId);
    }
    
}
