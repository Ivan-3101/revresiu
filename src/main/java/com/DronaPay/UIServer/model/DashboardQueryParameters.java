package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;


@Data
@Entity
@Table(name = "dashboardqueryparameters", schema = "ui")
public class DashboardQueryParameters {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idashboardparameterid")
    private Integer iDashboardParameterID;

    @Column(name = "vcparametername")
    private String vcParameterName;

    @Column(name = "vcparametertype")
    private String vcParameterType;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "idashboardqueryid")
    // private DashboardQuery iDashboardQuery;

    @Column(name = "idashboardqueryid")
    private Integer iDashboardQuery;

    @Column(name = "iorder")
    private Integer iOrder;

    @Column(name = "itenantid")
    private Integer itenantId;

    @Type(JsonType.class)
    @Column(name="validation", columnDefinition = "jsonb")
    private JsonNode validation;
}
