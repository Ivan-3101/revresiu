package com.DronaPay.UIServer.model.sim;


import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

import java.time.ZonedDateTime;
import java.util.Date;

@Entity
@Table(name = "runs", schema = "sim")
@Data
public class Runs {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "runid")
    private Long runID;

//    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
//    @JoinColumn(name = "simid")
//    private Simulations simid;

    @Column(name = "simid", length = 128)
    private String simid;

    @Column(name = "note", columnDefinition = "TEXT")
    private String note;

    @Temporal(TemporalType.DATE)
    @Column(name = "dtfrom")
    private Date dtfrom;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "dtto")
    private Date dtto;

    @Type(JsonType.class)
    @Column(name = "vcruledetail", columnDefinition = "jsonb")
    private JsonNode vcRuleDetail;

    @Type(JsonType.class)
    @Column(name = "vcruleparams", columnDefinition = "jsonb")
    private JsonNode vcRuleParams;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtcreated")
//    private Date dtcreated;

    @Column(name = "dtcreated", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtcreated;
    
    @Column(name = "itenantid")
    private Integer itenantId;
}
