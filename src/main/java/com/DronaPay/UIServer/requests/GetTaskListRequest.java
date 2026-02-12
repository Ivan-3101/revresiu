package com.DronaPay.UIServer.requests;


import lombok.Data;

import java.util.List;


@Data
public class GetTaskListRequest {
    private Integer maxResult;
    private String parameters;
    private Boolean open;
    private Boolean sortDir;
    private String sortBy;
    private Double minAmount;
    private Double maxAmount;
    private String type;
    private String level;
    private String address;
    private List<String> defKey;
    private String failedRules;
    private String startDate;
    private String endDate;
    private List<String> stage;
    private Integer riskScore;
    private String ticketid;
    private Boolean closed;
    private Boolean my;


}
