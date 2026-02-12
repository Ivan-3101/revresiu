package com.DronaPay.UIServer.requests;

import com.fasterxml.jackson.databind.JsonNode;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;

@Getter
public class AddTenantRequest {
    @NotBlank(message = "Tenant name cannot be blank")
    private String tenantName;

    @NotBlank(message = "Organization Id cannot be blank")
    private String orgId;

    private JsonNode outboundEmailSettings;
    private JsonNode inboundEmailSettings;

    @NotBlank(message = "Maker remark cannot be blank")
    private String makerRemark;
}
