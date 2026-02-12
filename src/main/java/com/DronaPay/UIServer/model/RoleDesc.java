package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;

import com.DronaPay.UIServer.CompositeKey.RoleDescKey;

import java.time.ZonedDateTime;


@Entity
@Table(name = "roledesc", schema = "ui")
@Data
@IdClass(RoleDescKey.class)
public class RoleDesc implements GrantedAuthority {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iroleid")
    private Integer iRoleID;

    @Column(name = "vcrolename", nullable = false)
    private String vcRoleName;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "istatus", nullable = false)
    private StatusCode iStatus;

    //@OneToOne(fetch = FetchType.EAGER)
    @Column(name = "ientryuserid")
    private Integer iEntryUserID;

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

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "imenustructuredesc")
    private MenuStructureDesc iMenuStructureDesc;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "itenantid")
    // private Tenant itenantId;
    @Id
    @Column(name = "itenantid")
    private Integer itenantId;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "vcorgid")
    // private Organization vcOrgId;

    @Override
    public String getAuthority() {
        // TODO Auto-generated method stub
        return null;
    }
}
