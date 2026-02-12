package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.AgentChats;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.domain.Pageable;


import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;

public interface AgentChatsRepository extends JpaRepository<AgentChats, Integer> {

    Optional<AgentChats> findTopByIuserIdAndItenantIdAndIagentIdOrderByDtTimestampDesc(Integer userId, Integer tenantId, Integer agentId);

    List<AgentChats> findByIagentIdAndIuserIdAndItenantIdAndDtTimestampAfterOrderByDtTimestampDesc(Integer agentId, Integer userId, Integer tenantId, ZonedDateTime fromDate, Pageable pageable);

    List<AgentChats> findByIuserIdAndItenantIdAndDtTimestampAfterOrderByDtTimestampDesc(Integer userId, Integer tenantId, ZonedDateTime fromDate, Pageable pageable);


}
