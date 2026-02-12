package com.DronaPay.UIServer.response;

import com.fasterxml.jackson.databind.JsonNode;
import lombok.Data;

import java.time.ZonedDateTime;

@Data
public class MlModelDetailResponse {
    private Integer modelId;
    private String modelName;
    private String description;
    private Double version;
    private JsonNode detail;
    private String modelStatus;
    private ZonedDateTime creationTimestamp;
    private ZonedDateTime lastUpdateTimestamp;
    private String type;
    private String vcRemark;
    private String makerChecker;
    private Integer itenantId;
    private String tenantName;
}
