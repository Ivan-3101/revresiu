package com.DronaPay.UIServer.requests;

import lombok.Getter;

@Getter
public class GetWorkflowState {
    private String workFlowKey;
    private Integer tenantId;
}
