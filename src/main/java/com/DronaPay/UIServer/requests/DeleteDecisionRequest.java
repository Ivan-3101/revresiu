package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.Pattern;
import lombok.Data;
import lombok.Getter;

@Getter
public class DeleteDecisionRequest {
    
    private Integer decisionId;
    private Integer itenantId;

    @Pattern(regexp = "^[a-zA-Z0-9 ,_\\-'\\\\/&.]+$", message = "Maker remark can only contain alphabets, numbers, " +
            "hyphen (-), comma (,), underscore (_), space, single quotation mark ('), forward slash (/), backslash (\\), " +
            "ampersand (&) and dot (.)")
    private String makerRemark;
}
