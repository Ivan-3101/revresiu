package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

import java.time.ZonedDateTime;

@Entity
@Table(name = "reportmailconfig", schema = "ui")
@Data
public class EmailReport {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "reportid", nullable = false)
    private Integer reportId;

    @Column(name = "dashboardqueryparams", columnDefinition = "jsonb")
    @Type(JsonType.class)
    private JsonNode dashboardQueryParams;

    @Column(name = "reportheaders", columnDefinition = "jsonb")
    @Type(JsonType.class)
    private JsonNode reportHeaders;

    @Column(name = "emailparameters", columnDefinition = "jsonb")
    @Type(JsonType.class)
    private JsonNode emailParameters;

    @Column(name = "frequency")
    private String frequency;

    @Column(name = "reporttime")
    private String reportTime;

    @Column(name = "day")
    private Integer day;

    // @ManyToMany(fetch = FetchType.EAGER)
    // @JoinTable(name = "reportusermap", schema = "ui", joinColumns = @JoinColumn(referencedColumnName = "reportid", name = "reportid"), inverseJoinColumns = @JoinColumn(referencedColumnName = "iuserid", name = "iuserid"))
    // private List<WebUser> reportUsers;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "idashboardid")
    // private Dashboard idashboardID;

    @Column(name = "idashboardid")
    private Integer idashboardID;

    @Column(name = "emaillist", columnDefinition = "TEXT")
    private String emailList;

    @Column(name = "bactive")
    private Boolean bactive;

    @Column(name = "bdelete")
    private Boolean bdelete;

//    @Column(name = "latestsenttimestamp")
//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    private Date latestSentTimestamp;


    @Column(name = "latestsenttimestamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime latestSentTimestamp;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "itenantid")
    private Tenant itenantId;

    //@ManyToOne(fetch = FetchType.EAGER)
    @Column(name = "iuserid")
    private Integer iuserId;

    @Column(name = "iorgid")
    private Integer iorgId;

}