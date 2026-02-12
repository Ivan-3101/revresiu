package com.DronaPay.UIServer.ResponseVO;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class RulesDropDownVO {
    private String label;
    private Integer value;
    private Integer score;
}
