package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.GroupToTaskFilterMap;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GroupToTaskFilterMapRepository extends JpaRepository<GroupToTaskFilterMap, Integer> {

    // @Query("SELECT distinct m FROM GroupToTaskFilterMap m where m.iGroupID.iGroupID in :listigroupid")
    // public List<GroupToTaskFilterMap> findAllByIGroupID(@Param("listigroupid") List<Integer> listofgroupid);

    public List<GroupToTaskFilterMap> findByIgroupIDInAndItenantIdIn(List<Integer> listofgroupid, List<Integer> tenantid);
}
