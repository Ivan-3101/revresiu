package com.DronaPay.UIServer.util;

import org.json.JSONArray;
import org.springframework.stereotype.Component;

import com.DronaPay.UIServer.response.KeysTenants;

import java.util.*;

@Component
public class CamundaParamExtractor {
    public KeysTenants extractTenantWorkflows(String parameter) {

        KeysTenants keysTenants = new KeysTenants();

        org.json.JSONObject params = new org.json.JSONObject(parameter);
        List<Integer> itenantids = new ArrayList<>();
        JSONArray tenantJson = params.optJSONArray("tenantIdIn");
        if (tenantJson != null) {
            for (int i = 0; i < tenantJson.length(); i++) {
                itenantids.add(tenantJson.getInt(i));
            }
        }

        List<String> workflowKeys = new ArrayList<>();
        JSONArray keysJson = params.optJSONArray("processDefinitionKeyIn");
        if(keysJson != null) {
            for(int i = 0; i < keysJson.length(); i++) {
                workflowKeys.add(keysJson.getString(i));
            }
        }
        keysTenants.setItenantIds(itenantids);
        keysTenants.setWorkflowKeys(workflowKeys);
        return keysTenants;
    }
}
