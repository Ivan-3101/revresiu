package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.ZonedDateTime;

@Entity
@Table(name = "agentchats", schema = "ui")
@Data
public class AgentChats {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "imessageid", nullable = false)
    private Long imessageId;

    @Column(name = "iagentid", nullable = false)
    private Integer iagentId;

    @Column(name = "bagentmsg", nullable = false)
    private Boolean bagentMsg;

    @Column(name = "vcmessage", columnDefinition = "TEXT", nullable = false)
    private String vcMessage;

    @Column(name = "dttimestamp", columnDefinition = "TIMESTAMP WITH TIME ZONE", nullable = false)
    private ZonedDateTime dtTimestamp;

    @Column(name = "iuserid", nullable = false)
    private Integer iuserId;

    @Column(name = "iorgid", nullable = false)
    private Integer iorgId;

    @Column(name = "itenantid", nullable = false)
    private Integer itenantId;

//    @Column(name = "isessionid", nullable = false)
//    private Integer isessionId;
}
