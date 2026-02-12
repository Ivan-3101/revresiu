package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.AiAgentAudit;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AiAgentAuditRepository extends JpaRepository<AiAgentAudit, Integer> {

    AiAgentAudit findByBclosedFalseAndIagentAuditIdAndItenantId(Integer auditID, Integer tenantId);

    AiAgentAudit findByBclosedFalseAndIagentIdAndItenantId(Integer agentId, Integer tenantId);

    AiAgentAudit findByIstatusIsNullAndBclosedFalseAndVcAgentNameAndItenantId(String agentName, Integer itenantId);

    List<AiAgentAudit> findByIstatusIsNullAndBclosedFalseAndItenantIdIn(List<Integer> tenantid);

}
