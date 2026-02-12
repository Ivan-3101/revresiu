package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.PanelAccessMap;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.util.UserMapping;

import java.util.List;

public interface PanelAccesMapRepositoryService {

    public List<PanelAccessMap> findByGroupandWorkflowName(List<Integer> groupId, String worflowname, Integer tenantid, WebUser loggedinuser) throws Exception;

    public List<PanelAccessMap> findAllByUserGroupInAndItenantIdIn(UserMapping userMapping) throws Exception;

}
