package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.TransactionClassesUiAudit;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TransactionClassUiAuditRepository extends JpaRepository<TransactionClassesUiAudit, Integer> {

    // @Query("SELECT u FROM TransactionClassesUiAudit u WHERE u.istatus = null AND u.bclosed = false")
    // public List<TransactionClassesUiAudit> findAllPendingEntries();

    public List<TransactionClassesUiAudit> findByIstatusIsNullAndBclosedFalse();

    public List<TransactionClassesUiAudit> findByIstatusIsNullAndBclosedFalseAndItenantIdInAndIclassIDIn(
            List<Integer> itenantids, List<Integer> classes);

    public List<TransactionClassesUiAudit> findByIstatusIsNullAndBclosedFalseAndItenantIdIn(List<Integer> tenants);

    // @Query("SELECT u FROM TransactionClassesUiAudit u WHERE  u.bclosed = false and u.iClassAuditID = :iclassid ")
    // public TransactionClassesUiAudit findClassPendingForAction(@Param("iclassid") Integer iclassid);
    public TransactionClassesUiAudit findByBclosedFalseAndIclassAuditIDAndItenantId(Integer iclassid, Integer tenantid);

    // @Query("SELECT u FROM TransactionClassesUiAudit u WHERE  u.bclosed = false and u.iClassID.iClassID = :iclassid ")
    // public TransactionClassesUiAudit findClassPendingForActionByIclassId(@Param("iclassid") Integer iclassid);
    public TransactionClassesUiAudit findByBclosedFalseAndIclassIDAndItenantId(Integer iclassid, Integer tenantid);

    // @Query("SELECT u FROM TransactionClassesUiAudit u WHERE u.istatus = null AND u.bclosed = false AND u.iDecisionID.iDecisionID != null AND u.iDecisionID.iDecisionID = :decisionid")
    // public List<TransactionClassesUiAudit> findAllPendingEntriesByIdecisionId(@Param("decisionid") Integer iDecisionId);

    public List<TransactionClassesUiAudit> findByIstatusIsNullAndBclosedFalseAndIdecisionID(Integer iDecisionId);

    public TransactionClassesUiAudit findByvcClassNameAndItenantIdAndIstatusIsNullAndBclosedFalse(String vcClassName, Integer tenantid);


}
