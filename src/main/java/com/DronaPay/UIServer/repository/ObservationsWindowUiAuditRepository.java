package com.DronaPay.UIServer.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.DronaPay.UIServer.model.ObservationWindowsAudit;

public interface ObservationsWindowUiAuditRepository extends  JpaRepository<ObservationWindowsAudit, Integer>{
    
    // @Query("SELECT u FROM ObservationWindowsAudit u WHERE u.istatus = null AND u.bclosed = false")
    // public List<ObservationWindowsAudit> findAllPendingEntries();

    public List<ObservationWindowsAudit> findByIstatusIsNullAndBclosedFalse();

    public List<ObservationWindowsAudit> findAllByItenantIdInAndIstatusIsNullAndBclosedFalse(List<Integer> tenants);

    // @Query("SELECT u FROM ObservationWindowsAudit u WHERE u.istatus = null AND u.bclosed = false AND u.wAuditId = :wauditid")
    // public ObservationWindowsAudit findPendingEntriesById(@Param("wauditid") int wAuditId);
    public ObservationWindowsAudit findByIstatusIsNullAndBclosedFalseAndWauditIdAndItenantId(Integer wAuditId,Integer tenantId);

    // @Query("SELECT u FROM ObservationWindowsAudit u WHERE u.istatus = null AND u.bclosed = false AND u.wId.wId = :wid")
    // public ObservationWindowsAudit findPendingEntriesByWId(@Param("wid") int wId);
    public ObservationWindowsAudit findByIstatusIsNullAndBclosedFalseAndWidAndItenantId(Integer wId,Integer tenantId);

    // @Query("SELECT u FROM ObservationWindowsAudit u WHERE u.istatus = null AND u.bclosed = false AND u.wName = :wname")
    // public ObservationWindowsAudit findPendingEntriesByName(@Param("wname") String wName);
    public ObservationWindowsAudit findByIstatusIsNullAndBclosedFalseAndWnameAndItenantId(String wname,Integer tenantId);

    // @Query("SELECT Max(u.wid) FROM ObservationWindowsAudit u WHERE u.istatus = null AND u.bclosed = false")
    // public Integer findmaxIdOfPending();
    public ObservationWindowsAudit findTopByIstatusIsNullAndBclosedFalseOrderByWidDesc();
}

