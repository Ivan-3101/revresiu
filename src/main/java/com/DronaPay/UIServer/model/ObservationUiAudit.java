package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

import java.time.ZonedDateTime;

@Entity
@Table(name = "observationsuiaudit", schema = "ui")
@Data
public class ObservationUiAudit extends MakerModel<ObservationUiAudit, ObservationsUi> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "oauditid", nullable = false)
    private Integer oauditId;

    @Column(name = "oname")
    private String oname;

    // @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "wid")
    // private ObservationWindows wId;

    @Column(name = "wid")
    private Integer wId;

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
    private Integer iRecordStatus;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtentrydatetime")
//    private Date dtEntryDateTime;

    @Column(name = "dtentrydatetime", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryDateTime;


    @Type(JsonType.class)
    @Column(name = "whereexpr", columnDefinition = "jsonb")
    private JsonNode whereExperession;

    @Column(name = "oid")
    private Integer oid;


    @Column(name = "odesc", columnDefinition = "TEXT")
    private String odesc;

    // @OneToOne(fetch = FetchType.EAGER)
    // @JoinColumn(name = "itenantid")
    // private Tenant itenantId;

    @Column(name = "itenantid")
    private Integer itenantId;

    @Override
    public ObservationsUi parseAudit(ObservationUiAudit t) {
        ObservationsUi observationsUi = new ObservationsUi();
        observationsUi.setAggregationType(t.getAggregationType());
        observationsUi.setDtApproverStamp(ZonedDateTime.now());
        observationsUi.setDtEntryDateTime(t.getDtEntryDateTime());
        observationsUi.setDtEntryStamp(t.getDtEntryStamp());
        observationsUi.setIEntryUserID(t.getIEntryUserID());
        observationsUi.setIorgId(t.getIorgId());
        observationsUi.setIrecordStatus(t.getIRecordStatus());
        observationsUi.setIstatus(t.getIstatus().getIStatusIDForMaster());
        observationsUi.setOCount(t.getOCount());
        observationsUi.setODuration(t.getODuration());
        observationsUi.setWExperession(t.getWExperession());
        observationsUi.setWhereExperession(t.getWhereExperession());
        observationsUi.setOid(t.getOid());
        observationsUi.setWid(t.getWId());
        observationsUi.setOname(t.getOname());
        observationsUi.setOdesc(t.getOdesc());
        observationsUi.setItenantId(t.getItenantId());
        return observationsUi;
    }

}
