package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.ZonedDateTime;

@Entity
@Table(name = "menustructuredesc", schema = "ui")
@Data
public class MenuStructureDesc {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    @Column(name = "imenuid")
    private Integer iMenuID;

    @Column(name = "vcmenuname", nullable = false)
    private String vcMenuName;

    @Column(name = "vcaction", nullable = false)
    private String vcAction;

    @Column(name = "vccontroller", nullable = false)
    private String vcController;

    @Column(name = "vcicon")
    private String vcIcon;

    @Column(name = "vchelptip")
    private String vcHelpTip;

    @Column(name = "isortorder", nullable = false)
    private Integer iSortOrder;

    @Column(name = "bcollapse")
    private boolean bCollapse;

    @Column(name = "vcrtlname")
    private String vcRtlName;

    @Column(name = "vcstate")
    private String vcState;

    @Column(name = "vcmini")
    private String vcMini;

    @Column(name = "vcrtlmini")
    private String vcRtlMini;

    @Column(name = "vcpath")
    private String vcPath;

    @Column(name = "vclayout")
    private String vcLayout;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "istatus", nullable = false)
    private StatusCode iStatus;

    // // @OneToOne(fetch = FetchType.EAGER)
    // @Column(name = "ientryuserid")
    // private Integer iEntryUserID;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtentrystamp")
//    private Date dtEntryStamp;

    @Column(name = "dtentrystamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryStamp;

    // //@OneToOne(fetch = FetchType.EAGER)
    // @Column(name = "ispproveruserid")
    // private Integer iApproverUserID;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtapproverstamp")
//    private Date dtApproverStamp;

    @Column(name = "dtapproverstamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtApproverStamp;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "iparentmenu")
    private MenuStructureDesc iParentMenu;
}
