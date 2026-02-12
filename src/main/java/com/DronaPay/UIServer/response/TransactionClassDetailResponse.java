package com.DronaPay.UIServer.response;

import com.DronaPay.UIServer.requests.AddNewDecisionRequest;
import com.fasterxml.jackson.databind.JsonNode;

import lombok.Data;

@Data
public class TransactionClassDetailResponse {

    private Boolean bactive;
    private Integer iclassid;
    private Integer idecisionid;
    private Integer iproductid;
    private Boolean payer;
    private Boolean payee;
    private Integer channelid;
    private String vcclassname;
    private JsonNode vcdecisionparams;
    private AddNewDecisionRequest addNewDecisionRequest;
    private Integer skipProcessing;
    private JsonNode attribs;
    private Integer itenantId;
    private String tenantName;
}
