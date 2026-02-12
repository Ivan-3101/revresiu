package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class GetAiAgentRequest {

    @NotNull(message = "Agent id cannot be null")
    private Integer iagentId;

    @NotNull(message = "Tenant cannot be blank")
    private Integer itenantId;

    @NotNull(message = "Audit cannot be null")
    private Boolean audit;

}
