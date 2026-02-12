package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.ChatSessions;

public interface ChatSessionsService {

    public ChatSessions saveChatSession(ChatSessions chatSessions) throws Exception;

}
