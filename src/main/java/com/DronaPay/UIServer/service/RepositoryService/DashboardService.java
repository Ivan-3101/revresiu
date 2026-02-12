package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.Dashboard;

import java.util.List;

public interface DashboardService {
    public List<Dashboard> findAllActiveAndNotDeleted(Integer tenantid) throws Exception;

    public Dashboard findById(Integer iDashboardID,Integer tenantid);

    public Dashboard findByNameTenant(String dashname, Integer tenantid);

    public List<Dashboard> findAllActiveAndNotDeletedAndIMenuID(Integer imenu, Integer tenantid) throws Exception;

    public List<Dashboard> findAllByIds(List<Integer> dashboardIds, Integer tenantid);

}
