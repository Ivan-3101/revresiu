package com.DronaPay.UIServer.requests;

import com.fasterxml.jackson.databind.JsonNode;

import lombok.Data;

@Data
public class AddSimulationApiRequest {
    private String note;
    private Integer idecisionid;
    private Integer iruleid;
    private Boolean isbatch;
    private JsonNode vcruledetail;
    private JsonNode vcruleparams;
    private Integer itenantid;
}
