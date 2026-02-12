package com.DronaPay.UIServer.requests;

import lombok.Data;

@Data
public class ClientUserLoginRequest {
    private String clientid;
    private String clientsecret;
}
