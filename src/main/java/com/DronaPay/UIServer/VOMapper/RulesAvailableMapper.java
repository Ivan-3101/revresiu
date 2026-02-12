package com.DronaPay.UIServer.VOMapper;

import com.DronaPay.UIServer.ResponseVO.RuleAvailable;
import com.DronaPay.UIServer.model.Rules;
import com.DronaPay.UIServer.model.RulesAudit;
import com.DronaPay.UIServer.model.RulesAvailableUi;
import com.DronaPay.UIServer.service.RepositoryService.RulesTempService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

public class RulesAvailableMapper {

    @Autowired
    private RulesTempService rulesTempService;

    public static LinkedList<RuleAvailable> parse(List<Rules> rulesDeque) {
        LinkedList<RuleAvailable> res = new LinkedList<>();
        for (Rules s : rulesDeque) {
            RuleAvailable ra = new RuleAvailable();
            ra.setAvailableRuleID(s.getIruleAvailableID() != null ? s.getIruleAvailableID() : null);
            ra.setRuleID(s.getIRuleID());
            ra.setActive(s.isBactive());
            ra.setDecisionID(s.getIdecisionID());
            ra.setLabel(s.getVcLabel());
            ra.setRuleName(s.getVcRuleName());
            ra.setRuleDescription(s.getVcRuleDescription());
            ra.setRuleParam(s.getVcRuleParams());
            ra.setRuleState(s.getVcRuleState());
            ra.setRuleType(s.getVcRuleType());
            ra.setRuleDimension(s.getVcRuleDimension());
            ra.setRuleDetails(s.getVcRuleDetail());
            ra.setInstance(s.getIInstance());
            ra.setVersionID(s.getIVersion());
            ra.setApprovedDateTimeStamp(s.getDtApproverStamp());
            ra.setCustom(s.isBcustom());
            ra.setRuleAuditID(-1);
            ra.setVcruleorder(s.getVcRuleOrder());
            res.add(ra);

        }
        return res;
    }

    public static LinkedList<RuleAvailable> parseToRulesTempAudit(List<RulesAudit> rulesDeque) {
        LinkedList<RuleAvailable> res = new LinkedList<>();
        for (RulesAudit s : rulesDeque) {
            RuleAvailable ra = new RuleAvailable();
            ra.setAvailableRuleID(s.getIruleAvailableID() != null ? s.getIruleAvailableID() : null);
            ra.setRuleID(s.getIRuleID());
            ra.setActive(s.isBactive());
            ra.setDecisionID(s.getIdecisionID());
            ra.setLabel(s.getVcLabel());
            ra.setRuleName(s.getVcRuleName());
            ra.setRuleDescription(s.getVcRuleDescription());
            ra.setRuleParam(s.getVcRuleParams());
            ra.setRuleState(s.getVcRuleState());
            ra.setRuleType(s.getVcRuleType());
            ra.setRuleDimension(s.getVcRuleDimension());
            ra.setRuleDetails(s.getVcRuleDetail());
            ra.setInstance(s.getIInstance());
            ra.setCustom(s.isBcustom());
            ra.setRuleAuditID(s.getIRuleIDAudit());
            ra.setAction(s.getIRuleID() == null ? "A" : null);
            ra.setVersionID(s.getIVersion());
            ra.setVcruleorder(s.getVcRuleOrder());
            res.add(ra);
        }
        return res;
    }

    public static List<RuleAvailable> parseToList(List<Rules> rulesDeque) {
        List<RuleAvailable> res = new ArrayList<>();
        for (Rules s : rulesDeque) {
            RuleAvailable ra = new RuleAvailable();
            ra.setAvailableRuleID(s.getIruleAvailableID() != null ? s.getIruleAvailableID() : null);
            ra.setRuleID(s.getIRuleID());
            ra.setActive(s.isBactive());
            ra.setDecisionID(s.getIdecisionID());
            ra.setLabel(s.getVcLabel());
            ra.setVersionID(s.getIVersion());
            ra.setRuleName(s.getVcRuleName());
            ra.setRuleDescription(s.getVcRuleDescription());
            ra.setRuleParam(s.getVcRuleParams());
            ra.setRuleState(s.getVcRuleState());
            ra.setRuleType(s.getVcRuleType());
            ra.setRuleDimension(s.getVcRuleDimension());
            ra.setRuleDetails(s.getVcRuleDetail());
            ra.setInstance(s.getIInstance());
            ra.setCustom(s.isBcustom());
            ra.setVcruleorder(s.getVcRuleOrder());
            res.add(ra);
        }
        return res;
    }

