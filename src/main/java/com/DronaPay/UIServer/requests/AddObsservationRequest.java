package com.DronaPay.UIServer.requests;

import com.fasterxml.jackson.databind.JsonNode;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.PositiveOrZero;
import lombok.Getter;

@Getter
public class AddObsservationRequest {

    @Pattern(
    regexp = "^[a-zA-Z0-9_>]+$",
    message = "Observation Name can only contain alphabets, numbers, underscore (_) and greater than (>)"
)
private String observationName;


    private Integer windowId;
    private JsonNode wgExpr;

    @Pattern(regexp = "^[a-zA-Z0-9]+$",
            message = "Observation Duration can only contain alphabets and numbers")
    private String observationDuration;

    @PositiveOrZero(message = "Observation Count must be a non-negative number")
    private Integer observationCount;

    private String aggregationType;
    private JsonNode whereExpr;

    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%'/\\\\&.-]+$", message = "Maker remark can only contain alphabets, numbers, " +
            "hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), " +
            "single quotation ('), forward and backward slash (/ , \\), ampersand (&) and dot (.)")
    private String makerRemark;

    private Integer observationId;

    @Pattern(
    regexp = "^[a-zA-Z0-9 ,_@*#%'\\\\/&.\\->]*$",
    message = "Observation Description can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), " +
              "at (@), space, asterisk (*), hash (#), percentage (%), single quotation ('), forward slash (/), " +
              "backward slash (\\), ampersand (&), dot (.), and greater than (>)"
)
private String odesc;
    
    private Integer itenantId;
}
