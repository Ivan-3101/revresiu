package com.DronaPay.UIServer.requests.CamundaRequests;

import lombok.Data;
import lombok.Getter;

import java.util.List;


@Getter
public class PriorityQueueTaskRequest {
    private List<String> variablelist;
    private String value;
    private Integer maxResult;
    private String sortOrder;
}
