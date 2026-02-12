package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;

@Getter
public class DeleteTenantRequest {
    @NotBlank(message = "Tenant Id cannot be blank")
    private String tenantExternalId;

    @NotBlank(message = "Maker remark cannot be blank")
    private String makerRemark;
}
