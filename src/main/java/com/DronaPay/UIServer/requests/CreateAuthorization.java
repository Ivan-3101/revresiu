package com.DronaPay.UIServer.requests;

import lombok.Data;

@Data
public class CreateAuthorization {
    Integer type;
    String permissions;
    String userId;
    String groupId;
    Integer resourceType;
    String resourceId;
}
