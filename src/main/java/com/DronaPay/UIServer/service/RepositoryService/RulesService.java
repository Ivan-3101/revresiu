package com.DronaPay.UIServer.service.RepositoryService;

import java.util.Deque;
import java.util.List;

import com.DronaPay.UIServer.model.RulesMasters;


public interface RulesService {

    public void save(RulesMasters rules) throws Exception;

    public RulesMasters saveAndGetSavedObject(RulesMasters rules) throws Exception;

    public List<RulesMasters> findAll() throws Exception;

    public List<RulesMasters> findAllByIDecisionID(int iDecisionID) throws Exception;

    public Deque<RulesMasters> getSequenceByiDecisionID(int iDecisionID) throws Exception;


    public Deque<RulesMasters> getSequenceByLastRuleiRuleID(RulesMasters rules, Deque<RulesMasters> res) throws Exception;

    public RulesMasters findLastByIDecisionID(int iDecisionID) throws Exception;

    public RulesMasters findCustomRuleBySuccessRuleAndIDecisionID(int iRuleID, int iDecisionID) throws Exception;

    public RulesMasters findByiRuleID(int iRuleID) throws Exception;

    // default rule methods
    public List<RulesMasters> findAllDefaultRulesByClass(int iDecisionID) throws Exception;

}
