package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.ChatSessions;
import com.DronaPay.UIServer.repository.ChatSessionsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChatSessionsServiceImpl implements ChatSessionsService{

    @Autowired
    private ChatSessionsRepository chatSessionsRepository;

    @Override
    public ChatSessions saveChatSession(ChatSessions chatSessions) throws Exception {
        return chatSessionsRepository.save(chatSessions);
    }
}
