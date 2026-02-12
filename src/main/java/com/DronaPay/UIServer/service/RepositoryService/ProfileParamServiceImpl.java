package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.WorkflowMasters;
import com.DronaPay.UIServer.repository.ProfileParametersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProfileParamServiceImpl implements ProfileParamsService {

    @Autowired
    private ProfileParametersRepository profileParamsRepo;

    @Autowired
    private WorkflowMasterService workflowMasterService;

    @Override
    public List<String> findByWorkflowAndType(String workflowkey, String type, Integer tenatid) throws Exception {

        WorkflowMasters workflow = workflowMasterService.findByWorkflowKeyAndTenantId(workflowkey, tenatid);
        return profileParamsRepo.findAllByWorkflowIDAndTypeAndItenantId(workflow.getWorkflowId(), type, tenatid).stream().map(x->x.getParameterName()).toList();
    }

}
