package com.DronaPay.UIServer.model;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

import java.time.ZonedDateTime;

@Entity
@Table(name = "scorerequests", schema = "ui")
@Data
public class ScoreRequests {

    @Id
    @Column(name = "vcrequestid", nullable = false)
    private String vcRequestID;

    @Column(name = "vcrequestdata", nullable = false, columnDefinition = "TEXT")
    private String vcRequestData;

//    @Column(name = "dtentrydatetime")
//    private Date dtEntryDateTime;

    @Column(name = "dtentrydatetime", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryDateTime;

}
