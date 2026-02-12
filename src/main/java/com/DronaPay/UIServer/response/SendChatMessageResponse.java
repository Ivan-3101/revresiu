package com.DronaPay.UIServer.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import com.fasterxml.jackson.databind.JsonNode;

@Data
@AllArgsConstructor
public class SendChatMessageResponse {
    private Integer agentId;
    private JsonNode agentReply;
}
