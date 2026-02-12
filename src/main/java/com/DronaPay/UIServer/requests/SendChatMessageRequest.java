package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class SendChatMessageRequest {

    @NotNull(message = "Agent cannot be null")
    private Integer agentId;

    @NotNull(message = "Tenant cannot be null")
    private Integer tenantId;

    @NotBlank(message = "Message cannot be null")
    @NotNull(message = "Message cannot be null")
    @NotEmpty(message = "Message cannot be null")
    private String userMessage;
}
