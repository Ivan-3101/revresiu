package com.DronaPay.UIServer.model;


import jakarta.persistence.*;
import lombok.Data;


@Entity
@Table(name = "rulesdraft", schema = "masters")
@Data
public class RulesDraft {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iruledraftid", nullable = false)
    private Integer iRuleDraftID;

//    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
//    @JoinColumn(name = "idecisionid")
//    private Decisions iDecisionID;

    @Column(name = "vcrulename", length = 255)
    private String vcRuleName;

    @Column(name = "vcruledescription", length = 1000)
    private String vcRuleDescription;

    @Column(name = "bactive")
    private boolean bactive;

    @Column(name = "vcruleparams", columnDefinition = "TEXT")
    private String vcRuleParams;

    @Column(name = "vclabel", columnDefinition = "TEXT")
    private String vcLabel;

    @Column(name = "vcruletype")
    private String vcRuleType;

    @Column(name = "bcustom")
    private boolean bCustom;

    @Column(name = "bdelete")
    private boolean bdelete;

    @Column(name = "btransaction")
    private boolean bTransaction;

    @Column(name = "bpayer")
    private boolean bPayer;

    @Column(name = "bpayee")
    private boolean bPayee;

    @Column(name = "ruledimension")
    private String vcRuleDimension;

    @Column(name = "rulestate")
    private String vcRuleState;

    @Column(name = "vcruledetail", length = 10485760, columnDefinition = "text")
    private String vcRuleDetail;

    @Column(name="itenantid")
    private Integer itenantId;

}
