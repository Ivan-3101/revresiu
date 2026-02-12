package com.DronaPay.UIServer.requests;

import lombok.Getter;

import java.util.*;

import com.fasterxml.jackson.databind.JsonNode;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;

@Getter
public class EmailReportAdd {
    @NotNull(message = "Available report id cannot be blank")
    private Integer id;

    @NotNull(message = "Attribs cannot be blank")
    private JsonNode filterConfig;

   
    @NotEmpty(message = "Email ids cannot be blank")
    private List<String> emailList;

    // @NotEmpty(message = "User cannot be blank")
    private List<String> vcusername;

    @NotNull(message = "Day cannot be blank")
    private Integer day;

    @NotBlank(message = "Frequency cannot be blank")
    private String frequency;

    @NotBlank(message = "Time cannot be blank")
    private String time;

    private Integer itenantId;
}
