package com.DronaPay.UIServer.VOMapper;

import com.DronaPay.UIServer.ResponseVO.RulesDropDownVO;
import com.DronaPay.UIServer.model.Rules;
import com.nimbusds.jose.shaded.gson.JsonObject;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONObject;

public class RulesDropDownVOMapper {
    public static List<RulesDropDownVO> parse(List<Rules> all) {
        List<RulesDropDownVO> res = new ArrayList<>();
        for(Rules rul: all) {
            JSONObject ruleParams = new JSONObject(rul.getVcRuleParams());
            RulesDropDownVO obj = RulesDropDownVO.builder()
            .label(rul.getVcRuleName())
            .value(rul.getIRuleID())
            .score((Integer) ruleParams.optQuery("/fail/score"))
            .build();
            res.add(obj);
        }
        return res;
    }
}
