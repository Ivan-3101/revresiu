package com.DronaPay.UIServer.requests;

import lombok.Data;

@Data
public class ResetUserPasswordRequest {

    private String username;

    private String vcOrgId;
}