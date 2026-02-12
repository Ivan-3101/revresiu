package com.DronaPay.UIServer.VOMapper;

import java.util.List;

import com.DronaPay.UIServer.ResponseVO.RuleManagementVO;
import com.DronaPay.UIServer.ResponseVO.RuleVOWithSelectedPosition;
import com.DronaPay.UIServer.ResponseVO.RulesVO;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.response.RuleEditResponse;
import com.DronaPay.UIServer.response.MenuPermissions;

public class RuleManagementVOMapper {

	// public static RuleManagementVO convert(Rules rules, TransactionClassesUI transactionClasses,
	// 		MenuPermissions menuPermissions, List<RulesVO> sequence) {
	// 	RuleManagementVO response = RuleManagementVO.builder().edit(menuPermissions.isEdit())
	// 			.delete(menuPermissions.isDelete()).status((rules.isBactive() ? "Active" : "Inactive"))
	// 			.ruledescription(rules.getVcRuleDescription()).rulename(rules.getVcRuleName())
	// 			.decision(transactionClasses.getIDecisionID().getVcDecisionName())
	// 			.classname(transactionClasses.getVcClassName())
	// 			.rule(RuleEditResponse.parse(transactionClasses, rules, sequence)).build();
	// 	return response;
	// }

	public static RuleManagementVO convert(Rules rules, DecisionUi decisions,
			MenuPermissions menuPermissions, List<RulesVO> sequence) {
		RuleManagementVO response = RuleManagementVO.builder().edit(menuPermissions.isEdit())
				.delete(menuPermissions.isDelete()).status((rules.isBactive() ? "Active" : "Inactive"))
				.ruledescription(rules.getVcRuleDescription()).rulename(rules.getVcRuleName())
				.decision(decisions.getVcDecisionName())
				.classname(decisions.getVcDecisionName())
				.rule(RuleEditResponse.parse(decisions, rules, sequence)).build();
		return response;
	}

	public static RuleManagementVO convert(Rules rules, DecisionUi decisions,
			MenuPermissions menuPermissions, RuleVOWithSelectedPosition ruleVOWithSelectedPosition) {
		RuleManagementVO response = RuleManagementVO.builder().edit(menuPermissions.isEdit())
				.delete(menuPermissions.isDelete()).status((rules.isBactive() ? "Active" : "Inactive"))
				.ruledescription(rules.getVcRuleDescription()).rulename(rules.getVcRuleName())
				.decision(decisions.getVcDecisionName())
				.classname(decisions.getVcDecisionName())
				.params(rules.getVcRuleParams())
				.rule(RuleEditResponse.parse(decisions, rules, ruleVOWithSelectedPosition)).build();
		return response;
	}

	// public static RuleManagementVO convert(Rules rules, TransactionClassesUI transactionClasses,
	// 		MenuPermissions menuPermissions, RuleVOWithSelectedPosition ruleVOWithSelectedPosition) {
	// 	RuleManagementVO response = RuleManagementVO.builder().edit(menuPermissions.isEdit())
	// 			.delete(menuPermissions.isDelete()).status((rules.isBactive() ? "Active" : "Inactive"))
	// 			.ruledescription(rules.getVcRuleDescription()).rulename(rules.getVcRuleName())
	// 			.decision(transactionClasses.getIDecisionID().getVcDecisionName())
	// 			.classname(transactionClasses.getVcClassName())
	// 			.rule(RuleEditResponse.parse(transactionClasses, rules, ruleVOWithSelectedPosition)).build();
	// 	return response;
	// }

}
