package com.DronaPay.UIServer.ResponseVO;

import com.fasterxml.jackson.databind.JsonNode;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class HistoricProfileVO {
    String vcpath;
    String vcdtype;
    Boolean bscore;
    Boolean bml;
    Boolean bui;
    String vccolumnname;
    String vcdescription;
    String vcroot;
    String vcquery;
    JsonNode params;
    JsonNode vcprefix;
    Boolean auditEntry;
    Boolean auditExist;
    String makerChecker;
    String latestRemark;
    Integer itenantId;
    String tenantName;
    Integer id;
    Integer auditId;
}
