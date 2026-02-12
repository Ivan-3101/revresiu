package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.AiAgentAudit;
import com.DronaPay.UIServer.repository.AiAgentAuditRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AiAgentAuditServiceImpl implements AiAgentAuditService{

    @Autowired
    private AiAgentAuditRepository aiAgentAuditRepository;

    @Override
    public AiAgentAudit saveAiAgentAudit(AiAgentAudit aiAgentAudit) throws Exception {
        return aiAgentAuditRepository.save(aiAgentAudit);
    }

    @Override
    public AiAgentAudit findPendingAiAgentAuditByAuditIDAndTenant(Integer auditID, Integer tenantId) throws Exception {
        return aiAgentAuditRepository.findByBclosedFalseAndIagentAuditIdAndItenantId(auditID, tenantId);
    }

    @Override
    public AiAgentAudit findPendingAiAgentAuditByAgentIDAndTenant(Integer agentId, Integer tenantId) throws Exception{
        return aiAgentAuditRepository.findByBclosedFalseAndIagentIdAndItenantId(agentId, tenantId);
    }

    @Override
    public AiAgentAudit findByAgentName(String agentName, Integer tenantId) throws Exception{
        return aiAgentAuditRepository.findByIstatusIsNullAndBclosedFalseAndVcAgentNameAndItenantId(agentName, tenantId);
    }

    @Override
    public List<AiAgentAudit> findPendingEntriesTenant(List<Integer> tenantid) throws Exception {
        return aiAgentAuditRepository.findByIstatusIsNullAndBclosedFalseAndItenantIdIn(tenantid);
    }
}
