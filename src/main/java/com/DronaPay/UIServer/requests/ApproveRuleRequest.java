package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.Pattern;
import lombok.Data;
import lombok.Getter;

@Getter
public class ApproveRuleRequest {
    
    private Integer itenantId;
    private Integer decisionid;
    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%\\-'\\\\/&.]+$", message = "Checker remark can only contain alphabets, numbers, " +
            "hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quote ('), " +
            "forward slash (/), backslash (\\), ampersand (&) and dot (.)")
    private String checkerRemark;

    private Boolean approve;
}
