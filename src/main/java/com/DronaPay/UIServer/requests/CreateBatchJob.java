package com.DronaPay.UIServer.requests;

import java.util.List;

import com.fasterxml.jackson.databind.JsonNode;

import jakarta.validation.constraints.Pattern;
import lombok.Getter;

@Getter
public class CreateBatchJob {

    private JsonNode jobParameters;
    private Integer typeId;
    private Integer itenantId;
    private List<JsonNode> datas;

    @Pattern(
    regexp = "^[a-zA-Z0-9 ,_/\\\\&.\\-()]*$",
    message = "Remark can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), empty space, " +
              "forward slash (/), backward slash (\\), ampersand (&), dot (.), and parentheses (())."
)
private String vcRemark;
    
}
