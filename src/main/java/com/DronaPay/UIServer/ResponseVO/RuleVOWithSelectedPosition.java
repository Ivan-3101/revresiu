package com.DronaPay.UIServer.ResponseVO;

import lombok.Data;

import java.util.List;

@Data
public class RuleVOWithSelectedPosition {

    private Integer selected;
    private List<RulesVO> rulesVOList;

}
