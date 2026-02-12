package com.DronaPay.UIServer.model.sim;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

import java.time.ZonedDateTime;


@Entity
@Table(name = "simulations", schema = "sim")
@Data
public class Simulations {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "simid", length = 128)
    private String simid;

    @Column(name = "note", columnDefinition = "TEXT")
    private String note;


    @Column(name = "idecisionid")
    private Long iDecisionID;

    @Column(name = "iruleid")
    private Long iRuleID;

    @Column(name = "isbatch")
    private Boolean isBatch;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtcreated")
//    private Date dtcreated;

    @Column(name = "dtcreated", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtcreated;
    

    @Type(JsonType.class)
    @Column(name = "vcruledetail", columnDefinition = "jsonb")
    private JsonNode vcRuleDetail;

    @Type(JsonType.class)
    @Column(name = "vcruleparams", columnDefinition = "jsonb")
    private JsonNode vcRuleParams;

    @Column(name = "itenantid")
    private Integer itenantId;

}
