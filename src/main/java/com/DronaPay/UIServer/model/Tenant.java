package com.DronaPay.UIServer.model;


import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.apache.commons.codec.digest.DigestUtils;
import org.hibernate.annotations.Type;
import org.springframework.beans.factory.annotation.Value;


@Entity
@Table(schema = "ui", name = "tenants")
@Data
public class Tenant extends CheckerModel {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "itenantid")
    private Integer itenantid;

    @Column(name = "vctenantid")
    private String vcTenantId;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "iorgId")
    // private Organization iorgId;

    @Column(name = "attribs", columnDefinition = "jsonb")
    @Type(JsonType.class)
    private JsonNode attribs;

    @Column(name = "config", columnDefinition = "jsonb")
    @Type(JsonType.class)
    private JsonNode config;

    @Column(name = "irecordstatus")
    private Integer irecordStatus;

    public String getTenantName() {
        return this.vcTenantId;
    }

    public void setTenantName(String name) {
        this.vcTenantId = name;
    }


}
