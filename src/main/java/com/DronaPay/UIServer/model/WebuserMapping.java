package com.DronaPay.UIServer.model;

import com.DronaPay.UIServer.CompositeKey.WebuserMappingKey;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "webusermapping", schema = "ui")
@IdClass(WebuserMappingKey.class)
@Getter
@Setter
public class WebuserMapping {

    @Id
    @Column(name = "itenantid")
    private Integer itenantId;

    @Id
    @Column(name = "iorgid")
    private Integer iorgId;

    @Id
    @Column(name = "webuserid")
    private Integer webuserID;

    @Id
    @Column(name = "mappingid")
    private Integer mappingID;

    @Id
    @Column(name = "mappingtype")
    private String mappingType;


}
