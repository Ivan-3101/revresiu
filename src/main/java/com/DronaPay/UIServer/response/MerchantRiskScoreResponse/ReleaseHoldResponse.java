package com.DronaPay.UIServer.response.MerchantRiskScoreResponse;

import lombok.Builder;
import lombok.Data;

@Data
public class ReleaseHoldResponse {
    private Boolean status;
    private String message;
}
