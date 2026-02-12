package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

@Data
public class DeleteMlModelRequest {

    @NotNull(message = "Model id cannot be null")
    private Integer imodelId;

    @NotNull(message = "Tenant cannot be blank")
    private Integer itenantId;

    @NotBlank(message = "Maker remark cannot be blank")
    @NotNull(message = "Maker remark cannot be blank")
    @NotEmpty(message = "Maker remark cannot be blank")
    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%'/\\\\&.()\\[\\]{}-]+$", message = "Maker remark can only contain letters, numbers, " +
            "hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quote ('), " +
            "slashes (/ or \\), ampersand (&), dot (.) and brackets")
    private String makerRemark;

}
