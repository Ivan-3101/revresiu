package com.DronaPay.UIServer.response;

import com.fasterxml.jackson.databind.JsonNode;
import lombok.Data;

@Data
public class AiAgentDetailResponse {
    private Integer agentId;
    private String agentName;
    private String description;
    private String initiation;
    private String policy;
    private String prompt;
    private JsonNode config;
    private String vcRemark;
    private String makerChecker;
    private Integer itenantId;
    private String tenantName;
}
