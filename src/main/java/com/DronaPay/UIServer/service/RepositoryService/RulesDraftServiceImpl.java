package com.DronaPay.UIServer.service.RepositoryService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.RulesDraft;
import com.DronaPay.UIServer.repository.RulesDraftRepository;

@Service
public class RulesDraftServiceImpl implements RulesDraftService {

    @Autowired
    private RulesDraftRepository rulesDraftRepository;
    
    @Override
    public void save(RulesDraft rl) throws Exception {
        rulesDraftRepository.save(rl);
    }
    
}
