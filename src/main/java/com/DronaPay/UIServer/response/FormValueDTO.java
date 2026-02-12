package com.DronaPay.UIServer.response;

import com.fasterxml.jackson.databind.JsonNode;
import lombok.Builder;
import lombok.Getter;

@Builder
@Getter
public class FormValueDTO {

    private Integer iFormValueID;
    private JsonNode valueJson;
    private FormMasterDTO formMaster;
}
