package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.ZonedDateTime;


@Entity
@Table(name = "Dashboardcustomlayoutaudit", schema = "ui")
@Data
public class DashboardCustomLayoutAudit {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idashboardcustomlayoutauditid", nullable = false)
    private Integer iDashboardCustomLayoutAuditID;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "idashboardcustomlayoutid")
    private DashboardCustomLayout iDashboardCustomLayoutID;

    //@OneToOne(fetch = FetchType.EAGER)
    @Column(name = "iuserid")
    private Integer iUserID;

    @Column(name = "iorgid")
    private Integer iorgId;

    // @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "iresultsetid")
    // private DashboardResultSet iResultSetID;

    @Column(name = "iresultsetid")
    private Integer iresultSetID;

    @Column(name = "bdelete")
    private Boolean bDelete;

    @Column(name = "bactive")
    private Boolean bActive;

    @Column(name = "bdetault")
    private Boolean bDefault;

    @Column(name = "bshared")
    private Boolean bShared;

    @Column(name = "vclayoutjson", columnDefinition = "TEXT")
    private String vcLayoutJSON;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtcreaatedtimestamp")
//    private Date dtCreaatedTimeStamp;


    @Column(name = "dtcreaatedtimestamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtCreaatedTimeStamp;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtlastupdatedtimestamp")
//    private Date dtLastupdatedTimeStamp;

    @Column(name = "dtlastupdatedtimestamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtLastupdatedTimeStamp;


    @Column(name = "itenantid")
    private Integer itenantId;
}
