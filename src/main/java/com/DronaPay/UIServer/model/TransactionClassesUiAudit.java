package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

import java.time.ZonedDateTime;

@Entity
@Table(name = "transactionclassesaudit", schema = "ui")

@Data
public class TransactionClassesUiAudit extends MakerModel<TransactionClassesUiAudit, TransactionClassesUI> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iclassauditid")
    private int iclassAuditID;

    @Column(name = "vcclassname", nullable = false, unique = false)
    private String vcClassName;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "iproductid")
    private Products iProductID;

    @Column(name = "ichannelid", nullable = false)
    private Integer iChannelID;

    // @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "idecisionid")
    // private DecisionUi idecisionID;

    @Column(name = "idecisionid")
    private Integer idecisionID;

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

    // @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "iclassid")
    // private TransactionClassesUI iclassID;


    @Column(name = "iclassid")
    private Integer iclassID;


    // @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "idecisionauditid")
    // private DecisionUiAudit iDecisionIDAudit;

    @Column(name = "idecisionauditid")
    private Integer iDecisionIDAudit;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "itenantid")
    // private Tenant itenantId;


    @Column(name = "itenantid")
    private Integer itenantId;

    @Override
    public TransactionClassesUI parseAudit(TransactionClassesUiAudit t) {
        TransactionClassesUI transactionClassesUI = new TransactionClassesUI();
        transactionClassesUI.setBActive(t.isBActive());
        transactionClassesUI.setBPayeeMandatory(t.isBPayeeMandatory());
        transactionClassesUI.setBPayerMandatory(t.isBPayerMandatory());
        transactionClassesUI.setIChannelID(t.getIChannelID());
        transactionClassesUI.setDtEntryStamp(ZonedDateTime.now());
        transactionClassesUI.setDtEntryDateTime(ZonedDateTime.now());
        if (t.getIclassID() != null) {

            transactionClassesUI.setIclassID(t.getIclassID());
        }
        transactionClassesUI.setIDecisionID(t.getIdecisionID());
        transactionClassesUI.setIProductID(t.getIProductID());
        transactionClassesUI.setIRecordStatus(0);
        transactionClassesUI.setVcClassName(t.getVcClassName());
        if (t.getVcDecisionParams() != null) {

            transactionClassesUI.setVcDecisionParams(t.getVcDecisionParams());
        }
        transactionClassesUI.setAttribs(t.getAttribs());
        transactionClassesUI.setSkipProcessing(t.getSkipProcessing());
        transactionClassesUI.setItenantId(t.getItenantId());
        transactionClassesUI.setIApproverUserID(t.getIApproverUserID());
        transactionClassesUI.setIEntryUserID(t.getIEntryUserID());
        transactionClassesUI.setIorgId(t.getIorgId());
        return transactionClassesUI;
    }

    public TransactionClassesUiAudit parseToAudit(TransactionClassesUI t) {
        TransactionClassesUiAudit transactionClassesUiAudit = new TransactionClassesUiAudit();
        transactionClassesUiAudit.setBActive(t.isBActive());
        transactionClassesUiAudit.setBclosed(false);
        transactionClassesUiAudit.setBPayeeMandatory(t.isBPayeeMandatory());
        transactionClassesUiAudit.setBPayerMandatory(t.isBPayerMandatory());
        transactionClassesUiAudit.setDtEntryStamp(ZonedDateTime.now());
        transactionClassesUiAudit.setIChannelID(t.getIChannelID());
        transactionClassesUiAudit.setIclassID(t.getIclassID());
        transactionClassesUiAudit.setIdecisionID(t.getIDecisionID());
        transactionClassesUiAudit.setIProductID(t.getIProductID());
        transactionClassesUiAudit.setIRecordStatus(0);
        transactionClassesUiAudit.setVcAction("M");
        transactionClassesUiAudit.setVcClassName(t.getVcClassName());
        transactionClassesUiAudit.setVcDecisionParams(t.getVcDecisionParams());
        transactionClassesUiAudit.setAttribs(t.getAttribs());
        transactionClassesUiAudit.setSkipProcessing(t.getSkipProcessing());
        transactionClassesUiAudit.setItenantId(t.getItenantId());
        return transactionClassesUiAudit;
    }

}
