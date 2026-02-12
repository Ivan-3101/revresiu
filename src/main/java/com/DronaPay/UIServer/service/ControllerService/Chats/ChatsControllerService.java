package com.DronaPay.UIServer.service.ControllerService.Chats;

import com.DronaPay.UIServer.requests.GetPreviousChatsRequest;
import com.DronaPay.UIServer.requests.SendChatMessageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

public interface ChatsControllerService {

    ResponseEntity<?> getChatsLhs(Integer tenantId, Authentication pr);

    ResponseEntity<?> getPreviousChats(GetPreviousChatsRequest getPreviousChatsRequest, Authentication pr);

    ResponseEntity<?> sendChatMessage(SendChatMessageRequest sendChatMessageRequest, Authentication pr);

}
