package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.model.JobData;

public interface JobDataService {
    
    void saveAll(List<JobData> jobDatas) throws Exception;


}
