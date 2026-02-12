package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;


@Entity
@Table(name = "templateresponse", schema = "ui")
@Data
public class TemplateResponse {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "templateid", nullable = false)
    private Integer templateId;

    @Column(name = "templatename")
    private String templateName;

    @Column(name = "responses")
    private String responses;

    @Column(name = "activeflag")
    private String activeFlag;

    @Column(name = "jsonresponse")
    private String jsonResponse;
}
