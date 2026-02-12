package com.DronaPay.UIServer.response;

import com.fasterxml.jackson.databind.JsonNode;

import lombok.Data;

@Data
public class DecisionDetailsResponse {
    
    private Integer decisionId;
    private Integer productId;
    private String label;
    private JsonNode vcResultParam;
    private JsonNode attribs;
    private String decisionDetail;
    private String latestRemark;
    private String makerChecker;
    private Integer itenantId;
    private String tenantName;
}
