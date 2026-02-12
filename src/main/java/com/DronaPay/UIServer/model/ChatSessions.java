package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.ZonedDateTime;

@Entity
@Table(name = "chatsessions", schema = "ui")
@Data
public class ChatSessions {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "isessionid", nullable = false)
    private Long isessionId;

    @Column(name = "iuserid", nullable = false)
    private Integer iuserId;

    @Column(name = "iorgid", nullable = false)
    private Integer iorgId;

    @Column(name = "iagentid", nullable = false)
    private Integer iagentId;

    @Column(name = "itenantid", nullable = false)
    private Integer itenantId;

    @Column(name = "dtstarttime", columnDefinition = "TIMESTAMP WITH TIME ZONE", nullable = false)
    private ZonedDateTime dtStartTime;

    @Column(name = "vcstatus", columnDefinition = "TEXT", nullable = false)
    private String vcStatus;
}
