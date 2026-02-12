package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.exception.NotFoundException;
import com.DronaPay.UIServer.model.RulesAudit;
import com.DronaPay.UIServer.repository.RuleAuditRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.Deque;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class RulesTempAuditServiceImpl extends RuleTempAuditService {

    @Autowired
    private RuleAuditRepository ruleTempAuditRepository;

    @Override
    public RulesAudit saveAudit(RulesAudit input) {

        return ruleTempAuditRepository.save(input);
    }

    @Override
    public Integer getCountByIRuleAvailableIDAndIDecisionId(int iRuleAvailableID, int iDecisionId) throws Exception {

        //return ruleTempAuditRepository.getCountByIRuleAvailableIDAndIDecisionId(iRuleAvailableID, iDecisionId);
        return ruleTempAuditRepository.countByIruleAvailableIDAndIdecisionIDAndBdeleteFalseAndBclosedFalseAndIstatusIsNull(iRuleAvailableID, iDecisionId);
    }


    public RulesAudit findByDecisionIDRuleID(List<RulesAudit> ruleList, Integer iRuleID) throws Exception {

        List<RulesAudit> ruleID = ruleList
                .stream()
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

    public List<RulesAudit> getSequenceByiDecisionID(int iDecisionID, Integer tenantid) throws Exception {
        return ruleTempAuditRepository.findByIdecisionIDAndItenantIdAndBdeleteFalseAndBclosedFalse(iDecisionID, tenantid);
    }

    public List<RulesAudit> inactiveByDecisionID(int iDecisionID) {
        return ruleTempAuditRepository.findByIdecisionIDAndBdeleteFalseAndBclosedFalseAndBactiveFalse(iDecisionID);
    }

    Deque<RulesAudit> getSequenceByLastRuleiRuleID(RulesAudit rules, Deque<RulesAudit> res, Map<Integer, List<RulesAudit>> mapofrules) throws Exception {
        res.addFirst(rules);
        List<RulesAudit> rule = mapofrules.get(rules.getIRuleIDAudit());
        if (rule == null || rule.size() == 0) {
            return res;
        } else if (rule.size() != 1) {
            throw new NotFoundException("more then 1 active rule found for rule id " + rules.getIRuleIDAudit(), String.valueOf(rules.getIRuleIDAudit()));
        } else {
            return getSequenceByLastRuleiRuleID(rule.get(0), res, mapofrules);
        }
    }


    @Override
    public List<RulesAudit> findAllByIDecisionID(int iDecisionID, Integer tenantid) throws Exception {
        //return ruleTempAuditRepository.findAllByCustomIDecisionID(iDecisionID);
        return ruleTempAuditRepository.findByIdecisionIDAndBcustomTrueAndBdeleteFalseAndBclosedFalseAndIstatusIsNull(iDecisionID);
    }

    @Override
    public List<RulesAudit> findAllPending(int iDecisionID, Integer tenantid) throws Exception {
        //return ruleTempAuditRepository.findAllByIDecisionID(iDecisionID);
        return ruleTempAuditRepository.findByIdecisionIDAndBdeleteFalseAndBclosedFalseAndIstatusIsNull(iDecisionID);
    }

    public boolean findAuditEntryExist(int iDecisionID, int iTenantid, List<Integer> iRuleIDAudit)
    {
        return ruleTempAuditRepository.existsByiRuleIDAuditInAndIdecisionIDAndItenantIdAndBclosedFalseAndIstatusIsNull(iRuleIDAudit, iDecisionID, iTenantid );
    }

    @Override
    public RulesAudit findById(Integer auditID, Integer tenantid) throws Exception {

        return ruleTempAuditRepository.findByiRuleIDAuditAndItenantIdAndBdeleteFalseAndBclosedFalse(auditID, tenantid);
    }

    @Override
    public List<RulesAudit> findPendingEntriesByDecisionID(Integer iDecisionID, Integer tenantid) throws Exception {
        //return ruleTempAuditRepository.findPendingEntriesByIDecisionID(iDecisionID);
        return ruleTempAuditRepository.findByIdecisionIDAndItenantIdAndBclosedFalseAndIstatusIsNull(iDecisionID, tenantid);

    }
}
