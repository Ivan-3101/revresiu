package com.DronaPay.UIServer.requests;

import com.DronaPay.UIServer.ResponseVO.RuleAvailable;
import jakarta.validation.constraints.Pattern;
import lombok.Getter;
import lombok.ToString;

import java.util.LinkedList;

@Getter
@ToString
public class EditDefaultRuleRequest {

    private Integer itenantId;
    private int decisionId;
    private LinkedList<RuleAvailable> editRule;

    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%\\-'\\\\/&.]+$", message = "Maker remark can only contain alphabets, numbers, " +
            "hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quote ('), " +
            "forward slash (/), backslash (\\), ampersand (&) and dot (.)")
    private String makerRemark;

    private Boolean audit;

}