    public static Map<Integer, RuleAvailable> parseToMap(List<Rules> rulesDeque) {
        Map<Integer, RuleAvailable> res = new HashMap<>();
        for (Rules s : rulesDeque) {
            RuleAvailable ra = new RuleAvailable();
            ra.setAvailableRuleID(s.getIruleAvailableID() != null ? s.getIruleAvailableID() : null);
            ra.setRuleID(s.getIRuleID());
            ra.setActive(s.isBactive());
            ra.setDecisionID(s.getIdecisionID());
            ra.setLabel(s.getVcLabel());
            ra.setRuleName(s.getVcRuleName());
            ra.setRuleDescription(s.getVcRuleDescription());
            ra.setRuleParam(s.getVcRuleParams());
            ra.setRuleState(s.getVcRuleState());
            ra.setRuleType(s.getVcRuleType());
            ra.setRuleDimension(s.getVcRuleDimension());
            ra.setRuleDetails(s.getVcRuleDetail());
            ra.setInstance(s.getIInstance());
            ra.setCustom(s.isBcustom());
            ra.setVcruleorder(s.getVcRuleOrder());
            res.put(s.getIRuleID(), ra);
        }
        return res;
    }

    public static List<RuleAvailable> parseAuditToList(List<RulesAudit> rulesDeque) {
        List<RuleAvailable> res = new ArrayList<>();
        for (RulesAudit s : rulesDeque) {
            RuleAvailable ra = new RuleAvailable();
            ra.setAvailableRuleID(s.getIruleAvailableID() != null ? s.getIruleAvailableID() : null);
            ra.setRuleID(s.getIRuleID());
            ra.setActive(s.isBactive());
            ra.setDecisionID(s.getIdecisionID());
            ra.setLabel(s.getVcLabel());
            ra.setRuleName(s.getVcRuleName());
            ra.setRuleDescription(s.getVcRuleDescription());
            ra.setRuleParam(s.getVcRuleParams());
            ra.setRuleState(s.getVcRuleState());
            ra.setRuleType(s.getVcRuleType());
            ra.setRuleDimension(s.getVcRuleDimension());
            ra.setRuleDetails(s.getVcRuleDetail());
            ra.setInstance(s.getIInstance());
            ra.setCustom(s.isBcustom());
            ra.setRuleAuditID(s.getIRuleIDAudit());
            ra.setVcruleorder(s.getVcRuleOrder());
            res.add(ra);
        }
        return res;
    }

    public List<RuleAvailable> parse(List<RulesAvailableUi> rulesAvailables, List<Rules> rules) {

        Map<Integer, Integer> countMap = rules
                .stream()
                .filter(a -> a.getIruleAvailableID() != null)
                .map(a -> a.getIruleAvailableID())
                .collect(Collectors.groupingBy(
                        Function.identity(), // Group by the rule id
                        Collectors.summingInt(e -> 1) // Count occurrences in each group
                ));

        List<RuleAvailable> res = rulesAvailables.stream().map(s -> {

            RuleAvailable ra = new RuleAvailable();
            ra.setAvailableRuleID(s.getIRuleAvailableID());
            ra.setActive(s.isBactive());
            // ra.setDecisionID(s.getIDecisionID().getIDecisionID());
            ra.setLabel(s.getVcLabel());
            ra.setRuleName(s.getVcRuleName());
            ra.setRuleDetails(s.getVcRuleDetail());
            ra.setRuleDescription(s.getVcRuleDescription());
            ra.setRuleParam(s.getVcRuleParams());
            ra.setRuleState(s.getVcRuleState());
            ra.setRuleType(s.getVcRuleType());

            ra.setInstance(countMap.get(s.getIRuleAvailableID()));
            ra.setRuleDimension(s.getVcRuleDimension());
            ra.setInstance(ra.getInstance());
            ra.setRuleAuditID(-1);

            return ra;
        }).collect(Collectors.toList());
        return res;

    }


}
