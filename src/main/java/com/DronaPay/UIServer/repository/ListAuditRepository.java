package com.DronaPay.UIServer.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.DronaPay.UIServer.model.ListAudit;


@Repository
public interface ListAuditRepository extends JpaRepository<ListAudit,Integer>{
    
    // @Query("SELECT u FROM ListAudit u WHERE u.vcExternalListItemId = :id AND u.istatus = null AND u.bclosed = false")
    // public ListAudit findByVcExternalListItemId(@Param("id") String vcExternalListItemId);

    public ListAudit findByVcExternalListItemIdAndIlistType_Id_ItenantId_ItenantidAndIstatusIsNullAndBclosedFalse(String vcExternalListItemId, Integer tenantid);

    // @Query("SELECT u FROM ListAudit u WHERE u.istatus = null AND u.bclosed = false")
    // public List<ListAudit> findAllPendingEntries();

    public List<ListAudit> findByIstatusIsNullAndBclosedFalse();

    public List<ListAudit> findAllByIstatusIsNullAndBclosedFalseAndIlistType_Id_ItenantId_ItenantidIn(List<Integer> tenants);

     public ListAudit findByiListItemAuditIdAndIlistType_Id_ItenantId_ItenantidAndIstatusIsNullAndBclosedFalse(Integer auditId,Integer tenants);
    
}
