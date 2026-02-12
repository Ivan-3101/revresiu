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
@Table(name = "taskvariables", schema = "ui")
@Data
public class TaskVariables {
    @Id
    @Column(name="id")
    private Integer id;

    @Column(name="variables", columnDefinition = "TEXT")
    private String variables;
}
