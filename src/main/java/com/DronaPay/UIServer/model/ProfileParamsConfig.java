package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "profileparamsconfig", schema = "ui")
public class ProfileParamsConfig {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

//    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
//    @JoinColumn(name = "workflowid")
//    private WorkflowMasters workflowID;

    @Column(name = "workflowid")
    private Integer workflowID;

    @Column(name = "parametername")
    private String parameterName;

    @Column(name = "type")
    private String type;

    @Column(name = "itenantid")
    private Integer itenantId;
}
