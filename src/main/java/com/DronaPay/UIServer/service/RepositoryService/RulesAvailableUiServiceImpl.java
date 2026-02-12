package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.VOMapper.RulesAvailableUiMapper;
import com.DronaPay.UIServer.model.RulesAvailableUi;
import com.DronaPay.UIServer.repository.RulesAvailableUiRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RulesAvailableUiServiceImpl implements RulesAvailableUiService {

    @Autowired
    private RulesAvailableUiRepository rulesAvailableUiRepository;

    @Autowired
    private RulesAvailableUiAuditService rulesAvailableAuditService;

    @Autowired
    private RulesAvailableService rulesAvailableService;

    @Override
    public List<RulesAvailableUi> findAllActiveNonDeleted() throws Exception {
        return rulesAvailableUiRepository.findByBactiveTrueAndBdeleteFalse();
    }

    @Override
    public List<RulesAvailableUi> findAllActiveNonDeletedTenant(Integer tenantid) {
        List<RulesAvailableUi> rulesTent = rulesAvailableUiRepository.findByBactiveTrueAndBdeleteFalseAndItenantId(tenantid);
        List<RulesAvailableUi> rulesNull = rulesAvailableUiRepository.findByBactiveTrueAndBdeleteFalseAndItenantIdIsNull();
        rulesTent.addAll(rulesNull);
        return rulesTent;
    }

    @Override
    @Transactional
    public RulesAvailableUi save(RulesAvailableUi rl) throws Exception {
        rulesAvailableService.save(RulesAvailableUiMapper.parseToMaster(rl));
        RulesAvailableUi temp = rulesAvailableUiRepository.save(rl);
        rulesAvailableAuditService.save(RulesAvailableUiMapper.parse(temp));
        return temp;
    }

    @Override
    public RulesAvailableUi findById(Integer id) throws Exception {
        return rulesAvailableUiRepository.getReferenceById(id);
    }

}
