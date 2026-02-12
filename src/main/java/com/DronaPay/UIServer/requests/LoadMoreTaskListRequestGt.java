package com.DronaPay.UIServer.requests;

import lombok.Data;
import lombok.Getter;

@Getter
public class LoadMoreTaskListRequestGt {

    private String parameters;
    private Integer nextStartIndex;
    private Integer maxResult;
    
}
