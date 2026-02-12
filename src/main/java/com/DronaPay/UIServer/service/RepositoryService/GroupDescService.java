package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.GroupDesc;
import com.DronaPay.UIServer.model.WebuserMapping;
import com.DronaPay.UIServer.model.WebuserMappingAudit;
import com.DronaPay.UIServer.util.UserMapping;

import java.util.List;
import java.util.Map;

public interface GroupDescService {

    public List<GroupDesc> findAll() throws Exception;

    public void save(GroupDesc gd) throws Exception;

    public GroupDesc findByiGroupID(int value) throws Exception;

    public GroupDesc findByVcGroupID(String id, Integer tenantid) throws Exception;

    public List<GroupDesc> findAllById(UserMapping userMapping);

    public List<GroupDesc> findAllByTenantIds(List<Integer> tenantids);

    Map<Integer, GroupDesc> findAllMap();

    public List<GroupDesc> findByWebuserMapping(List<WebuserMapping> webuserMappingList) throws Exception;

    public List<GroupDesc> findByWebuserMappingAudit(List<WebuserMappingAudit> webuserMappingAuditList) throws Exception;

    public GroupDesc findByGroupID(Integer groupid, Integer tenantid) throws Exception;
}
