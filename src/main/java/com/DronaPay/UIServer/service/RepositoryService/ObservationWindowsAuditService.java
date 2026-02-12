package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.model.ObservationWindowsAudit;

public interface ObservationWindowsAuditService {
    
    public List<ObservationWindowsAudit> findAllPendingEntries() throws Exception;

    public List<ObservationWindowsAudit> findAllPendingEntriesTenant(List<Integer> tenants) throws Exception;

    public ObservationWindowsAudit saveObservationWindowAudit(ObservationWindowsAudit observationWindowsAudit) throws Exception;

    public ObservationWindowsAudit findByWAuditId(Integer wAuditId,Integer tenantId) throws Exception;

    public ObservationWindowsAudit findbyWId(Integer wId,Integer tenantId) throws Exception;

    public ObservationWindowsAudit findBywName(String wNme,Integer tenantId) throws Exception;

    public Integer findMaxId() throws Exception;
}
