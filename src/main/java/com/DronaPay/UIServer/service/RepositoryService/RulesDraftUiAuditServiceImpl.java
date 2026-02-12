package com.DronaPay.UIServer.service.RepositoryService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.RulesDraftUiAudit;
import com.DronaPay.UIServer.repository.RulesDraftUiAuditRepository;

@Service
public class RulesDraftUiAuditServiceImpl implements RulesDraftUiAuditService {

    @Autowired
    private RulesDraftUiAuditRepository rulesDraftAuditRepository;

    @Override
    public void save(RulesDraftUiAudit rl) throws Exception {
        rulesDraftAuditRepository.save(rl);
    }
    
}
