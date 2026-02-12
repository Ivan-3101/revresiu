package com.DronaPay.UIServer.model;


import jakarta.persistence.*;
import lombok.Data;

import java.time.ZonedDateTime;

@Entity
@Table(name = "Dashboardcustomlayout", schema = "ui")
@Data
public class DashboardCustomLayout {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idashboardcustomlayoutid", nullable = false)
    private Integer iDashboardCustomLayoutID;

    // @OneToOne(fetch = FetchType.EAGER)
    @Column(name = "iuserid")
    private Integer iuserID;

    @Column(name = "iorgid")
    private Integer iorgId;

    // @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "iresultsetid")
    // private DashboardResultSet iresultSetID;

    @Column(name = "iresultsetid")
    private Integer iresultSetID;

    @Column(name = "bdelete")
    private Boolean bdelete;

    @Column(name = "bactive")
    private Boolean bactive;

    @Column(name = "bdetault")
    private Boolean bdefault;

    @Column(name = "bshared")
    private Boolean bshared;

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
