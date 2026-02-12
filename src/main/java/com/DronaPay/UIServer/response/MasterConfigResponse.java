package com.DronaPay.UIServer.response;

import com.fasterxml.jackson.databind.JsonNode;

import lombok.Data;

@Data
public class MasterConfigResponse {
    JsonNode configJson;
    String name;
}
