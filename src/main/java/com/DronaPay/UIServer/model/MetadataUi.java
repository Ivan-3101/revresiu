package com.DronaPay.UIServer.model;


import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

@Entity
@Table(name = "metadata", schema = "ui")
@Data
public class MetadataUi extends CheckerModel {
    @Id
    @Column(name = "imetadataid")
    private Integer iMetadataId;

    @Column(name = "vcpath", length = 256)
    private String vcpath;

    @Column(name = "vcdtype", length = 32)
    private String vcdtype;

    @Column(name = "bscore")
    private Boolean bscore;

    @Column(name = "bml")
    private Boolean bml;

    @Column(name = "bui")
    private Boolean bui;

    @Column(name = "vccolumnname", length = 1024)
    private String vccolumnname;

    @Column(name = "vcdescription", length = 1024)
    private String vcdescription;

    @Column(name = "vcroot", length = 99)
    private String vcroot;

    @Column(name = "vcquery", columnDefinition = "TEXT")
    private String vcquery;

    @Column(name = "irecordstatus")
    private Integer irecordStatus;

    @Type(JsonType.class)
    @Column(name = "vcprefix", columnDefinition = "jsonb", length = 250)
    private JsonNode vcPrefix;

    @Type(JsonType.class)
    @Column(name = "config", columnDefinition = "jsonb", length = 250)
    private JsonNode config;

    @Column(name="itenantid")
    private Integer itenantId;
}
