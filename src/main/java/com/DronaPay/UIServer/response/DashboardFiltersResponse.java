package com.DronaPay.UIServer.response;

import com.fasterxml.jackson.databind.JsonNode;
import lombok.Data;

import java.util.List;
import java.util.Map;

@Data

public class DashboardFiltersResponse {
    private List<Map<String, Object>> options;
    private String diplayName;
    private Object value;
    private Boolean parametersRequired = false;
    private String parametersJsonString;
    private Integer filterQueryID;
    private String filterType;
    private Integer filterID;
    private JsonNode validation;
}
