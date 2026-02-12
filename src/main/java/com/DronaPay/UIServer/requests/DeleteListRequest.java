package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.Pattern;
import lombok.Data;
import lombok.Getter;

@Getter
public class DeleteListRequest {
    
    private String listItemID;
    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%()+'\\\\/&.-]+$", message = "Maker remark can only contain alphabets, numbers," +
            " hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), " +
            "single quotation ('), forward and backward slash (/ , \\), brackets (), plus (+), ampersand (&) and dot (.)")
    private String makerRemark;

    private Integer itenantId;
    
}
