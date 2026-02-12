package com.DronaPay.UIServer.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.DronaPay.UIServer.model.EmailReportLog;

public interface EmailReportLogRepository extends JpaRepository<EmailReportLog, Integer>{
    
}
