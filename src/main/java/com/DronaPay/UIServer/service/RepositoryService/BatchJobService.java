package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.BatchJob;

import java.util.List;

public interface BatchJobService {

    List<BatchJob> findAll(Integer itenantId, List<Integer> jobtype) throws Exception;

    BatchJob createJob(BatchJob batchJob) throws Exception;

    List<BatchJob> findPendingJob(Integer itenantid);

    List<BatchJob> findByJobid(Integer jobid);

}
