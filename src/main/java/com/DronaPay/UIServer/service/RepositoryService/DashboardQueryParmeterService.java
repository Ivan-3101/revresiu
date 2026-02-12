package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.model.DashboardQueryParameters;

public interface DashboardQueryParmeterService  {

    public List<DashboardQueryParameters> findByidAndTenant(Integer id,Integer tenant);
    
}
