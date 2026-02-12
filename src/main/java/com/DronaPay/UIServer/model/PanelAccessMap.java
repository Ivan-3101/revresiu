package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "panelaccessmap", schema = "ui")
public class PanelAccessMap {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "panelaccessmap")
    private Integer panelAccessMap;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "panelid")
    private TaskPanelTemplate taskPanelTemplate;

//    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
//    @JoinColumn(name = "groupid")
//    private GroupDesc userGroup;

    @Column(name = "groupid")
    private Integer userGroup;

//    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
//    @JoinColumn(name = "workflowid")
//    private WorkflowMasters workflowMasters;

    @Column(name = "workflowid")
    private Integer workflowMasters;

    @Column(name = "itenantid")
    private Integer itenantId;


}
