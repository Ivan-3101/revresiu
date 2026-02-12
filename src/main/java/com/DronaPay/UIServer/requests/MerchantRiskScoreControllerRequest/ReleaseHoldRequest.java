package com.DronaPay.UIServer.requests.MerchantRiskScoreControllerRequest;


import lombok.Data;
import lombok.Getter;

@Getter
public class ReleaseHoldRequest {

    private String reqid;
    private String org;
    private String txn_id;
    private String type;

}
