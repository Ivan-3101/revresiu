package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.annotations.Type;

@Entity
@Table(name = "metadataaudit", schema = "ui")

@Data
@Slf4j
public class MetadataUiAudit extends MakerModel<MetadataUiAudit, MetadataUi> {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "imetadataauditid")
    private Integer iMetadataAuditId;

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

    
    @Column(name = "imetadataid")
    private Integer iMetadataId;

    @Override
    public MetadataUi parseAudit(MetadataUiAudit t) {

        MetadataUi metaUi = new MetadataUi();
        metaUi.setBui(t.getBui());
        metaUi.setBscore(t.getBscore());
        metaUi.setBml(t.getBml());
        metaUi.setVcPrefix(t.getVcPrefix());
        metaUi.setVcroot(t.getVcroot());
        metaUi.setVccolumnname(t.getVccolumnname());
        metaUi.setVcdtype(t.getVcdtype());
        metaUi.setVcdescription(t.getVcdescription());
        metaUi.setVcpath(t.getVcpath());
        metaUi.setVcquery(t.getVcquery());
        metaUi.setConfig(t.getConfig());
        metaUi.setIrecordStatus(0);
        metaUi.setItenantId(t.getItenantId());
        return metaUi;
    }

}
