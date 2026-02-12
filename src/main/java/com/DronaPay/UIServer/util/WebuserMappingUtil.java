package com.DronaPay.UIServer.util;

import com.DronaPay.UIServer.Constants.Enum.WebuserMappingType;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.repository.WebuserMappingAuditRepository;
import com.DronaPay.UIServer.repository.WebuserMappingRepository;
import com.DronaPay.UIServer.requests.UserPermissionRequest;
import com.DronaPay.UIServer.service.RepositoryService.WebuserMappingAuditService;
import com.DronaPay.UIServer.service.RepositoryService.WebuserMappingService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.stream.Collectors;

@Service
public class WebuserMappingUtil {

    @Autowired
    private WebuserMappingRepository webuserMappingService;

    @Autowired
    private WebuserMappingAuditRepository webuserMappingAuditService;



    public List<WebuserMappingAudit> getWebuserMappingClassAudit(List<UserPermissionRequest> classes,
            List<Integer> tenants) {
        if (classes.stream().map(wfl -> wfl.getValue()).toList().contains(-1)) {
            return tenants.stream().map(a -> {
                WebuserMappingAudit webuserMapping = new WebuserMappingAudit();
                webuserMapping.setMappingType(String.valueOf(WebuserMappingType.TransactionClass));
                webuserMapping.setMappingID(-1);
                webuserMapping.setItenantId(a);
                return webuserMapping;
            }).collect(Collectors.toList());
        } else {
            return classes.stream().map(a -> {
                WebuserMappingAudit webuserMapping = new WebuserMappingAudit();
                webuserMapping.setMappingType(String.valueOf(WebuserMappingType.TransactionClass));
                webuserMapping.setMappingID(a.getValue());
                webuserMapping.setItenantId(a.getItenantId());
                return webuserMapping;
            }).collect(Collectors.toList());
        }
    }

    public List<WebuserMappingAudit> getWebuserMappingTenantsAudit(List<Integer> tenants) {
        return tenants.stream().map(a -> {
            WebuserMappingAudit webuserMapping = new WebuserMappingAudit();
            webuserMapping.setMappingType(String.valueOf(WebuserMappingType.Tenant));
            webuserMapping.setMappingID(a);
            webuserMapping.setItenantId(a);
            return webuserMapping;
        }).collect(Collectors.toList());
    }

    public List<WebuserMappingAudit> getWebuserMappingWorkflowsAudit(List<UserPermissionRequest> workflows,
            List<Integer> tenants) {
        if (workflows.stream().map(wfl -> wfl.getValue()).toList().contains(-1)) {
            return tenants.stream().map(a -> {
                WebuserMappingAudit webuserMapping = new WebuserMappingAudit();
                webuserMapping.setMappingType(String.valueOf(WebuserMappingType.Workflow));
                webuserMapping.setMappingID(-1);
                webuserMapping.setItenantId(a);
                return webuserMapping;
            }).collect(Collectors.toList());
        } else {
            return workflows.stream().map(a -> {
                WebuserMappingAudit webuserMapping = new WebuserMappingAudit();
                webuserMapping.setMappingType(String.valueOf(WebuserMappingType.Workflow));
                webuserMapping.setMappingID(a.getValue());
                webuserMapping.setItenantId(a.getItenantId());
                return webuserMapping;
            }).collect(Collectors.toList());
        }
    }

    public List<WebuserMappingAudit> getWebuserMappingAuditGroups(List<UserPermissionRequest> groupDescs) {

        return groupDescs.stream().map(a -> {
            WebuserMappingAudit webuserMapping = new WebuserMappingAudit();
            webuserMapping.setMappingType(String.valueOf(WebuserMappingType.Group));
            webuserMapping.setMappingID(a.getValue());
            webuserMapping.setItenantId(a.getItenantId());
            return webuserMapping;
        }).collect(Collectors.toList());
    }

    public List<WebuserMappingAudit> getWebuserMappingAuditRoles(UserPermissionRequest rD) {
        WebuserMappingAudit webuserMapping = new WebuserMappingAudit();
        webuserMapping.setMappingType(String.valueOf(WebuserMappingType.Role));
        webuserMapping.setMappingID(rD.getValue());
        webuserMapping.setItenantId(rD.getItenantId());
        return Arrays.asList(webuserMapping);
    }

    public List<WebuserMappingAudit> getWebuserMappingAuditAll(UserPermissionRequest roleDescs,
            List<UserPermissionRequest> groupDescs,
            List<UserPermissionRequest> workflows, List<UserPermissionRequest> classes, List<Integer> tenants,
            WebUserAudit webUserAudit) {
        List<WebuserMappingAudit> webuserMappingList = new ArrayList<>();
        webuserMappingList.addAll(getWebuserMappingAuditGroups(groupDescs));
        webuserMappingList.addAll(getWebuserMappingAuditRoles(roleDescs));
        webuserMappingList.addAll(getWebuserMappingWorkflowsAudit(workflows, tenants));
        webuserMappingList.addAll(getWebuserMappingTenantsAudit(tenants));
        webuserMappingList.addAll(getWebuserMappingClassAudit(classes, tenants));
        return webuserMappingList;
    }

