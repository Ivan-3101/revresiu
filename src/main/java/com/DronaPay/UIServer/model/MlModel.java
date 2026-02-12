package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

@Entity
@Table(name = "mlmodels", schema = "ui")
@Data
public class MlModel extends CheckerModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "imodelid", nullable = false)
    private Integer imodelId;

    @Column(name = "vcmlflowmodelname")
    private String vcMlFlowModelName;

    @Column(name = "vcmlflowmodeldescription", columnDefinition = "TEXT")
    private String vcMlFlowModelDescription;

    @Type(JsonType.class)
    @Column(name = "vcmodeldetail", columnDefinition = "jsonb")
    private JsonNode vcModelDetail;

    @Column(name = "imlversion")
    private Double iMlVersion;

    @Column(name = "vctype")
    private String vcType;

    @Column(name = "laststatus")
    private String lastStatus;

    @Column(name = "vcremark", columnDefinition = "TEXT")
    private String vcRemark;

    @Column(name = "irecordstatus")
    private Integer irecordStatus;

    @Column(name = "itenantid")
    private Integer itenantId;
}
