package com.DronaPay.UIServer.VOMapper;

import com.DronaPay.UIServer.model.Tenant;
import com.DronaPay.UIServer.model.TransactionClassesUI;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.model.WebUserAudit;
import com.DronaPay.UIServer.model.WorkflowMasters;
import com.DronaPay.UIServer.repository.TransactionClassesUiRepository;
import com.DronaPay.UIServer.requests.NewWebUserAuditRequest;
import com.DronaPay.UIServer.requests.UserPermissionRequest;
import com.DronaPay.UIServer.service.RepositoryService.GroupDescService;
import com.DronaPay.UIServer.service.RepositoryService.RoleDescService;
import com.DronaPay.UIServer.service.RepositoryService.TenantRepositoryService;
import com.DronaPay.UIServer.service.RepositoryService.TransactionClassesUiService;
import com.DronaPay.UIServer.service.RepositoryService.WorkflowMasterService;
import com.DronaPay.UIServer.util.AllUsersMapping;
import com.DronaPay.UIServer.util.UserMapping;
import com.DronaPay.UIServer.util.WebuserMappingUtil;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NewWebUserAuditRequestMapper {

    @Autowired
    RoleDescService roleDescService;

    @Autowired
    GroupDescService groupDescService;

    @Autowired
    private WorkflowMasterService workflowMasterService;

    @Autowired
    private TenantRepositoryService tenantRepositoryService;

    @Autowired
    private TransactionClassesUiService transactionClassesUiService;

    @Autowired
    private WebuserMappingUtil webuserMappingUtil;

    public List<WorkflowMasters> extractWorkflow(UserMapping workflowids) {
        return workflowMasterService.findByWorkflowIDs(workflowids);

    }

    public List<TransactionClassesUI> extractTransClasses(UserMapping cids) {
        return transactionClassesUiService.findByTenantClass(cids);
    }

    public NewWebUserAuditRequest parse(WebUserAudit wua) {
        NewWebUserAuditRequest nwuar = new NewWebUserAuditRequest();
        nwuar.setUsername(wua.getVcUserName());
//        nwuar.setPassword(wua.getVcPassword());
        nwuar.setEmailid(wua.getVcEmailID());
        nwuar.setContact(wua.getVcContact());
        nwuar.setMobile(wua.getVcMobile());
        nwuar.setProfileimg(wua.getVcProfileImg());
        nwuar.setFirstname(wua.getVcFirstName());
        nwuar.setLastname(wua.getVcLastName());
        nwuar.setAddress(wua.getVcAddress());
        nwuar.setDesignation(wua.getVcDesignation());
        nwuar.setRemark(wua.getVcRemark());

        AllUsersMapping allMappingInfo = webuserMappingUtil.getWebUserAuditMappings(Arrays.asList(wua.getIUserAuditID()), wua.getIorgId().getIorgid());
        nwuar.setUserpermissions(
                UserPermissionRequestMapper.parseRole(roleDescService.findAllById(allMappingInfo.getUserPermissions().get(wua.getIUserAuditID()))).get(0));
        nwuar.setUsergroups(UserPermissionRequestMapper.parseGroup(groupDescService.findAllById(allMappingInfo.getUserGroup().get(wua.getIUserAuditID()))));
        nwuar.setUsertenants(
                UserPermissionRequestMapper.parseTenant(tenantRepositoryService.findByTenantIds(allMappingInfo.getUserTenant().get(wua.getIUserAuditID()))));

        UserPermissionRequest allOption = new UserPermissionRequest();
        allOption.setLabel("All");
        allOption.setValue(-1);
        List<UserPermissionRequest> all = new ArrayList<>();
        all.add(allOption);
        if (allMappingInfo.getUserWorkflow().get(wua.getIUserAuditID()).getMappingIds().contains(-1)) {
            nwuar.setUserworkflows(all);
        } else {
            nwuar.setUserworkflows(UserPermissionRequestMapper.parseWorkflow(extractWorkflow(allMappingInfo.getUserWorkflow().get(wua.getIUserAuditID()))));
        }

        if (allMappingInfo.getUserClass().get(wua.getIUserAuditID()).getMappingIds().contains(-1)) {
            nwuar.setUserclasses(all);
        } else {
            nwuar.setUserclasses(UserPermissionRequestMapper.parseClass(extractTransClasses(allMappingInfo.getUserClass().get(wua.getIUserAuditID()))));
        }
        nwuar.setAction(wua.getVcAction());
        return nwuar;
    }

    public NewWebUserAuditRequest parse(WebUser wu) {
        NewWebUserAuditRequest nwuar = new NewWebUserAuditRequest();
        nwuar.setUsername(wu.getVcUserName());
//        nwuar.setPassword(wu.getVcPassword());
        nwuar.setEmailid(wu.getVcEmailID());
        nwuar.setContact(wu.getVcContact());
        nwuar.setMobile(wu.getVcMobile());
        nwuar.setProfileimg(wu.getVcProfileImg());
        nwuar.setFirstname(wu.getVcFirstName());
        nwuar.setLastname(wu.getVcLastName());
        nwuar.setAddress(wu.getVcAddress());
        nwuar.setDesignation(wu.getVcDesignation());
         
        AllUsersMapping allMappingInfo = webuserMappingUtil.getWebUserMappings(Arrays.asList(wu.getIuserID()), wu.getIorgId().getIorgid());
                
        nwuar.setUserpermissions(
                UserPermissionRequestMapper.parseRole(roleDescService.findAllById(allMappingInfo.getUserPermissions().get(wu.getIuserID()))).get(0));
        nwuar.setUsergroups(UserPermissionRequestMapper.parseGroup(groupDescService.findAllById(allMappingInfo.getUserGroup().get(wu.getIuserID()))));
        nwuar.setUsertenants(
                UserPermissionRequestMapper.parseTenant(tenantRepositoryService.findByTenantIds(allMappingInfo.getUserTenant().get(wu.getIuserID()))));
        UserPermissionRequest allOption = new UserPermissionRequest();
        allOption.setLabel("All");
        allOption.setValue(-1);
        List<UserPermissionRequest> all = new ArrayList<>();
        all.add(allOption);
        if (allMappingInfo.getUserWorkflow().get(wu.getIuserID()).getMappingIds().contains(-1)) {
            nwuar.setUserworkflows(all);
        } else {
            nwuar.setUserworkflows(UserPermissionRequestMapper.parseWorkflow(extractWorkflow(allMappingInfo.getUserWorkflow().get(wu.getIuserID()))));
        }

        if (allMappingInfo.getUserClass().get(wu.getIuserID()).getMappingIds().contains(-1)) {
            nwuar.setUserclasses(all);
        } else {
            nwuar.setUserclasses(UserPermissionRequestMapper.parseClass(extractTransClasses(allMappingInfo.getUserClass().get(wu.getIuserID()))));
        }
        return nwuar;
    }
}
