package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.ZonedDateTime;

@Entity
@Table(name = "emailaudittrail", schema = "ui")
@Data
public class EmailAuditTrail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "auditid", nullable = false)
    private Integer auditId;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "emailtemplateid")
    // private EmailModel emailTemplateId;

    @Column(name = "emailtemplateid")
    private Integer emailTemplateId;

    @Column(name = "sentsubject", columnDefinition = "TEXT")
    private String sentSubject;

    @Column(name = "sentbody", columnDefinition = "TEXT")
    private String sendBody;

    @Column(name = "correlation_id")
    private String correlationId;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "senttimestamp")
//    private Date sentTimeStamp;

    @Column(name = "senttimestamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime sentTimeStamp;

    @Column(name = "responsesubject", columnDefinition = "TEXT")
    private String responseSubject;

    @Column(name = "responsebody", columnDefinition = "TEXT")
    private String responseBody;

    // @Column(name = "responseattachments", columnDefinition = "TEXT")
    // private List<String> responseAttachments;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "responsetimestamp")
//    private Date responseTimeStamp;

    @Column(name = "responsetimestamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime responseTimeStamp;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "statustimestamp")
//    private Date statusTimeStamp;


    @Column(name = "statustimestamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime statusTimeStamp;

    @Column(name = "processingstatus")
    private Integer processingStatus;

    // @JoinColumn(name = "itenantid")
    // @ManyToOne(fetch = FetchType.EAGER)
    // private Tenant itenantId;
    @Column(name = "itenantid")
    private Integer itenantId;

}
