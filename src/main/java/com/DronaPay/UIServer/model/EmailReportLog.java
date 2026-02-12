package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

import java.time.ZonedDateTime;

@Entity
@Table(name = "reportmaillog", schema = "ui")
@Data
public class EmailReportLog {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ilogid", nullable = false)
    private Integer ilogId;

    //@ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @Column(name = "ireportid")
    private Integer ireportId;

    @Column(name = "reportparams", columnDefinition = "jsonb")
    @Type(JsonType.class)
    private JsonNode reportParams;

//    @Column(name = "timestamp")
//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    private Date timestamp;

    @Column(name = "timestamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime timestamp;

    @Column(name = "status")
    private String status;

    @Column(name = "itenantid")
    private Integer itenantId;
}
