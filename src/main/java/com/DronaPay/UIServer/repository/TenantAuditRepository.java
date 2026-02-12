package com.DronaPay.UIServer.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.DronaPay.UIServer.model.TenantAudit;

public interface TenantAuditRepository extends JpaRepository<TenantAudit, Integer> {

    public List<TenantAudit> findAllByIstatusIsNullAndBclosedFalse();

    public TenantAudit findByIstatusIsNullAndBclosedFalseAndVcTenantId(String tenantid);
    
}
