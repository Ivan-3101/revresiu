package com.DronaPay.UIServer.CompositeKey;

import java.io.Serializable;

import com.DronaPay.UIServer.model.Tenant;

public class WorkflowMastersKey implements Serializable {
    private Integer workflowId;
    private Tenant itenantId;
}
