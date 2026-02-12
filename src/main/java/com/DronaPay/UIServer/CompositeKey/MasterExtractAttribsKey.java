package com.DronaPay.UIServer.CompositeKey;

import lombok.Data;
import java.io.Serializable;

@Data
public class MasterExtractAttribsKey implements Serializable {
    private String level;
    private String attribpath;

    public MasterExtractAttribsKey() {

    }

    public MasterExtractAttribsKey(String level, String attribpath) {
        this.level = level;
        this.attribpath = attribpath;
    }
}
