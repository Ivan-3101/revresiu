package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.Instant;
import java.time.ZonedDateTime;

@Data
@Entity
@Table(name = "activelogintokens", schema = "ui")
public class ActiveLoginToken {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "activelogintokenid")
    private Integer activeLoginTokenId;

    @Column(name = "activeLoginToken", columnDefinition = "TEXT")
    private String activeLoginToken;

    @Column(name = "refreshtoken", columnDefinition = "TEXT")
    private String refreshToken;

    @Column(name = "dtexpirydatetime")
    private Instant dtExpiryDatetime;

    // @OneToOne(fetch = FetchType.EAGER) 
    // @JoinColumn(name = "iuserid")
    @Column(name = "iuserid")
    private Integer iUserId;

    @Column(name = "iorgid")
    private Integer iorgId;


    @Column(name = "isgeneratedthroughrefreshtoken")
    private Boolean isGeneratedThroughRefreshToken;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "clientuser")
    private ClientUser iClientUser;

//    @Column(name = "dtentrydatetime")
//    private Date dtEntryDatetime;


    @Column(name = "dtentrydatetime", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryDatetime;
}
