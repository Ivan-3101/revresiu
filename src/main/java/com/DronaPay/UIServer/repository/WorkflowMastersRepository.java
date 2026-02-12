package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.WorkflowMasters;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface WorkflowMastersRepository extends JpaRepository<WorkflowMasters, Integer> {

    public WorkflowMasters findByWorkflowKey(String key);


    public WorkflowMasters findByWorkflowKeyAndItenantId_Itenantid(String key, Integer tenantid);

    public Optional<WorkflowMasters> findByWorkflowNameAndItenantId_Itenantid(String name, Integer tenantid);

    public List<WorkflowMasters> findAllByWorkflowKey(String workflowkey);

    public List<WorkflowMasters> findByIsFilterDisplayTrue();

    public List<WorkflowMasters> findByIsManualCreationTrue();

    public WorkflowMasters findByWorkflowIdAndItenantId_Itenantid(Integer workflowid, Integer tenantid);

    public List<WorkflowMasters> findAllByItenantId_ItenantidAndIsManualCreationTrue(Integer tenant);

    public List<WorkflowMasters> findAllByItenantId_ItenantidAndWorkflowIdInAndIsManualCreationTrue(Integer tenant, List<Integer> workflowids);

    public List<WorkflowMasters> findAllByItenantId_ItenantidInAndAndWorkflowIdIn(
            List<Integer> tenants, List<Integer> workflows
    );

    public List<WorkflowMasters> findAllByItenantId_ItenantidInAndWorkflowIdIn(
            List<Integer> tenants, List<Integer> workflows
    );

    public List<WorkflowMasters> findAllByItenantId_ItenantidIn(List<Integer> tenantids);


    public List<WorkflowMasters> findAllByWorkflowKeyAndItenantId_Itenantid(String workflowkey, Integer tenatid);


}
