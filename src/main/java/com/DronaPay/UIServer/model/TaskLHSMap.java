package com.DronaPay.UIServer.model;

import com.DronaPay.UIServer.CompositeKey.TaskLHSMapKey;
import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

@Entity
@Table(name = "tasklhsmap", schema = "ui")
@Data
@IdClass(TaskLHSMapKey.class)
public class TaskLHSMap {

//    @Id
//    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
//    @JoinColumn(name = "iworkflowid")
//    private WorkflowMasters workflowId;

    @Id
    @Column(name = "iworkflowid")
    private Integer workflowId;


    @Id
    @Column(name = "itenantid")
    private Integer itenantId;

    @Id
    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "idropdownoptionid")
    private TaskDropdownOptions optionId;

    @Id
    @Column(name = "iorder")
    private Integer iorder;

    @Id
    @Column(name = "irow")
    private Integer irow;

    @Column(name = "icolumn")
    private Integer icolumn;

    @Type(JsonType.class)
    @Column(name = "valueconfig", columnDefinition = "jsonb")
    private JsonNode valueConfig;
}
