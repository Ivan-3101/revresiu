package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.Pattern;
import lombok.Data;
import lombok.Getter;

@Getter
public class DeleteTransactionClassRequest {
    
    private Integer classId;
    private Integer itenantId;
    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%'/\\\\&.-]+$", message = "Maker remark can only contain alphabets, " +
            "numbers, space, comma (,), underscore (_), at (@), asterisk (*), hash (#), percentage (%), " +
            "single quotes (' '), forward slash (/), backward slash (\\), ampersand (&) and dot (.)")
    private String makerRemark;
}
