package com.DronaPay.UIServer.requests;

import lombok.Data;
import lombok.Getter;

@Getter
public class DashboardRequest {
    private String tableName;
    private String jsonFilter;
    private String timeZone;
}
