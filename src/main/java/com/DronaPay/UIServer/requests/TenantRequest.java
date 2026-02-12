package com.DronaPay.UIServer.requests;

import com.fasterxml.jackson.databind.JsonNode;

import lombok.Getter;

@Getter
public class TenantRequest {
    private JsonNode config;
    private JsonNode attribs;
}
