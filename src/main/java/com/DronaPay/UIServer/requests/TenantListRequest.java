package com.DronaPay.UIServer.requests;

import java.util.List;

import lombok.Getter;

@Getter
public class TenantListRequest {
    private List<Integer> tenants;
}
