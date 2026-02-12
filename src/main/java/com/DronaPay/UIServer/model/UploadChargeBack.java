package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.ZonedDateTime;

@Entity
@Table(name = "uploadchargeback", schema = "ui")
@Data
public class UploadChargeBack {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "uploadchargebackid")
    private Integer uploadChargeBackId;

    @Column(name = "fieldname")
    private String fieldName;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "uploadtimestamp")
//    private Date uploadTimeStamp;

    @Column(name = "uploadtimestamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime uploadTimeStamp;

    @Column(name = "status")
    private String status;

    @Column(name = "passedrecords")
    private Integer passedRecords;

    @Column(name = "failedrecords")
    private Integer failedRecords;

    @Column(name = "totalrecords")
    private Integer totalRecords;

    @Column(name = "uploadfile")
    private String uploadFile;

    @Column(name = "errorlog")
    private String errorLog;

}
