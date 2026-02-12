package com.DronaPay.UIServer.ResponseVO;

import lombok.Builder;

import lombok.Data;

@Builder
@Data
public class DecisionVo {
    private Integer value;
    private String label;

//    public static DecisionVo parse(Decision decision)
//    {
//        DecisionVo res = new DecisionVo();
//        res.setLabel(decision.getVcDecisionName());
//        res.setValue(decision.getIDecisionID());
//        return res;
//    }
}
