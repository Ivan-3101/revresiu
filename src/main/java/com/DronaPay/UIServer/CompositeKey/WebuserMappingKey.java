package com.DronaPay.UIServer.CompositeKey;

import com.DronaPay.UIServer.model.WebUser;

import java.io.Serializable;

public class WebuserMappingKey implements Serializable {

    private Integer itenantId;
    private Integer iorgId;
    private Integer webuserID;
    private Integer mappingID;
    private String mappingType;

    public WebuserMappingKey() {
    }

    public WebuserMappingKey(Integer itenantId, Integer iorgId, Integer webuserID, Integer mappingID, String mappringType) {
        itenantId = itenantId;
        iorgId = iorgId;
        webuserID = webuserID;
        mappingID = mappingID;
        mappringType = mappringType;
    }
}
