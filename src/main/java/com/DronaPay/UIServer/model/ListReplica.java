package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

import java.time.ZonedDateTime;

@Entity
@Table(name = "list", schema = "ui")
@Data
public class ListReplica extends CheckerModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ilistitemid")
    private Integer iListitemId;

    @Column(name = "vcexternallistitemid", length = 100)
    private String vcExternalListItemId;

    @Column(name = "vcsource", length = 100)
    private String vcSource;

    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "ilisttype")
    @JoinColumn(name = "itenantid")
    private ListMaster ilistType;

    @Column(name = "vcfield", length = 100)
    private String vcField;

    @Column(name = "vcvalue", length = 100)
    private String vcValue;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dteffectivefrom")
//    private Date dtEffectiveFrom;

    @Column(name = "dteffectivefrom", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEffectiveFrom;


//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtexpiresat")
//    private Date dtExpiresAt;

    @Column(name = "dtexpiresat", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtExpiresAt;


    @Column(name = "vcnote", length = 200)
    private String vcNote;

    @Column(name = "irecordstatus")
    private Integer irecordStatus;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtentrydatetime")
//    private Date dtEntryDateTime;


    @Column(name = "dtentrydatetime", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryDateTime;

    @Type(JsonType.class)
    @Column(name = "attribs", columnDefinition = "jsonb")
    private JsonNode attribs;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "itenantid")
    // private Tenant itenantId;
    // @Column(name = "itenantid")
    // private Integer itenantId;

    public ListAudit parseToAudit(ListReplica listReplica) {
        ListAudit listAudit = new ListAudit();
        listAudit.setDtEffectiveFrom(listReplica.getDtEffectiveFrom());
        listAudit.setIRecordStatus(listReplica.getIrecordStatus());
        listAudit.setIListitemId(listReplica);
        listAudit.setIlistType(listReplica.getIlistType());
        listAudit.setVcExternalListItemId(listReplica.getVcExternalListItemId());
        listAudit.setVcField(listReplica.getVcField());
        listAudit.setVcNote(listReplica.getVcNote());
        listAudit.setVcSource(listReplica.getVcSource());
        listAudit.setVcValue(listReplica.getVcValue());
        listAudit.setDtExpiresAt(listReplica.getDtExpiresAt());
        listAudit.setAttribs(listReplica.getAttribs());
        // listAudit.setItenantId(listReplica.getItenantId());

        return listAudit;
    }
}
