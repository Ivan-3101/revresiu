package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.repository.RulesRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.DronaPay.UIServer.model.RulesMasters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.Deque;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class RulesServiceImpl implements RulesService {

	@Autowired
	private RulesRepository rulesRepository;

	public void save(RulesMasters rules) throws Exception {
		rulesRepository.save(rules);
	}

	public RulesMasters saveAndGetSavedObject(RulesMasters rules) throws Exception {
		return rulesRepository.save(rules);
	}

	public List<RulesMasters> findAll() throws Exception {
		return rulesRepository.findAll();
	}

	public List<RulesMasters> findAllByIDecisionID(int iDecisionID) throws Exception {
		//return rulesRepository.findAllByIDecisionID(iDecisionID);
		return rulesRepository.findByIdecisionID_iDecisionIDAndBcustomTrueAndBdeleteFalse(iDecisionID);
	}

	public RulesMasters findByDecisionIDRuleID(Integer iDecisionID, Integer iRuleID) throws Exception {
		List<RulesMasters> ruleList = rulesRepository.findByIdecisionID_iDecisionIDAndBcustomTrueAndBactiveTrueAndBdeleteFalse(iDecisionID);
		List<RulesMasters> ruleID = ruleList.stream().filter( x ->
		{
			String vcRuleOrder = x.getVcRuleOrder();
			ObjectMapper mapper = new ObjectMapper();
			try {
				JsonNode ruleorderJSON = mapper.readTree(vcRuleOrder);
				if(ruleorderJSON != null) {
					JsonNode successRule = ruleorderJSON.get("SuccessRule");
					if(successRule != null) {
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

		if(ruleID.size() >= 1) {
			throw new SQLException("Multiple matching rule ids found");
		} else if(ruleID.size() == 0) {
			return null;
		} else {
			return ruleID.get(0);
		}
	}

	public Deque<RulesMasters> getSequenceByiDecisionID(int iDecisionID) throws Exception {
		//RulesMasters last = rulesRepository.findLastCustomRuleByIDecisionID(iDecisionID);
		RulesMasters last = findByDecisionIDRuleID(iDecisionID, -1);
		Deque<RulesMasters> res = new LinkedList<>();
		if (last != null) {
			res = getSequenceByLastRuleiRuleID(last, res);
		}
		return res;
	}


	public Deque<RulesMasters> getSequenceByLastRuleiRuleID(RulesMasters rules, Deque<RulesMasters> res) throws Exception {
		if (rules.isBactive()) {
			res.addFirst(rules);
		}
		//RulesMasters rule = rulesRepository.findCustomRuleBySuccessRuleAndIDecisionID(rules.getIRuleID(),
		//		rules.getIdecisionID().getIDecisionID());
		RulesMasters rule = findByDecisionIDRuleID(rules.getIdecisionID().getIDecisionID(), rules.getIRuleID());
		if (rule == null) {
			return res;
		} else {
			return getSequenceByLastRuleiRuleID(rule, res);
		}
	}

	public RulesMasters findLastByIDecisionID(int iDecisionID) throws Exception {
		//return rulesRepository.findLastCustomRuleByIDecisionID(iDecisionID);
		return findByDecisionIDRuleID(iDecisionID, -1);
	}

	public RulesMasters findCustomRuleBySuccessRuleAndIDecisionID(int iRuleID, int iDecisionID) throws Exception {
		//return rulesRepository.findCustomRuleBySuccessRuleAndIDecisionID(iRuleID, iDecisionID);
		return findByDecisionIDRuleID(iDecisionID, iRuleID);
	}

	public RulesMasters findByiRuleID(int iRuleID) throws Exception {
		return rulesRepository.findById(iRuleID).orElse(null);
	}

	@Override
	public List<RulesMasters> findAllDefaultRulesByClass(int iDecisionID) throws Exception {
		//return rulesRepository.findAllDefaultRulesByIDecisionID(iDecisionID);
		return rulesRepository.findByIdecisionID_iDecisionIDAndBcustomFalseAndBdeleteFalse(iDecisionID);
	}

}
