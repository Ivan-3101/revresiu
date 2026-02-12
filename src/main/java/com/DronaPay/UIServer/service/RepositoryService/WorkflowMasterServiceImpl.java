package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.exception.NotFoundException;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.model.WorkflowMasters;
import com.DronaPay.UIServer.repository.WorkflowMastersRepository;
import com.DronaPay.UIServer.util.UserMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WorkflowMasterServiceImpl implements WorkflowMasterService {
    @Autowired
    private WorkflowMastersRepository workflowMastersRepository;


    public List<WorkflowMasters> findAll() throws Exception {
        return workflowMastersRepository.findByIsFilterDisplayTrue();
    }

    public List<WorkflowMasters> findAllManualCreation() throws Exception {
        return workflowMastersRepository.findByIsManualCreationTrue();
    }

    @Override
    public WorkflowMasters findByWorkflowID(Integer workflowid, Integer tenantid) throws Exception {
        // TODO Auto-generated method stub
        return workflowMastersRepository.findByWorkflowIdAndItenantId_Itenantid(workflowid, tenantid);
    }


    @Override
    public List<WorkflowMasters> findAllByTenantsAndWorkflows(List<Integer> tenants, List<Integer> workflows) {
        return workflowMastersRepository.findAllByItenantId_ItenantidInAndWorkflowIdIn(tenants, workflows);
    }

    @Override
    @Cacheable("userworkflowsbytenant")
    public List<WorkflowMasters> findAllByTenants(List<Integer> tenants) {
        return workflowMastersRepository.findAllByItenantId_ItenantidIn(tenants);
    }

    @Override
    @Cacheable("userworkflowsbyid")
    public List<WorkflowMasters> findByWorkflowIDs(UserMapping mappings) {
        return workflowMastersRepository.findAllByItenantId_ItenantidInAndAndWorkflowIdIn(mappings.getTenantids(), mappings.getMappingIds());
    }

    @Override
    public List<WorkflowMasters> findAllManualTenant(Integer tenant) {
        return workflowMastersRepository.findAllByItenantId_ItenantidAndIsManualCreationTrue(tenant);
    }

    @Override
    public List<WorkflowMasters> findAllManualTenantWorkflow(Integer tenant, List<Integer> workflowids) {
        return workflowMastersRepository.findAllByItenantId_ItenantidAndIsManualCreationTrue(tenant);
    }

    @Override
    public Integer findWorkflowTenantId(String key) {
        return workflowMastersRepository.findByWorkflowKey(key).getItenantId().getItenantid();
    }

    @Override
    public WorkflowMasters findByWorkflowKeyAndTenantId(String key, Integer tenantid) {
        return workflowMastersRepository.findByWorkflowKeyAndItenantId_Itenantid(key, tenantid);
    }


    public WorkflowMasters findByWorkflowNameAndTenantId(String name, Integer tenantid, WebUser loggedinuser) {
        return workflowMastersRepository.findByWorkflowNameAndItenantId_Itenantid(name, tenantid)
                .orElseThrow(() -> new NotFoundException("failed to find workflow with name " + name + " and tenantid " + tenantid, loggedinuser, " name " + name + " and tenantid " + tenantid));
    }


}
