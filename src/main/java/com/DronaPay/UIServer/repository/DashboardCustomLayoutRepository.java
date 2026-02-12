package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.DashboardCustomLayout;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface DashboardCustomLayoutRepository extends JpaRepository<DashboardCustomLayout, Integer> {

    // @Query("SELECT d FROM DashboardCustomLayout d WHERE d.bactive = true and
    // d.bdelete = false and d.bdefault = true and
    // d.iresultSetID.iDashboardResultSetID = :iresultsetid and d.iuserID.iUserID =
    // :iuserid")
    // public Optional<DashboardCustomLayout>
    // findDefaultLayoutByIResultSetID(@Param("iresultsetid") Integer iResultSetID,
    // @Param("iuserid") Integer iUserID);

    public Optional<DashboardCustomLayout> findByBactiveTrueAndBdeleteFalseAndBdefaultTrueAndIresultSetIDAndIuserIDIsNull(Integer iResultSetID);

    public Optional<DashboardCustomLayout> findByBactiveTrueAndBdeleteFalseAndBdefaultTrueAndIresultSetIDAndIuserIDAndItenantId(
            Integer iResultSetID,
            Integer iUserID,
            Integer tenantId);

    // @Query("SELECT d FROM DashboardCustomLayout d WHERE d.bactive = true and
    // d.bdelete = false and d.iresultSetID.iDashboardResultSetID = :iresultsetid
    // and d.iuserID.iUserID = :iuserid")
    // public Optional<DashboardCustomLayout>
    // findLayoutByIResultSetID(@Param("iresultsetid") Integer iResultSetID,
    // @Param("iuserid") Integer iUserID);

    public Optional<DashboardCustomLayout> findByBactiveTrueAndBdeleteFalseAndIresultSetIDAndIuserIDAndItenantId(
            Integer iResultSetID,
            Integer iUserID,
            Integer tenantId);

    // @Modifying
    // @Query("UPDATE DashboardCustomLayout d SET d.bdefault = false where
    // d.iresultSetID.iDashboardResultSetID = :iresultsetid ")
    // public void removeDefaultByResultSetID(@Param("iresultsetid") Integer
    // iResultSetID);

    public List<DashboardCustomLayout> findByIresultSetIDAndItenantId(Integer iResultSetID, Integer iTenantId);

    public Optional<DashboardCustomLayout> findByBactiveTrueAndBdeleteFalseAndBdefaultTrueAndIresultSetIDAndIuserIDIsNullAndItenantId(Integer iResultSetID, Integer iTenantId);

}
