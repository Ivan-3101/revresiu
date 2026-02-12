package com.DronaPay.UIServer.service.ApiServices;

import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.http.ResponseEntity;

public interface AgentsApiService {

    public ResponseEntity<String> getAgentResponse(Integer itenantid, Integer iuserid, String userMessage, String agentid, JsonNode agentConfig) throws Exception;

    public ResponseEntity<String> reloadConfig(String agentId) throws Exception;
}
