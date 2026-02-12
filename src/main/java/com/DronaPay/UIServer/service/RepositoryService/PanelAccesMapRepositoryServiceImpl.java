package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.PanelAccessMap;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.repository.PanelAccessMapRepository;
import com.DronaPay.UIServer.util.UserMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PanelAccesMapRepositoryServiceImpl implements PanelAccesMapRepositoryService {

    @Autowired
    private PanelAccessMapRepository panelAccessMapRepository;

    @Autowired
    private WorkflowMasterService workflowMasterService;

    @Override
    public List<PanelAccessMap> findByGroupandWorkflowName(List<Integer> groupId, String worflowname, Integer itenantid, WebUser loggedinuser) throws Exception {
        //return panelAccessMapRepository.getBYGroupAndWorkflowName(groupId, worflowname);
        Integer workflowid = workflowMasterService.findByWorkflowNameAndTenantId(worflowname, itenantid, loggedinuser).getWorkflowId();

        return panelAccessMapRepository.findALlByUserGroupInAndWorkflowMastersAndItenantId(groupId, workflowid, itenantid);
    }


    @Override
    public List<PanelAccessMap> findAllByUserGroupInAndItenantIdIn(UserMapping userMapping) throws Exception {
        //return panelAccessMapRepository.getBYGroupAndWorkflowName(groupId, worflowname);
        return panelAccessMapRepository.findAllByUserGroupInAndItenantIdIn(userMapping.getMappingIds(), userMapping.getTenantids());
    }

}
