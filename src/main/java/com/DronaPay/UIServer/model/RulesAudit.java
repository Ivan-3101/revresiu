package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;
import org.json.JSONObject;

import java.time.ZonedDateTime;

@Entity
@Table(name = "rulesaudit", schema = "ui")
@Data
public class RulesAudit extends MakerModel<RulesAudit, Rules> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iruleidaudit", nullable = false)
    private int iRuleIDAudit;

    // @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "iruleid")
    // private Rules iRuleID;

    @Column(name = "iruleid")
    private Integer iRuleID;
    // @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "idecisionid")
    // private DecisionUi idecisionID;

    @Column(name = "idecisionid")
    private Integer idecisionID;

    @Column(name = "vcrulename", length = 255)
    private String vcRuleName;

    @Column(name = "vcruledescription", length = 1000)
    private String vcRuleDescription;

    @Column(name = "vcruledetail", length = 10485760, columnDefinition = "text")
    private String vcRuleDetail;

    @Column(name = "iversion")
    private Integer iVersion;

//    @Column(name = "dtstartdate")
//    private Date dtStartDate;

    @Column(name = "dtstartdate", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtStartDate;


    @Column(name = "vcrulemapinfo")
    private String vcRuleMapInfo;

    @Column(name = "vcbpmnfilelocation")
    private String vcBPMNFileLocation;

    @Column(name = "bactive")
    private boolean bactive;

//    @Column(name = "dtentrydatetime")
//    private Date dtEntryDatetime;

    @Column(name = "dtentrydatetime", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryDatetime;

    // @OneToOne(fetch = FetchType.EAGER)
    @Column(name = "iuserid")
    private Integer iUserID;

    // @Column(name = "iorgid")
    // private Integer iorgId;

    @Column(name = "vcruleparams", columnDefinition = "TEXT")
    private String vcRuleParams;

    @Column(name = "vcruleorder", nullable = false)
    private String vcRuleOrder;

    @Column(name = "bcustom")
    private boolean bcustom;

    @Column(name = "bdelete")
    private boolean bdelete;

    @Column(name = "iruleavailableid")
    private Integer iruleAvailableID;
    // @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "iruleavailableid")
    // private RulesAvailableUi iruleAvailableID;

    @Column(name = "vclabel", columnDefinition = "Text")
    private String vcLabel;

    @Column(name = "ruledimension")
    private String vcRuleDimension;

    @Column(name = "rulestate")
    private String vcRuleState;

    @Column(name = "vcruletype")
    private String vcRuleType;

    @Column(name = "iinstance")
    private Integer iInstance;

    @Column(name = "itenantid")
    private Integer itenantId;

    @Override
    public Rules parseAudit(RulesAudit t) {
        Rules rulesTemp = new Rules();
        rulesTemp.setBactive(t.isBactive());
        rulesTemp.setBcustom(t.isBcustom());
        rulesTemp.setBdelete(t.isBdelete());
        rulesTemp.setDtEntryDatetime(t.getDtEntryDatetime());
        rulesTemp.setDtStartDate(t.getDtStartDate());
        rulesTemp.setIdecisionID(t.getIdecisionID());
        rulesTemp.setIInstance(t.getIInstance());
        rulesTemp.setIruleAvailableID(t.getIruleAvailableID());
        rulesTemp.setIRuleID(t.getIRuleID());
        //rulesTemp.setIUserID(t.getIUserID());
        rulesTemp.setIVersion(t.getIVersion());
        rulesTemp.setVcBPMNFileLocation(t.getVcBPMNFileLocation());
        rulesTemp.setVcLabel(t.getVcLabel());
        rulesTemp.setVcRuleDescription(t.getVcRuleDescription());
        rulesTemp.setVcRuleDetail(t.getVcRuleDetail());
        rulesTemp.setVcRuleDimension(t.getVcRuleDimension());
        rulesTemp.setVcRuleMapInfo(t.getVcRuleMapInfo());
        rulesTemp.setVcRuleName(t.getVcRuleName());
        rulesTemp.setVcRuleOrder(t.getVcRuleOrder());
        rulesTemp.setVcRuleParams(t.getVcRuleParams());
        rulesTemp.setVcRuleState(t.getVcRuleState());
        rulesTemp.setVcRuleType(t.getVcRuleType());
        rulesTemp.setDtApproverStamp(t.getDtApproverStamp());
        rulesTemp.setDtEntryStamp(t.getDtEntryStamp());
        rulesTemp.setIApproverUserID(t.getIApproverUserID());
        rulesTemp.setIorgId(t.getIorgId());
        rulesTemp.setIEntryUserID(t.getIEntryUserID());
        rulesTemp.setIstatus(t.getIstatus() != null ? t.getIstatus().getIStatusIDForMaster() : null);
        return rulesTemp;
    }

    public Integer getSuccessRule() {
        JSONObject ruleorderJSON = new JSONObject(this.vcRuleOrder);
        return ruleorderJSON.optInt("SuccessRule");
    }

}
