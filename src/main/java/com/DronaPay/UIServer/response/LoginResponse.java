package com.DronaPay.UIServer.response;

import lombok.Data;

@Data
public class LoginResponse {

    private String token;
    private boolean changePassword;
    private String refreshToken;
    private String tokentype;
    private Integer expirein;
    private String idtoken;

}
