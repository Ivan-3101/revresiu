package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.model.ListAudit;
import com.DronaPay.UIServer.service.Audit;

// @Service
public abstract class ListAuditService implements Audit<ListAudit> {
    
    public abstract List<ListAudit> findPendingEntries();

    public abstract ListAudit findByExternalId(String externalID, Integer tenantid) throws Exception;

    public abstract List<ListAudit> findPendingEntriesTenants(List<Integer> tenants);
   
}
