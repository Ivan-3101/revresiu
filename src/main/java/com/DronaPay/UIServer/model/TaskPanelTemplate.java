package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;
import lombok.ToString;

import java.util.List;

@Data
@Entity
@Table(name = "taskpanelmasters", schema = "ui")
public class TaskPanelTemplate {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "taskpanelid")
    private Integer taskPanelId;

    @Column(name = "panelname")
    private String panelName;

    @JsonIgnore
    @OneToMany(fetch = FetchType.EAGER, mappedBy = "taskPanelTemplate")
    @ToString.Exclude
    private List<SectionMasters> sectionMasters;

    @Column(name = "sequence")
    private Integer sequence;
}
