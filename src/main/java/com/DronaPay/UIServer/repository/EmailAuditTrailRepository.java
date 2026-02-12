package com.DronaPay.UIServer.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.DronaPay.UIServer.model.EmailAuditTrail;

public interface EmailAuditTrailRepository extends JpaRepository<EmailAuditTrail, Integer> {

    // EmailAuditTrail findTopByCorrelationIdAndProcessingStatusNotOrderByAuditIdDesc(String correlationId,Integer processingStatus);

    EmailAuditTrail findTopByCorrelationIdAndProcessingStatusNotAndItenantIdOrderByAuditIdDesc(String correlationId,Integer processingStatus, Integer tenantid);
}
