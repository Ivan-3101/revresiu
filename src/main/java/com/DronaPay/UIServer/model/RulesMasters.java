package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.ZonedDateTime;

@Entity
@Table(name = "rules", schema = "masters")
@Data
public class RulesMasters {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iruleid", nullable = false)
    private Integer iRuleID;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "idecisionid")
    private Decisions idecisionID;

    // @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "iproductid")
    // private Products iProductID;

    @Column(name = "vcrulename", length = 20)
    private String vcRuleName;

    @Column(name = "vcruledescription", length = 1000)
    private String vcRuleDescription;

    @Column(name = "vcruledetail", columnDefinition = "TEXT")
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
    // @JoinColumn(name = "iuserid")
    // private WebUser iUserID;

    @Column(name = "vcruleparams", columnDefinition = "TEXT")
    private String vcRuleParams;

    @Column(name = "vcruleorder", nullable = false)
    private String vcRuleOrder;

    @Column(name = "bcustom")
    private boolean bcustom;

    @Column(name = "bdelete")
    private boolean bdelete;

}
