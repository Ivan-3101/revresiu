package com.DronaPay.UIServer.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "responsecallbacktemplate", schema = "ui")
@Data
public class ResponseCallBackTemplate {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "templateid")
    private Integer templateId;

    @Column(name = "subjecttemplate")
    private String subjectTemplate;

    @Column(name = "bodytemplate")
    private String bodyTemplate;

    @Column(name = "messagename")
    private String messageName;

}
