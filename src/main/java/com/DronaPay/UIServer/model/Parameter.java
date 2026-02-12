package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "parameter", schema = "ui")
public class Parameter {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iparameterid")
    private Integer iParameterID;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "iproductid")
    private Products iProductID;

    @Column(name = "vcparametertype")
    private String vcParameterType;

    @Column(name = "vcparametername")
    private String vcParameterName;

    @Column(name = "vcdatatype")
    private String vcDataType;

    @Column(name = "vcdescription")
    private String vcDescription;
}
