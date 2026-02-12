package com.DronaPay.UIServer.CompositeKey;

import lombok.Data;

import java.io.Serializable;

@Data
public class MetaDataKey implements Serializable {
    private String vcpath;

    private String vcroot;

    public MetaDataKey() {
    }

    public MetaDataKey(String vcpath, String vcroot) {
        this.vcpath = vcpath;
        this.vcroot = vcroot;
    }
}
