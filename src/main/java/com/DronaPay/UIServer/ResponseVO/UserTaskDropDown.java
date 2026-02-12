package com.DronaPay.UIServer.ResponseVO;

import java.util.List;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class UserTaskDropDown {
    private Object label;
    private Object value;
    private List<String> groups;
}