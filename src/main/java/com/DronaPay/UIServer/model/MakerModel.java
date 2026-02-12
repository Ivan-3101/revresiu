package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;

import java.time.ZonedDateTime;

@MappedSuperclass
@Data
public abstract class MakerModel<T, U> {

    @Column(name = "bclosed", nullable = false)
    protected boolean bclosed;

    @Column(name = "vcaction", nullable = false, length = 3)
    protected String vcAction;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "istatus")
    protected StatusCode istatus;

    //@OneToOne(fetch = FetchType.EAGER)
    @Column(name = "ientryuserid")
    //@CreatedBy
    protected Integer iEntryUserID;

    //    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @CreationTimestamp
//    @Column(name = "dtentrystamp")
//    protected Date dtEntryStamp;
    //@ManyToOne(fetch = FetchType.EAGER)
    @Column(name = "iapproveruserid")
    protected Integer iApproverUserID;
//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtapproverstamp")
//    protected Date dtApproverStamp;
    @Column(name = "vcremark", length = 255)
    protected String vcRemark;
    @Column(name = "dtapproverstamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtApproverStamp;
    @Column(name = "dtentrystamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    @CreationTimestamp
    private ZonedDateTime dtEntryStamp;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "iorgid")
    private Organization iorgId;

    public abstract U parseAudit(T t);
}
