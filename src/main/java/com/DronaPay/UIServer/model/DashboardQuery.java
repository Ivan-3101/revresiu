package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Entity
@Table(name = "dashboardquery", schema = "ui")
@Data
public class DashboardQuery {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idashboardqueryid", nullable = false)
    private Integer iDashboardQueryID;

    @Column(name = "vcdashboardquery", columnDefinition = "TEXT")
    private String vcDashboardQuery;

    @Column(name = "bparametersrequired")
    private Boolean bParametersRequired;

    @Column(name = "vcfilterparametersjson", columnDefinition = "TEXT")
    private String vcDashboardParametersJson;

    // @OneToMany(fetch = FetchType.EAGER, mappedBy = "iDashboardQuery", cascade = CascadeType.MERGE)
    // private List<DashboardQueryParameters> dashboardQueryParametersList;

    @Column(name = "formattingrequiered")
    private Boolean formattingRequiered;

//    @Column(name = "runonanalytics")
//    private Boolean runOnAnalytics;

    @Column(name = "transposerequired")
    private Boolean transposeRequired;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "imenustructuredesc")
    private MenuStructureDesc imenuStructureDesc;

    @Column(name = "itenantid")
    private Integer itenantId;

    @Column(name = "dbtype")
    private Integer dbType;

}
