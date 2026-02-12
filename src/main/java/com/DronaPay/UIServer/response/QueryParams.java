package com.DronaPay.UIServer.response;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class QueryParams {

    private String parameterName;
    private String parameterType;
    private Object value;
    private String calcType;
    private String calcUnit;
    private Object calcValue;



}
