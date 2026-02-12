package com.DronaPay.UIServer.requests.CamundaRequests;

import lombok.Data;
import lombok.Getter;

@Getter
public class AddCommentGt {
    private String taskid;
    private String message;
    private String processInstanceId;
}
