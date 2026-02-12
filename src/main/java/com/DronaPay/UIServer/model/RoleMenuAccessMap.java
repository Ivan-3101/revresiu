package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.ZonedDateTime;

@Entity
@Table(name = "rolemenuaccessmap", schema = "ui")
@Data
public class RoleMenuAccessMap {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "irolemenumapid")
    private Integer iRoleMenuMapID;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "iroleid", nullable = false)
    // private RoleDesc iRoleID;

    @Column(name = "iroleid")
    private Integer iRoleID;

    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "imenuid", nullable = false)
    private MenuStructureDesc imenuID;

    @Column(name = "bview", nullable = false)
    private boolean bview;

    @Column(name = "badd", nullable = false)
    private boolean bAdd;

    @Column(name = "bedit", nullable = false)
    private boolean bEdit;

    @Column(name = "bdelete", nullable = false)
    private boolean bDelete;

    @Column(name = "bapprove", nullable = false)
    private boolean bApprove;

    @Column(name = "bpublish", nullable = false)
    private boolean bPublish;

    @Column(name = "istatus", nullable = false)
    private boolean iStatus;

    // @ManyToOne(fetch = FetchType.EAGER)
    // @JoinColumn(name = "ientryuserid")
    // private WebUser iEntryUserID;

    @Column(name = "ientryuserid")
    private Integer iEntryUserID;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtentrystamp")
//    private Date dtEntryStamp;

    @Column(name = "dtentrystamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryStamp;

    // @ManyToOne(fetch = FetchType.EAGER)
    // @JoinColumn(name = "iapproveruserid")
    // private WebUser iApproverUserID;

    @Column(name = "iapproveruserid")
    private Integer iApproverUserID;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtapproverstamp")
//    private Date dtApproverStamp;

    @Column(name = "dtapproverstamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtApproverStamp;

    @Column(name = "iorgid")
    private Integer iorgId;

    @Column(name = "itenantid")
    private Integer itenantId;


}
