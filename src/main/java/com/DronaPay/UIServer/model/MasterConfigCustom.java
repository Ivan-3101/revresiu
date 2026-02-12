package com.DronaPay.UIServer.model;


import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

import java.time.ZonedDateTime;

@Entity
@Table(name = "masterconfigcustom", schema = "ui")
@Data
public class MasterConfigCustom {
    @Id
    @Column(name = "icustomid")
    private Integer icustomId;

    @Column(name = "configjson", columnDefinition = "jsonb")
    @Type(JsonType.class)
    private JsonNode configJson;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "iparentid")
    private MasterConfig iparentId;

    @Column(name = "bdelete")
    private Boolean bdelete;

//    @Column(name = "createdtime")
//    private Date createdTime;


    @Column(name = "createdtime", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime createdTime;


//    @Column(name = "updatedtime")
//    private Date updatedTime;


    @Column(name = "updatedtime", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime updatedTime;
}
