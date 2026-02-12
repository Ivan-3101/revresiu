package com.DronaPay.UIServer.response;

import com.fasterxml.jackson.databind.JsonNode;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class WindowDetailResponse {

    private Integer wId;
    private String remark;
    private String wName;
    private String wDuration;
    private Integer wCount;
    private JsonNode selectExpr;
    private JsonNode whereExpr;
    private JsonNode groupByExpr;
    private Integer orgId;
    private String wdesc;
    private Integer itenantId;
    private String tenantName;
    private String idexpr;
    private String tsexpr;
}
