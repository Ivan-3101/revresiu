package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.exception.NotFoundException;
import com.DronaPay.UIServer.model.DashboardFilters;
import com.DronaPay.UIServer.repository.DashboardFiltersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class DashboardFiltersServiceImpl implements DashboardFiltersService {

    @Autowired
    private DashboardFiltersRepository dashboardFiltersRepository;

    public ArrayList<DashboardFilters> getAllByIDashboardID(Integer idashboardid, Integer tenantId) throws Exception {
        // return dashboardFiltersRepository.getAllByIDashboardID(idashboardid);
        return dashboardFiltersRepository
                .findByIdashboardIDAndItenantIdOrderByIfilterOrderAsc(idashboardid, tenantId);
    }

    public DashboardFilters findById(Integer idashboardid, Integer tenantId) {
        // return dashboardFiltersRepository.getAllByIDashboardID(idashboardid);
        return dashboardFiltersRepository.findByiDashboardFilterIDAndItenantId(idashboardid, tenantId);

    }

}
