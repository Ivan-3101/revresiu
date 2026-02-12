package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.DashboardCustomLayoutAudit;
import com.DronaPay.UIServer.repository.DashboardCustomLayoutAuditRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DashboardCustomLayoutAuditServiceImpl implements DashboardCustomLayoutAuditService{

    @Autowired
    private DashboardCustomLayoutAuditRepository dashboardCustomLayoutAuditRepository;

    public DashboardCustomLayoutAudit save(DashboardCustomLayoutAudit al) throws Exception {
        return dashboardCustomLayoutAuditRepository.save(al);
    }

}
