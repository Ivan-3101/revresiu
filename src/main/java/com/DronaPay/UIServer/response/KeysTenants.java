package com.DronaPay.UIServer.response;

import lombok.Data;
import java.util.*;
@Data
public class KeysTenants {
    private List<Integer> itenantIds;
    private List<String> workflowKeys;
}
