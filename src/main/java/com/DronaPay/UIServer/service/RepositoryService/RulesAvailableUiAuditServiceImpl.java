package com.DronaPay.UIServer.service.RepositoryService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.RulesAvailableUiAudit;
import com.DronaPay.UIServer.repository.RulesAvailableUiAuditRepository;

@Service
public class RulesAvailableUiAuditServiceImpl implements RulesAvailableUiAuditService {

    @Autowired
    private RulesAvailableUiAuditRepository rulesAuditRepository;

    @Override
    public void save(RulesAvailableUiAudit rl) throws Exception {
        rulesAuditRepository.save(rl);
    }
    
}
