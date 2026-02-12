package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.JobData;
import com.DronaPay.UIServer.repository.JobDataRepository;

@Service
public class JobDataServiceImpl  implements JobDataService{

    @Autowired
    private JobDataRepository jobDataRepository;

    @Override
    public void saveAll(List<JobData> jobDatas) throws Exception {
        jobDataRepository.saveAll(jobDatas);
    }
    
}
