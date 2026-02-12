package com.DronaPay.UIServer.util;

import java.util.List;
import java.util.Map;

import lombok.Data;

@Data
public class AllUsersMapping {
    private Map<Integer, UserMapping> userPermissions;
    private Map<Integer, UserMapping> userGroup;
    private Map<Integer, UserMapping> userWorkflow;
    private Map<Integer, List<Integer>> userTenant;
    private Map<Integer, UserMapping> userClass;
}
