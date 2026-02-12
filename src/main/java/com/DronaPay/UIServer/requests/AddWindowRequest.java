package com.DronaPay.UIServer.requests;

import com.fasterxml.jackson.databind.JsonNode;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.PositiveOrZero;
import lombok.Getter;

@Getter
public class AddWindowRequest {

    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%'/\\\\&.-]+$", message = "Maker remark can only contain alphabets, numbers, " +
            "hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), " +
            "single quotation ('), forward and backward slash (/ , \\), ampersand (&) and dot (.)")
    private String makerRemark;

    @Pattern(regexp = "^[a-zA-Z0-9_-]+$", message = "Window Name can only contain alphabets, numbers, underscore (_) " +
            "and hyphen (-)")
    private String windowName;

    @Pattern(regexp = "^[a-zA-Z0-9]+$",
            message = "Window Duration can only contain alphabets and numbers")
    private String windowDuration;

    @PositiveOrZero(message = "Window Count must be a non-negative number")
    private Integer windowCount;

    private JsonNode selectExpr;
    private JsonNode whereExpr;
    private JsonNode groupByExpr;
    private Integer windowId;

    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%'\\\\/&.-]*$", message = "Window Description can only contain alphabets, " +
            "numbers, hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), " +
            "single quotation ('), forward and backward slash (/ , \\), ampersand (&) and dot (.)")
    private String wdesc;

    private Integer itenantId;
    private String idexpr;
    private String tsexpr;
}
