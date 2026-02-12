package com.DronaPay.UIServer.requests;

import lombok.Data;
import lombok.Getter;

@Getter
public class ReassignTask {
    
    private String taskId;
    private String reassignUser;
    private String assignedUser;
    private String processInstanceId;
}
