package com.DronaPay.UIServer.model;

import org.hibernate.annotations.Type;

import com.DronaPay.UIServer.CompositeKey.WorkflowMastersKey;
import com.fasterxml.jackson.databind.JsonNode;

import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "workflowmasters", schema = "ui")
@IdClass(WorkflowMastersKey.class)
public class WorkflowMasters {

    @Id
    @Column(name = "workflowid")
    private Integer workflowId;

    @Column(name = "workflowname")
    private String workflowName;

    @Column(name = "workflowkey")
    private String workflowKey;

    @Id
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "itenantid")
    private Tenant itenantId;

    // @Column(name = "manual_display_name")
    // private String manualDisplayName;

    @Column(name = "is_manual_creation")
    private Boolean isManualCreation;

    @Column(name = "is_filter_display")
    private Boolean isFilterDisplay;

    @Type(JsonType.class)
    @Column(name = "manual_attribs", columnDefinition = "jsonb")
    private JsonNode attribs;

    // @JoinColumn(name="idecisionid")
    // @ManyToOne(fetch = FetchType.EAGER)
    // private DecisionUi decisionId;
 
    @Column(name="idecisionid")
    private Integer decisionId;

    // @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "manualworkflowid")
    // private WorkflowMasters manualWorkflow;

    @Column(name = "manualworkflowid")
    private Integer manualWorkflow;

    @Type(JsonType.class)
    @Column(name = "filterparams", columnDefinition = "jsonb")
    private JsonNode filterParams;

    @Type(JsonType.class)
    @Column(name = "displayconfig", columnDefinition = "jsonb")
    private JsonNode displayConfig;
}