    public UserMapping mappingHelperAudit(List<WebuserMappingAudit> mapping, String mappingType) {
        UserMapping uMap = new UserMapping();
        uMap.setMappingIds(mapping.stream().filter(wbmp -> wbmp.getMappingType().equals(mappingType))
                .map(wbmp -> wbmp.getMappingID()).toList());
        uMap.setTenantids(mapping.stream().filter(wbmp -> wbmp.getMappingType().equals(mappingType))
                .map(wbmp -> wbmp.getItenantId()).toList());
        return uMap;
    }

    public UserMapping mappingHelper(List<WebuserMapping> mapping, String mappingType) {
        UserMapping uMap = new UserMapping();
        uMap.setMappingIds(mapping.stream().filter(wbmp -> wbmp.getMappingType().equals(mappingType))
                .map(wbmp -> wbmp.getMappingID()).toList());
        uMap.setTenantids(mapping.stream().filter(wbmp -> wbmp.getMappingType().equals(mappingType))
                .map(wbmp -> wbmp.getItenantId()).toList());
        return uMap;
    }

    public AllUsersMapping getWebUserMappings(List<Integer> userid, Integer iorgid) {
        AllUsersMapping mappingInfo = new AllUsersMapping();
        mappingInfo.setUserClass(new HashMap<>());
        mappingInfo.setUserTenant(new HashMap<>());
        mappingInfo.setUserWorkflow(new HashMap<>());
        mappingInfo.setUserPermissions(new HashMap<>());
        mappingInfo.setUserGroup(new HashMap<>());

        Map<Integer, List<WebuserMapping>> allmappings = webuserMappingService
                .findAllByWebuserIDInAndIorgId(userid, iorgid)
                .stream()
                .collect(Collectors.groupingBy(WebuserMapping::getWebuserID));

        for (Map.Entry<Integer, List<WebuserMapping>> entry : allmappings.entrySet()) {
            Integer iuserid = entry.getKey();
            mappingInfo.getUserPermissions().put(iuserid,
                    mappingHelper(entry.getValue(), String.valueOf(WebuserMappingType.Role)));
            mappingInfo.getUserClass().put(iuserid,
                    mappingHelper(entry.getValue(), String.valueOf(WebuserMappingType.TransactionClass)));
            mappingInfo.getUserWorkflow().put(iuserid,
                    mappingHelper(entry.getValue(), String.valueOf(WebuserMappingType.Workflow)));
            mappingInfo.getUserGroup().put(iuserid,
                    mappingHelper(entry.getValue(), String.valueOf(WebuserMappingType.Group)));
            mappingInfo.getUserTenant().put(iuserid, entry.getValue().stream().filter(a -> a.getMappingType()
                    .equals(String.valueOf(WebuserMappingType.Tenant)))
                    .map(a -> a.getMappingID())
                    .collect(Collectors.toList()));
        }

        return mappingInfo;

    }

    public AllUsersMapping getWebUserAuditMappings(List<Integer> userid, Integer iorgid) {
        AllUsersMapping mappingInfo = new AllUsersMapping();
        mappingInfo.setUserClass(new HashMap<>());
        mappingInfo.setUserTenant(new HashMap<>());
        mappingInfo.setUserWorkflow(new HashMap<>());
        mappingInfo.setUserPermissions(new HashMap<>());
        mappingInfo.setUserGroup(new HashMap<>());

        Map<Integer, List<WebuserMappingAudit>> allmappings = webuserMappingAuditService
                .findAllByWebUserAuditIDInAndIorgId(userid, iorgid)
                .stream()
                .collect(Collectors.groupingBy(WebuserMappingAudit::getWebUserAuditID));

        for (Map.Entry<Integer, List<WebuserMappingAudit>> entry : allmappings.entrySet()) {
            Integer iuserid = entry.getKey();
            mappingInfo.getUserPermissions().put(iuserid,
                    mappingHelperAudit(entry.getValue(), String.valueOf(WebuserMappingType.Role)));
            mappingInfo.getUserClass().put(iuserid,
                    mappingHelperAudit(entry.getValue(), String.valueOf(WebuserMappingType.TransactionClass)));
            mappingInfo.getUserWorkflow().put(iuserid,
                    mappingHelperAudit(entry.getValue(), String.valueOf(WebuserMappingType.Workflow)));
            mappingInfo.getUserGroup().put(iuserid,
                    mappingHelperAudit(entry.getValue(), String.valueOf(WebuserMappingType.Group)));
            mappingInfo.getUserTenant().put(iuserid, entry.getValue().stream().filter(a -> a.getMappingType()
                    .equals(String.valueOf(WebuserMappingType.Tenant)))
                    .map(a -> a.getMappingID())
                    .collect(Collectors.toList()));
        }

        return mappingInfo;

    }

}
