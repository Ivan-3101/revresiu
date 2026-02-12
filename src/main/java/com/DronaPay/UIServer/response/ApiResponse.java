package com.DronaPay.UIServer.response;

import lombok.Data;
import org.springframework.http.HttpStatus;

@Data
public class ApiResponse {
    private Boolean success;
    private String message;
    private HttpStatus status;
    private Object responseObject;

    public ApiResponse(Boolean success, String message) {
        this.success = success;
        this.message = message;
    }

    public ApiResponse(Object responseObject) {
        this.responseObject = responseObject;
        this.success = true;
    }

    public ApiResponse(Object responseObject, Boolean success, String message) {
        this.success = success;
        this.message = message;
        this.responseObject = responseObject;
    }

    public ApiResponse(Object responseObject, Boolean success, String message, HttpStatus status) {
        this.success = success;
        this.message = message;
        this.responseObject = responseObject;
        this.status = status;
    }

    public ApiResponse(Boolean success, String message, HttpStatus status) {
        this.success = success;
        this.message = message;
        this.status = status;
    }

}