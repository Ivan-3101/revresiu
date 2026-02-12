package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;


@Entity
@Table(name = "chargebacktransactions", schema = "ui")
@Data
public class ChargeBackTransactions {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "chargebacktransactionid")
    private Integer uploadChargeBackId;

    @Column(name = "chargebackid", unique = true)
    private String chargebackid;

    @Column(name = "transactionid")
    private String transactionid;

    @Column(name = "adjtype")
    private String adjType;

}
