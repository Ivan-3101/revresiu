package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.VOMapper.RulesDraftUiMapper;
import com.DronaPay.UIServer.model.RulesDraftUi;
import com.DronaPay.UIServer.repository.RulesDraftUiRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RulesDraftUiServiceImpl implements RulesDraftUiService {

    @Autowired
    private RulesDraftService rulesDraftService;

    @Autowired
    private RulesDraftUiAuditService rulesDraftUiAuditService;

    @Autowired
    private RulesDraftUiRepository rulesDraftUiRepository;

    @Override
    @Transactional
    public RulesDraftUi save(RulesDraftUi rl) throws Exception {
        rulesDraftService.save(RulesDraftUiMapper.parseToMaster(rl));
        RulesDraftUi temp = rulesDraftUiRepository.save(rl);
        rulesDraftUiAuditService.save(RulesDraftUiMapper.parse(temp));
        return temp;

    }

    @Override
    public List<RulesDraftUi> findAllActiveNonDeleted() throws Exception {
        return rulesDraftUiRepository.findByBactiveTrueAndBdeleteFalse();
    }

    @Override
    public RulesDraftUi findById(Integer id) throws Exception {
        return rulesDraftUiRepository.getReferenceById(id);
    }

    @Override
    public List<RulesDraftUi> findAllActiveNonDeletedByTenant(Integer tenantId) throws Exception {
        return rulesDraftUiRepository.findByBactiveTrueAndBdeleteFalseAndItenantId(tenantId);
    }

}
