package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.MasterConfig;
import com.DronaPay.UIServer.repository.MasterConfigRepo;

@Service
public class MasterConfigServiceImpl implements MasterConfigService{

    @Autowired
    MasterConfigRepo masterConfigRepo;

    @Override
    public List<MasterConfig> findAllByName(List<String> name) throws Exception {
       return masterConfigRepo.findByConfigNameInAndBdeleteFalse(name);
    }
}
