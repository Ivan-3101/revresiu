package com.DronaPay.UIServer.service.RepositoryService;


import com.DronaPay.UIServer.exception.NotFoundException;
import com.DronaPay.UIServer.model.Rules;
import com.DronaPay.UIServer.repository.RulesUIRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.Deque;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@Slf4j
public class RulesTempServiceImpl extends RulesTempService {

    @Autowired
    private RulesUIRepository rulesTempRepository;

    public void save(Rules rules) throws Exception {
        rulesTempRepository.save(rules);
    }

    public Rules saveAndGetSavedObject(Rules rules) throws Exception {
        return rulesTempRepository.save(rules);
    }

    public List<Rules> findAll() throws Exception {
        return rulesTempRepository.findAll();
    }

    public List<Rules> findAllByIDecisionID(int iDecisionID, Integer tenantid) throws Exception {
        //return rulesTempRepository.findAllByIDecisionID(iDecisionID);
        return rulesTempRepository.findByIdecisionIDAndItenantIdAndBcustomTrueAndBdeleteFalse(iDecisionID, tenantid);
    }

    public Rules findByDecisionIDRuleID(Integer iDecisionID, Integer iRuleID) throws Exception {
        List<Rules> ruleList = rulesTempRepository.findByIdecisionIDAndBdeleteFalseAndBactiveTrue(iDecisionID);
        List<Rules> ruleID = ruleList.stream()
                .filter(x ->
                {
                    String vcRuleOrder = x.getVcRuleOrder();
                    ObjectMapper mapper = new ObjectMapper();
                    try {
                        JsonNode ruleorderJSON = mapper.readTree(vcRuleOrder);
                        if (ruleorderJSON != null) {
                            JsonNode successRule = ruleorderJSON.get("SuccessRule");
                            if (successRule != null) {
                                return (successRule.asInt() == iRuleID);
                            } else {
                                return false;
                            }
                        } else {
                            return false;
                        }
                    } catch (JsonProcessingException e) {
                        return false;
                    }
                }).collect(Collectors.toList());

        if (ruleID.size() > 1) {
            throw new SQLException("Multiple matching rule ids found" + iRuleID);
        } else if (ruleID.size() == 0) {
            return null;
        } else {
            return ruleID.get(0);
        }
    }

    public List<Rules> getSequenceByiDecisionID(int iDecisionID, Integer tenantid) throws Exception {
        return rulesTempRepository.findByIdecisionIDAndItenantIdAndBdeleteFalse(iDecisionID, tenantid);
    }

    Deque<Rules> getSequenceByLastRuleiRuleID(Rules rules, Deque<Rules> res, Map<Integer, List<Rules>> mapofrules) throws Exception {
        res.addFirst(rules);
        List<Rules> rule = mapofrules.get(rules.getIRuleID());

        if (rule == null || rule.size() == 0) {
            return res;
        } else if (rule.size() != 1) {
            throw new NotFoundException("more then 1 active rule found for rule id " + rules.getIRuleID(), rules.getIRuleID().toString());
        } else {
            return getSequenceByLastRuleiRuleID(rule.get(0), res, mapofrules);
        }
    }

    public Rules findLastDefaultByIDecisionID(int iDecisionID) throws Exception {
        //return rulesTempRepository.findLastDefaultRuleByIDecisionID(iDecisionID);
        return findByDecisionIDRuleID(iDecisionID, -1);
    }

    public Rules findDefaultRuleBySuccessRuleAndIDecisionID(int iRuleID, int iDecisionID) throws Exception {
        //return rulesTempRepository.findDefaultRuleBySuccessRuleAndIDecisionID(iRuleID, iDecisionID);
        return findByDecisionIDRuleID(iDecisionID, iRuleID);
    }

    public List<Rules> inactiveByDecisionID(int iDecisionID) {
        return rulesTempRepository.findByIdecisionIDAndBdeleteFalseAndBactiveFalse(iDecisionID);
    }

    public Rules findByiRuleID(int iRuleID, Integer tenantid) throws Exception {
        return rulesTempRepository.findById(iRuleID).orElse(null);
    }

    public List<Rules> findAllDefaultRulesByClass(int iDecisionID) throws Exception {

        //return rulesTempRepository.findAllDefaultRulesByIDecisionID(iDecisionID);
        return rulesTempRepository.findByIdecisionIDAndBcustomFalseAndBdeleteFalse(iDecisionID);
    }

    public Integer getCountByIRuleAvailableID(int iRuleAvailableID) throws Exception {
        //return rulesTempRepository.getCountByIRuleAvailableID(iRuleAvailableID);
        return rulesTempRepository.countByIruleAvailableIDAndBdeleteFalse(iRuleAvailableID);
    }

    @Override
    public List<Rules> findAllDefaultByIDecisionID(int iDecisionID, Integer tenantid) throws Exception {
        //return rulesTempRepository.findAllDefaultByIDecisionID(iDecisionID);
        return rulesTempRepository.findByIdecisionIDAndItenantIdAndBdeleteFalse(iDecisionID, tenantid);
    }

    @Override
    public Integer getCountByIRuleAvailableIDAndIDecisionId(int iRuleAvailableID, int iDecisionId) throws Exception {
        //return rulesTempRepository.getCountByIRuleAvailableIDAndIDecisionId(iRuleAvailableID, iDecisionId);
        return rulesTempRepository.countByIruleAvailableIDAndIdecisionIDAndBdeleteFalse(iRuleAvailableID, iDecisionId);
    }

    @Override
    public Rules saveAudit(Rules input) {
        // TODO Auto-generated method stub
        return rulesTempRepository.save(input);
    }

    @Override
    public List<String> findDistinctRuleName() throws Exception {
        // TODO Auto-generated method stub
        //return rulesTempRepository.findAllActiveNonDeletedRuleNames();
        List<Rules> rulesList = rulesTempRepository.findDistinctByBactiveTrueAndBdeleteFalse();
        return rulesList.stream().map(x -> x.getVcRuleName()).distinct().collect(Collectors.toList());
    }

    @Override
    public List<String> findDistinctRuleNameTenant(List<Integer> tenants) throws Exception {
        // TODO Auto-generated method stub
        //return rulesTempRepository.findAllActiveNonDeletedRuleNames();
        log.info("Started query");
        List<Rules> rulesList = rulesTempRepository.findAllByBactiveTrueAndBdeleteFalseAndItenantIdIn(tenants);
        log.info("query end");
        return rulesList.stream().map(x -> x.getVcRuleName()).distinct().collect(Collectors.toList());
    }

    @Override
    public Rules findRuleForQueryExecution(Integer iRuleId) throws Exception {
        return rulesTempRepository.findByiRuleIDAndBactiveTrueAndBapicallTrue(iRuleId);
    }

}
