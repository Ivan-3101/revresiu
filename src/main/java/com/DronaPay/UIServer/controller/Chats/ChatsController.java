package com.DronaPay.UIServer.controller.Chats;

import com.DronaPay.UIServer.requests.GetPreviousChatsRequest;
import com.DronaPay.UIServer.requests.SendChatMessageRequest;
import com.DronaPay.UIServer.service.ControllerService.Chats.ChatsControllerService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.Authentication;

@RestController
@RequestMapping("/api/v1/testing/ai-ml/chats")
public class ChatsController {

    @Autowired
    private ChatsControllerService chatsControllerService;

    @GetMapping("/get-chats-lhs/tenant-id/{tenantid}")
    public ResponseEntity<?> getChatsLhs(@PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return chatsControllerService.getChatsLhs(tenantid, pr);
    }

    @PostMapping("/get-previous-chats")
    public ResponseEntity<?> getPreviousChats(@Valid @RequestBody GetPreviousChatsRequest getPreviousChatsRequest, Authentication pr) {
        return chatsControllerService.getPreviousChats(getPreviousChatsRequest, pr);
    }

    @PostMapping("/send-message")
    public ResponseEntity<?> sendChatMessage(@Valid @RequestBody SendChatMessageRequest sendChatMessageRequest, Authentication pr) {
        return chatsControllerService.sendChatMessage(sendChatMessageRequest, pr);
    }
}
