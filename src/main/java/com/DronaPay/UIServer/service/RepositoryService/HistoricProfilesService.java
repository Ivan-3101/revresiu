package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.model.MetaData;

public interface HistoricProfilesService {
    
    public List<MetaData> findAllData() throws  Exception;

    public List<MetaData> findAllActiveTenant(Integer tenantid);

    public List<MetaData> findByColumnAndRoot(List<String> columns, String root, Integer tenantid) throws Exception;

    // public MetaData findByVcrootVcPath(String vcroot, String vcpath) throws Exception;
    
}
