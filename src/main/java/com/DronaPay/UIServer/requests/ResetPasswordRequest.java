package com.DronaPay.UIServer.requests;

import lombok.Data;
import lombok.Getter;

@Getter
public class ResetPasswordRequest {
    
    private String newPassword;
    private String confirmNewPassword;
    private String resetToken;
}
