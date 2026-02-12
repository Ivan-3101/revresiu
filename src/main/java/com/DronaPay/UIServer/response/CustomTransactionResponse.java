package com.DronaPay.UIServer.response;

import com.fasterxml.jackson.databind.JsonNode;
import lombok.Builder;
import lombok.Data;

import java.time.ZonedDateTime;

@Builder
@Data
public class CustomTransactionResponse {

    private int iClassID;

    private int iClassAuditID;


    private String vcClassName;

    // private int iProductId;

    // private int iDecisionId;

    // private String vcDecisionParams;

    // private String vcResultParams;

    private Boolean bActive;
    ;

    private Boolean auditEntry;

    private Boolean auditExist;

    private String lastStatus;

    private ZonedDateTime lastUpdate;

    private String latestRemark;

    private String makerChecker;

    private String action;

    private JsonNode decisionParams;

    private JsonNode attribs;

    private Integer itenantId;

    private String tenantName;
}
