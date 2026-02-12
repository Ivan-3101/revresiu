package com.DronaPay.UIServer.ResponseVO;

import com.DronaPay.UIServer.response.ResultSetResponse;
import lombok.Data;

@Data
public class DashboardResultSetVO {
    private String DashboardName;
    private String DashboardLayout;
    private String Schema;
    private ResultSetResponse DashboardData;
    private String DashboardColumns;
    private Boolean parametersRequired;
    private String parametersJsonString;
    private Integer colSize;
    private Integer rowNo;
    private Boolean loading = false;
    private Integer iQueryID;
}
