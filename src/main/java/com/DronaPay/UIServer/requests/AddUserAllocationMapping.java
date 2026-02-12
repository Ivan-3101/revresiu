package com.DronaPay.UIServer.requests;

import java.util.List;
import lombok.Data;
import lombok.Getter;

@Getter
public class AddUserAllocationMapping {
    private List<Integer> role1userids;
    private Integer role2userid;
    private Integer role1groupid;
    private Integer role2groupid;
    private Integer workflowid;
    private Integer itenantId;
}
