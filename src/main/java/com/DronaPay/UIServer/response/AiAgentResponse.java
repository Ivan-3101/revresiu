package com.DronaPay.UIServer.response;

import lombok.Builder;
import lombok.Data;

import java.time.ZonedDateTime;

@Builder
@Data
public class AiAgentResponse {
    private Integer iagentId;
    private Integer iagentAuditId;
    private String agentName;
    private String description;
    private String initiation;
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
