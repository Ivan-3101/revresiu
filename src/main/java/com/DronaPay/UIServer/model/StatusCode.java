package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Getter;


@Entity
@Table(name = "statuscode", schema = "ui")
@Getter
public class StatusCode {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "istatusid")
    private Integer iStatusID;

    @Column(name = "vcstatusname")
    private String vcStatusName;

    @Column(name = "bupdatemaster")
    private boolean bUpdateMaster;

    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.MERGE)
    @JoinColumn(name = "istatusidformaster")
    private StatusCode iStatusIDForMaster;
}
