package com.DronaPay.UIServer.requests;

import lombok.Getter;

@Getter
public class ProfileParameters {
    private String payerVpa;
    private String payeeVpa;
    private String payerAccount;
    private String payeeAccount;
    private String workflowKey;
    private Integer tenantid;
}
