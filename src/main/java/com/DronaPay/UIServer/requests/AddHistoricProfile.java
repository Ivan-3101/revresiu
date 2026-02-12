package com.DronaPay.UIServer.requests;

import com.fasterxml.jackson.databind.JsonNode;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Getter;

@Getter
public class AddHistoricProfile {
    @NotBlank(message = "vcpath cannot be blank")
    @NotEmpty(message = "vcpath cannot be blank")
    @NotNull(message = "vcpath cannot be blank")
    private String vcpath;

    @NotBlank(message = "vcroot cannot be blank")
    @NotEmpty(message = "vcroot cannot be blank")
    @NotNull(message = "vcroot cannot be blank")
    private String vcroot;

    @NotBlank(message = "Data type cannot be blank")
    @NotEmpty(message = "Data type cannot be blank")
    @NotNull(message = "Data type cannot be blank")
    private String dataType;

    @NotBlank(message = "Name cannot be blank")
    @NotEmpty(message = "Name cannot be blank")
    @NotNull(message = "Name cannot be blank")
    private String name;

    @NotBlank(message = "Description cannot be blank")
@NotEmpty(message = "Description cannot be blank")
@NotNull(message = "Description cannot be blank")
@Pattern(
    regexp = "^[a-zA-Z0-9 ,_@*#%'/\\\\&.\\-{}()><\\[\\]]+$",
    message = "Description can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), at (@), space, " +
              "asterisk (*), hash (#), percentage (%), single quotation ('), forward slash (/), backward slash (\\), " +
              "ampersand (&), dot (.), curly braces ({ }), parentheses (()), greater than (>), and square brackets ([])."
)
private String description;

    // @NotBlank(message = "Query cannot be blank")
    // @NotEmpty(message = "Query cannot be blank")
    // @NotNull(message = "Query cannot be blank")
    private String query;

    private JsonNode params;

    @NotNull(message = "Tenant cannot be blank")
    private Integer itenantId;

    @NotBlank(message = "Maker remark cannot be blank")
    @NotEmpty(message = "Maker remark cannot be blank")
    @NotNull(message = "Maker remark cannot be blank")
    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%'/\\\\&.\\-{}()><\\[\\]]+$", message = "Description can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), at (@), space, " +
              "asterisk (*), hash (#), percentage (%), single quotation ('), forward slash (/), backward slash (\\), " +
              "ampersand (&), dot (.), curly braces ({ }), parentheses (()), greater than (>), and square brackets ([]).")
    private String makerRemark;

   
    private Integer id;

  
    private Integer auditId;

    private Boolean isHistoricProfile;
}
