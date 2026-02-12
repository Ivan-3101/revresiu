package com.DronaPay.UIServer.CompositeKey;

import lombok.Data;

import java.io.Serializable;

@Data
public class AllocationUsersKey implements Serializable {
    // private Integer allocationID;
    private Integer role1UserID;

    private Integer role2UserID;

    private Integer role1GroupID;

    private Integer role2GroupID;

    private Integer workflowID;

    private Integer itenantId;

    private Integer iorgId;

    public AllocationUsersKey() {
    }

    public AllocationUsersKey(Integer role1UserID, Integer role2UserID, Integer role1GroupID,
                              Integer role2GroupID, Integer workflowID, Integer itenantId, Integer iorgId) {
        // this.allocationID = allocationID;
        this.role1UserID = role1UserID;
        this.role2UserID = role2UserID;
        this.role1GroupID = role1GroupID;
        this.role2GroupID = role2GroupID;
        this.workflowID = workflowID;
        this.iorgId = iorgId;
        this.itenantId = itenantId;
    }
}
