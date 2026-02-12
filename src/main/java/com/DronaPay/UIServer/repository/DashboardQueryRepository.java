package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.DashboardQuery;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DashboardQueryRepository extends JpaRepository<DashboardQuery, Integer> {

    public DashboardQuery findByiDashboardQueryIDAndItenantId(Integer id,Integer tenantId);

}
