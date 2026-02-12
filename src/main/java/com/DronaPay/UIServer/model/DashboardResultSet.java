package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.ZonedDateTime;

@Entity
@Table(name = "dashboardresultset", schema = "ui")
@Data
public class DashboardResultSet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idashboardresultsetid", nullable = false)
    private Integer iDashboardResultSetID;

    @Column(name = "vcdashboardresultsetname")
    private String vcDashboardResultSetName;

    @Column(name = "vcdashboardresultsetlayout", columnDefinition = "TEXT")
    private String vcDashboardResultSetLayout;

    @Column(name = "vcdashboardresultsetcolumnjson", columnDefinition = "TEXT")
    private String vcDashboardResultSetColumnJson;

    @Column(name = "vcdashboardresultsetschema", columnDefinition = "TEXT")
    private String vcDashboardResultSetSchema;

    @Column(name = "iresultsetorder")
    private Integer iResultSetOrder;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "idashboardid")
    // private Dashboard iDashboardID;

    @Column(name = "idashboardid")
    private Integer iDashboardID;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "idashboardqueryid")
    // private DashboardQuery dashboardQuery;

    @Column(name = "idashboardqueryid")
    private Integer dashboardQuery;

    @Column(name = "icolsize")
    private Integer iColSize;

    @Column(name = "irowno")
    private Integer iRowNo;

    // @OneToOne(fetch = FetchType.EAGER)
    @Column(name = "iuserid")
    private Integer LastModifiedBy;


    @Column(name = "iorgid")
    private Integer iorgId;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtlastupdatedtimestamp")
//    private Date dtLastupdatedTimeStamp;

    @Column(name = "dtlastupdatedtimestamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtLastupdatedTimeStamp;


//    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
//    @JoinColumn(name = "imenustructuredesc")
//    private MenuStructureDesc imenuStructureDesc;

    @Column(name = "itenantid")
    private Integer itenantId;
}
