package com.DronaPay.UIServer.service.RepositoryService;


import com.DronaPay.UIServer.repository.RulesAvailableRepository;
import com.DronaPay.UIServer.model.RulesAvailable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class RulesAvailableServiceImpl implements RulesAvailableService{

    @Autowired
    private RulesAvailableRepository rulesAvailableRepository;

    public List<RulesAvailable> findAllByIDecisionIDActiveAndNotDeleted() throws Exception
    {
        //return rulesAvailableRepository.findAllByIDecisionIDActiveAndNotDeleted();
        return rulesAvailableRepository.findByBactiveTrueAndBdeleteFalse();
    }

    @Override
    public List<String> findRuleTypes() throws Exception {
        
        //return rulesAvailableRepository.findDistinctRuleType();
        List<RulesAvailable> rules = rulesAvailableRepository.findByBactiveTrueAndBdeleteFalse();
        return rules.stream().map(x->x.getVcRuleType()).distinct().collect(Collectors.toList());
    }

    @Override
    public List<RulesAvailable> findAllByIDecisionIDActiveAndNotDeletedAndRuleType() throws Exception {
       //return rulesAvailableRepository.findAllByIDecisionIDActiveAndNotDeleted();
       return rulesAvailableRepository.findByBactiveTrueAndBdeleteFalse();
    }

    public RulesAvailable findById(Integer iRuleAvailableID) throws Exception
    {
        return rulesAvailableRepository.findById(iRuleAvailableID).orElse(null);
    }

    @Override
    public List<String> findRuleLabels() throws Exception { 
        //return rulesAvailableRepository.findDistinctLabel();
        List<RulesAvailable> rulesList = rulesAvailableRepository.findByBactiveTrueAndBdeleteFalse();
        return rulesList.stream().map(x->x.getVcLabel()).distinct().collect(Collectors.toList());
    }

    @Override
    public void save(RulesAvailable ra) throws Exception {
        rulesAvailableRepository.save(ra);
    }


}
