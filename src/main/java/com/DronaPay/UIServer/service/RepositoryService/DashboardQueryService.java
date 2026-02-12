package com.DronaPay.UIServer.service.RepositoryService;


import com.DronaPay.UIServer.model.DashboardQuery;

public interface DashboardQueryService {

    public DashboardQuery findById(Integer iDashboardQueryID,Integer tenantId);

}
