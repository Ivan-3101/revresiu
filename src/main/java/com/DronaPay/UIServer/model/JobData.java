package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import lombok.Data;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Type;
import org.hibernate.annotations.Parameter;;

@Entity
@Table(name = "batch_job_data", schema = "batch")
@Data
public class JobData {

  @Id
  @GeneratedValue(generator = "sequence-generator")
  @GenericGenerator(name = "sequence-generator", strategy = "org.hibernate.id.enhanced.SequenceStyleGenerator", parameters = {
      @Parameter(name = "sequence_name", value = "batch.batch_job_data_seq"),
      @Parameter(name = "increment_size", value = "1")
  })
  @Column(name = "jobdataid")
  private Integer jobDataId;

  @Type(JsonType.class)
  @Column(name = "jobdata", columnDefinition = "jsonb")
  private JsonNode jobData;

  // // @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
  // // @JoinColumn(name = "jobid")
  // private BatchJob jobid;
  @Column(name = "jobid")
  private Integer jobid;

  @Column(name = "status")
  private String status;

  @Type(JsonType.class)
  @Column(name = "processresponse", columnDefinition = "jsonb")
  private JsonNode processResponse;

}
