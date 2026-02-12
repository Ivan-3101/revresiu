package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.AgentChats;
import com.DronaPay.UIServer.repository.AgentChatsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class AgentChatsServiceImpl implements AgentChatsService{

    @Autowired
    private AgentChatsRepository agentChatsRepository;

    @Override
    public AgentChats saveAgentChat(AgentChats agentChats) throws Exception {
        return agentChatsRepository.save(agentChats);
    }

    @Override
    public Optional<AgentChats> findTopByIuserIdAndItenantIdAndIagentIdOrderByDtTimestampDesc(Integer userId, Integer tenantId, Integer agentId) {
        return agentChatsRepository.findTopByIuserIdAndItenantIdAndIagentIdOrderByDtTimestampDesc(userId, tenantId, agentId);
    }

    @Override
    public List<AgentChats> findTopChatsByAgentUserTenant(Integer agentId, Integer userId, Integer tenantId, ZonedDateTime fromDate, int page, int size) {
        return agentChatsRepository.findByIagentIdAndIuserIdAndItenantIdAndDtTimestampAfterOrderByDtTimestampDesc(
                agentId, userId, tenantId, fromDate, PageRequest.of(page,size));
    }

    @Override
    public List<AgentChats> findTopChatsByUserTenant(Integer userId, Integer tenantId, ZonedDateTime fromDate, int page, int size) {
        return agentChatsRepository.findByIuserIdAndItenantIdAndDtTimestampAfterOrderByDtTimestampDesc(
                userId, tenantId, fromDate, PageRequest.of(page,size));
    }

}
