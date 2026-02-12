package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class GetPreviousChatsRequest {
    @NotNull(message = "Agent cannot be null")
    private Integer agentId;

    @NotNull(message = "Tenant cannot be null")
    private Integer tenantId;

    private Integer limit;

    private Integer offset;
}
