package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

import java.time.ZonedDateTime;

@Entity
@Table(name = "transactionclasses", schema = "masters")
@Data
public class TransactionClasses {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iclassid")
    private int iClassID;

    @Column(name = "vcclassname", nullable = false, unique = true)
    private String vcClassName;

    // @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "iproductid")
    // private Products iProductID;

    @Column(name = "ichannelid", nullable = false)
    private Integer iChannelID;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "idecisionid", nullable = false)
    private Decisions iDecisionID;

    @Column(name = "bpayermandatory")
    private boolean bPayerMandatory;

    @Column(name = "bpayeemandatory")
    private boolean bPayeeMandatory;

    @Column(name = "bactive")
    private boolean bActive;

    @Column(name = "irecordstatus")
    private Integer iRecordStatus;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtentrydatetime")
//    private Date dtEntryDateTime;

    @Column(name = "dtentrydatetime", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryDateTime;

//    @Type(type = "jsonb")
//    @Column(name = "vcdecisionparams" ,columnDefinition = "jsonb")
//    private String vcDecisionParams;

    @Type(JsonType.class)
    @Column(name = "vcdecisionparams", columnDefinition = "jsonb")
    private JsonNode vcDecisionParams;

    // @Type(type= "jsonb")
    // @Column(name = "attribs", columnDefinition = "jsonb")
    // private JsonNode attribs;

    // @Column(name = "skipprocessing")
    // private Integer skipProcessing;
    // @Type(type = "jsonb")
    // @Column(name = "vcresultparams" ,columnDefinition = "jsonb")
    // private String vcResultParams;
}
