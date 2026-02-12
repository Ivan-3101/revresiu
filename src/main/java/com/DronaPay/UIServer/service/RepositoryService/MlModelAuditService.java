package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.MlModelAudit;

import java.util.List;

public interface MlModelAuditService {

    public MlModelAudit saveMlModelAudit(MlModelAudit mlModelAudit) throws Exception;

    public MlModelAudit findByModelName(String modelName, Integer tenantId) throws Exception ;

    public MlModelAudit findPendingMlModelAuditByAuditIDAndTenant(Integer auditID, Integer tenantId) throws Exception ;

    public MlModelAudit findPendingMlModelAuditByModelIDAndTenant(Integer modelId, Integer tenantId) throws Exception ;

    public List<MlModelAudit> findPendingEntriesTenant(List<Integer> tenantid) throws Exception;

}
