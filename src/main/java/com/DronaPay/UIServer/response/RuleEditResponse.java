package com.DronaPay.UIServer.response;

import com.DronaPay.UIServer.ResponseVO.ClassAndDecisionVO;
import com.DronaPay.UIServer.ResponseVO.RuleVOWithSelectedPosition;
import com.DronaPay.UIServer.ResponseVO.RulesVO;
import com.DronaPay.UIServer.VOMapper.DecisionVoMapper;
import com.DronaPay.UIServer.model.DecisionUi;
import com.DronaPay.UIServer.model.Rules;
import lombok.Data;

import java.time.ZonedDateTime;
import java.util.List;

@Data
public class RuleEditResponse {

    private Integer id;
    private ClassAndDecisionVO classAndDecision;
    private String ruleName;
    private String ruleDescription;
    private String rulecode;
    private boolean active;
    private ZonedDateTime startDate;
    private List<RulesVO> sequence;
    private Integer selected;
    private String params;

//     public static RuleEditResponse parse(TransactionClassesUI transactionClasses, Rules rules, List<RulesVO> sequence)
//     {
//         ClassAndDecisionVO temp = ClassAndDecisionVO.builder()
//         		.decisionVO(DecisionVoMapper.parse(transactionClasses.getIDecisionID()))
//         		.productid(transactionClasses.getIProductID().getIProductID())
//         		.label(transactionClasses.getVcClassName())
//         		.value(transactionClasses.getIclassID())
//         		.build();
// //        temp.setDecisionVO(DecisionVoMapper.parse(transactionClasses.getIDecisionID()));
// //        temp.setProductid(transactionClasses.getIProductID().getIProductID());
// //        temp.setLabel(transactionClasses.getVcClassName());
// //        temp.setValue(transactionClasses.getIClassID());

//         RuleEditResponse response = new RuleEditResponse();
//         response.setId(rules.getIRuleID());
//         response.setClassAndDecision(temp);
//         response.setRuleName(rules.getVcRuleName());
//         response.setRuleDescription(rules.getVcRuleDescription());
//         response.setRulecode(rules.getVcRuleDetail());
//         response.setActive(rules.isBactive());
//         response.setStartDate(rules.getDtStartDate());
//         response.setParams(rules.getVcRuleParams());
//         response.setSequence(sequence);
//         return response;
//     }


//     public static RuleEditResponse parse(TransactionClassesUI transactionClasses, Rules rules, RuleVOWithSelectedPosition ruleVOWithSelectedPosition)
//     {
//         ClassAndDecisionVO temp = ClassAndDecisionVO.builder()
//         		.decisionVO(DecisionVoMapper.parse(transactionClasses.getIDecisionID()))
//         		.productid(transactionClasses.getIProductID().getIProductID())
//         		.label(transactionClasses.getVcClassName())
//         		.value(transactionClasses.getIclassID())
//         		.build();
// //        temp.setDecisionVO(DecisionVoMapper.parse(transactionClasses.getIDecisionID()));
// //        temp.setProductid(transactionClasses.getIProductID().getIProductID());
// //        temp.setLabel(transactionClasses.getVcClassName());
// //        temp.setValue(transactionClasses.getIClassID());
//         RuleEditResponse response = new RuleEditResponse();
//         response.setId(rules.getIRuleID());
//         response.setClassAndDecision(temp);
//         response.setRuleName(rules.getVcRuleName());
//         response.setRuleDescription(rules.getVcRuleDescription());
//         response.setRulecode(rules.getVcRuleDetail());
//         response.setActive(rules.isBactive());
//         response.setStartDate(rules.getDtStartDate());
//         response.setParams(rules.getVcRuleParams());
//         response.setSequence(ruleVOWithSelectedPosition.getRulesVOList());
//         response.setSelected(ruleVOWithSelectedPosition.getSelected());
//         return response;
//     }

    public static RuleEditResponse parse(DecisionUi decisions, Rules rules, List<RulesVO> sequence) {
        ClassAndDecisionVO temp = ClassAndDecisionVO.builder()
                .decisionVO(DecisionVoMapper.parse(decisions))
                .label(decisions.getVcDecisionName())
                .value(decisions.getIDecisionID())
                .build();
//        temp.setDecisionVO(DecisionVoMapper.parse(transactionClasses.getIDecisionID()));
//        temp.setProductid(transactionClasses.getIProductID().getIProductID());
//        temp.setLabel(transactionClasses.getVcClassName());
//        temp.setValue(transactionClasses.getIClassID());

        RuleEditResponse response = new RuleEditResponse();
        response.setId(rules.getIRuleID());
        response.setClassAndDecision(temp);
        response.setRuleName(rules.getVcRuleName());
        response.setRuleDescription(rules.getVcRuleDescription());
        response.setRulecode(rules.getVcRuleDetail());
        response.setActive(rules.isBactive());
        response.setParams(rules.getVcRuleParams());
        response.setStartDate(rules.getDtStartDate());
        response.setSequence(sequence);
        return response;
    }

    public static RuleEditResponse parse(DecisionUi decisions, Rules rules, RuleVOWithSelectedPosition ruleVOWithSelectedPosition) {
        ClassAndDecisionVO temp = ClassAndDecisionVO.builder()
                .decisionVO(DecisionVoMapper.parse(decisions))
                .label(decisions.getVcDecisionName())
                .productid(decisions.getIProductID().getIProductID())
                .value(decisions.getIDecisionID())
                .build();
//        temp.setDecisionVO(DecisionVoMapper.parse(transactionClasses.getIDecisionID()));
//        temp.setProductid(transactionClasses.getIProductID().getIProductID());
//        temp.setLabel(transactionClasses.getVcClassName());
//        temp.setValue(transactionClasses.getIClassID());
        RuleEditResponse response = new RuleEditResponse();
        response.setId(rules.getIRuleID());
        response.setClassAndDecision(temp);
        response.setRuleName(rules.getVcRuleName());
        response.setRuleDescription(rules.getVcRuleDescription());
        response.setRulecode(rules.getVcRuleDetail());
        response.setActive(rules.isBactive());
        response.setStartDate(rules.getDtStartDate());
        response.setParams(rules.getVcRuleParams());
        response.setSequence(ruleVOWithSelectedPosition.getRulesVOList());
        response.setSelected(ruleVOWithSelectedPosition.getSelected());
        return response;
    }


}
