package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.DashboardResultSetAudit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DashboardResultSetAuditRepository extends JpaRepository<DashboardResultSetAudit, Integer> {
}
