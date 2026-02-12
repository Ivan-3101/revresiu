package com.DronaPay.UIServer.requests;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class DashboardQueryRequestGt {
    private Integer queryID;
    private String parametersJson;
    private String timeZone;
    private String inputTimezone;
    private String dashboardName;
}
