package com.DronaPay.UIServer.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class QcResponse {
    private String user;
    private String emailId;
}
