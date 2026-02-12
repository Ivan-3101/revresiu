package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.GroupDesc;
import com.DronaPay.UIServer.model.WebuserMapping;
import com.DronaPay.UIServer.model.WebuserMappingAudit;
import com.DronaPay.UIServer.repository.GroupDescRepository;
import com.DronaPay.UIServer.util.UserMapping;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class GroupDescServiceImpl implements GroupDescService {

    @Autowired
    private GroupDescRepository groupDescRepository;

    public List<GroupDesc> findAll() throws Exception {
        return groupDescRepository.findByVcGroupTypeNot("INTERNAL");
    }

    public void save(GroupDesc gd) throws Exception {
        groupDescRepository.save(gd);
    }

    public GroupDesc findByiGroupID(int value) {
        return groupDescRepository.getById(value);
    }

    public GroupDesc findByVcGroupID(String id, Integer tenantid) {
        return groupDescRepository.findByVcGroupIDAndItenantId(id, tenantid);
    }

    // @Cacheable("usergroupbyid")
    public List<GroupDesc> findAllById(UserMapping mapping) {
        return groupDescRepository.findAllByIgroupIDInAndItenantIdIn(mapping.getMappingIds(), mapping.getTenantids());
    }

    @Override
    public List<GroupDesc> findAllByTenantIds(List<Integer> tenantids) {
        return groupDescRepository.findAllByItenantIdInAndVcGroupType(tenantids, "WORKFLOW");
    }

    public Map<Integer, GroupDesc> findAllMap() {
        return groupDescRepository.findAll().stream().collect(Collectors.toMap(GroupDesc::getIgroupID, Function.identity()));
    }

    @Override
    public List<GroupDesc> findByWebuserMapping(List<WebuserMapping> webuserMappingList) throws Exception{
        return webuserMappingList.stream()
                .map(webUserMapping -> {
                    try {
                        return findByGroupID(webUserMapping.getMappingID(), webUserMapping.getItenantId());
                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }
                })
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
    }

    @Override
    public List<GroupDesc> findByWebuserMappingAudit(List<WebuserMappingAudit> webuserMappingAuditList) throws Exception{
        return webuserMappingAuditList.stream()
                .map(audit -> {
                    try {
                        return findByGroupID(audit.getMappingID(), audit.getItenantId());
                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }
                })
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
    }

    @Override
    @Cacheable(value = "GROUPDESC", key = "#groupId + '_' + #tenantId", unless = "#result == null")
    public GroupDesc findByGroupID(Integer groupid, Integer tenantid) throws Exception{
        return groupDescRepository.findByIgroupIDAndItenantId(groupid,tenantid);
    }
}
