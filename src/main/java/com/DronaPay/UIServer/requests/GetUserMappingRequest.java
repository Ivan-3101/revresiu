package com.DronaPay.UIServer.requests;

import java.util.List;

import lombok.Data;
import lombok.Getter;

@Getter
public class GetUserMappingRequest {
    private String workflowKey;
    private String parentUserName;
    private List<String> parentUserGroupID;
    private List<String> childUserGroupID;
    private String childUserName;
}
