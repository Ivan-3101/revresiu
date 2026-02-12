package com.DronaPay.UIServer.exception;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

import java.util.Optional;


@Slf4j
@Getter
public class TokenNotValid extends RuntimeException {

    private String message;
    private String parameters;


    public TokenNotValid(String message, String parameters) {
        this.message = message;
        this.parameters = Optional.ofNullable(parameters).orElse("");
    }


}
