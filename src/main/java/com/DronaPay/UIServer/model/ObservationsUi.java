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
@Table(name = "observationsui", schema = "ui")
@Data
public class ObservationsUi extends CheckerModel {

    @Id
    @Column(name = "oid", nullable = false)
    private Integer oid;

    @Column(name = "oname")
    private String oname;

    // @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "wid")
    // private ObservationWindows wid;

    @Column(name = "wid")
    private Integer wid;

    @Type(JsonType.class)
    @Column(name = "wexpr", columnDefinition = "jsonb")
    private JsonNode wExperession;

    @Column(name = "oduration")
    private String oDuration;

    @Column(name = "ocount")
    private Integer oCount;

    @Column(name = "aggregationtype")
    private String aggregationType;

    @Column(name = "irecordstatus")
    private Integer irecordStatus;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtentrydatetime")
//    private Date dtEntryDateTime;

    @Column(name = "dtentrydatetime", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryDateTime;

    @Type(JsonType.class)
    @Column(name = "whereexpr", columnDefinition = "jsonb")
    private JsonNode whereExperession;

    @Column(name = "latestremark")
    private String latestRemark;

    @Column(name = "laststatus")
    private String lastStatus;

    @Column(name = "odesc", columnDefinition = "TEXT")
    private String odesc;

    // @OneToOne(fetch = FetchType.EAGER)
    // @JoinColumn(name = "itenantid")
    // private Tenant itenantId;

    @Column(name = "itenantid")
    private Integer itenantId;

}
