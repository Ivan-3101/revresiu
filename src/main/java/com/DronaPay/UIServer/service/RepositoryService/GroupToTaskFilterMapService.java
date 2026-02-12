package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.GroupToTaskFilterMap;
import com.DronaPay.UIServer.util.UserMapping;

import java.util.List;

public interface GroupToTaskFilterMapService {

    public List<GroupToTaskFilterMap> findAllByIGroupIDAndTenantID(UserMapping tenantid) throws Exception;
}
