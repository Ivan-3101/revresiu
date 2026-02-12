package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.DashboardCustomLayout;

public interface DashboardCustomLayoutService {
    public DashboardCustomLayout findDefaultLayoutByIResultSetID(Integer iResultSetID, Integer IUserID, Integer iTenantID) throws Exception;

    public DashboardCustomLayout findDefaultLayoutByIResultSetIDUser(Integer iResultSetID, Integer IUserID,Integer tenantId) throws Exception;

    public DashboardCustomLayout save(DashboardCustomLayout al) throws Exception;

    public void removeDefaultByResultSetID(Integer iResultSetID, Integer itenantid) throws Exception;

}
