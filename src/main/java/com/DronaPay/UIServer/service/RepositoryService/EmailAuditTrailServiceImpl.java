package com.DronaPay.UIServer.service.RepositoryService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.DronaPay.UIServer.model.EmailAuditTrail;
import com.DronaPay.UIServer.repository.EmailAuditTrailRepository;

@Component
public class EmailAuditTrailServiceImpl implements EmailAuditTrailService {

    @Autowired
    private EmailAuditTrailRepository emailAuditTrailRepository;

    @Override
    public EmailAuditTrail save(EmailAuditTrail emailAuditTrail) throws Exception {
        return emailAuditTrailRepository.save(emailAuditTrail);
    }

    @Override
    public EmailAuditTrail findByCorrerlationAndStatus(String correlationKey, Integer status, Integer tenantid) throws Exception {

        return emailAuditTrailRepository.findTopByCorrelationIdAndProcessingStatusNotAndItenantIdOrderByAuditIdDesc(correlationKey,
                status, tenantid);
    }

}
