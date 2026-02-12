package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

@Data
public class ApproveAiAgentRequest {
    private Integer iagentAuditId;
    @NotBlank(message = "Checker remark cannot be blank")
    @NotNull(message = "Checker remark cannot be blank")
    @NotEmpty(message = "Checker remark cannot be blank")
    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%'/\\\\&.()\\[\\]{}-]+$", message = "Checker remark can only contain letters, numbers, " +
            "hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quote ('), " +
            "slashes (/ or \\), ampersand (&), dot (.) and brackets")
    private String checkerRemark;
    private Boolean approve;
    private Integer tenantId;
}
