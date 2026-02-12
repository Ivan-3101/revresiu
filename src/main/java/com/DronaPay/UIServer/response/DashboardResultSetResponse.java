package com.DronaPay.UIServer.response;

import com.DronaPay.UIServer.ResponseVO.DashboardResultSetVO;
import lombok.Data;

import java.util.HashMap;

@Data
public class DashboardResultSetResponse {

    private Integer numberOfRows;
    private HashMap<Integer, DashboardResultSetVO> resultSet;

    @Override
    protected void finalize() throws Throwable {
        this.numberOfRows = null;
        this.resultSet  = null;
    }
}
