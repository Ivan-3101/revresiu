package com.DronaPay.UIServer.service.RepositoryService;


import java.util.List;

import com.DronaPay.UIServer.model.TenantAudit;
import com.DronaPay.UIServer.service.Audit;

public abstract class TenantAuditRepositoryService implements Audit<TenantAudit> {

    public abstract List<TenantAudit> findPendingEntries() throws Exception;

    public abstract TenantAudit findByTenantId(String tenantid) throws Exception;
    
}
