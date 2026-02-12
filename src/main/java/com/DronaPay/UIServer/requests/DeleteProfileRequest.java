package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Getter;

@Getter
public class DeleteProfileRequest {

    @NotBlank(message = "vcroot cannot be blank")
    @NotEmpty(message = "vcroot cannot be blank")
    @NotNull(message = "vcroot cannot be blank")
    String vcroot;

    @NotBlank(message = "vcpath cannot be blank")
    @NotEmpty(message = "vcpath cannot be blank")
    @NotNull(message = "vcpath cannot be blank")
    String vcpath;

    @NotBlank(message = "Maker remark cannot be blank")
    @NotEmpty(message = "Maker remark cannot be blank")
    @NotNull(message = "Maker remark cannot be blank")
    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%'/\\\\&.-]+$", message = "Maker remark can only contain alphabets, numbers, " +
            "hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), " +
            "single quotation ('), forward and backward slash (/ , \\), ampersand (&) and dot (.)")
    String makerRemark;

    @NotNull(message = "Tenant cannot be blank")
    private Integer itenantId;

     @NotNull(message = "Id cannot be null")
    private Integer id;

}
