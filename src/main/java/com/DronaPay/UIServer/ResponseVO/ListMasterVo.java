package com.DronaPay.UIServer.ResponseVO;

import com.fasterxml.jackson.databind.JsonNode;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ListMasterVo {
    private String label;
    private Integer value;
    private Integer expiry;
    private JsonNode iConfigJson;
}
