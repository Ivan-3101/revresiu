package com.DronaPay.UIServer.model;


import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;
import org.hibernate.annotations.Type;

import java.time.ZonedDateTime;

@Entity
@Table(name = "masterconfig", schema = "ui")
@Data
public class MasterConfig {
    @Id
    @Column(name = "iconfigid")
    private Integer iconfigId;

    @Column(name = "configjson", columnDefinition = "jsonb")
    @Type(JsonType.class)
    private JsonNode configJson;

    @Column(name = "configname", unique = true)
    private String configName;

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
