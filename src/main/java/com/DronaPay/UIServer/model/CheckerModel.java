package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.ZonedDateTime;

@MappedSuperclass
@Data
public abstract class CheckerModel {

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "istatus")
    protected StatusCode istatus;

    //@OneToOne(fetch = FetchType.EAGER)
    @Column(name = "ientryuserid")
    protected Integer iEntryUserID;

    //    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtentrystamp")
//    protected Date dtEntryStamp;
    //@ManyToOne(fetch = FetchType.EAGER)
    @Column(name = "iapproveruserid")
    protected Integer iApproverUserID;
//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtapproverstamp")
//    protected Date dtApproverStamp;


    @Column(name = "dtapproverstamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtApproverStamp;

    @Column(name = "dtentrystamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryStamp;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "iorgid")
    private Organization iorgId;
}
