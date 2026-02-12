package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.model.MasterConfigCustom;

public interface MasterConfigCustomService {
    public List<MasterConfigCustom> findAllByParentId(List<Integer> ids) throws Exception;
}
