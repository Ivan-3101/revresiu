package com.DronaPay.UIServer.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.DronaPay.UIServer.model.DecisionUiWorkflowAudit;

public interface DecisionUiWorkflowAuditRepository extends JpaRepository<DecisionUiWorkflowAudit,Integer>{

    // @Query("SELECT u FROM DecisionUiWorkflowAudit u WHERE u.istatus = null AND u.bclosed = false")
    // public List<DecisionUiWorkflowAudit> findAllPendingEntries();

    public List<DecisionUiWorkflowAudit> findByIstatusIsNullAndBclosedFalse();

    public List<DecisionUiWorkflowAudit> findByIstatusIsNullAndBclosedFalseAndItenantIdIn(List<Integer> tenantid);

    // @Query("SELECT u FROM DecisionUiWorkflowAudit u WHERE  u.bclosed = false and u.idecisionUiId.iDecisionID = :idecisionid ")
    // public DecisionUiWorkflowAudit findPendingByDecisionId(@Param("idecisionidde") Integer iDecisionId);
    public DecisionUiWorkflowAudit findByBclosedFalseAndIdecisionUiId(Integer iDecisionId);

     public DecisionUiWorkflowAudit findByBclosedFalseAndIdecisionUiIdAndItenantId(Integer iDecisionId,Integer tenantId);

    public DecisionUiWorkflowAudit findByBclosedFalseAndIdecisionAuditID(Integer auditID);

    public DecisionUiWorkflowAudit findByBclosedFalseAndIdecisionAuditIDAndItenantId(Integer auditId,Integer tenantId);
}
