package com.DronaPay.UIServer.requests;

import lombok.Data;

@Data
public class DashboardFilterOptionRequest {
    private Integer filterID;
    private String parametersJson;
    private String timeZone;
    private Integer tenantId;
}

