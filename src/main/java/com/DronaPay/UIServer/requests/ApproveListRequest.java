package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.Pattern;
import lombok.Data;
import lombok.Getter;

@Getter
public class ApproveListRequest {
    
    // private Integer auditId;
    private Integer itenantId;
    private String externalID;

    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%()+'\\\\/&.-]+$", message = "Checker remark can only contain alphabets, numbers," +
            " hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), " +
            "single quotation ('), forward and backward slash (/ , \\), brackets (), plus (+), ampersand (&) and dot (.)")
    private String checkerRemark;

    private Boolean approve;
    private String processInstanceId;
    
//    private String taskid;
}
