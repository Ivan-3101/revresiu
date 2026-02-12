package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;

@Getter
public class ApproveTenantRequest {
    @NotBlank(message = "Tenant Id cannot be blank")
    private String tenantExternalId;

    @NotNull(message = "Approve cannot be blank")
    private Boolean approve;

    @NotBlank(message = "Checker remark cannot be blank")
    private String checkerRemark;
}
