package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.model.WorkflowMasters;
import com.DronaPay.UIServer.util.UserMapping;

import java.util.List;

public interface WorkflowMasterService {

    public Integer findWorkflowTenantId(String key);

    public List<WorkflowMasters> findAllManualCreation() throws Exception;

    public List<WorkflowMasters> findAllManualTenant(Integer tenant) throws Exception;

    public List<WorkflowMasters> findAll() throws Exception;

    public WorkflowMasters findByWorkflowID(Integer workflowid, Integer tenantid) throws Exception;

    public List<WorkflowMasters> findByWorkflowIDs(UserMapping userMapping);

    public List<WorkflowMasters> findAllByTenants(List<Integer> tenants);

    public List<WorkflowMasters> findAllByTenantsAndWorkflows(List<Integer> tenants, List<Integer> workflows);

    

    public List<WorkflowMasters> findAllManualTenantWorkflow(Integer tenant, List<Integer> workflowids);

    public WorkflowMasters findByWorkflowKeyAndTenantId(String key, Integer tenantid);

    public WorkflowMasters findByWorkflowNameAndTenantId(String name, Integer tenantid, WebUser loggedinuser);


}
