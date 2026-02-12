package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.AiAgent;
import com.DronaPay.UIServer.repository.AiAgentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class AiAgentServiceImpl implements AiAgentService{

    @Autowired
    private AiAgentRepository aiAgentRepository;

    @Override
    public AiAgent saveAiAgent(AiAgent aiAgent) throws Exception {
        return aiAgentRepository.save(aiAgent);
    }

    @Override
    public AiAgent findByAgentIdAndTenant(Integer agentId, Integer tenantId) throws Exception{
        return aiAgentRepository.findByIagentIdAndItenantId(agentId, tenantId);
    }

    @Override
    public AiAgent findByAgentName(String agentName, Integer tenantId) throws Exception{
        return aiAgentRepository.findByVcAgentNameAndIrecordStatusAndItenantId(agentName, 0, tenantId);
    }

    @Override
    public List<AiAgent> findAllNonDeletedTenants(List<Integer> tenants) throws Exception {
        return aiAgentRepository.findAllByItenantIdIn(tenants)
                .stream()
                .filter(agent->{
                    return agent.getIstatus() == null || agent.getIstatus().getIStatusID() == 1;
                }).collect(Collectors.toList());
    }
}
