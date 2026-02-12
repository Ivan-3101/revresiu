package com.DronaPay.UIServer.requests;

import lombok.Data;
import lombok.Getter;

@Getter
public class ChangePasswordRequest {
    
    private String oldPassword;

    private String newPassword;

    private String confirmNewPassword;
}
