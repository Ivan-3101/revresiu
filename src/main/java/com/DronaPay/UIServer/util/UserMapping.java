package com.DronaPay.UIServer.util;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class UserMapping {
    List<Integer> mappingIds;
    List<Integer> tenantids;

    public UserMapping() {
        mappingIds = new ArrayList<>();
        tenantids = new ArrayList<>();
    }
}
