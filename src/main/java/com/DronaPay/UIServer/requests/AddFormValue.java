package com.DronaPay.UIServer.requests;


import com.fasterxml.jackson.databind.JsonNode;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;

@Getter
public class AddFormValue {

    @NotNull(message = "Form ID must not be null")
    private Integer iformid;

    @NotNull(message = "Value Json must not be null")
    private JsonNode valuesjson;

    private String processInstanceID;

    private Integer itenantId;
}
