package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.MetadataUi;
import com.DronaPay.UIServer.model.MetadataUiAudit;
import com.DronaPay.UIServer.service.Audit;
import java.util.List;

public abstract class MetadataAuditService implements Audit<MetadataUiAudit> {

    public abstract List<MetadataUiAudit> findPendingEntriesTenants(List<Integer> tenants);
     
    public abstract List<MetadataUiAudit> findPendingEntries();

    public abstract MetadataUiAudit findByVcrootVcPathTenant(String vcroot, String vcpath, Integer tenant) throws Exception;

    public abstract MetadataUiAudit findByVcrootVcPath(String vcroot, String vcpath) throws Exception;

    abstract MetadataUiAudit findByAuditId(Integer id,Integer tenantId) throws Exception;

    abstract MetadataUiAudit findByMetadatUiId(Integer id,Integer tenantId) throws Exception;

    abstract List<MetadataUiAudit> findDUplicate(String label,String window,String root,String path, Integer tenantid);
    
}
