package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.Dashboard;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DashboardRepository extends JpaRepository<Dashboard, Integer> {

    // @Query("SELECT d FROM Dashboard d WHERE d.bActive = true and d.bDelete =
    // false order by d.iOrder")
    // public List<Dashboard> findAllActiveAndNotDeleted();

    public Optional<Dashboard> findByVcDashboardNameAndItenantId(String vcDashboardName, Integer tenantId);

    public Dashboard findByiDashboardIDAndItenantId(Integer id, Integer tenantid);

    public List<Dashboard> findByItenantIdAndBactiveTrueAndBdeleteFalseAndBdynamicTrueOrderByIorderAsc(
            Integer tenantId);

    public List<Dashboard> findByImenuStructureDesc_iMenuIDAndItenantIdAndBactiveTrueAndBdeleteFalseAndBdynamicTrueOrderByIorderAsc(
            Integer imenuid, Integer tenantId);

    public List<Dashboard> findByImenuStructureDesc_iMenuIDAndItenantIdAndBactiveTrueAndBdeleteFalseOrderByIorderAsc(
            Integer iMenuid, Integer tenantId);

    public List<Dashboard> findAllByiDashboardIDInAndItenantId(List<Integer> dashboardIds, Integer tenantid);
}
