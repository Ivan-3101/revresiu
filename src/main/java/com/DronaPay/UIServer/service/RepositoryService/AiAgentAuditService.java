package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.AiAgentAudit;

import java.util.List;

public interface AiAgentAuditService {

    public AiAgentAudit saveAiAgentAudit(AiAgentAudit aiAgentAudit) throws Exception;

    public AiAgentAudit findPendingAiAgentAuditByAuditIDAndTenant(Integer auditID, Integer tenantId) throws Exception ;

    public AiAgentAudit findPendingAiAgentAuditByAgentIDAndTenant(Integer agentId, Integer tenantId) throws Exception ;

    public AiAgentAudit findByAgentName(String agentName, Integer tenantId) throws Exception ;

    public List<AiAgentAudit> findPendingEntriesTenant(List<Integer> tenantid) throws Exception;
}
