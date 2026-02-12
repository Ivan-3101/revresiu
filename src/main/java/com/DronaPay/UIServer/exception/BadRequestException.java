package com.DronaPay.UIServer.exception;

import com.DronaPay.UIServer.model.ClientUser;
import com.DronaPay.UIServer.model.WebUser;
import lombok.Getter;

import java.util.Optional;


@Getter
public class BadRequestException extends RuntimeException {

    private String message;
    private WebUser webUser;
    private String parameters;

    private ClientUser clientUser;

    public BadRequestException(String message, WebUser webUser, String parameters) {
        this.message = message;
        this.parameters = Optional.ofNullable(parameters).orElse("");
        this.webUser = webUser;
    }


    public BadRequestException(String message, String parameters) {
        this.message = message;
        this.parameters = Optional.ofNullable(parameters).orElse("");
    }

}