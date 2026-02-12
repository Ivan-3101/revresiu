package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.ProfileParamsConfig;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;


public interface ProfileParametersRepository extends JpaRepository<ProfileParamsConfig, Integer> {

    //    @Query("select ppc.parameterName from ProfileParamsConfig ppc where " +
//            "ppc.workflowID in (select wm.workflowId from WorkflowMasters wm where wm.workflowKey = :workflowKey and wm.itenantId.itenantid = :tenantid ) " +
//            "and ppc.type = :type and ppc.itenantId = :tenantid")
    public List<ProfileParamsConfig> findAllByWorkflowIDAndTypeAndItenantId(Integer workflowid, String type, Integer itenantid) throws Exception;
}
