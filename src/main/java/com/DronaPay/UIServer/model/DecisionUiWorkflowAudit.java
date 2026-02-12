package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

import java.time.ZonedDateTime;

@Entity
@Table(name = "decisionsworkflowaudit", schema = "ui")
@Data
public class DecisionUiWorkflowAudit extends MakerModel<DecisionUiWorkflowAudit, DecisionUi> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Idecisionauditid", nullable = false)
    private Integer idecisionAuditID;

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
    private boolean bActive;

//    @Column(name = "dtentrydatetime")
//    private Date dtEntryDatetime;


    @Column(name = "dtentrydatetime", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryDatetime;

    //@OneToOne(fetch = FetchType.EAGER)
    @Column(name = "iuserid")
    private Integer iUserID;

    // @Column(name = "iorgid")
    // private Integer iorgId;

    @Column(name = "irecordstatus")
    private int iRecordStatus;

    @Type(JsonType.class)
    @Column(name = "vcresultparams", columnDefinition = "jsonb")
    private JsonNode vcResultParams;

    // @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "Idecisionid")
    // private DecisionUi idecisionUiId;

    @Column(name = "Idecisionid")
    private Integer idecisionUiId;

    @Type(JsonType.class)
    @Column(name = "attribs", columnDefinition = "jsonb")
    private JsonNode attribs;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "itenantid")
    // private Tenant itenantId;

    @Column(name = "itenantid")
    private Integer itenantId;

    @Override
    public DecisionUi parseAudit(DecisionUiWorkflowAudit t) {
        DecisionUi decisionUi = new DecisionUi();
        decisionUi.setBactive(t.isBActive());
        decisionUi.setDtApproverStamp(t.getDtApproverStamp());
        decisionUi.setDtEntryDatetime(t.getDtEntryDatetime());
        decisionUi.setDtEntryStamp(t.getDtEntryStamp());
        decisionUi.setIApproverUserID(t.getIApproverUserID());
        if (t.getIdecisionUiId() != null) {

            decisionUi.setIDecisionID(t.getIdecisionUiId());
        }
        decisionUi.setIEntryUserID(t.getIEntryUserID());
        decisionUi.setIorgId(t.getIorgId());
        decisionUi.setIProductID(t.getIProductID());
        decisionUi.setIRecordStatus(t.getIRecordStatus());
        decisionUi.setIstatus(t.getIstatus().getIStatusIDForMaster());
        decisionUi.setIUserID(t.getIUserID());
        decisionUi.setVcDecisionDetail(t.getVcDecisionDetail());
        decisionUi.setVcDecisionMapInfo(t.getVcDecisionMapInfo());
        decisionUi.setVcDecisionName(t.getVcDecisionName());
        decisionUi.setVcResultParams(t.getVcResultParams());
        decisionUi.setAttribs(t.getAttribs());
        decisionUi.setItenantId(t.getItenantId());
        return decisionUi;
    }

    public DecisionUiWorkflowAudit parseToAudit(DecisionUi t) {
        DecisionUiWorkflowAudit decisionUi = new DecisionUiWorkflowAudit();
        decisionUi.setBActive(t.isBactive());
        decisionUi.setDtApproverStamp(t.getDtApproverStamp());
        decisionUi.setDtEntryDatetime(t.getDtEntryDatetime());
        decisionUi.setDtEntryStamp(t.getDtEntryStamp());
        decisionUi.setIApproverUserID(t.getIApproverUserID());
        decisionUi.setIdecisionUiId(t.getIDecisionID());
        decisionUi.setIEntryUserID(t.getIEntryUserID());
        decisionUi.setIorgId(t.getIorgId());
        decisionUi.setIProductID(t.getIProductID());
        decisionUi.setIRecordStatus(t.getIRecordStatus());
        decisionUi.setIUserID(t.getIUserID());
        decisionUi.setVcDecisionDetail(t.getVcDecisionDetail());
        decisionUi.setVcDecisionMapInfo(t.getVcDecisionMapInfo());
        decisionUi.setVcDecisionName(t.getVcDecisionName());
        decisionUi.setVcResultParams(t.getVcResultParams());
        decisionUi.setAttribs(t.getAttribs());
        decisionUi.setItenantId(t.getItenantId());
        return decisionUi;
    }
}
