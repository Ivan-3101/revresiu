package com.DronaPay.UIServer.ResponseVO;

import lombok.Data;

import java.util.*;

@Data
public class AvailableReportsVO {
    List<Map<String, Object>> userInfo;
    List<Map<String, Object>> availableReports;
}
