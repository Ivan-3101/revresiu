package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.DashboardResultSet;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DashboardResultSetRepository extends JpaRepository<DashboardResultSet, Integer> {

    public DashboardResultSet findByiDashboardResultSetIDAndItenantId(Integer id,Integer tenantid);

    public List<DashboardResultSet> findAllByiDashboardIDAndItenantId(Integer id,Integer tenantid);

    public List<DashboardResultSet> findAllByiDashboardResultSetIDInAndItenantId(List<Integer> id,Integer tenantid);

}
