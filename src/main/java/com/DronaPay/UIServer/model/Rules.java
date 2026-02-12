package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;
import org.json.JSONObject;

import java.time.ZonedDateTime;

@Entity
@Table(name = "rules", schema = "ui")
@Data
public class Rules extends CheckerModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iruleid", nullable = false)
    private Integer iRuleID;

    // @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "idecisionid")
    // private DecisionUi idecisionID;

    @Column(name = "idecisionid")
    private Integer idecisionID;

    // @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "iproductid")
    // private Products iProductID;

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

    //@OneToOne(fetch = FetchType.EAGER)
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
    @Column(name = "vcquery", columnDefinition = "TEXT")
    private String vcQuery;
    @Column(name = "bapicall")
    private Boolean bapicall;
    @Column(name = "bexecutequery")
    private Boolean bexecutequery;
    @Type(JsonType.class)
    @Column(name = "vcqueryresultmap", columnDefinition = "jsonb")
    private JsonNode vcQueryResultMap;
    @Type(JsonType.class)
    @Column(name = "vcqueryfilterparams", columnDefinition = "jsonb")
    private JsonNode vcQueryFilterParams;
    @Type(JsonType.class)
    @Column(name = "vcresponseapiattribs", columnDefinition = "jsonb")
    private JsonNode vcResponseApiAttribs;
    @Column(name = "itenantid")
    private Integer itenantId;

    public Integer getSuccessRule() {
        JSONObject ruleorderJSON = new JSONObject(this.vcRuleOrder);
        return ruleorderJSON.optInt("SuccessRule");
    }

    public Integer getGetStartRule() {
        JSONObject ruleorderJSON = new JSONObject(this.vcRuleOrder);
        return ruleorderJSON.optInt("StartRule");
    }
}
