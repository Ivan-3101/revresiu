package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.ChatSessions;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ChatSessionsRepository extends JpaRepository<ChatSessions, Integer> {
}
