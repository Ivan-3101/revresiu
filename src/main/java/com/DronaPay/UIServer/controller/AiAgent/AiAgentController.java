package com.DronaPay.UIServer.controller.AiAgent;

import com.DronaPay.UIServer.requests.AddAiAgentRequest;
import com.DronaPay.UIServer.requests.ApproveAiAgentRequest;
import com.DronaPay.UIServer.requests.DeleteAiAgentRequest;
import com.DronaPay.UIServer.requests.EditAiAgentRequest;
import com.DronaPay.UIServer.requests.GetAiAgentRequest;
import com.DronaPay.UIServer.service.ControllerService.AiAgent.AiAgentControllerService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/testing/ai-ml/ai-agents")
public class AiAgentController {

    @Autowired
    private AiAgentControllerService aiAgentControllerService;

    @GetMapping("/get-aiagents-list")
    public ResponseEntity<?> getListOfAiAgents(Authentication pr) {
        return aiAgentControllerService.getListOfAiAgents(pr);
    }

    @PostMapping("/get-aiagent")
    public ResponseEntity<?> getAiAgentDetails(@RequestBody @Valid GetAiAgentRequest getAiAgentRequest, Authentication pr) {
        return aiAgentControllerService.getAiAgentDetails(getAiAgentRequest, pr);
    }

    @PostMapping("/add-aiagent")
    public ResponseEntity<?> addAiAgent(@Valid @RequestBody AddAiAgentRequest addAiAgentRequest, Authentication pr) {
        return aiAgentControllerService.addAiAgent(addAiAgentRequest, pr);
    }

    @PostMapping("/edit-aiagent")
    public ResponseEntity<?> editAiAgent(@RequestBody @Valid EditAiAgentRequest editAiAgentRequest, Authentication pr) {
        return aiAgentControllerService.editAiAgent(editAiAgentRequest, pr);
    }

    @PostMapping("/delete-aiagent")
    public ResponseEntity<?> deleteAiAgent(@RequestBody @Valid DeleteAiAgentRequest deleteAiAgentRequest, Authentication pr) {
        return aiAgentControllerService.deleteAiAgent(deleteAiAgentRequest, pr);
    }

    @PostMapping("/approve-aiagent")
    public ResponseEntity<?> approveAiAgent(@RequestBody @Valid ApproveAiAgentRequest approveAiAgentRequest, Authentication pr) {
        return aiAgentControllerService.approveAiAgent(approveAiAgentRequest, pr);
    }
}
