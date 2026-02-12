package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.DashboardQueryParameters;
import com.DronaPay.UIServer.repository.DashboardQueryParametersRepository;

@Service
public class DashboardQueryParmeterServiceImpl implements DashboardQueryParmeterService {

    @Autowired
    private DashboardQueryParametersRepository dashboardQueryParametersRepository;

    @Override
    public List<DashboardQueryParameters> findByidAndTenant(Integer id, Integer tenant) {
        return dashboardQueryParametersRepository.findAllByiDashboardQueryAndItenantId(id, tenant);
    }
    
}
