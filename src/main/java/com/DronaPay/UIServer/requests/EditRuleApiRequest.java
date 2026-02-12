package com.DronaPay.UIServer.requests;

import com.DronaPay.UIServer.model.Rules;

import lombok.Data;

@Data
public class EditRuleApiRequest {

    private String vcruledescription;
    private String vcruledetail;
    private String vcruleparams;
    private String vcruleorder;
    private Boolean bactive;
    private String action;

    public static EditRuleApiRequest parseRuleTmepToAddRuleApiRequest(Rules ruleTemp) {

        EditRuleApiRequest editRuleApiRequest = new EditRuleApiRequest();
        editRuleApiRequest.setAction("M");
        editRuleApiRequest.setBactive(ruleTemp.isBactive());
        editRuleApiRequest.setVcruledescription(ruleTemp.getVcRuleDescription());
        if (ruleTemp.isBcustom()) {
            org.json.JSONObject param = new org.json.JSONObject(ruleTemp.getVcRuleDetail());
            if (param.opt("formattedquery") != null) {
                editRuleApiRequest.setVcruledetail(param.opt("formattedquery").toString());
            }
        } else {
            editRuleApiRequest.setVcruledetail(ruleTemp.getVcRuleDetail());
        }
        editRuleApiRequest.setVcruleorder(ruleTemp.getVcRuleOrder());
        editRuleApiRequest.setVcruleparams(ruleTemp.getVcRuleParams());
        return editRuleApiRequest;
    }
}
