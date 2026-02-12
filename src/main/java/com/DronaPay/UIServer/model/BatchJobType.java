package com.DronaPay.UIServer.model;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "batch_job_types", schema = "batch")
@Data
public class BatchJobType {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "jobtypeid")
    private Integer jobTypeId;

    @Column(name = "jobtype", nullable = false)
    private String jobType;

    @Column(name = "processingUrl", nullable = false)
    private String processingUrl;

    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "iserverid")
    private APIServerKeys iserverId;

    @Column(name = "maxrecords", nullable = false)
    private Integer maxRecords;

    @Column(name = "maxrowsize")
    private Integer maxRowSize;

    @Column(name = "numthreads")
    private Integer numThreads;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "jobTypeId", cascade = CascadeType.MERGE)
    private List<BatchJob> bulkJobs;

}
