package com.DronaPay.UIServer.service.RepositoryService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.EmailReportLog;
import com.DronaPay.UIServer.repository.EmailReportLogRepository;

@Service
public class EmailReportLogServiceImpl implements EmailReportLogService {

    @Autowired
    private EmailReportLogRepository emailReportLogRepository;

    @Override
    public EmailReportLog save(EmailReportLog log) {
        return emailReportLogRepository.save(log);
    }
    
}
