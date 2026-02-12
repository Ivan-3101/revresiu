package com.DronaPay.UIServer.VOMapper;

import com.DronaPay.UIServer.model.RulesAvailable;
import com.DronaPay.UIServer.model.RulesAvailableUi;
import com.DronaPay.UIServer.model.RulesAvailableUiAudit;

import java.util.LinkedList;
import java.util.List;

public class RulesAvailableUiMapper {
    public static RulesAvailableUiAudit parse(RulesAvailableUi rule) {
        RulesAvailableUiAudit audit = new RulesAvailableUiAudit();
        audit.setBCustom(rule.isBCustom());
        audit.setBPayee(rule.isBPayee());
        audit.setBPayer(rule.isBPayer());
        audit.setBTransaction(rule.isBTransaction());
        audit.setBactive(rule.isBactive());
        audit.setBdelete(rule.isBdelete());
        audit.setIRuleAvailableID(rule);
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

    public static RulesAvailable parseToMaster(RulesAvailableUi rlUi) {
        RulesAvailable rl = new RulesAvailable();
        rl.setBCustom(rlUi.isBCustom());
        rl.setBPayee(rlUi.isBPayee());
        rl.setBPayer(rlUi.isBPayer());
        rl.setBTransaction(rlUi.isBTransaction());
        rl.setBactive(rlUi.isBactive());
        rl.setBdelete(rlUi.isBdelete());
        rl.setIRuleAvailableID(rlUi.getIRuleAvailableID());
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
