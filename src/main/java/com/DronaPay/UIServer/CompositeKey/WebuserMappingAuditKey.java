package com.DronaPay.UIServer.CompositeKey;

import com.DronaPay.UIServer.model.WebUserAudit;

import java.io.Serializable;

public class WebuserMappingAuditKey implements Serializable {
    private Integer itenantId;
    private Integer iorgId;
    private Integer webUserAuditID;
    private Integer mappingID;
    private String mappingType;

    public WebuserMappingAuditKey() {
    }

    public WebuserMappingAuditKey(Integer itenantid, Integer iorgid, Integer webUserAuditID, Integer mappingID, String mappingType) {
        this.itenantId = itenantid;
        this.iorgId = iorgid;
        this.webUserAuditID = webUserAuditID;
        this.mappingID = mappingID;
        this.mappingType = mappingType;
    }
}
