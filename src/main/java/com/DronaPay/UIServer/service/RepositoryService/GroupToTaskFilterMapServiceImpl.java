package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.GroupToTaskFilterMap;
import com.DronaPay.UIServer.repository.GroupToTaskFilterMapRepository;
import com.DronaPay.UIServer.util.UserMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GroupToTaskFilterMapServiceImpl implements GroupToTaskFilterMapService {

    @Autowired
    private GroupToTaskFilterMapRepository groupToTaskFilterMapRepository;

    public List<GroupToTaskFilterMap> findAllByIGroupIDAndTenantID(UserMapping userMapping) throws Exception {
        return groupToTaskFilterMapRepository.findByIgroupIDInAndItenantIdIn(userMapping.getMappingIds(), userMapping.getTenantids());
    }
}
