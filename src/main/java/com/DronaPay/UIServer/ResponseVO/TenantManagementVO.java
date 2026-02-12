package com.DronaPay.UIServer.ResponseVO;

import com.fasterxml.jackson.databind.JsonNode;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class TenantManagementVO {
    private String tenantExternalId;
    private String tenantName;
    private String orgName;
    private JsonNode inboundEmailSettings;
    private JsonNode outboundEmailSettings;
    private Boolean auditExist;
    private Boolean auditEntry;
    private String remarks;
    private String makerChecker;
    private String action;
}
