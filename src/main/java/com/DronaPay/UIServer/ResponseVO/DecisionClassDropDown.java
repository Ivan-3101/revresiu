package com.DronaPay.UIServer.ResponseVO;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class DecisionClassDropDown {

    private Object label;
    private Object value;
    private Integer idecisionAuditID;
    private Object prooductId;
    private Object vcResultParam;
    private Object lastUpdate;
    private Object latestRemark;
    private Object lastStatus;
    private Boolean auditEntry;
    private Boolean auditExist;
    private String makerChecker;
    private String action;
    private Integer itenantId;
    private String tenantName;
    
}
