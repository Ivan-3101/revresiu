package com.DronaPay.UIServer.model;
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
import java.time.ZonedDateTime;
import java.util.Date;
import java.util.List;

import org.hibernate.annotations.Type;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.databind.JsonNode;

import io.hypersistence.utils.hibernate.type.json.JsonType;
import lombok.Data;

@Entity
@Table(name = "batch_job", schema = "batch")
@Data
public class BatchJob {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "jobid")
  private Integer jobId;

  @Column(name = "jobstatus", nullable = false)
  private String jobStatus;

  @Column(name = "createdtimestamp")
  private Date createdTimeStamp;

  @Column(name = "startedtimestamp")
  private Date startedTimeStamp;

  @Column(name = "endtimestamp")
  private Date endTimeStamp;

  @Column(name = "vcremark", columnDefinition = "TEXT")
  private String vcRemark;

  @Column(name = "ientryuserid")
  private Integer ientryuserid;

  @Column(name = "iorgid")
  private Integer iorgid;


  // @JsonIgnore
  // @OneToMany(fetch = FetchType.EAGER, mappedBy = "jobid", cascade = CascadeType.MERGE)
  // private List<JobData> jobDatas;

  @JsonIgnore
  @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
  @JoinColumn(name = "jobtypeid")
  private BatchJobType jobTypeId;

  @Column(name = "totalrecords")
  private Integer totalRecords;

  @Column(name = "passedrecords")
  private Integer passedRecords;

  @Column(name = "failedrecords")
  private Integer failedRecords;

  @Column(name = "itenantid")
  private Integer itenantId;

  @JsonIgnore
  @Type(JsonType.class)
  @Column(name = "jobparams", columnDefinition = "jsonb")
  private JsonNode jobParams;

}
