package com.DronaPay.UIServer.ResponseVO;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class RuleAvailableVO {
    String name;
    String description;
    String label;
    String vcruledetail;
    String vcruleparams;
}
