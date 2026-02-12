package com.DronaPay.UIServer.response;

import com.fasterxml.jackson.databind.JsonNode;
import lombok.Builder;
import lombok.Data;

import java.time.ZonedDateTime;

@Builder
@Data
public class MlModelAvailableResponse {
    private Integer imodelId;
    private Integer imodelAuditId;
    private String modelName;
    private String description;
    private String type;
    private Double currentVersion;
    private Double latestVersion;
    private JsonNode detail;
    private ZonedDateTime createdDate;
    private ZonedDateTime lastUpdate;
    private String latestRemark;
    private String lastStatus;
    private Boolean auditEntry;
    private Boolean auditExist;
    private String makerChecker;
    private String action;
    private Integer itenantId;
    private String tenantName;

}
