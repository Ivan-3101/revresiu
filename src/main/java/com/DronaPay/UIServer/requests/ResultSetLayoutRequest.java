package com.DronaPay.UIServer.requests;

import lombok.Getter;

@Getter
public class ResultSetLayoutRequest {
    private String layoutJsonString;
    private Integer resultSetID;
    private Boolean setDefault;
    private Boolean setForMySelf;
    private Boolean resetMyself;
    private Integer tenantId;
}
