package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.CompositeKey.AiAgentsKey;
import com.DronaPay.UIServer.model.AiAgent;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AiAgentRepository  extends JpaRepository<AiAgent, AiAgentsKey> {

    AiAgent findByIagentIdAndItenantId(Integer agentId, Integer itenantId);

    AiAgent findByVcAgentNameAndIrecordStatusAndItenantId(String agentName, Integer zero, Integer itenantId);

    List<AiAgent> findAllByItenantIdIn(List<Integer> tenantids);
}
