package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class AddNewDecisionRequest {

    @NotNull(message = "Product Id cannot be blank")
    private Integer productId;
    @NotNull(message = "Decision cannot be blank")
    @NotBlank(message = "Decision cannot be blank")
    @NotEmpty(message = "Decision cannot be blank")
    private String vcDecisionName;
    @NotNull(message = "Decision detail cannot be blank")
    @NotBlank(message = "Decision detail cannot be blank")
    @NotEmpty(message = "Decision detail cannot be blank")
    private String vcDecisionDetail;
    @NotNull(message = "Active cannot be blank")
    private Boolean active;
}
