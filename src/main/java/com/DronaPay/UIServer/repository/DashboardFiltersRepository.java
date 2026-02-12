package com.DronaPay.UIServer.repository;

import java.util.ArrayList;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.DronaPay.UIServer.model.DashboardFilters;

@Repository
public interface DashboardFiltersRepository extends JpaRepository<DashboardFilters, Integer> {

    // @Query("SELECT df FROM DashboardFilters df WHERE df.idashboardID.iDashboardID
    // = :dashboardid order by df.ifilterOrder asc")
    // public ArrayList<DashboardFilters> getAllByIDashboardID(@Param("dashboardid")
    // Integer idashboardid);

    public DashboardFilters findByiDashboardFilterIDAndItenantId(Integer id, Integer tenantId);

    public ArrayList<DashboardFilters> findByIdashboardIDAndItenantIdOrderByIfilterOrderAsc(
            Integer idashboardid, Integer tenantId);
}
