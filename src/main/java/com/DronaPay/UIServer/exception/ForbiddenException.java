package com.DronaPay.UIServer.exception;

import com.DronaPay.UIServer.model.ClientUser;
import com.DronaPay.UIServer.model.WebUser;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

import java.util.Optional;

//@ResponseStatus(HttpStatus.FORBIDDEN)
@Slf4j
@Getter
public class ForbiddenException extends RuntimeException {

    private String message;
    private WebUser webUser;
    private String parameters;
    private String type="";
    private ClientUser clientUser;

    public ForbiddenException(String message, WebUser webUser, String parameters) {
        this.message = message;
        this.parameters = Optional.ofNullable(parameters).orElse("");
        this.webUser = webUser;
    }


    public ForbiddenException(String message, String parameters) {
        this.message = message;
        this.parameters = Optional.ofNullable(parameters).orElse("");
    }

    public ForbiddenException(String message, String parameters, String type) {
        this.message = message;
        this.parameters = Optional.ofNullable(parameters).orElse("");
        this.type = Optional.ofNullable(type).orElse("");
    }

    public ForbiddenException(String message, WebUser webUser, String parameters, String type) {
        this.message = message;
        this.parameters = Optional.ofNullable(parameters).orElse("");
        this.type = Optional.ofNullable(type).orElse("");
    }

    public ForbiddenException(String message) {
        super(message);
    }

}
