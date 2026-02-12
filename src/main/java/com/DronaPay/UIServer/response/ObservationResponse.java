package com.DronaPay.UIServer.response;

import lombok.Builder;
import lombok.Data;

import java.time.ZonedDateTime;

@Builder
@Data
public class ObservationResponse {

    private Boolean auditEntry;

    private Boolean auditExist;

    private String lastStatus;

    private ZonedDateTime lastUpdate;

    private String latestRemark;

    private String makerChecker;

    private String action;

    private String observationName;

    private String observationDuration;

    private Integer observationCount;

    private String aggregationType;

    private Integer oId;

    private Integer oAuditId;

    private Integer wId;

    private String wdesc;

    private Integer itenantId;

    private String tenantName;
}
