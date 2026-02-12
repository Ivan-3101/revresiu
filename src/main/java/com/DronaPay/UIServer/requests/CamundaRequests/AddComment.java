package com.DronaPay.UIServer.requests.CamundaRequests;

import lombok.Data;
import lombok.Getter;

@Data
public class AddComment {
    private String taskid;
    private String message;
    private String processInstanceId;
}
