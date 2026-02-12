package com.DronaPay.UIServer.service.RepositoryService;
import java.util.List;

import com.DronaPay.UIServer.model.MasterConfig;

public interface MasterConfigService {
    public List<MasterConfig> findAllByName(List<String> name) throws Exception;
}
