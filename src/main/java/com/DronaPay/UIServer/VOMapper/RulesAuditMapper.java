package com.DronaPay.UIServer.VOMapper;

import com.DronaPay.UIServer.model.Rules;
import com.DronaPay.UIServer.model.RulesAudit;

import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class RulesAuditMapper {

    public static List<RulesAudit> parseRuleTemp(List<Rules> rulelist, Integer tenantid) {

        List<RulesAudit> rulesTempAudits = new ArrayList<>();
        for (Rules rulesTemp : rulelist) {
            RulesAudit rulesTempAudit = new RulesAudit();
            rulesTempAudit.setBactive(rulesTemp.isBactive());
            rulesTempAudit.setBclosed(false);
            rulesTempAudit.setBcustom(rulesTemp.isBcustom());
            rulesTempAudit.setBdelete(rulesTemp.isBdelete());
            rulesTempAudit.setDtEntryDatetime(ZonedDateTime.now());
            rulesTempAudit.setIdecisionID(rulesTemp.getIdecisionID());
            rulesTempAudit.setIInstance(rulesTemp.getIInstance());
            rulesTempAudit.setIruleAvailableID(rulesTemp.getIruleAvailableID());
            rulesTempAudit.setIRuleID(rulesTemp.getIRuleID());
            rulesTempAudit.setIstatus(null);
            rulesTempAudit.setVcAction("X");
            rulesTempAudit.setVcBPMNFileLocation(rulesTemp.getVcBPMNFileLocation());
            rulesTempAudit.setVcLabel(rulesTemp.getVcLabel());
            rulesTempAudit.setVcRuleDescription(rulesTemp.getVcRuleDescription());
            rulesTempAudit.setVcRuleDetail(rulesTemp.getVcRuleDetail());
            rulesTempAudit.setVcRuleDimension(rulesTemp.getVcRuleDimension());
            rulesTempAudit.setVcRuleOrder(rulesTemp.getVcRuleOrder());
            rulesTempAudit.setVcRuleParams(rulesTemp.getVcRuleParams());
            rulesTempAudit.setVcRuleState(rulesTemp.getVcRuleState());
            rulesTempAudit.setVcRuleType(rulesTemp.getVcRuleType());
            rulesTempAudit.setVcRuleName(rulesTemp.getVcRuleName());
            rulesTempAudit.setIUserID(rulesTemp.getIUserID());
            rulesTempAudit.setIorgId(rulesTemp.getIorgId());
            rulesTempAudit.setItenantId(tenantid);
            rulesTempAudit.setIVersion(rulesTemp.getIVersion());
            rulesTempAudits.add(rulesTempAudit);
        }
        return rulesTempAudits;
    }

    public static RulesAudit parseRuleTempToAudit(Rules rulesTemp) {

        RulesAudit rulesTempAudit = new RulesAudit();
        rulesTempAudit.setBactive(rulesTemp.isBactive());
        rulesTempAudit.setBclosed(false);
        rulesTempAudit.setBcustom(rulesTemp.isBcustom());
        rulesTempAudit.setBdelete(rulesTemp.isBdelete());
        rulesTempAudit.setDtEntryDatetime(ZonedDateTime.now());
        rulesTempAudit.setIdecisionID(rulesTemp.getIdecisionID());
        rulesTempAudit.setIInstance(rulesTemp.getIInstance());
        rulesTempAudit.setIruleAvailableID(rulesTemp.getIruleAvailableID());
        rulesTempAudit.setIRuleID(rulesTemp.getIRuleID());
        rulesTempAudit.setIstatus(null);
        rulesTempAudit.setVcAction("X");
        rulesTempAudit.setVcBPMNFileLocation(rulesTemp.getVcBPMNFileLocation());
        rulesTempAudit.setVcLabel(rulesTemp.getVcLabel());
        rulesTempAudit.setVcRuleDescription(rulesTemp.getVcRuleDescription());
        rulesTempAudit.setVcRuleDetail(rulesTemp.getVcRuleDetail());
        rulesTempAudit.setVcRuleDimension(rulesTemp.getVcRuleDimension());
        rulesTempAudit.setVcRuleOrder(rulesTemp.getVcRuleOrder());
        rulesTempAudit.setVcRuleParams(rulesTemp.getVcRuleParams());
        rulesTempAudit.setVcRuleState(rulesTemp.getVcRuleState());
        rulesTempAudit.setVcRuleType(rulesTemp.getVcRuleType());
        rulesTempAudit.setVcRuleName(rulesTemp.getVcRuleName());
        rulesTempAudit.setItenantId(rulesTemp.getItenantId());
        rulesTempAudit.setIVersion(rulesTemp.getIVersion());
        return rulesTempAudit;
    }

    public static List<Rules> parseAudittoTemp(List<RulesAudit> rulesTempAudits) {
        List<Rules> rulesTemps = new ArrayList<>();
        for (RulesAudit rulesTempAudit : rulesTempAudits) {
            Rules rulesTem = new Rules();
            rulesTem.setBactive(rulesTempAudit.isBactive());
            rulesTem.setBcustom(rulesTempAudit.isBcustom());
            rulesTem.setBdelete(rulesTempAudit.isBdelete());
            rulesTem.setDtApproverStamp(ZonedDateTime.now());
            rulesTem.setDtEntryDatetime(ZonedDateTime.now());
            rulesTem.setDtEntryStamp(ZonedDateTime.now());
            rulesTem.setIdecisionID(rulesTempAudit.getIdecisionID());
            rulesTem.setIEntryUserID(rulesTempAudit.getIEntryUserID());
            rulesTem.setIorgId(rulesTempAudit.getIorgId());
            rulesTem.setIInstance(rulesTempAudit.getIInstance());
            rulesTem.setIruleAvailableID(rulesTempAudit.getIruleAvailableID());
            rulesTem.setIRuleID(rulesTempAudit.getIRuleID());
            rulesTem.setIUserID(rulesTempAudit.getIUserID());
            rulesTem.setIorgId(rulesTempAudit.getIorgId());
            rulesTem.setIVersion(rulesTempAudit.getIVersion());
            rulesTem.setVcBPMNFileLocation(rulesTempAudit.getVcBPMNFileLocation());
            rulesTem.setVcLabel(rulesTempAudit.getVcLabel());
            rulesTem.setVcRuleDescription(rulesTempAudit.getVcRuleDescription());
            rulesTem.setVcRuleDetail(rulesTempAudit.getVcRuleDetail());
            rulesTem.setVcRuleDimension(rulesTempAudit.getVcRuleDimension());
            rulesTem.setVcRuleMapInfo(rulesTempAudit.getVcRuleMapInfo());
            rulesTem.setVcRuleName(rulesTempAudit.getVcRuleName());
            rulesTem.setVcRuleOrder(rulesTempAudit.getVcRuleOrder());
            rulesTem.setVcRuleParams(rulesTempAudit.getVcRuleParams());
            rulesTem.setVcRuleState(rulesTempAudit.getVcRuleState());
            rulesTem.setVcRuleType(rulesTempAudit.getVcRuleType());
            rulesTem.setItenantId(rulesTempAudit.getItenantId());
            rulesTemps.add(rulesTem);
        }

        return rulesTemps;
    }

    public static Map<Integer, Rules> parseAudit(List<RulesAudit> rulesTempAudits) {

        return rulesTempAudits.stream()
                .collect(Collectors.toMap(
                        RulesAudit::getIRuleIDAudit,
                        rulesTempAudit -> {
                            Rules rulesTem = new Rules();
                            rulesTem.setBactive(rulesTempAudit.isBactive());
                            rulesTem.setBcustom(rulesTempAudit.isBcustom());
                            rulesTem.setBdelete(rulesTempAudit.isBdelete());
                            rulesTem.setDtApproverStamp(ZonedDateTime.now());
                            rulesTem.setDtEntryDatetime(ZonedDateTime.now());
                            rulesTem.setDtEntryStamp(ZonedDateTime.now());
                            rulesTem.setIdecisionID(rulesTempAudit.getIdecisionID());
                            rulesTem.setIEntryUserID(rulesTempAudit.getIEntryUserID());
                            rulesTem.setIorgId(rulesTempAudit.getIorgId());
                            rulesTem.setIInstance(rulesTempAudit.getIInstance());
                            rulesTem.setIruleAvailableID(rulesTempAudit.getIruleAvailableID());
                            rulesTem.setIRuleID(rulesTempAudit.getIRuleID());
                            rulesTem.setIUserID(rulesTempAudit.getIUserID());
                            rulesTem.setIorgId(rulesTempAudit.getIorgId());
//                            rulesTem.setIVersion(rulesTempAudit.getIVersion());
                            if (rulesTempAudit.getIRuleID() != null && rulesTempAudit.getIVersion() != null) {
                                if (rulesTempAudit.getVcAction().equalsIgnoreCase("N")) {
                                    rulesTem.setIVersion(rulesTempAudit.getIVersion());
                                } else {
                                    rulesTem.setIVersion(rulesTempAudit.getIVersion() + 1);
                                }
                            } else {
                                rulesTem.setIVersion(0);
                            }
                            rulesTem.setVcBPMNFileLocation(rulesTempAudit.getVcBPMNFileLocation());
                            rulesTem.setVcLabel(rulesTempAudit.getVcLabel());
                            rulesTem.setVcRuleDescription(rulesTempAudit.getVcRuleDescription());
                            rulesTem.setVcRuleDetail(rulesTempAudit.getVcRuleDetail());
                            rulesTem.setVcRuleDimension(rulesTempAudit.getVcRuleDimension());
                            rulesTem.setVcRuleMapInfo(rulesTempAudit.getVcRuleMapInfo());
                            rulesTem.setVcRuleName(rulesTempAudit.getVcRuleName());
                            rulesTem.setVcRuleOrder(rulesTempAudit.getVcRuleOrder());
                            rulesTem.setVcRuleParams(rulesTempAudit.getVcRuleParams());
                            rulesTem.setVcRuleState(rulesTempAudit.getVcRuleState());
                            rulesTem.setVcRuleType(rulesTempAudit.getVcRuleType());
                            rulesTem.setItenantId(rulesTempAudit.getItenantId());
                            return rulesTem;
                        }
                ));
    }
    public static LinkedList<Rules> parseToRulesTemp(List<RulesAudit> rulesTempAudit) {
        LinkedList<Rules> res = new LinkedList<>();
        for (RulesAudit rulesTem : rulesTempAudit) {
            Rules rulesTemNEw = new Rules();
            rulesTemNEw.setBactive(rulesTem.isBactive());
            rulesTemNEw.setBcustom(rulesTem.isBcustom());
            rulesTemNEw.setBdelete(rulesTem.isBdelete());
            rulesTemNEw.setDtApproverStamp(ZonedDateTime.now());
            rulesTemNEw.setDtEntryDatetime(ZonedDateTime.now());
            rulesTemNEw.setDtEntryStamp(ZonedDateTime.now());
            rulesTemNEw.setIdecisionID(rulesTem.getIdecisionID());
            rulesTemNEw.setIEntryUserID(rulesTem.getIEntryUserID());
            rulesTemNEw.setIInstance(rulesTem.getIInstance());
            rulesTemNEw.setIruleAvailableID(rulesTem.getIruleAvailableID());
            rulesTemNEw.setIRuleID(rulesTem.getIRuleID());
            rulesTemNEw.setIUserID(rulesTem.getIUserID());
            rulesTemNEw.setIorgId(rulesTemNEw.getIorgId());
            if (rulesTem.getIRuleID() != null) {
                rulesTemNEw.setIRuleID(rulesTem.getIRuleID());
                // System.out.println("Rule original " + rulesTem.getIRuleID());
                // System.out.println("VC rule detail from rule id: " +
                // rulesTem.getIRuleID().getVcRuleDetail() + " from audit table: " +
                // rulesTem.getVcRuleDetail());
                // System.out.println("Audit rule id " + rulesTem.getIRuleIDAudit() + " Rule id
                // existing: id " + rulesTem.getIRuleID().getIRuleID() + " version " +
                // rulesTem.getIRuleID().getIVersion());

                if (rulesTem.getVcAction().equalsIgnoreCase("N")) {
                    rulesTemNEw.setIVersion(rulesTem.getIVersion());
                } else {
                    rulesTemNEw.setIVersion(rulesTem.getIVersion() + 1);
                }
            } else {
                rulesTemNEw.setIVersion(0);
            }

            rulesTemNEw.setVcBPMNFileLocation(rulesTem.getVcBPMNFileLocation());
            rulesTemNEw.setVcLabel(rulesTem.getVcLabel());
            rulesTemNEw.setVcRuleDescription(rulesTem.getVcRuleDescription());
            rulesTemNEw.setVcRuleDetail(rulesTem.getVcRuleDetail());
            rulesTemNEw.setVcRuleDimension(rulesTem.getVcRuleDimension());
            rulesTemNEw.setVcRuleMapInfo(rulesTem.getVcRuleMapInfo());
            rulesTemNEw.setVcRuleName(rulesTem.getVcRuleName());
            rulesTemNEw.setVcRuleOrder(rulesTem.getVcRuleOrder());
            rulesTemNEw.setVcRuleParams(rulesTem.getVcRuleParams());
            rulesTemNEw.setVcRuleState(rulesTem.getVcRuleState());
            rulesTemNEw.setVcRuleType(rulesTem.getVcRuleType());
            rulesTemNEw.setItenantId(rulesTem.getItenantId());
            res.add(rulesTemNEw);
        }

        return res;
    }
}
