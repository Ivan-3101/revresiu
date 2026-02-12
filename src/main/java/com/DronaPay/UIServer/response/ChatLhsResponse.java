package com.DronaPay.UIServer.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.time.ZonedDateTime;
import java.util.List;

@Data
@Builder
public class ChatLhsResponse {

    private List<AgentInfo> availableAgents;
    private List<RecentChat> recentChats;

    @Data
    @AllArgsConstructor
    public static class AgentInfo {
        private Integer iagentId;
        private String agentName;
    }

    @Data
    @AllArgsConstructor
    public static class RecentChat {
        private Integer iagentId;
        private String agentName;
        private ZonedDateTime lastMessageTime;
    }
}
