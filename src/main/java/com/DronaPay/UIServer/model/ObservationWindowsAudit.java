package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

import java.time.ZonedDateTime;

@Entity
@Table(name = "observationwindowsuiaudit", schema = "ui")
@Data
public class ObservationWindowsAudit extends MakerModel<ObservationWindowsAudit, ObservationWindows> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "wauitid", nullable = false)
    private Integer wauditId;

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
    private Integer iRecordStatus;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtentrydatetime")
//    private Date dtEntryDateTime;

    @Column(name = "dtentrydatetime", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryDateTime;

    @Column(name = "wid")
    private Integer wid;


    @Column(name = "wdesc", columnDefinition = "TEXT")
    private String wdesc;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "itenantid")
    // private Tenant itenantId;

    @Column(name = "itenantid")
    private Integer itenantId;

    @Override
    public ObservationWindows parseAudit(ObservationWindowsAudit t) {
        ObservationWindows observationWindows = new ObservationWindows();
        observationWindows.setDtApproverStamp(t.getDtApproverStamp());
        observationWindows.setDtEntryDateTime(t.getDtEntryDateTime());
        observationWindows.setDtEntryStamp(t.getDtEntryStamp());
        observationWindows.setGroupbyExperession(t.getGroupbyExperession());
        observationWindows.setIApproverUserID(t.getIApproverUserID());
        observationWindows.setIorgId(t.getIorgId());
        observationWindows.setIEntryUserID(t.getIEntryUserID());
        observationWindows.setIrecordStatus(t.getIRecordStatus());
        observationWindows.setIstatus(t.getIstatus().getIStatusIDForMaster());
        observationWindows.setSelectExperession(t.getSelectExperession());
        observationWindows.setWCount(t.getWCount());
        observationWindows.setWDuration(t.getWDuration());
        observationWindows.setWid(t.getWid());
        observationWindows.setWname(t.getWname());
        observationWindows.setWhereExperession(t.getWhereExperession());
        observationWindows.setWdesc(t.getWdesc());
        observationWindows.setItenantId(t.getItenantId());
        observationWindows.setIdexpr(t.getIdexpr());
        observationWindows.setTsexpr(t.getTsexpr());
        return observationWindows;
    }

}
