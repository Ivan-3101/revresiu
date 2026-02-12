package com.DronaPay.UIServer.ResponseVO;


import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class DropdownWithObject {
    private Object label;
    private Object value;
}
