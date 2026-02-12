package com.DronaPay.UIServer.VOMapper;

import java.util.ArrayList;
import java.util.Deque;
import java.util.List;

import com.DronaPay.UIServer.ResponseVO.RuleVOWithSelectedPosition;
import com.DronaPay.UIServer.ResponseVO.RulesVO;
import com.DronaPay.UIServer.model.Rules;

public class RuleVOMapper {

	public static RulesVO parse(Rules rules) {
		RulesVO res = RulesVO.builder().id(rules.getIRuleID()).rulename(rules.getVcRuleName())
				.order(rules.getVcRuleOrder()).active(rules.isBactive()).build();

		return res;
	}

	public static List<RulesVO> parse(Deque<Rules> rulesDeque) {
		List<RulesVO> res = new ArrayList<>();
		for (Rules rule : rulesDeque) {
			RulesVO temp = RulesVO.builder().rulename(rule.getVcRuleName()).id(rule.getIRuleID())
					.order(rule.getVcRuleOrder()).active(rule.isBactive()).build();
			res.add(temp);
		}
		return res;
	}

	public static RuleVOWithSelectedPosition parse(Deque<Rules> rulesDeque, Rules selected) {
		RuleVOWithSelectedPosition res = new RuleVOWithSelectedPosition();
		List<RulesVO> listTemp = new ArrayList<>();
		int index = 0;
		Integer selectedPostion = null;
		for (Rules rule : rulesDeque) {
			RulesVO temp = RulesVO.builder().rulename(rule.getVcRuleName()).id(rule.getIRuleID())
					.order(rule.getVcRuleOrder()).active(rule.isBactive()).params(rule.getVcRuleParams()).build();
			if (rule.getIRuleID().equals(selected.getIRuleID())) {
				selectedPostion = index;
			}
			listTemp.add(temp);
			index++;
		}
		if (!selected.isBactive()) {
			listTemp.add(RuleVOMapper.parse(selected));
			res.setSelected(listTemp.size() - 1);
		} else {
			res.setSelected(selectedPostion);
		}
		res.setRulesVOList(listTemp);
		return res;
	}

}
