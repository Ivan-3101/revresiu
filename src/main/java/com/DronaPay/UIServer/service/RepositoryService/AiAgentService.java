package com.DronaPay.UIServer.service.RepositoryService;


import com.DronaPay.UIServer.model.AiAgent;

import java.util.List;

public interface AiAgentService  {

    public AiAgent saveAiAgent(AiAgent aiAgent) throws Exception;

    public AiAgent findByAgentIdAndTenant(Integer agentId, Integer tenantId) throws Exception ;

    public AiAgent findByAgentName(String agentName, Integer tenantId) throws Exception ;

    public List<AiAgent> findAllNonDeletedTenants(List<Integer> tenants) throws Exception;

}
