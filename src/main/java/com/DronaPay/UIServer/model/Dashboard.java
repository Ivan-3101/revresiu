package com.DronaPay.UIServer.model;


import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Entity
@Table(name = "dashboard", schema = "ui")
@Data
public class Dashboard {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idashboardid", nullable = false)
    private Integer iDashboardID;

    @Column(name = "vcdashboardname")
    private String vcDashboardName;

    @Column(name = "bdelete")
    private Boolean bdelete;

    @Column(name = "bactive")
    private Boolean bactive;

    // @OneToMany(fetch = FetchType.EAGER, mappedBy = "idashboardID", cascade = CascadeType.MERGE)
    // private List<DashboardFilters> dashboardFiltersList;

    // @OneToMany(fetch = FetchType.EAGER, mappedBy = "iDashboardID", cascade = CascadeType.MERGE)
    // private List<DashboardResultSet> dashboardResultSetList;

    @Column(name = "iorder")
    private Integer iorder;

    @Column(name = "irowcount")
    private Integer iRowCount;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "imenustructuredesc")
    private MenuStructureDesc imenuStructureDesc;

    @Column(name = "itenantid")
    private Integer itenantId;

    @Column(name = "bdynamic")
    private Boolean bdynamic;

}
