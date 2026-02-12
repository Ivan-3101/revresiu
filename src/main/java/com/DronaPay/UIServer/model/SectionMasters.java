package com.DronaPay.UIServer.model;

import org.hibernate.annotations.Type;

import com.fasterxml.jackson.databind.JsonNode;

import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "sectionmasters", schema = "ui")
public class SectionMasters {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "sectionid")
    private Integer sectionlId;

    @ManyToOne
    @JoinColumn(name = "taskpanelid")
    private TaskPanelTemplate taskPanelTemplate;

    @Column(name = "sectionname")
    private String sectionName;

    @Type(JsonType.class)
    @Column(name = "value_config", columnDefinition = "jsonb")
    private JsonNode valueConfig;
}
