package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

import java.time.ZonedDateTime;

@Entity
@Table(name = "decisions", schema = "masters")

@Data
public class Decisions {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idecisionid", nullable = false)
    private Integer iDecisionID;

    // @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "iproductid")
    // private Products iProductID;

    @Column(name = "vcdecisionname")
    private String vcDecisionName;

    @Column(name = "vcdecisiondetail")
    private String vcDecisionDetail;

    @Column(name = "vcdecisionmapinfo")
    private String vcDecisionMapInfo;

    @Column(name = "bactive")
    private boolean bactive;

//    @Column(name = "dtentrydatetime")
//    private Date dtEntryDatetime;

    @Column(name = "dtentrydatetime", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryDatetime;

    // @OneToOne(fetch = FetchType.EAGER)
    // @JoinColumn(name = "iuserid")
    // private WebUser iUserID;

    @Column(name = "irecordstatus")
    private int iRecordStatus;


    @Type(JsonType.class)
    @Column(name = "vcresultparams", columnDefinition = "jsonb")
    private JsonNode vcResultParams;


}
