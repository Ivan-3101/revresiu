package com.DronaPay.UIServer.requests;

import com.fasterxml.jackson.databind.JsonNode;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Getter;

@Getter
public class AddNewDecisionRequestGt {

    @NotNull(message = "Product Id cannot be blank")
    private Integer productId;

    @NotNull(message = "Decision cannot be blank")
    @NotBlank(message = "Decision cannot be blank")
    @NotEmpty(message = "Decision cannot be blank")
    @Pattern(regexp = "^[a-zA-Z0-9 _-]+$",
            message = "Decision Name can only contain alphabets, numbers, space, underscore (_) and hyphen (-)")
    private String vcDecisionName;

    @NotNull(message = "Decision detail cannot be blank")
    @NotBlank(message = "Decision detail cannot be blank")
    @NotEmpty(message = "Decision detail cannot be blank")
    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%.-]+$", message = "Decision details can only contain alphabets, numbers, " +
            "hyphen (-), comma (,), underscore (_), at symbol (@), space, asterisk (*), hash (#), percentage (%) " +
            "and dot (.)")
    private String vcDecisionDetail;

    @NotNull(message = "Active cannot be blank")
    private Boolean active;

    @NotNull(message = "Maker remark cannot be blank")
    @NotBlank(message = "Maker remark cannot be blank")
    @NotEmpty(message = "Maker remark cannot be blank")
    @Pattern(regexp = "^[a-zA-Z0-9 ,_\\-'\\\\/&.]+$", message = "Maker remark can only contain alphabets, numbers, " +
            "hyphen (-), comma (,), underscore (_), space, single quotation mark ('), forward slash (/), backslash (\\), " +
            "ampersand (&) and dot (.)")
    private String makerRemark;

    private JsonNode attribs;
    private JsonNode vcResultParams;
    private Integer itenantId;
}
