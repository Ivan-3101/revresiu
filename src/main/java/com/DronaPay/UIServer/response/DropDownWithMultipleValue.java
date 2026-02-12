package com.DronaPay.UIServer.response;

import java.util.ArrayList;
import java.util.List;

import lombok.Builder;
import lombok.Data;


@Data
public class DropDownWithMultipleValue {
    private Object label;
    private List<String> value;
}
