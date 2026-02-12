package com.DronaPay.UIServer.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class DecisionDropDown {
    
    private Object label;
    private Object value;
    private Object productid;
    private Object detail;
    private Object masterdecisionid;
    private Object attribs;
}
