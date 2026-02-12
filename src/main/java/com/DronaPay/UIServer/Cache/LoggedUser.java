package com.DronaPay.UIServer.Cache;

import com.DronaPay.UIServer.Constants.MultiTenant;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.util.UserMapping;

import lombok.Builder;
import lombok.Getter;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Getter
@Builder
public class LoggedUser {

    private WebUser webUser;
    private List<GroupDesc> groups;
    private List<Tenant> tenant;
    private List<RoleDesc> roleDescs;
    private List<WorkflowMasters> workflows;
    private Map<String, MenuPermissions> permissions;
    // private List<TransactionClassesUI> transactionClasses;

    // private List<Integer> userGroup;
    private List<Integer> userTenant;
    private UserMapping userClass;
    // private List<Integer> userWorkflow;
    public boolean allowTenants(List<Integer> tenantids) {
        return (tenantids.size() > 0 &&
                tenant.stream()
                        .map(a -> a.getItenantid())
                        .collect(Collectors.toList())
                        .containsAll(tenantids));
    }

    public boolean allowTenantsWorkflowKeys(List<Integer> tenantids, List<String> reqWorkflowKeys) {
        Boolean allowed = false;
        if (tenantids.size() > 0 && tenant.stream()
                .map(a -> a.getItenantid())
                .collect(Collectors.toList())
                .containsAll(tenantids)) {
            if (workflows.stream().map(wfl -> wfl.getWorkflowKey()).toList().containsAll(reqWorkflowKeys)) {
                allowed = true;
            }
        }
        return allowed;
    }

    public boolean allowWorkflowId(Integer reqworkflowid) {
        return workflows.stream().anyMatch(wfl -> wfl.getWorkflowId().equals(reqworkflowid));
    }

    public boolean allowOrg(String reqorgid) {
        String loggedUserOrg = webUser.getIorgId().getVcOrgId();
        return (loggedUserOrg.equals(MultiTenant.adminOrg) || loggedUserOrg.equals(reqorgid));
    }

}
