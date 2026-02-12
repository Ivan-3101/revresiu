package com.DronaPay.UIServer.requests;

import com.DronaPay.UIServer.model.Rules;
import lombok.Data;

@Data
public class AddRuleApiRequest {

    private String vcrulename;
    private Integer idecisionid;
    private String vcruledescription;
    private String vcruledetail;
    private String vcruleparams;
    private String vcruleorder;
    private Boolean bcustom;
    private Boolean bdelete;
    private Boolean bactive;
    private Integer iuserid;
    private Integer iversion;
    private String action;
    private String mst_type;
//    private Integer StartRule;

    public static AddRuleApiRequest parseRuleTmepToAddRuleApiRequest(Rules ruleTemp, String action) {

        AddRuleApiRequest addRuleApiRequest = new AddRuleApiRequest();
        addRuleApiRequest.setAction(action);
        addRuleApiRequest.setBactive(ruleTemp.isBactive());
        addRuleApiRequest.setBcustom(ruleTemp.isBcustom());
        addRuleApiRequest.setBdelete(ruleTemp.isBdelete());
        addRuleApiRequest.setIdecisionid(ruleTemp.getIdecisionID());
        addRuleApiRequest.setIuserid(ruleTemp.getIUserID());
        addRuleApiRequest.setIuserid(ruleTemp.getIUserID() != null ? ruleTemp.getIUserID() : null);
        addRuleApiRequest.setVcruledescription(ruleTemp.getVcRuleDescription());
        addRuleApiRequest.setIversion(ruleTemp.getIVersion());
        addRuleApiRequest.setVcruledetail(ruleTemp.getVcRuleDetail());
        addRuleApiRequest.setVcrulename(ruleTemp.getVcRuleName());
        addRuleApiRequest.setVcruleorder(ruleTemp.getVcRuleOrder());
        addRuleApiRequest.setVcruleparams(ruleTemp.getVcRuleParams());
        addRuleApiRequest.setMst_type("rules");
//        addRuleApiRequest.setStartRule(ruleTemp.getGetStartRule() == 0 ? null : 1);
        return addRuleApiRequest;
    }
}
