package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "grouptotaskfiltermap", schema = "ui")
public class GroupToTaskFilterMap {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "igrouptotaskfilterid")
    private Integer iGroupToTaskFilterID;

//    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
//    @JoinColumn(name = "igroupid")
//    private GroupDesc igroupID;

    @Column(name = "igroupid")
    private Integer igroupID;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "itaskfilterid")
    private TaskFilterMaster iTaskFilterID;

    @Column(name = "iposition")
    private Integer iPosition;

    @Column(name = "itenantid")
    private Integer itenantId;
}
