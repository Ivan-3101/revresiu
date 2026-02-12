package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.model.ObservationUiAudit;

public interface ObservationUiAuditService {
    
    public List<ObservationUiAudit> findAllPendingEntries() throws Exception;

    public List<ObservationUiAudit> findAllPendingEntriesTenant(List<Integer> tennats) throws Exception;

    public ObservationUiAudit saveObservationUiAudit(ObservationUiAudit observationUiAudit) throws Exception;

    public ObservationUiAudit findByObservationUiAduitId(Integer oAuditId,Integer tenantId) throws Exception;

    public ObservationUiAudit findByOId(Integer oId, Integer wid, Integer tenantid) throws Exception;

    public ObservationUiAudit findByOnameAndItenantId(String wName, Integer tenantId) throws Exception;

    public Integer findMaxIdPending() throws Exception;
}
