package com.DronaPay.UIServer.model;

import com.DronaPay.UIServer.CompositeKey.MasterExtractAttribsKey;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

@Entity
@Table(name = "masterextractattribs", schema = "ui")
@Data
@IdClass(MasterExtractAttribsKey.class)
public class MasterExtractAttribs {
    @Id
    @Column(name = "level")
    String level;

    @Column(name = "displayname")
    String displayName;

    @Id
    @Column(name = "attribpath", columnDefinition = "TEXT")
    String attribpath;

    @Column(name = "datatype")
    String dataType;
    
    @Column(name="itenantid")
    private Integer itenantId;
    
    @Column(name = "attribs", columnDefinition = "jsonb")
    @Type(JsonType.class)
    private JsonNode attribs;
}
