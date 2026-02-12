package com.DronaPay.UIServer.VOMapper;

import com.DronaPay.UIServer.model.GroupDesc;
import com.DronaPay.UIServer.model.RoleDesc;
import com.DronaPay.UIServer.model.Tenant;
import com.DronaPay.UIServer.model.TransactionClassesUI;
import com.DronaPay.UIServer.model.WorkflowMasters;
import com.DronaPay.UIServer.requests.UserPermissionRequest;
import com.DronaPay.UIServer.util.UserMapping;

import java.util.ArrayList;
import java.util.List;

public class UserPermissionRequestMapper {

    public static List<UserPermissionRequest> parseGroup(List<GroupDesc> gdl) {
        List<UserPermissionRequest> uprl = new ArrayList<>();

        for (GroupDesc gd : gdl) {
            UserPermissionRequest upr = new UserPermissionRequest();
            if (!gd.getVcGroupType().equalsIgnoreCase("internal")) {
                upr.setLabel(gd.getVcGroupName());
                upr.setValue(gd.getIgroupID());
                upr.setItenantId(gd.getItenantId());
                uprl.add(upr);
            }

        }
        return uprl;
    }

    public static List<UserPermissionRequest> parseRole(List<RoleDesc> rdl) {
        List<UserPermissionRequest> uprl = new ArrayList<>();
        
        for (RoleDesc gd : rdl) {
            UserPermissionRequest upr = new UserPermissionRequest();
            upr.setLabel(gd.getVcRoleName());
            upr.setValue(gd.getIRoleID());
            upr.setItenantId(gd.getItenantId());
            uprl.add(upr);

        }
        return uprl;
    }

    public static List<UserPermissionRequest> parseWorkflow(List<WorkflowMasters> wfl) {

        List<UserPermissionRequest> uprl = new ArrayList<>();
        for (WorkflowMasters wf : wfl) {
            UserPermissionRequest upr = new UserPermissionRequest();
            upr.setLabel(wf.getWorkflowName());
            upr.setValue(wf.getWorkflowId());
            upr.setItenantId(wf.getItenantId().getItenantid());
            uprl.add(upr);

        }

        return uprl;
    }

    public static List<UserPermissionRequest> parseTenant(List<Tenant> tenants) {
        List<UserPermissionRequest> uprl = new ArrayList<>();
       
        for (Tenant tnt : tenants) {
            UserPermissionRequest upr = new UserPermissionRequest();
            upr.setLabel(tnt.getTenantName());
            upr.setValue(tnt.getItenantid());
            upr.setItenantId(tnt.getItenantid());
            uprl.add(upr);

        }
        return uprl;
    }

    public static List<UserPermissionRequest> parseClass(List<TransactionClassesUI> classes) {

        List<UserPermissionRequest> uprl = new ArrayList<>();
        for (TransactionClassesUI cl : classes) {
            UserPermissionRequest upr = new UserPermissionRequest();
            upr.setLabel(cl.getVcClassName());
            upr.setValue(cl.getIclassID());
            upr.setItenantId(cl.getItenantId());
            uprl.add(upr);
        }
        return uprl;
    }



    public static UserMapping parseToUserMap(List<UserPermissionRequest> pRequests) {
        UserMapping ret = new UserMapping();
        for(UserPermissionRequest req: pRequests) {
            ret.getMappingIds().add(req.getValue());
            ret.getTenantids().add(req.getItenantId());
        }
        return ret;
    }
}
