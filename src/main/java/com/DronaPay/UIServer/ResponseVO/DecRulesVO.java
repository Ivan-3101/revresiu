package com.DronaPay.UIServer.ResponseVO;

import java.util.List;

import lombok.Data;

@Data
public class DecRulesVO {
    private List<RulesDropDownVO> rulesDropDown;
    private String aggregateType;
}
