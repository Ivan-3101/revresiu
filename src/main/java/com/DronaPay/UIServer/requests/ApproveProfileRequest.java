package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Getter;

@Getter
public class ApproveProfileRequest {
    @NotBlank(message = "vcroot cannot be blank")
    @NotEmpty(message = "vcroot cannot be blank")
    @NotNull(message = "vcroot cannot be blank")
    private String vcroot;

    @NotBlank(message = "vcpath cannot be blank")
    @NotEmpty(message = "vcpath cannot be blank")
    @NotNull(message = "vcpath cannot be blank")
    private String vcpath;

    private Integer auditId;

    @NotBlank(message = "checker remark cannot be blank")
    @NotEmpty(message = "checker remark cannot be blank")
    @NotNull(message = "checker remark cannot be blank")
    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%'/\\\\&.-]+$", message = "Checker remark can only contain alphabets, numbers, " +
            "hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), " +
            "single quotation ('), forward and backward slash (/ , \\), ampersand (&) and dot (.)")
    private String checkerRemark;

    @NotNull(message = "Tenant cannot be blank")
    private Integer itenantId;

    @NotNull(message = "approve cannot be blank")
    private Boolean approve;

}
