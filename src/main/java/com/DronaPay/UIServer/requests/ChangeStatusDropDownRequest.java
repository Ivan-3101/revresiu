package com.DronaPay.UIServer.requests;

import lombok.Data;
import lombok.Getter;


@Getter
public class ChangeStatusDropDownRequest {
    private String workFlowKey;
    private String userTaskState;
    private Integer tenantId;
}
