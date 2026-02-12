package com.DronaPay.UIServer.requests;


import com.DronaPay.UIServer.Cache.LoggedUser;

import com.DronaPay.UIServer.util.UserMapping;
import lombok.Data;

@Data
public class DashboardQueryRequest {
    private Integer queryID;
    private String parametersJson;
    private String timeZone;
    private String inputTimezone;

    private Integer itenantID;
    private Long executionID;
    private Integer iuserid;
    private Integer iorgid;
    private UserMapping classIds;
    private String dashboardName;
}
