package com.DronaPay.UIServer.requests;

import com.fasterxml.jackson.databind.JsonNode;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;

@Getter
public class EditTenantRequest {
    @NotBlank(message = "Tenant Id cannot be blank")
    private String tenantExternalId;

    @NotNull(message = "Audit cannot be blank")
    private Boolean audit;

    @NotBlank(message = "Tenant name cannot be blank")
    private String tenantName;


    private JsonNode outboundEmailSettings;
    private JsonNode inboundEmailSettings;

    @NotBlank(message = "Maker remark cannot be blank")
    private String makerRemark;
}
