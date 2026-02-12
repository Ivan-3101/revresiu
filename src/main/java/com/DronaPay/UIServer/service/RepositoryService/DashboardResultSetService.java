package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.DashboardResultSet;

import java.util.List;

public interface DashboardResultSetService {
    public DashboardResultSet findByID(Integer iDashboardResultSetID,Integer tenantId);

      public List<DashboardResultSet> findAllByDashboardID(Integer iDashboardID,Integer tenantId);


    public DashboardResultSet save(DashboardResultSet dashboardResultSet) throws Exception;

    public List<DashboardResultSet> findAllById(List<Integer> iDashboardResultSetID,Integer tenantId);

}
