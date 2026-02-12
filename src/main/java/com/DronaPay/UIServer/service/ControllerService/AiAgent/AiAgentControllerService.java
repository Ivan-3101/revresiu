package com.DronaPay.UIServer.service.ControllerService.AiAgent;

import com.DronaPay.UIServer.requests.*;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

public interface AiAgentControllerService {

    public ResponseEntity<?> getListOfAiAgents(Authentication pr);

    public ResponseEntity<?> getAiAgentDetails(GetAiAgentRequest req, Authentication pr);

    public ResponseEntity<?> addAiAgent(AddAiAgentRequest addAiAgentRequest, Authentication pr);

    public ResponseEntity<?> editAiAgent(EditAiAgentRequest editAiAgentRequest, Authentication pr);

    public ResponseEntity<?> deleteAiAgent(DeleteAiAgentRequest deleteAiAgentRequest, Authentication pr);

    public ResponseEntity<?> approveAiAgent(ApproveAiAgentRequest approveAiAgentRequest, Authentication pr);

}