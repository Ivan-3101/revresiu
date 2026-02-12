package com.DronaPay.UIServer.VOMapper;

import com.DronaPay.UIServer.model.DashboardResultSet;
import com.DronaPay.UIServer.model.DashboardResultSetAudit;

public class DashboardResultSetVOMapper {
    public static DashboardResultSetAudit parse(DashboardResultSet drs) {
        DashboardResultSetAudit drsa = new DashboardResultSetAudit();
        drsa.setIDashboardResultSetID(drs);
        drsa.setVcDashboardResultSetName(drs.getVcDashboardResultSetName());
        drsa.setVcDashboardResultSetLayout(drs.getVcDashboardResultSetLayout());
        drsa.setVcDashboardResultSetColumnJson(drs.getVcDashboardResultSetColumnJson());
        drsa.setVcDashboardResultSetSchema(drs.getVcDashboardResultSetSchema());
        drsa.setIResultSetOrder(drs.getIResultSetOrder());
        drsa.setIDashboardID(drs.getIDashboardID());
        drsa.setDashboardQuery(drs.getDashboardQuery());
        drsa.setIColSize(drs.getIColSize());
        drsa.setIRowNo(drs.getIRowNo());
        drsa.setLastModifiedBy(drs.getLastModifiedBy());
        drsa.setDtLastupdatedTimeStamp(drs.getDtLastupdatedTimeStamp());
        drsa.setItenantId(drs.getItenantId());
        return drsa;
    }
}
