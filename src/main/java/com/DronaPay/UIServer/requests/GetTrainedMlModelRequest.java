package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class GetTrainedMlModelRequest {

    @NotEmpty(message = "Model name cannot be null")
    @NotBlank(message = "Model name cannot be null")
    @NotNull(message = "Model name cannot be null")
    private String modelName;

    @NotNull(message = "Model status cannot be null")
    @NotEmpty(message = "Model status cannot be null")
    @NotBlank(message = "Model status cannot be null")
    private String modelStatus;

    @NotNull(message = "Tenant cannot be blank")
    private Integer itenantId;

}
