package com.DronaPay.UIServer.model;
import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

import org.hibernate.annotations.Type;

import com.fasterxml.jackson.databind.JsonNode;

import io.hypersistence.utils.hibernate.type.json.JsonType;

@Entity
@Table(name = "emailserviceprovider", schema = "ui")
@Data
public class EmailServiceProvider {
    @Id
    @Column(name = "id")
    private Integer id;

    @Type(JsonType.class)
    @Column(name = "parameters", columnDefinition = "jsonb")
    private JsonNode parameters;

    @Column(name = "type")
    private String type;
}
