package com.DronaPay.UIServer.response;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class TenantDetialResponse {

    private String tenantId;
    private String tenantName;
    private String tenantType;
    private String serverKey;
    private String serverSceret;

}
