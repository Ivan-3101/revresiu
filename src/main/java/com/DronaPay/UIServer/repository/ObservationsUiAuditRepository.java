package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.ObservationUiAudit;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ObservationsUiAuditRepository extends JpaRepository<ObservationUiAudit, Integer> {

    // @Query("SELECT u FROM ObservationUiAudit u WHERE u.istatus = null AND u.bclosed = false")
    // public List<ObservationUiAudit> findAllPendingEntries();

    public List<ObservationUiAudit> findByIstatusIsNullAndBclosedFalse();

    public List<ObservationUiAudit> findAllByItenantIdInAndIstatusIsNullAndBclosedFalse(List<Integer> tenants);
    // public List<ObservationUiAudit> findAllByIstatusIsNullAndBclosedFalseAndItenantId_ItenantidIn(List<Integer> tennats);

    // @Query("SELECT u FROM ObservationUiAudit u WHERE u.istatus = null AND u.bclosed = false AND u.oAuditId = :oauditid")
    // public ObservationUiAudit findAllPendingEntriesById(@Param("oauditid") int oAuditId);
    public ObservationUiAudit findByIstatusIsNullAndBclosedFalseAndOauditIdAndItenantId(Integer oAuditId,Integer tenantId);

    // @Query("SELECT u FROM ObservationUiAudit u WHERE u.istatus = null AND u.bclosed = false AND u.oId.oId = :oid")
    // public ObservationUiAudit findAllPendingEntriesByOId(@Param("oid") int oId);
    public ObservationUiAudit findByIstatusIsNullAndBclosedFalseAndOidAndItenantId(Integer oId,Integer tenantId);

    // @Query("SELECT u FROM ObservationUiAudit u WHERE u.istatus = null AND u.bclosed = false AND u.oName = :oname")
    // public ObservationUiAudit findAllPendingEntriesByName(@Param("oname") String oName);

    public ObservationUiAudit findByIstatusIsNullAndBclosedFalseAndOnameAndItenantId(String oname, Integer tenantId);

    // @Query("SELECT Max(u.oid) FROM ObservationUiAudit u WHERE u.istatus = null AND u.bclosed = false")
    // public Integer findMaxIdOfPendingEntry();
    public ObservationUiAudit findTopByIstatusIsNullAndBclosedFalseOrderByOid();

    public ObservationUiAudit findTopByIstatusIsNullAndBclosedFalseOrderByOidDesc();

}
