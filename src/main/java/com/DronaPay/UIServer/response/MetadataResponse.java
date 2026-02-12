package com.DronaPay.UIServer.response;

import com.fasterxml.jackson.databind.JsonNode;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class MetadataResponse {
    String vcpath;
    String vcroot;
    String path;
    JsonNode vcprefix;
    String description;
    JsonNode config;
}
