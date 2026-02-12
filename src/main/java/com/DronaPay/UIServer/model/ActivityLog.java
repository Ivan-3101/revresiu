package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.ZonedDateTime;


@Entity
@Table(name = "activitylog", schema = "ui")
@Data
@EntityListeners(AuditingEntityListener.class)
public class ActivityLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iactivityid")
    private Integer iActivityID;

    // @CreatedBy
    // @OneToOne(fetch = FetchType.EAGER)
    // @JoinColumn(name = "iuserid")
    @Column(name = "iuserid")
    private Integer iUserID;

    @Column(name = "iorgid")
    private Integer iorgId;

    @Column(name = "vcactivity", columnDefinition = "TEXT")
    private String vcActivity;

//    @Column(name = "dtactivity")
//    @CreatedDate
//    private Date dtActivity;


    @Column(name = "dtactivity", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    @CreatedDate
    private ZonedDateTime dtActivity;


    @Column(name = "vcparameters", columnDefinition = "TEXT")
    private String vcParameters;
}
