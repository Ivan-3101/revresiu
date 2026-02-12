package com.DronaPay.UIServer.requests;

import lombok.Data;
import lombok.Getter;

@Getter
public class ClaimBulkRequest {
    
    private String taskid;
    private String processid;
}
