package com.DronaPay.UIServer.requests;

import lombok.Data;
import lombok.Getter;

@Data
public class LoadMoreTaskListRequest {

    private String parameters;
    private Integer nextStartIndex;
    private Integer maxResult;
    
}
