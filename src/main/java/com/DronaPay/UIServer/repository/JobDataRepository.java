package com.DronaPay.UIServer.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.DronaPay.UIServer.model.JobData;

import java.util.List;

public interface JobDataRepository extends JpaRepository<JobData,Integer> {

    List<JobData> findByJobidAndStatus(Integer jobid, String status);
    
}
