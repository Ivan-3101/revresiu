package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.Pattern;
import lombok.Data;
import lombok.Getter;

@Getter
public class ApproveDecisionDetails {
    
    private Integer idecisionAuditId;
    @Pattern(regexp = "^[a-zA-Z0-9 ,_\\-'\\\\/&.]+$", message = "Checker remark can only contain alphabets, numbers, " +
            "hyphen (-), comma (,), underscore (_), space, single quotation mark ('), forward slash (/), backslash (\\), " +
            "ampersand (&) and dot (.)")
    private String checkerRemark;
    private Boolean approve;
    private Integer tenantId;
}
