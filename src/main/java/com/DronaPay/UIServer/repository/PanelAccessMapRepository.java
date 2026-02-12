package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.PanelAccessMap;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PanelAccessMapRepository extends JpaRepository<PanelAccessMap, Integer> {

    // @Query("SELECT wua FROM PanelAccessMap wua WHERE wua.userGroup.iGroupID IN (:igroupid) AND wua.workflowMasters.workflowName = :workflowname ")
    // public List<PanelAccessMap> getBYGroupAndWorkflowName(@Param("igroupid") List<Integer> groupId,@Param("workflowname") String worflowname);
//    public List<PanelAccessMap> findByUserGroupInAndWorkflowMasters_WorkflowNameAndWorkflowMasters_ItenantId_Itenantid(List<Integer> groupId, String workflowname, Integer tenantid);


    //    @Query("SELECT wua FROM PanelAccessMap wua WHERE wua.userGroup IN (:groupId) AND wua.workflowMasters in (select ws.workflowId from WorkflowMasters ws where ws.workflowName = :workflowname and ws.itenantId.itenantid =:tenantid)  and  wua.itenantId = :tenantid ")
    public List<PanelAccessMap> findALlByUserGroupInAndWorkflowMastersAndItenantId(List<Integer> groupId, Integer workflowname, Integer tenantid);

//    @Query("SELECT wua FROM PanelAccessMap wua WHERE wua.userGroup IN (:igroupid) AND wua.workflowMasters in (select ws.workflowId from WorkflowMasters ws where ws.workflowName = :workflowname) ")
//    public List<PanelAccessMap> findByUserGroupInAndAndItenantIdIn(List<Integer> groupId, List<Integer> tenantID);


//    @Query("select distinct ws.workflowName from WorkflowMasters ws where  ws.workflowId in " +
//            "(SELECT wua.workflowMasters FROM PanelAccessMap wua WHERE wua.userGroup IN (:groupId) AND wua.itenantId in (:tenantID))" +
//            "and ws.itenantId.itenantid in (:tenantID) ")
//    public List<String> findByUserGroupInAndAndItenantIdIn(List<Integer> groupId, List<Integer> tenantID);

    public List<PanelAccessMap> findAllByUserGroupInAndItenantIdIn(List<Integer> groupId, List<Integer> tenantID);


}
