package com.DronaPay.UIServer.response;

import com.fasterxml.jackson.databind.JsonNode;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class ObservationDetailResponse {

    private Integer id;
    private String remark;
    private String aggregationType;
    private Integer observationCount;
    private String observationDuration;
    private String observationName;
    private JsonNode wExpr;
    private JsonNode whereExpr;
    private Integer wId;
    private Integer orgId;
    private String wdesc;
    private String odesc;
    private Integer itenantId;
    private String tenantName;

}
