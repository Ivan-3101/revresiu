package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.BatchJob;
import com.DronaPay.UIServer.repository.BatchJobRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service
public class BatchJobServiceImpl implements BatchJobService {

    @Autowired
    private BatchJobRepository batchJobRepository;

    @Override
    public List<BatchJob> findAll(Integer itenantId, List<Integer> jobtype) {

        return batchJobRepository.findAllByItenantIdAndJobTypeId_JobTypeIdInOrderByJobIdDesc(itenantId, jobtype);
    }

    @Override
    public BatchJob createJob(BatchJob batchJob) throws Exception {
        return batchJobRepository.save(batchJob);
    }

    @Override
    public List<BatchJob> findPendingJob(Integer itenantid) {
        return batchJobRepository.findAllByJobStatusInAndItenantId(Arrays.asList("PENDING", "IN PROGRESS"), itenantid);
    }

    @Override
    public List<BatchJob> findByJobid(Integer jobid) {
        return batchJobRepository.findByjobId(jobid);
    }


}
