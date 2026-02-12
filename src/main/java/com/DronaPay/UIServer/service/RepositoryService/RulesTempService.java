package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.Rules;
import com.DronaPay.UIServer.service.Audit;

import java.util.List;

public abstract class RulesTempService implements Audit<Rules> {

    abstract void save(Rules rules) throws Exception;

    abstract Rules saveAndGetSavedObject(Rules rules) throws Exception;

    abstract List<Rules> findAll() throws Exception;

    abstract List<Rules> findAllByIDecisionID(int iDecisionID, Integer tenantid) throws Exception;

    abstract List<Rules> findAllDefaultByIDecisionID(int iDecisionID, Integer tenantid) throws Exception;

    abstract List<Rules> getSequenceByiDecisionID(int iDecisionID, Integer tenantid) throws Exception;

    abstract Rules findLastDefaultByIDecisionID(int iDecisionID) throws Exception;

    abstract Rules findDefaultRuleBySuccessRuleAndIDecisionID(int iRuleID, int iDecisionID) throws Exception;

    abstract Rules findByiRuleID(int iRuleID, Integer tenantid) throws Exception;

    // default rule methods
    abstract List<Rules> findAllDefaultRulesByClass(int iDecisionID) throws Exception;

    abstract Integer getCountByIRuleAvailableID(int iRuleAvailableID) throws Exception;

    abstract Integer getCountByIRuleAvailableIDAndIDecisionId(int iRuleAvailableID, int iDecisionId) throws Exception;

    abstract List<String> findDistinctRuleName() throws Exception;

    abstract List<String> findDistinctRuleNameTenant(List<Integer> tenant) throws Exception;

    abstract Rules findRuleForQueryExecution(Integer iRuleId) throws Exception;

}
