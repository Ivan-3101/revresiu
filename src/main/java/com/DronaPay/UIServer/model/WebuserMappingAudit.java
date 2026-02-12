package com.DronaPay.UIServer.model;

import com.DronaPay.UIServer.CompositeKey.WebuserMappingAuditKey;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "webusermappingaudit", schema = "ui")
@IdClass(WebuserMappingAuditKey.class)
@Getter
@Setter
public class WebuserMappingAudit {

    @Id
    @Column(name = "itenantid")
    private Integer itenantId;

    @Id
    @Column(name = "iorgid")
    private Integer iorgId;

    @Id
    @Column(name = "webuserauditid")
    private Integer webUserAuditID;

    @Id
    @Column(name = "mappingid")
    private Integer mappingID;

    @Id
    @Column(name = "mappingtype")
    private String mappingType;

    public WebuserMappingAudit() {

    }


}
