package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.MasterConfigCustom;
import com.DronaPay.UIServer.repository.MasterConfigCustomRepo;

@Service
public class MasterConfigCustomServiceImpl implements MasterConfigCustomService {
    
    @Autowired
    private MasterConfigCustomRepo masterConfigCustomRepo;

    @Override
    public List<MasterConfigCustom> findAllByParentId(List<Integer> ids) throws Exception {
        return masterConfigCustomRepo.findByIparentId_IconfigIdInAndBdeleteFalse(ids);
    }
    
}
