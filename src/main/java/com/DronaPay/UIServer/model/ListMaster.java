package com.DronaPay.UIServer.model;

import com.DronaPay.UIServer.model.EmbeddedId.ListMasterEmbeddedId;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

@Entity
@Table(name = "listmaster", schema = "ui")
@Data
public class ListMaster {

    // @Id
    // @GeneratedValue(strategy = GenerationType.IDENTITY)
    // @Column(name = "ilistmasterid", nullable = false)
    // private Integer iListMasterID;
    @EmbeddedId
    private ListMasterEmbeddedId id;

    @Column(name = "vcname", unique = true)
    private String vcName;

    @Column(name = "ifordays")
    private Integer iForDays;

    @Type(JsonType.class)
    @Column(name = "iconfigjson",columnDefinition = "jsonb")
    private JsonNode iConfigJson;


    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "itenantid")
    // private Tenant itenantId;

}
