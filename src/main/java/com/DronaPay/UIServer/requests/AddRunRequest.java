package com.DronaPay.UIServer.requests;

import com.fasterxml.jackson.databind.JsonNode;

import lombok.Getter;


@Getter
public class AddRunRequest {

    private String note;
    private String dtfrom;
    private String dtto;
    private JsonNode vcruledetail;
    private JsonNode vcruleparams;
    private Integer itenantid;
}
