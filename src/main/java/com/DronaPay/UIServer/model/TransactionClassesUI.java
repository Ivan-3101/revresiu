package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

import java.time.ZonedDateTime;

@Entity
@Table(name = "transactionclasses", schema = "ui")
@Data
public class TransactionClassesUI extends CheckerModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iclassid")
    private int iclassID;

    @Column(name = "vcclassname", nullable = false, unique = true)
    private String vcClassName;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "iproductid")
    private Products iProductID;

    @Column(name = "ichannelid", nullable = false)
    private Integer iChannelID;

    // @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "idecisionid", nullable = false)
    // private DecisionUi iDecisionID;

    // @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @Column(name = "idecisionid", nullable = false)
    private Integer iDecisionID;

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

    @Type(JsonType.class)
    @Column(name = "vcdecisionparams", columnDefinition = "jsonb")
    private JsonNode vcDecisionParams;

    @Type(JsonType.class)
    @Column(name = "attribs", columnDefinition = "jsonb")
    private JsonNode attribs;

    @Column(name = "skipprocessing")
    private Integer skipProcessing;

    @Column(name = "latestremark")
    private String latestRemark;

    @Column(name = "laststatus")
    private String lastStatus;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "itenantid")
    // private Tenant itenantId;

    @Column(name = "itenantid")
    private Integer itenantId;


    public TransactionClasses parseToTransactionClass(TransactionClassesUI transactionClassesUI) {

        TransactionClasses transactionClasses = new TransactionClasses();
        transactionClasses.setBActive(transactionClassesUI.isBActive());
        transactionClasses.setBPayeeMandatory(transactionClassesUI.isBPayeeMandatory());
        transactionClasses.setBPayerMandatory(transactionClassesUI.isBPayerMandatory());
        transactionClasses.setDtEntryDateTime(transactionClassesUI.getDtEntryDateTime());
        transactionClasses.setIChannelID(transactionClassesUI.getIChannelID());
        transactionClasses.setIClassID(transactionClassesUI.getIclassID());
        //transactionClasses.setIProductID(transactionClassesUI.getIProductID());
        transactionClasses.setIRecordStatus(transactionClassesUI.getIRecordStatus());
        transactionClasses.setVcClassName(transactionClassesUI.getVcClassName());
        if (transactionClassesUI.getVcDecisionParams() != null) {

            transactionClasses.setVcDecisionParams(transactionClassesUI.getVcDecisionParams().get("formattedquery"));
        }
        return transactionClasses;
    }

}
