package com.DronaPay.UIServer.requests;

import lombok.Getter;



@Getter
public class SubmitTaskOpen {
    
    private String claimedUser;
    private String comments;
    private String taskid;
    private String processId;
    private String body;
}
