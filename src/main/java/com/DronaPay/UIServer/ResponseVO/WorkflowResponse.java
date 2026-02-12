package com.DronaPay.UIServer.ResponseVO;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class WorkflowResponse {
    String label;
    Integer value;
    String workflowKey;
    Integer itenantId;
}
