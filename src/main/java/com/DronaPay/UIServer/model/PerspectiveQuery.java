package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Data
@Entity
@Table(name = "perspectivequery", schema = "ui")
public class PerspectiveQuery {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iperspectivequeryid")
    private Integer iPerspectiveQueryID;

    @Column(name = "vctablename", unique = true)
    private String vcTableName;

    @Column(name = "vcquery")
    private String vcQuery;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "perspectivequery", cascade = CascadeType.MERGE)
    private List<PerspectiveQueryParameters> perspectiveQueryParametersList;

    @Column(name = "formattingrequiered")
    private Boolean formattingRequiered;

    @Column(name = "runonanalytics")
    private Boolean runOnAnalytics;
}
