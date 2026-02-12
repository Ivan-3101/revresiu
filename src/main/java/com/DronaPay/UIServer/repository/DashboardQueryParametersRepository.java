package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.DashboardQueryParameters;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DashboardQueryParametersRepository extends JpaRepository<DashboardQueryParameters, Integer> {

    public List<DashboardQueryParameters> findAllByiDashboardQueryAndItenantId(Integer query_id,Integer tenantId);
}
