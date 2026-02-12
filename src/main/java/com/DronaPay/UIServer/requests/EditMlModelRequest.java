package com.DronaPay.UIServer.requests;

import com.fasterxml.jackson.databind.JsonNode;
import jakarta.validation.constraints.*;
import lombok.Data;

@Data
public class EditMlModelRequest {

    @NotNull(message = "Model id cannot be null")
    private Integer imodelId;

    @NotBlank(message = "Model name cannot be blank")
    @NotNull(message = "Model name cannot be blank")
    @NotEmpty(message = "Model name cannot be blank")
    @Size(min = 2, max = 50, message = "Model name must be between 2 and 50 characters")
    @Pattern(regexp = "^[a-zA-Z0-9 ._\\-/\\\\&()\\[\\]{}]+$",
            message = "Model name can only contain letters, numbers, space, dot (.), underscore (_), hyphen (-), " +
                    "forward slash (/), backward slash (\\), ampersand (&) and brackets")
    private String mlModelName;

    @NotBlank(message = "Model description cannot be blank")
    @NotNull(message = "Model description cannot be blank")
    @NotEmpty(message = "Model description cannot be blank")
    @Size(min = 2, max = 50, message = "Model description must be between 2 and 50 characters")
    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%'/\\\\&.()\\[\\]{}-]+$",
            message = "Model description can only contain letters, numbers, hyphen (-), comma (,), underscore (_)," +
                    " at (@), space, asterisk (*), hash (#), percentage (%), single quote ('), slashes (/ or \\), " +
                    "ampersand (&), dot (.) and brackets")
    private String mlModelDescription;

    @DecimalMin(value = "0.0", inclusive = true, message = "Model version must be a non-negative number")
    private Double mlVersion;

    @NotNull(message = "Model status cannot be blank")
    @NotEmpty(message = "Model status cannot be blank")
    @NotBlank(message = "Model status cannot be blank")
    private String modelStatus;

    private JsonNode modelDetail;

    @NotBlank(message = "Model type cannot be blank")
    @NotNull(message = "Model type cannot be blank")
    @NotEmpty(message = "Model type cannot be blank")
    private String modelType;

    @NotBlank(message = "Maker remark cannot be blank")
    @NotNull(message = "Maker remark cannot be blank")
    @NotEmpty(message = "Maker remark cannot be blank")
    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%'/\\\\&.()\\[\\]{}-]+$", message = "Maker remark can only contain letters, " +
            "numbers, hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), " +
            "single quote ('), slashes (/ or \\), ampersand (&), dot (.) and brackets")
    private String makerRemark;

    @NotNull(message = "Tenant ID cannot be blank")
    private Integer itenantId;

    @NotNull(message = "Audit cannot be null")
    private Boolean audit;

    private Boolean isVersionUpdate;
}
