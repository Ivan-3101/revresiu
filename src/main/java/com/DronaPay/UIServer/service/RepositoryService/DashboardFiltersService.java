package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.DashboardFilters;

import java.util.ArrayList;

public interface DashboardFiltersService {

    public ArrayList<DashboardFilters> getAllByIDashboardID(Integer idashboardid,Integer tenantId) throws Exception;

    public DashboardFilters findById(Integer idashboardid,Integer tenantid);
}
