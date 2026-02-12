package com.DronaPay.UIServer.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

import java.math.BigInteger;

@Entity
@Table(name = "accounts", schema = "masters")
@Data
public class Accounts {
    @Id
    @Column(name = "iaccountid")
    private BigInteger iaccountID;

    @Column(name = "vcexternalaccountid")
    private String vcExternalAccountID;
}
