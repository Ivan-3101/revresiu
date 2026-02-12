package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class GetMlModelRequest {

    @NotNull(message = "Model id cannot be null")
    private Integer imodelId;

    @NotNull(message = "Tenant cannot be blank")
    private Integer itenantId;

    @NotNull(message = "Audit cannot be null")
    private Boolean audit;

}
