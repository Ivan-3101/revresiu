package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.MetadataUi;
import com.DronaPay.UIServer.service.Audit;
import java.util.List;

public abstract class MetadataUiService implements Audit<MetadataUi> {

    public abstract List<MetadataUi> findAllActiveMetadataTenants(List<Integer> tenants) throws Exception;

    public abstract  List<MetadataUi> findAllActiveMetadata() throws Exception;

    public abstract MetadataUi findByVcrootVcPath(String vcroot, String vcpath) throws Exception;

    public abstract MetadataUi findByVcrootVcPathTenant(String vcroot, String vcpath, Integer tenant) throws Exception;

    public abstract List<MetadataUi> findByColumnAndRootTenant(List<String> columns, String root, Integer tenantid);

    public abstract MetadataUi findById(Integer id) throws Exception;

    public abstract List<MetadataUi> findDUplicate(String label,String window,String root,String path,Integer tenant);
}
