package com.DronaPay.UIServer.VOMapper;

import com.DronaPay.UIServer.model.DashboardCustomLayout;
import com.DronaPay.UIServer.model.DashboardCustomLayoutAudit;

public class DashboardCustomLayoutVoMapper {
    public static DashboardCustomLayoutAudit parse(DashboardCustomLayout dcl) {
        DashboardCustomLayoutAudit dcla = new DashboardCustomLayoutAudit();
        dcla.setIDashboardCustomLayoutID(dcl);
        dcla.setVcLayoutJSON(dcl.getVcLayoutJSON());
        dcla.setBActive(dcl.getBactive());
        dcla.setBDelete(dcl.getBdelete());
        dcla.setBShared(dcl.getBshared());
        dcla.setBDefault(dcl.getBdefault());
        dcla.setIUserID(dcl.getIuserID());
        dcla.setIorgId(dcl.getIorgId());
        dcla.setDtCreaatedTimeStamp(dcl.getDtCreaatedTimeStamp());
        dcla.setDtLastupdatedTimeStamp(dcl.getDtLastupdatedTimeStamp());
        dcla.setIresultSetID(dcl.getIresultSetID());
        dcla.setItenantId(dcl.getItenantId());
        return dcla;
    }
}
