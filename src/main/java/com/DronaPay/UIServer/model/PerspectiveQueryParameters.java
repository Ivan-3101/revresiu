package com.DronaPay.UIServer.model;


import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "perspectivequeryparameters", schema = "ui")
public class PerspectiveQueryParameters {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iperspectiveparameterid")
    private Integer iPerspectiveParameterID;

    @Column(name = "iposition")
    private Integer iPosition;

    @Column(name = "vcparametername")
    private String vcParameterName;

    @Column(name = "vcparametertype")
    private String vcParameterType;

    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "iperspectivequeryid")
    private PerspectiveQuery perspectivequery;

    @Column(name = "iorder")
    private Integer iOrder;
}
