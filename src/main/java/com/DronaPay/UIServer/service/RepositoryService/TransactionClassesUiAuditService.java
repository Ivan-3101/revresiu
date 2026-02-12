package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.TransactionClassesUiAudit;
import com.DronaPay.UIServer.service.Audit;

import java.util.List;

public abstract class TransactionClassesUiAuditService implements Audit<TransactionClassesUiAudit> {

    abstract List<TransactionClassesUiAudit> findPendingEntries() throws Exception;

    abstract TransactionClassesUiAudit findTransactionDetail(Integer iclassId, Integer tenantid);

    abstract TransactionClassesUiAudit findPendingEntriesByIClassId(Integer iClassId, Integer itenantid);

    abstract List<TransactionClassesUiAudit> findPendinEntriesByIDecisionId(Integer iDecisionId);

    public abstract TransactionClassesUiAudit findPendingEntriesTenantClass(String vcclassname, Integer itenantid);

    abstract List<TransactionClassesUiAudit> findPendingEntriesTenantClass(List<Integer> itenantids,
                                                                           List<Integer> classids);
}
