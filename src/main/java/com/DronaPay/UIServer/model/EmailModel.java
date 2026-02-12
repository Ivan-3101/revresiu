package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;


@Entity
@Table(name = "emailtemplate", schema = "ui")
@Data
public class EmailModel {
    @Id
    @Column(name = "id")
    private Integer id;

    @Column(name = "body", columnDefinition = "TEXT")
    private String body;

    @Column(name = "subject", columnDefinition = "TEXT")
    private String subject;

    @Column(name = "associateid")
    private String associateid;

    @Column(name = "response", columnDefinition = "TEXT")
    private String response;

    @Column(name = "camunda_message_name")
    private String camunda_message_name;

    @Column(name = "itenantid")
    private Integer itenantId;

    // @OneToMany(fetch = FetchType.EAGER, mappedBy = "auditId", cascade = CascadeType.MERGE)
    // private List<EmailAuditTrail> emailAuditTrail;

}
