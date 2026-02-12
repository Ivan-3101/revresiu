package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "sectionparameters", schema = "ui")
@Data
public class SectionParameters {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "isectionid", nullable = false)
    private Integer isectionID;

    @Column(name = "vcsectionname")
    private String vcSectionName;

    @Column(name = "vcparamname")
    private String vcParamName;

    @Column(name = "bactive")
    private Boolean bactive;

    @Column(name = "bdelete")
    private Boolean bdelete;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "idashboardqueryid")
    // private DashboardQuery iDashboardQueryID;

    @Column(name = "idashboardqueryid")
    private Integer iDashboardQueryID;
    
    @Column(name = "itenantid")
    private Integer itenantId;
}
