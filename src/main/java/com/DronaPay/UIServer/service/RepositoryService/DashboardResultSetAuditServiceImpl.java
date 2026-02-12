package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.DashboardResultSetAudit;
import org.springframework.beans.factory.annotation.Autowired;

public class DashboardResultSetAuditServiceImpl implements DashboardResultSetAuditService{

    @Autowired
    private DashboardResultSetAuditService dashboardResultSetAuditService;

    public DashboardResultSetAudit save(DashboardResultSetAudit dashboardResultSetAudit) throws Exception {
       return dashboardResultSetAuditService.save(dashboardResultSetAudit);
    }
}
