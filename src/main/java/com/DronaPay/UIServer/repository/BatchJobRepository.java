package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.BatchJob;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BatchJobRepository extends JpaRepository<BatchJob, Integer> {

    List<BatchJob> findAllByItenantIdOrderByJobIdDesc(Integer itenantId);

    List<BatchJob> findAllByItenantIdAndJobTypeId_JobTypeIdInOrderByJobIdDesc(Integer itenantId, List<Integer> jobTypeId);

    List<BatchJob> findAllByJobStatusInAndItenantId(List<String> status, Integer itenantid);

    List<BatchJob> findByjobId(Integer jobid);


}
