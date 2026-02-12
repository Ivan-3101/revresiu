package com.DronaPay.UIServer.requests;

import com.fasterxml.jackson.databind.JsonNode;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class TestRule {
    @NotNull(message = "Rule connot be empty")
    private JsonNode rule;

    @NotNull(message = "data connot be empty")
    private JsonNode data;

    private Integer itenantid;
}
