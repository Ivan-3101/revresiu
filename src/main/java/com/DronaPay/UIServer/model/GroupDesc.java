package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.ZonedDateTime;

import com.DronaPay.UIServer.CompositeKey.GroupDescKey;

@Entity
@Table(name = "groupdesc", schema = "ui")
@Getter
@Setter
@IdClass(GroupDescKey.class)
public class GroupDesc {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "igroupid")
    private Integer igroupID;

    @Column(name = "vcgroupid", nullable = false)
    private String vcGroupID;

    @Column(name = "vcgroupname", nullable = false)
    private String vcGroupName;

    @Column(name = "vcgrouptype", nullable = false)
    private String vcGroupType;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "istatus", nullable = false)
    private StatusCode iStatus;

    //@OneToOne(fetch = FetchType.EAGER)
    @Column(name = "ientryuserid")
    private Integer iEntryUserID;

    @Column(name = "iorgid")
    private Integer iorgId;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtentrystamp")
//    private Date dtEntryStamp;

    @Column(name = "dtentrystamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryStamp;

    //@OneToOne(fetch = FetchType.EAGER)
    @Column(name = "iapproveruserid")
    private Integer iApproverUserID;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtapproverstamp")
//    private Date dtApproverStamp;

    @Column(name = "dtapproverstamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtApproverStamp;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "itenantid")
    // private Tenant itenantId;

    @Id
    @Column(name = "itenantid")
    private Integer itenantId;

    // @OneToOne(fetch = FetchType.EAGER, mappedBy = "role1GroupID", cascade =
    // CascadeType.MERGE)
    // private AllocationUsers allocationUser1ID;

    // @OneToMany(fetch = FetchType.EAGER, mappedBy = "role2GroupID", cascade =
    // CascadeType.MERGE)
    // private List<AllocationUsers> allocationUser2ID;

    @Override 
    public boolean equals(Object gp1) {
        return (this.igroupID.equals(((GroupDesc)gp1).getIgroupID()) &&
        this.itenantId.equals(((GroupDesc)gp1).getItenantId()));
    }

    @Override
    public int hashCode() {
        return this.vcGroupID.length();
    }

}
