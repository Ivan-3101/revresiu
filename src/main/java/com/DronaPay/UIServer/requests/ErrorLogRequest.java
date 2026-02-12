package com.DronaPay.UIServer.requests;

import lombok.Getter;

@Getter
public class ErrorLogRequest {
    private String level;
    private String message;
    private String url;
    private String body;
    private String error;
    private String requestType;
}
