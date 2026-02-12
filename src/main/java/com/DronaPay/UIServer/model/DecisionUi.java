package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

import java.time.ZonedDateTime;

@Entity
@Table(name = "decisions", schema = "ui")
@Data
public class DecisionUi extends CheckerModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idecisionid", nullable = false)
    private Integer iDecisionID;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "iproductid")
    private Products iProductID;

    @Column(name = "vcdecisionname")
    private String vcDecisionName;

    @Column(name = "vcdecisiondetail")
    private String vcDecisionDetail;

    @Column(name = "vcdecisionmapinfo")
    private String vcDecisionMapInfo;

    @Column(name = "bactive")
    private boolean bactive;

//    @Column(name = "dtentrydatetime")
//    private Date dtEntryDatetime;


    @Column(name = "dtentrydatetime", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryDatetime;

    //@OneToOne(fetch = FetchType.EAGER)
    @Column(name = "iuserid")
    private Integer iUserID;

    @Column(name = "irecordstatus")
    private int iRecordStatus;

    @Type(JsonType.class)
    @Column(name = "vcresultparams", columnDefinition = "jsonb")
    private JsonNode vcResultParams;

    @Type(JsonType.class)
    @Column(name = "attribs", columnDefinition = "jsonb")
    private JsonNode attribs;

    @Column(name = "latestremark")
    private String latestRemark;

    @Column(name = "laststatus")
    private String lastStatus;

    @Column(name = "masterdecisionid")
    private Integer masterDecisionId;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "itenantid")
    // private Tenant itenantId;

    @Column(name = "itenantid")
    private Integer itenantId;


}
