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
@Table(name = "observationwindowsui", schema = "ui")
@Data
public class ObservationWindows extends CheckerModel {

    @Id
    @Column(name = "wid", nullable = false)
    private Integer wid;

    @Column(name = "wname")
    private String wname;

    @Column(name = "wduration")
    private String wDuration;

    @Column(name = "wcount")
    private Integer wCount;

    @Type(JsonType.class)
    @Column(name = "selectexpr", columnDefinition = "jsonb")
    private JsonNode selectExperession;

    @Type(JsonType.class)
    @Column(name = "whereexpr", columnDefinition = "jsonb")
    private JsonNode whereExperession;

    @Type(JsonType.class)
    @Column(name = "groupbyexpr", columnDefinition = "jsonb")
    private JsonNode groupbyExperession;

    @Column(name = "idexpr")
    private String idexpr;

    @Column(name = "tsexpr")
    private String tsexpr;

    @Column(name = "irecordstatus")
    private Integer irecordStatus;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtentrydatetime")
//    private Date dtEntryDateTime;

    @Column(name = "dtentrydatetime", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryDateTime;
    
    @Column(name = "latestremark")
    private String latestRemark;

    @Column(name = "laststatus")
    private String lastStatus;

    @Column(name = "wdesc", columnDefinition = "TEXT")
    private String wdesc;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "itenantid")
    // private Tenant itenantId;

    @Column(name = "itenantid")
    private Integer itenantId;
}

