package com.DronaPay.UIServer.exception;

import com.DronaPay.UIServer.model.ClientUser;
import com.DronaPay.UIServer.model.WebUser;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

import java.util.Optional;


@Slf4j
@Getter
public class NotFoundException extends RuntimeException {

    private String message;
    private WebUser webUser;
    private String parameters;
    private String type="";
    private ClientUser clientUser;

    public NotFoundException(String message, WebUser webUser, String parameters) {
        this.message = message;
        this.parameters = Optional.ofNullable(parameters).orElse("");
        this.webUser = webUser;
    }

    
    public NotFoundException(String message, String parameters) {
        this.message = message;
        this.parameters = Optional.ofNullable(parameters).orElse("");
    }

    public NotFoundException(String message, String parameters, String type) {
        this.message = message;
        this.parameters = Optional.ofNullable(parameters).orElse("");
        this.type = Optional.ofNullable(type).orElse("");
    }

}
