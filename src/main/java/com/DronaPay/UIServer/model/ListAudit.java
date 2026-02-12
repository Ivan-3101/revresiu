package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

import java.time.ZonedDateTime;

@Entity
@Table(name = "listaudit", schema = "ui")

@Data
public class ListAudit extends MakerModel<ListAudit, ListReplica> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ilistitemauditid", nullable = false)
    private Integer iListItemAuditId;

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
    private Integer iRecordStatus;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtentrydatetime")
//    private Date dtEntryDateTime;

    @Column(name = "dtentrydatetime", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryDateTime;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "ilistitemid")
    private ListReplica iListitemId;

    @Type(JsonType.class)
    @Column(name = "attribs", columnDefinition = "jsonb")
    private JsonNode attribs;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "itenantid")
    // private Tenant itenantId;

    // @Column(name = "itenantid")
    // private Integer itenantId;

    @Override
    public ListReplica parseAudit(ListAudit t) {
        ListReplica listReplica = new ListReplica();
        listReplica.setIListitemId(t.getIListitemId() != null ? t.getIListitemId().getIListitemId() : null);
        listReplica.setDtEffectiveFrom(t.getDtEffectiveFrom());
        listReplica.setDtEntryDateTime(ZonedDateTime.now());
        listReplica.setDtExpiresAt(t.getDtExpiresAt());
        listReplica.setIlistType(t.getIlistType());
        listReplica.setVcExternalListItemId(t.getVcExternalListItemId());
        listReplica.setVcField(t.getVcField());
        listReplica.setVcNote(t.getVcNote());
        listReplica.setVcSource(t.getVcSource());
        listReplica.setVcValue(t.getVcValue());
        listReplica.setAttribs(t.getAttribs());
        if (t.getVcAction().equals("X")) {
            listReplica.setIrecordStatus(1);
        } else {
            listReplica.setIrecordStatus(0);
        }
        return listReplica;
    }
}
