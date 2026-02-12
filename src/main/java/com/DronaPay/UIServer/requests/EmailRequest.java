package com.DronaPay.UIServer.requests;

import lombok.Data;
import lombok.Getter;

import java.util.*;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class EmailRequest {
    private Integer itenantId;
    private Integer templateid;
    private List<String> toEmail;
    private List<String> ccEmail;
    private List<String> bccEmail;
    private Map<String, Object> bodyParams;
    private Map<String, Object> subjectParams;
    private Map<String, String> providerProperties;
    private String emailProvider;
    private List<EmailAttachment> attachments;
    private List<String> sensitiveVariables;
}
