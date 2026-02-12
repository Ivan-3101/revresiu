package com.DronaPay.UIServer.requests;

import lombok.Data;

@Data
public class ForgotPasswordRequest {
    
    private String newPassword;
    private String confirmNewPassword;
}
