package com.DronaPay.UIServer.response;

import lombok.Builder;
import lombok.Data;

import java.time.ZonedDateTime;

@Builder
@Data
public class WindowResponse {

    private Boolean auditEntry;

    private Boolean auditExist;

    private String lastStatus;

    private ZonedDateTime lastUpdate;

    private String latestRemark;

    private String makerChecker;

    private String action;

    private String windowName;

    private String windowDuration;

    private Integer windowCount;

    private Integer wId;

    private Integer wAuditId;

    private String wdesc;

    private Integer itenantId;

    private String tenantName;
}
