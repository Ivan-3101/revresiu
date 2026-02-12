package com.DronaPay.UIServer.requests;

import lombok.Getter;

@Getter
public class AuthenticationRequest {

    private String userName;
    private String password;
    private String orgId;
//
//    public String getUserName() {
//        return userName;
//    }
//    public String getPassword() {
//        return password;
//    }

    @Override
    public String toString() {
        return "AuthenticationRequest{" +
                "userName='" + userName + '\'' +
                '}';
    }
}
