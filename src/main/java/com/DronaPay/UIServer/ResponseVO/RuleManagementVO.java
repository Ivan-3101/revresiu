package com.DronaPay.UIServer.ResponseVO;


import com.DronaPay.UIServer.response.RuleEditResponse;

import lombok.Builder;
import lombok.Data;

//import java.util.List;

@Builder
@Data
public class RuleManagementVO {


    private String classname;
    private String decision;
    private String rulename;
    private String ruledescription;
    private String status;
    private Boolean edit;
    private Boolean delete;
    private RuleEditResponse rule;
    private String params;

//    public static RuleManagementVO convert(Rules rules,
//                                           TransactionClasses transactionClasses,
//                                           MenuPermissions menuPermissions,
//                                           List<RulesVO> sequence)
//    {
//        RuleManagementVO response = new RuleManagementVO();
//        response.setEdit(menuPermissions.isEdit());
//        response.setDelete(menuPermissions.isDelete());
//        response.setStatus((rules.isBActive()?"Active":"Inactive"));
//        response.setRuledescription(rules.getVcRuleDescription());
//        response.setRulename(rules.getVcRuleName());
//        response.setDecision(transactionClasses.getIDecisionID().getVcDecisionName());
//        response.setClassname(transactionClasses.getVcClassName());
//        response.setRule(RuleEditResponse.parse(transactionClasses, rules, sequence));
//        return response;
//    }
//
//    public static RuleManagementVO convert(Rules rules,
//                                           TransactionClasses transactionClasses,
//                                           MenuPermissions menuPermissions,
//                                           RuleVOWithSelectedPosition ruleVOWithSelectedPosition)
//    {
//        RuleManagementVO response = new RuleManagementVO();
//        response.setEdit(menuPermissions.isEdit());
//        response.setDelete(menuPermissions.isDelete());
//        response.setStatus((rules.isBActive()?"Active":"Inactive"));
//        response.setRuledescription(rules.getVcRuleDescription());
//        response.setRulename(rules.getVcRuleName());
//        response.setDecision(transactionClasses.getIDecisionID().getVcDecisionName());
//        response.setClassname(transactionClasses.getVcClassName());
//        response.setRule(RuleEditResponse.parse(transactionClasses, rules, ruleVOWithSelectedPosition));
//        return response;
//    }
}
