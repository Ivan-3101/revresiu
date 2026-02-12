package com.DronaPay.UIServer.response;

import com.fasterxml.jackson.databind.JsonNode;
import lombok.Builder;
import lombok.Getter;

@Builder
@Getter
public class FormMasterDTO {
    private Integer iFormID;
    private String vcFormName;
    private JsonNode inputJson;
    private JsonNode formattingJson;
    private String displayName;
}
