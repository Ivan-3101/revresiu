package com.DronaPay.UIServer.service.RepositoryService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.DashboardQuery;
import com.DronaPay.UIServer.repository.DashboardQueryRepository;

@Service
public class DashboardQueryServiceImpl implements DashboardQueryService {

    @Autowired
    private DashboardQueryRepository dashboardQueryRepository;

    public DashboardQuery findById(Integer iDashboardQueryID,Integer tenantId) {
        return dashboardQueryRepository.findByiDashboardQueryIDAndItenantId(iDashboardQueryID, tenantId);
    }
}
