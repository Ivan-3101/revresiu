package com.DronaPay.UIServer.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.DronaPay.UIServer.model.DecisionUiAudit;
public interface DecisionAuditRepository extends JpaRepository<DecisionUiAudit,Integer> {
    
    // @Query("SELECT u FROM DecisionUiAudit u WHERE u.iStatus = null AND u.bClosed = false")
    // public List<DecisionUiAudit> findAllPendingEntries();

    public List<DecisionUiAudit> findByIstatusIsNullAndBclosedFalse();

    // @Query("SELECT u FROM DecisionUiAudit u WHERE  u.bClosed = false and u.iDecisionUiId.iDecisionID = :idecisionid ")
    // public DecisionUiAudit findPendingByDecisionId(@Param("idecisionid") Integer iDecisionId);
    public DecisionUiAudit findByBclosedFalseAndIdecisionUiIdAndItenantId(Integer iDecisionId, Integer tenantid);

    public List<DecisionUiAudit> findAllByIstatusIsNullAndBclosedFalseAndItenantIdIn(List<Integer> tenantids);

    public DecisionUiAudit findByiDecisionAuditIDAndItenantIdAndBclosedFalse(Integer auditId,Integer tenantId);
    
}
