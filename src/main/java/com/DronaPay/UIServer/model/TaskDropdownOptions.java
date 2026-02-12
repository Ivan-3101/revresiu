package com.DronaPay.UIServer.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

import org.hibernate.annotations.Type;

import com.fasterxml.jackson.databind.JsonNode;

import io.hypersistence.utils.hibernate.type.json.JsonType;

@Entity
@Table(name = "taskdropdownoptions", schema = "ui")
@Data
public class TaskDropdownOptions {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ioptionid", nullable = false)
    private Integer ioptionId;

    @Column(name="vclabel", length = 255)
    private String vclabel;

    @Type(JsonType.class)
    @Column(name="vcvalue", columnDefinition = "jsonb")
    private JsonNode vcvalue; 

}
