package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.AgentChats;

import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;

public interface AgentChatsService {

    AgentChats saveAgentChat(AgentChats agentChats) throws Exception;

    Optional<AgentChats> findTopByIuserIdAndItenantIdAndIagentIdOrderByDtTimestampDesc(Integer userId, Integer tenantId, Integer agentId);

    List<AgentChats> findTopChatsByAgentUserTenant(Integer agentId, Integer userId, Integer tenantId, ZonedDateTime fromDate, int page, int size);

    List<AgentChats> findTopChatsByUserTenant(Integer userId, Integer tenantId, ZonedDateTime fromDate, int page, int size);


}
