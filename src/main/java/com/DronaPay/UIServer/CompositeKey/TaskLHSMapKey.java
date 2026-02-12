package com.DronaPay.UIServer.CompositeKey;

import lombok.Data;

import java.io.Serializable;

@Data
public class TaskLHSMapKey implements Serializable {
    // private Integer allocationID;
    private Integer workflowId;

    private Integer optionId;

    private Integer iorder;

    private Integer irow;


    private Integer itenantId;

    public TaskLHSMapKey() {
    }

    public TaskLHSMapKey(Integer workflowId, Integer optionId, Integer iorder,
                         Integer irow, Integer itenantId) {
        // this.allocationID = allocationID;
        this.workflowId = workflowId;
        this.optionId = optionId;
        this.iorder = iorder;
        this.irow = irow;
        this.itenantId = itenantId;
    }
}
