package com.DronaPay.UIServer.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "apiserver_keys", schema="batch")
@Data
public class APIServerKeys {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iserverid", nullable = false)
    private Integer iserverId;

    @Column(name = "baseurl", nullable = false)
    private String baseUrl;

    @Column(name = "keyname", nullable = false)
    private String keyName;

    @Column(name = "keyvalue", nullable = false)
    private String keyValue;
}
