package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.VOMapper.DashboardResultSetVOMapper;
import com.DronaPay.UIServer.exception.NotFoundException;
import com.DronaPay.UIServer.model.DashboardResultSet;
import com.DronaPay.UIServer.repository.DashboardResultSetAuditRepository;
import com.DronaPay.UIServer.repository.DashboardResultSetRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DashboardResultSetServiceImpl implements DashboardResultSetService {

    @Autowired
    private DashboardResultSetRepository dashboardResultSetRepository;

    @Autowired
    private DashboardResultSetAuditRepository dashboardResultSetAuditRepository;

    public DashboardResultSet findByID(Integer iDashboardResultSetID,Integer tenantId) {
        return dashboardResultSetRepository.findByiDashboardResultSetIDAndItenantId(iDashboardResultSetID, tenantId);
    }

    public List<DashboardResultSet> findAllById(List<Integer> iDashboardResultSetID,Integer tenantId) {
        return dashboardResultSetRepository.findAllByiDashboardResultSetIDInAndItenantId(iDashboardResultSetID, tenantId);
    }

    @Transactional
    public DashboardResultSet save(DashboardResultSet dashboardResultSet) throws Exception {
        DashboardResultSet temp = dashboardResultSetRepository.save(dashboardResultSet);
        dashboardResultSetAuditRepository.save(DashboardResultSetVOMapper.parse(temp));
        return temp;
    }

    @Override
    public List<DashboardResultSet> findAllByDashboardID(Integer iDashboardID, Integer tenantId) {
       return dashboardResultSetRepository.findAllByiDashboardIDAndItenantId(iDashboardID, tenantId);
    }
}
