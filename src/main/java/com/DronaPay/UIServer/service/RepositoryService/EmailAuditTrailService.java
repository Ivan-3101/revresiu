package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.EmailAuditTrail;

public interface EmailAuditTrailService {
    
    EmailAuditTrail save(EmailAuditTrail emailAuditTrail) throws Exception;

    EmailAuditTrail findByCorrerlationAndStatus(String correlationKey,Integer status, Integer tenantid) throws Exception;

}
