package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.DashboardCustomLayoutAudit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DashboardCustomLayoutAuditRepository extends JpaRepository<DashboardCustomLayoutAudit, Integer> {

}
