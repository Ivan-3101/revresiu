package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.GroupDesc;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GroupDescRepository extends JpaRepository<GroupDesc, Integer> {
    public GroupDesc findByVcGroupIDAndItenantId(String id, Integer tenantid);

    public GroupDesc findByIgroupIDAndItenantId(Integer groupid, Integer tenantid);

    public List<GroupDesc> findByVcGroupTypeNot(String type);

    public List<GroupDesc> findAllByVcGroupIDIn(List<String> group_ids);

    public List<GroupDesc> findAllByVcGroupIDInAndItenantId(List<String> group_ids, Integer itenantid);

    public List<GroupDesc> findAllByItenantIdInAndVcGroupType(List<Integer> tenantids, String type);

    public List<GroupDesc> findAllByIgroupIDInAndItenantIdIn(List<Integer> groupids, List<Integer> tenantids);

}
