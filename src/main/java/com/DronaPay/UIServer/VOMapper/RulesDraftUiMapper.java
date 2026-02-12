package com.DronaPay.UIServer.VOMapper;

import com.DronaPay.UIServer.model.RulesDraft;
import com.DronaPay.UIServer.model.RulesDraftUi;
import com.DronaPay.UIServer.model.RulesDraftUiAudit;

import java.util.LinkedList;
import java.util.List;

public class RulesDraftUiMapper {
    public static RulesDraftUiAudit parse(RulesDraftUi rule) {

        RulesDraftUiAudit audit = new RulesDraftUiAudit();
        audit.setBCustom(rule.isBCustom());
        audit.setBPayee(rule.isBPayee());
        audit.setBPayer(rule.isBPayer());
        audit.setBTransaction(rule.isBTransaction());
        audit.setBactive(rule.isBactive());
        audit.setBdelete(rule.isBdelete());
        audit.setIRuleDraftID(rule);
        audit.setVcLabel(rule.getVcLabel());
        audit.setVcRuleDescription(rule.getVcRuleDescription());
        audit.setVcRuleDetail(rule.getVcRuleDetail());
        audit.setVcRuleDimension(rule.getVcRuleDimension());
        audit.setVcRuleName(rule.getVcRuleName());
        audit.setVcRuleParams(rule.getVcRuleParams());
        audit.setVcRuleState(rule.getVcRuleState());
        audit.setVcRuleType(rule.getVcRuleType());
        audit.setItenantId(rule.getItenantId());
        return audit;
    }

    public static RulesDraft parseToMaster(RulesDraftUi rlUi) {
        RulesDraft rl = new RulesDraft();
        rl.setBCustom(rlUi.isBCustom());
        rl.setBPayee(rlUi.isBPayee());
        rl.setBPayer(rlUi.isBPayer());
        rl.setBTransaction(rlUi.isBTransaction());
        rl.setBactive(rlUi.isBactive());
        rl.setBdelete(rlUi.isBdelete());
        rl.setIRuleDraftID(rlUi.getIRuleDraftID());
        rl.setVcLabel(rlUi.getVcLabel());
        rl.setVcRuleDescription(rlUi.getVcRuleDescription());
        rl.setVcRuleDetail(rlUi.getVcRuleDetail());
        rl.setVcRuleDimension(rlUi.getVcRuleDimension());
        rl.setVcRuleName(rlUi.getVcRuleName());
        rl.setVcRuleParams(rlUi.getVcRuleParams());
        rl.setVcRuleState(rlUi.getVcRuleState());
        rl.setVcRuleType(rlUi.getVcRuleType());
        rl.setItenantId(rlUi.getItenantId());
        return rl;
    }
}
