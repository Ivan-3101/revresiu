package com.DronaPay.UIServer.requests;

import java.util.List;

import lombok.Getter;

@Getter
public class BatchStatusRequest {
    List<String> workflowKey;
}

