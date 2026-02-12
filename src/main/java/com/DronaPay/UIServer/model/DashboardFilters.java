package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

@Entity
@Table(name = "dashboardfilters", schema = "ui")
@Data
public class DashboardFilters {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idashboardfilterid", nullable = false)
    private Integer iDashboardFilterID;

    @Column(name = "vcdashboardfiltername")
    private String vcDashboardFilterName;

    @Column(name = "vcdashboardfilterdisplayname")
    private String vcDashboardFilterDisplayName;

    @Column(name = "vcdashboardfiltertype")
    private String vcDashboardFilterType;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "idashboardid")
    // private Dashboard idashboardID;
     
    @Column(name = "idashboardid")
    private Integer idashboardID;

    @Column(name = "ifilterorder")
    private Integer ifilterOrder;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "idashboardqueryidforoptions")
    // private DashboardQuery iDashboardQueryIDForOptions;
    
    @Column(name = "idashboardqueryidforoptions")
    private Integer iDashboardQueryIDForOptions;

    // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "idashboardqueryidfordefaultvalue")
    // private DashboardQuery iDashboardQueryIDForDefaultValue;

    @Column(name = "idashboardqueryidfordefaultvalue")
    private Integer iDashboardQueryIDForDefaultValue;

    @Column(name = "itenantid")
    private Integer itenantId;

    @Type(JsonType.class)
    @Column(name="validation", columnDefinition = "jsonb")
    private JsonNode validation;
}
