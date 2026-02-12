package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.ZonedDateTime;

@Entity
@Table(name = "channels", schema = "masters")

@Data
public class Channels {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ichannelid", nullable = false)
    private Integer iChannelId;

    @Column(name = "vcchannelname")
    private String vcChannelName;

    @Column(name = "vcchanneldetail")
    private String vcChannelDetail;

    @Column(name = "bactive")
    private Boolean bActive;

    @Column(name = "irecordstatus")
    private Integer iRecordStatus;

//    @Column(name = "dtentrydatetime")
//    private Date dtEntryDatetime;

    @Column(name = "dtentrydatetime", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryDatetime;


}
