package com.DronaPay.UIServer.model;


import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "taskfiltermaster", schema = "ui")
public class TaskFilterMaster {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "itaskfilterid")
    private Integer iTaskFilterID;

    @Column(name = "vcfiltername")
    private String vcFilterName;

    @Column(name = "render")
    private Boolean bRender;

    @Column(name = "brequired")
    private Boolean bRequired;

    @Column(name = "vckeyname")
    private String vcKeyName;

    @Column(name = "vcerrorname")
    private String vcErrorName;

    @Column(name = "vccondition")
    private String vcCondition;

}
