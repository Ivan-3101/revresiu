package com.DronaPay.UIServer.service.ControllerService.Chats;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.Enum.ChatSessionsStatus;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.model.ChatSessions;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.requests.*;
import com.DronaPay.UIServer.response.*;
import com.DronaPay.UIServer.service.ApiServices.AgentsApiService;
import com.DronaPay.UIServer.service.RepositoryService.ActivityLogService;
import com.DronaPay.UIServer.service.RepositoryService.AgentChatsService;
import com.DronaPay.UIServer.service.RepositoryService.AiAgentService;
import com.DronaPay.UIServer.service.RepositoryService.ChatSessionsService;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.time.ZonedDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class ChatsControllerServiceImpl implements ChatsControllerService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ChatsControllerServiceImpl.class);
    private static final String menu_name = MenuNames.Chats;

    @Autowired
    private ActivityLogService activityLogService;

    @Autowired
    private AgentChatsService agentChatsService;

    @Autowired
    private AiAgentService aiAgentService;

    @Autowired
    private ChatSessionsService chatSessionsService;

    @Autowired
    private AgentsApiService agentsApiService;

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Override
    public ResponseEntity<?> getChatsLhs(Integer tenantId, Authentication pr) {
        LOGGER.debug("entered in class " + ChatsControllerServiceImpl.class + " in method getChatsLhs");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();
        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp == null || !mp.isView()) {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access Chats list");
            LOGGER.debug("Exiting getChatsLhs Method in " + ChatsControllerServiceImpl.class
                    + " class with response  : Unauthorized to access list of chats");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Unauthorized to access list of Chats"),
                    HttpStatus.FORBIDDEN);
        }

        Integer userId = loggedInUser.getIuserID();


        List<ChatLhsResponse.AgentInfo> availableAgents = new ArrayList<>();
        List<ChatLhsResponse.RecentChat> recentChats = new ArrayList<>();
        List<AiAgent> agents = new ArrayList<>();

        try {
            agents = aiAgentService.findAllNonDeletedTenants(List.of(tenantId))
                    .stream()
                    .filter(agent -> agent.getIrecordStatus() != null && agent.getIrecordStatus() == 0
                            && Objects.equals(agent.getVcInitiation(), "Chat"))
                    .collect(Collectors.toList());
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to get Agent details", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        for (AiAgent agent : agents) {
            availableAgents.add(new ChatLhsResponse.AgentInfo(agent.getIagentId(), agent.getVcAgentName()));
        }

        ZonedDateTime thirtyDaysAgo = ZonedDateTime.now().minusDays(30);

        for (AiAgent agent : agents) {
            Integer agentId = agent.getIagentId();

            try{
                if (agentId == 0 && "Drona".equalsIgnoreCase(agent.getVcAgentName())) {
                    recentChats.add(new ChatLhsResponse.RecentChat(agentId, agent.getVcAgentName(), null));
                } else {
                    Optional<AgentChats> latest = agentChatsService
                            .findTopByIuserIdAndItenantIdAndIagentIdOrderByDtTimestampDesc(userId, tenantId, agentId);
                    if (latest.isPresent() && latest.get().getDtTimestamp().isAfter(thirtyDaysAgo)) {
                        recentChats.add(new ChatLhsResponse.RecentChat(agentId, agent.getVcAgentName(), latest.get().getDtTimestamp()));
                    }
                }
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get Recent chat details", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }

        ChatLhsResponse response = ChatLhsResponse.builder()
                .availableAgents(availableAgents)
                .recentChats(recentChats)
                .build();

        return ResponseEntity.ok(response);
    }

    @Override
    public ResponseEntity<?> getPreviousChats(GetPreviousChatsRequest getPreviousChatsRequest, Authentication pr) {
        LOGGER.debug("Entered getPreviousChats in " + ChatsControllerServiceImpl.class);

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();
        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp == null || !mp.isView()) {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access Chats");
            LOGGER.debug("Exiting getPreviousChats Method in " + ChatsControllerServiceImpl.class
                    + " class with response  : Unauthorized to access chats");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Unauthorized to access Chats"),
                    HttpStatus.FORBIDDEN);
        }

        Integer userId = loggedInUser.getIuserID();
        Integer agentId = getPreviousChatsRequest.getAgentId();
        Integer tenantId = getPreviousChatsRequest.getTenantId();
        int size = getPreviousChatsRequest.getLimit() == null || getPreviousChatsRequest.getLimit() == 0 ? 10 : getPreviousChatsRequest.getLimit();
        int offset = getPreviousChatsRequest.getOffset() == null ? 0 : getPreviousChatsRequest.getOffset();
        int page = offset / size;

        AiAgent aiAgent = null;
        try{
            aiAgent = aiAgentService.findByAgentIdAndTenant(agentId, tenantId);
        } catch (Exception e) {
            LOGGER.error("Error while fetching agent: " + e);
            activityLogService.addActivity(loggedInUser, "failed to get agent",
                    e.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        if(aiAgent == null){
            LOGGER.info("Agent not found for agentId = {} and tenantId = {}", agentId, tenantId);
            activityLogService.addActivity(loggedInUser, "No Agent found");
            return new ResponseEntity<>(new ApiResponse(false, "No Agent found"), HttpStatus.BAD_REQUEST);

        }

        ZonedDateTime thirtyDaysAgo = ZonedDateTime.now().minusDays(30);

        List<AgentChats> chatEntities;

        if (agentId == 0 || "Drona".equalsIgnoreCase(aiAgent.getVcAgentName())) {
            chatEntities = agentChatsService.findTopChatsByUserTenant(userId, tenantId,
                    thirtyDaysAgo, page, size);
        } else {
            chatEntities = agentChatsService.findTopChatsByAgentUserTenant(agentId, userId, tenantId,
                    thirtyDaysAgo, page, size);
        }

        // Reverse to get oldest → newest
        Collections.reverse(chatEntities);

        List<PreviousChatResponse> responseList = chatEntities.stream()
                .map(chat -> new PreviousChatResponse(
                        chat.getBagentMsg(),
                        chat.getVcMessage(),
                        chat.getDtTimestamp()
                ))
                .collect(Collectors.toList());

        LOGGER.info("Exiting getPreviousChats with " + responseList.size() + " messages");
        return ResponseEntity.ok(responseList);
    }

    @Override
    public ResponseEntity<?> sendChatMessage(SendChatMessageRequest sendChatMessageRequest, Authentication pr) {
        LOGGER.debug("Entered in class " + ChatsControllerServiceImpl.class + " in method sendChatMessage");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();
        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp == null || !mp.isAdd()) {
            activityLogService.addActivity(loggedInUser, "Unauthorized to send chat message");
            LOGGER.debug("Exiting sendChatMessage Method in " + ChatsControllerServiceImpl.class
                    + " class with response  : unauthorized to send chat message");
            return new ResponseEntity<>(new ApiResponse(false,
                    "Unauthorized to send chat message"), HttpStatus.FORBIDDEN);
        }

        try {

            Integer iagentId = sendChatMessageRequest.getAgentId();
            Integer tenantId = sendChatMessageRequest.getTenantId();
            String userMessage = sendChatMessageRequest.getUserMessage();
            Integer userId = loggedInUser.getIuserID();

            AiAgent aiAgent = null;

            try{
                aiAgent = aiAgentService.findByAgentIdAndTenant(iagentId,
                        tenantId);
            } catch (Exception e){
                LOGGER.error("Error while fetching Agent: " + e + "\nParam: "
                        + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "Failed to get Agent", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (aiAgent == null) {
                LOGGER.warn("No Agent found for agentId={} and tenantId={}",
                        iagentId, tenantId);
                activityLogService.addActivity(loggedInUser,
                        "Attempted to send message to non-existing agent: " +
                                iagentId);
                return new ResponseEntity<>(new ApiResponse(false, "Agent not found"),
                        HttpStatus.BAD_REQUEST);
            }

            String agentIdFromConfig = null;
            JsonNode vcConfig = aiAgent.getVcConfig();
            try {
                if (vcConfig != null && vcConfig.has("agent")) {
                    agentIdFromConfig = vcConfig.get("agent").asText();
                } else {
                    LOGGER.info("Missing 'agent' in vcConfig for agent: {}", aiAgent.getIagentId());
                    activityLogService.addActivity(loggedInUser, "Missing 'agent' in vcConfig");
                    return new ResponseEntity<>(new ApiResponse(false, "Invalid agent configuration"), HttpStatus.BAD_REQUEST);
                }
                if (!vcConfig.has("input_data") || !vcConfig.get("input_data").isArray()) {
                    LOGGER.info("Missing or invalid 'input_data' in vcConfig for agent: {}", agentIdFromConfig);
                    activityLogService.addActivity(loggedInUser, "Missing or invalid 'input_data' in vcConfig");
                    return new ResponseEntity<>(new ApiResponse(false, "Invalid agent configuration"), HttpStatus.BAD_REQUEST);
                }
            } catch (Exception e) {
                LOGGER.info("Failed to extract agentId from vcConfig: " + e.getMessage());
                activityLogService.addActivity(loggedInUser, "Invalid vcConfig JSON", e.toString());
                return new ResponseEntity<>(new ApiResponse(false, "Invalid agent config"), HttpStatus.BAD_REQUEST);
            }

            // Step 1: Call getAgentResponse
            JsonNode agentReply;
            try {
                ResponseEntity<String> apiResponse = agentsApiService.getAgentResponse(
                        tenantId,userId,userMessage, agentIdFromConfig, vcConfig);

                if (!apiResponse.getStatusCode().is2xxSuccessful()) {
                    LOGGER.error("Agent API responded with non-2xx status: {} - Body: {}",
                            apiResponse.getStatusCode(), apiResponse.getBody());
                    activityLogService.addActivity(loggedInUser,
                            "Agent API returned error: " + apiResponse.getStatusCode());
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            apiResponse.getStatusCode());
                }

                String responseBody = apiResponse.getBody();
                JsonNode responseJson = new ObjectMapper().readTree(responseBody);

                if (responseJson.has("answer")) {
                    agentReply = responseJson;
                } else {
                    LOGGER.info("Agent API response missing 'answer' field. Full response: {}", responseBody);
                    activityLogService.addActivity(loggedInUser,
                            "Agent API response missing 'answer' field");
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.BAD_GATEWAY);
                }
            } catch (Exception e) {
                LOGGER.error("Failed to get response from agent. Error: " + e.getMessage(), e);
                activityLogService.addActivity(loggedInUser, "Failed to get response from agent",
                        e.toString());
                return new ResponseEntity<>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            // Step 2: Save user message
            AgentChats userMsg = new AgentChats();
            userMsg.setIagentId(iagentId);
            userMsg.setBagentMsg(false);
            userMsg.setVcMessage(userMessage);
            userMsg.setDtTimestamp(ZonedDateTime.now());
            userMsg.setIuserId(userId);
            userMsg.setIorgId(loggedInUser.getIorgId().getIorgid());
            userMsg.setItenantId(tenantId);

            try {
                agentChatsService.saveAgentChat(userMsg);
            } catch (Exception e) {
                LOGGER.error("Failed to save chat [userId={}, agentId={}]. Error: {}", userId, iagentId,
                        e.getMessage(), e);
                activityLogService.addActivity(loggedInUser, "failed to save chat", e.toString());
                return new ResponseEntity<>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            // Step 3: Save agent response
            String agentMessage;
            if (agentReply.get("answer").isTextual()) {
                agentMessage = agentReply.get("answer").asText();
            } else {
                agentMessage = agentReply.get("answer").toString();
            }

            AgentChats agentMsg = new AgentChats();
            agentMsg.setIagentId(iagentId);
            agentMsg.setBagentMsg(true);
            agentMsg.setVcMessage(agentMessage);
            agentMsg.setDtTimestamp(ZonedDateTime.now());
            agentMsg.setIuserId(userId);
            agentMsg.setIorgId(loggedInUser.getIorgId().getIorgid());
            agentMsg.setItenantId(tenantId);

            try {
                agentChatsService.saveAgentChat(agentMsg);
            } catch (Exception e) {
                LOGGER.error("Failed to save chat [userId={}, agentId={}]. Error: {}", userId, iagentId,
                        e.getMessage(), e);
                activityLogService.addActivity(loggedInUser, "failed to save chat", e.toString());
                return new ResponseEntity<>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            SendChatMessageResponse response = new SendChatMessageResponse(iagentId, agentReply);

            LOGGER.debug("Exiting sendChatMessage Method in "
                    + ChatsControllerServiceImpl.class
                    + " class with response  : sent chat message");
            activityLogService.addActivity(loggedInUser, "User sent a chat message to agent " +
                    iagentId);
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            LOGGER.error("Error in sendChatMessage: " + e);
            activityLogService.addActivity(loggedInUser, "Failed to send chat message",
                    loggerEncoderUtil.encode(sendChatMessageRequest.toString()));
            return new ResponseEntity<>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
