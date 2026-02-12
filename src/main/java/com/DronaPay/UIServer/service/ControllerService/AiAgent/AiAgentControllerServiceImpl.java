package com.DronaPay.UIServer.service.ControllerService.AiAgent;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.requests.*;
import com.DronaPay.UIServer.response.*;
import com.DronaPay.UIServer.service.ApiServices.AgentsApiService;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.fasterxml.jackson.databind.JsonNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
public class AiAgentControllerServiceImpl implements AiAgentControllerService {

    private static final Logger LOGGER = LoggerFactory.getLogger(AiAgentControllerServiceImpl.class);
    final String menu_name = MenuNames.AiAgents;

    @Autowired
    private ActivityLogService activityLogService;

    @Autowired
    private AiAgentService aiAgentService;

    @Autowired
    private TenantRepositoryService tenantRepositoryService;

    @Autowired
    private AiAgentAuditService aiAgentAuditService;

    @Autowired
    private AgentsApiService agentsApiService;

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Autowired
    private StatusCodeService statusCodeService;

    @Override
    public ResponseEntity<?> getListOfAiAgents(Authentication pr){
        LOGGER.debug("entered in class " + AiAgentControllerServiceImpl.class + " in method getListOfAiAgents");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp == null || !mp.isView()) {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access Agent list");
            LOGGER.debug("Exiting getListOfAiAgents Method in " + AiAgentControllerServiceImpl.class
                    + " class with response  : Unauthorized to access list of Agents");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Unauthorized to access list of Agents"),
                    HttpStatus.FORBIDDEN);
        }

        AiAgentListView aiAgentListView = new AiAgentListView();
        aiAgentListView.setAdd(mp.isAdd());
        aiAgentListView.setApprove(mp.isApprove());
        aiAgentListView.setDelete(mp.isDelete());
        aiAgentListView.setEdit(mp.isEdit());
        aiAgentListView.setView(mp.isView());

        List<AiAgent> aiagentsList = new ArrayList<>();
        List<AiAgentResponse> responses = new ArrayList<>();
        List<AiAgentAudit> aiagentAudits = new ArrayList<>();

        try {
            List<Integer> tenantids = loggedUser.getUserTenant();
            aiagentsList = aiAgentService.findAllNonDeletedTenants(tenantids);
            aiagentsList = aiagentsList.stream().filter(c -> c.getIrecordStatus() == 0)
                    .collect(Collectors.toList());
            aiagentAudits = aiAgentAuditService.findPendingEntriesTenant(tenantids);
            aiagentsList.stream()
                    .map(d -> responses.add(AiAgentResponse.builder()
                            .agentName(d.getVcAgentName())
                            .iagentId(d.getIagentId())
                            .description(d.getVcAgentDescription())
                            .initiation(d.getVcInitiation())
                            .createdDate(d.getDtEntryStamp())
                            .lastUpdate(d.getDtApproverStamp())
                            .latestRemark(d.getVcRemark())
                            .itenantId(d.getItenantId())
                            .tenantName(tenantRepositoryService.findByItenantId(d.getItenantId()).getTenantName())
                            .lastStatus(d.getLastStatus())
                            .auditEntry(false)
                            .auditExist(false)
                            .makerChecker("M")
                            .build()))
                    .collect(Collectors.toList());

            for (int i = 0; i < responses.size(); i++) {
                for (int k = 0; k < aiagentAudits.size(); k++) {
                    if (aiagentAudits.get(k).getIagentId() != null) {
                        if (responses.get(i).getIagentId().equals(aiagentAudits.get(k).getIagentId())) {
                            responses.get(i).setAuditExist(true);
                        }
                    }
                }
            }

            aiagentAudits.stream()
                    .map(d -> responses.add(AiAgentResponse.builder()
                            .agentName(d.getVcAgentName())
                            .iagentId(d.getIagentId() != null ? d.getIagentId() : -1)
                            .iagentAuditId(d.getIagentAuditId())
                            .description(d.getVcAgentDescription())
                            .initiation(d.getVcInitiation())
                            .createdDate(d.getDtEntryStamp())
                            .lastUpdate(d.getDtEntryStamp())
                            .latestRemark(d.getVcRemark())
                            .lastStatus("Pending")
                            .itenantId(d.getItenantId())
                            .tenantName(tenantRepositoryService.findByItenantId(d.getItenantId()).getTenantName())
                            .auditEntry(true)
                            .auditExist(false)
                            .makerChecker(!Objects.equals(d.getIEntryUserID(), loggedInUser.getIuserID()) ? "C" : "M")
                            .action(d.getVcAction())
                            .build()))
                    .collect(Collectors.toList());

            aiAgentListView.setAiagentList(responses);

            LOGGER.debug("Exiting getListOfAiAgents Method in "
                    + AiAgentControllerServiceImpl.class
                    + " class with response  : with parameters type dropdown");
            activityLogService.addActivity(loggedInUser, "Agent List accessed");
            return ResponseEntity.ok(aiAgentListView);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to get Agent details", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    public ResponseEntity<?> getAiAgentDetails(GetAiAgentRequest getAiAgentRequest, Authentication pr) {
        LOGGER.debug("Entered getAiAgentDetails in class " + AiAgentControllerServiceImpl.class);

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();
        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp == null || !mp.isView()) {
            activityLogService.addActivity(loggedInUser, "Unauthorized to view Agent");
            LOGGER.debug("Exiting getAiAgentDetails Method in " + AiAgentControllerServiceImpl.class
                    + " class with response  : unauthorized to view Agent");
            return new ResponseEntity<>(new ApiResponse(false, "Unauthorized to view Agent"), HttpStatus.FORBIDDEN);
        }

        try {
            if (!getAiAgentRequest.getAudit()) {
                AiAgent aiAgent = null;

                try {
                    aiAgent = aiAgentService.findByAgentIdAndTenant(getAiAgentRequest.getIagentId(),
                            getAiAgentRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Error while fetching agent: " + e);
                    activityLogService.addActivity(loggedInUser, "failed to get agent",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }


                if (aiAgent != null) {
                    AiAgentDetailResponse aiAgentDetailResponse = new AiAgentDetailResponse();
                    aiAgentDetailResponse.setAgentId(aiAgent.getIagentId());
                    aiAgentDetailResponse.setAgentName(aiAgent.getVcAgentName());
                    aiAgentDetailResponse.setDescription(aiAgent.getVcAgentDescription());
                    aiAgentDetailResponse.setInitiation(aiAgent.getVcInitiation());
                    aiAgentDetailResponse.setPolicy(aiAgent.getVcPolicy());
                    aiAgentDetailResponse.setPrompt(aiAgent.getVcPrompt());
                    aiAgentDetailResponse.setConfig(aiAgent.getVcConfig());
                    aiAgentDetailResponse.setVcRemark(aiAgent.getVcRemark());
                    aiAgentDetailResponse.setMakerChecker("M");
                    aiAgentDetailResponse.setItenantId(aiAgent.getItenantId());
                    aiAgentDetailResponse.setTenantName(tenantRepositoryService.findByItenantId(aiAgent.getItenantId()).getTenantName());

                    LOGGER.debug("Exiting getAiAgentDetails Method in "
                            + AiAgentControllerServiceImpl.class
                            + " class with response  : with parameters type get Agent details");
                    activityLogService.addActivity(loggedInUser,
                            "Agent details accessed successfully");
                    return ResponseEntity.ok(aiAgentDetailResponse);
                }else{
                    activityLogService.addActivity(loggedInUser, "No Agent found");
                    return new ResponseEntity<>(new ApiResponse(false, "No Agent found"), HttpStatus.BAD_REQUEST);
                }
            } else {
                AiAgentAudit audit = null;

                try {
                    audit = aiAgentAuditService.findPendingAiAgentAuditByAuditIDAndTenant(getAiAgentRequest.getIagentId(),
                            getAiAgentRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Error while fetching agent audit : " + e);
                    activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (audit != null) {
                    AiAgentDetailResponse aiAgentDetailResponse = new AiAgentDetailResponse();
                    aiAgentDetailResponse.setAgentId(audit.getIagentAuditId());
                    aiAgentDetailResponse.setAgentName(audit.getVcAgentName());
                    aiAgentDetailResponse.setDescription(audit.getVcAgentDescription());
                    aiAgentDetailResponse.setInitiation(audit.getVcInitiation());
                    aiAgentDetailResponse.setPolicy(audit.getVcPolicy());
                    aiAgentDetailResponse.setPrompt(audit.getVcPrompt());
                    aiAgentDetailResponse.setConfig(audit.getVcConfig());
                    aiAgentDetailResponse.setVcRemark(audit.getVcRemark());
                    aiAgentDetailResponse.setMakerChecker(!Objects.equals(audit.getIEntryUserID(), loggedInUser.getIuserID())
                            ? "C" : "M");
                    aiAgentDetailResponse.setItenantId(audit.getItenantId());
                    aiAgentDetailResponse.setTenantName(tenantRepositoryService.findByItenantId(audit.getItenantId()).getTenantName());

                    LOGGER.debug("Exiting getAiAgentDetails Method in "
                            + AiAgentControllerServiceImpl.class
                            + " class with response  : with parameters type get Agent details");
                    activityLogService.addActivity(loggedInUser,
                            "Agent details accessed successfully");
                    return ResponseEntity.ok(aiAgentDetailResponse);
                }
                else{
                    LOGGER.debug("Exiting getAiAgentDetails Method in "
                            + AiAgentControllerServiceImpl.class
                            + " class with response  : with parameters type get Agent details");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to access Agent details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "No pending Agent entries found"),
                            HttpStatus.BAD_REQUEST);
                }
            }
        } catch (Exception e) {
            LOGGER.error("Error in getAiAgentDetails: " + e + "\nParams: " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "Failed to get Agent details", e.toString());
            return new ResponseEntity<>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }
    }

    @Override
    public ResponseEntity<?> addAiAgent(AddAiAgentRequest addAiAgentRequest, Authentication pr){
        LOGGER.debug("entered in class " + AiAgentControllerServiceImpl.class + " in method addAiAgent");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();
        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp == null || !mp.isAdd()) {
            activityLogService.addActivity(loggedInUser, "Unauthorized to add Agent");
            LOGGER.debug("Exiting addAiAgent Method in " + AiAgentControllerServiceImpl.class
                    + " class with response  : unauthorized to add Agent");
            return new ResponseEntity<>(new ApiResponse(false, "Unauthorized to add Agent"), HttpStatus.FORBIDDEN);
        }

        if (addAiAgentRequest.getConfig() == null || addAiAgentRequest.getConfig().isEmpty()){
            LOGGER.debug("Exiting addAiAgent Method in "
                    + AiAgentControllerServiceImpl.class
                    + " class with response  : with parameter add Agent");
            activityLogService.addActivity(loggedInUser, "Failed to add Agent");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false,
                            "Agent Config cannot be blank"),
                    HttpStatus.BAD_REQUEST);
        }

        AiAgent existName = null;

        try {
            existName = aiAgentService.findByAgentName(addAiAgentRequest.getAgentName(), addAiAgentRequest.getItenantId());
        } catch (Exception e) {
            LOGGER.error("Exiting  addAiAgent Method in "
                    + AiAgentControllerServiceImpl.class
                    + " class with response  : failed to fetch agent with agent name");
            activityLogService.addActivity(loggedInUser, "failed to save new agent",
                    addAiAgentRequest.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        if (existName != null) {
            LOGGER.debug("Exiting  addAiAgent Method in "
                    + AiAgentControllerServiceImpl.class
                    + " class with response  : with parameter add agent request");
            activityLogService.addActivity(loggedInUser, "failed to save new agent",
                    addAiAgentRequest.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false,
                            "Agent name already exists"),
                    HttpStatus.CONFLICT);
        }

        AiAgentAudit existAuditName = null;

        try {
            existAuditName = aiAgentAuditService
                    .findByAgentName(addAiAgentRequest.getAgentName(), addAiAgentRequest.getItenantId());
        } catch (Exception e) {
            LOGGER.error("Exiting  addAiAgent Method in "
                    + AiAgentControllerServiceImpl.class
                    + " class with response  : failed to fetch agent audit with agent name");
            activityLogService.addActivity(loggedInUser, "failed to save new agent",
                    addAiAgentRequest.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        if (existAuditName != null) {
            LOGGER.debug("Exiting  addAiAgent Method in "
                    + AiAgentControllerServiceImpl.class
                    + " class with response  : with parameter add agent request");
            activityLogService.addActivity(loggedInUser, "failed to save new agent",
                    addAiAgentRequest.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false,
                            "Agent name already exists in audit"),
                    HttpStatus.CONFLICT);
        }

        try {
            JsonNode vcConfig = addAiAgentRequest.getConfig();
            if (vcConfig == null || !vcConfig.has("agent")) {
                LOGGER.info("Missing 'agent' in vcConfig");
                activityLogService.addActivity(loggedInUser, "Missing 'agent' in vcConfig");
                return new ResponseEntity<>(new ApiResponse(false, "Missing 'agent' in vcConfig"), HttpStatus.BAD_REQUEST);
            }
            if (!vcConfig.has("input_data") || !vcConfig.get("input_data").isArray()) {
                LOGGER.info("Missing or invalid 'input_data' in vcConfig for agent");
                activityLogService.addActivity(loggedInUser, "Missing or invalid 'input_data' in vcConfig");
                return new ResponseEntity<>(new ApiResponse(false, "Invalid agent configuration"), HttpStatus.BAD_REQUEST);
            }
        } catch (Exception e) {
            LOGGER.error("Failed to extract agentId from vcConfig: " + e.getMessage());
            activityLogService.addActivity(loggedInUser, "Invalid vcConfig JSON", e.toString());
            return new ResponseEntity<>(new ApiResponse(false, "Invalid agent config"), HttpStatus.BAD_REQUEST);
        }

        AiAgentAudit audit = new AiAgentAudit();
        audit.setVcAgentName(addAiAgentRequest.getAgentName());
        audit.setVcAgentDescription(addAiAgentRequest.getAgentDescription());
        audit.setVcInitiation(addAiAgentRequest.getInitiation());
        audit.setVcPolicy(addAiAgentRequest.getPolicy());
        audit.setVcPrompt(addAiAgentRequest.getPrompt());
        audit.setVcConfig(addAiAgentRequest.getConfig());
        audit.setIVersion(0);
        audit.setItenantId(addAiAgentRequest.getItenantId());
        audit.setVcAction("A");
        audit.setBclosed(false);
        audit.setIrecordStatus(0);
        audit.setVcRemark(addAiAgentRequest.getMakerRemark());
        audit.setIEntryUserID(loggedInUser.getIuserID());
        audit.setIorgId(loggedInUser.getIorgId());
        audit.setDtEntryStamp(ZonedDateTime.now());

        try {
            audit = aiAgentAuditService.saveAiAgentAudit(audit);
        } catch (Exception e) {
            LOGGER.error("Error while saving agent audit : " + e + "\nParam : " +
                    loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to save Agent audit entry", e.toString());
            return new ResponseEntity<>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        activityLogService.addActivity(loggedInUser, "Agent addition sent for approval");
        return new ResponseEntity<>(new ApiResponse(true, "Agent addition sent for approval"), HttpStatus.ACCEPTED);
    }

    @Override
    public ResponseEntity<?> editAiAgent(EditAiAgentRequest editAiAgentRequest, Authentication pr){
        LOGGER.debug("entered in class " + AiAgentControllerServiceImpl.class + " in method editAiAgent");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();
        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp == null || !mp.isEdit()) {
            activityLogService.addActivity(loggedInUser, "Unauthorized to edit Agent");
            LOGGER.debug("Exiting addAiAgent Method in " + AiAgentControllerServiceImpl.class
                    + " class with response  : unauthorized to edit Agent");
            return new ResponseEntity<>(new ApiResponse(false, "Unauthorized to edit Agent"), HttpStatus.FORBIDDEN);
        }

        if (editAiAgentRequest.getAudit()) {
            AiAgentAudit audit = null;
            try {
                audit = aiAgentAuditService.findPendingAiAgentAuditByAuditIDAndTenant(
                        editAiAgentRequest.getIagentId(), editAiAgentRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Error while fetching agent audit with agent ID : " + editAiAgentRequest.getIagentId()
                        + "\nError : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get pending Agent entry",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (audit != null) {
                AiAgent existName = null;

                try {
                    existName = aiAgentService.findByAgentName(editAiAgentRequest.getAgentName(), editAiAgentRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Exiting  editAiAgent Method in "
                            + AiAgentControllerServiceImpl.class
                            + " class with response  : failed to find agent with agent name");
                    activityLogService.addActivity(loggedInUser, "failed to edit agent",
                            editAiAgentRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (existName != null && !Objects.equals(audit.getIagentId(), existName.getIagentId())) {
                    LOGGER.debug("Exiting  editAiAgent Method in "
                            + AiAgentControllerServiceImpl.class
                            + " class with response  : with parameter edit agent request");
                    activityLogService.addActivity(loggedInUser, "failed to edit agent",
                            editAiAgentRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Agent name already exists"),
                            HttpStatus.CONFLICT);
                }

                AiAgentAudit existAuditName = null;

                try {
                    existAuditName = aiAgentAuditService
                            .findByAgentName(editAiAgentRequest.getAgentName(), editAiAgentRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Exiting  editAiAgent Method in "
                            + AiAgentControllerServiceImpl.class
                            + " class with response  : failed to find agent audit with agent name");
                    activityLogService.addActivity(loggedInUser, "failed to edit agent",
                            editAiAgentRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (existAuditName != null && !Objects.equals(audit.getIagentAuditId(), existAuditName.getIagentAuditId())) {
                    LOGGER.debug("Exiting  editAiAgent Method in "
                            + AiAgentControllerServiceImpl.class
                            + " class with response  : with parameter edit agent request");
                    activityLogService.addActivity(loggedInUser, "failed to edit agent",
                            editAiAgentRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Agent name already exists in audit"),
                            HttpStatus.CONFLICT);
                }

                if (!Objects.equals(audit.getIEntryUserID(), loggedInUser.getIuserID())) {
                    LOGGER.debug("Exiting editAiAgent Method in "
                            + AiAgentControllerServiceImpl.class
                            + " class with response  : Only Maker can edit this entry");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to edit Agent");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Only Maker can edit this entry"),
                            HttpStatus.BAD_REQUEST);
                }

                if(!Objects.equals(audit.getItenantId(), editAiAgentRequest.getItenantId())){
                    LOGGER.debug("Exiting editAiAgent Method in "
                            + AiAgentControllerServiceImpl.class
                            + " class with response  : Tenant cannot be modified");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to edit Agent");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Tenant cannot be modified"),
                            HttpStatus.BAD_REQUEST);
                }

                if(!Objects.equals(audit.getVcPolicy(), editAiAgentRequest.getPolicy())){
                    LOGGER.debug("Exiting editAiAgent Method in "
                            + AiAgentControllerServiceImpl.class
                            + " class with response  : Policy cannot be modified");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to edit Agent");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Policy cannot be modified"),
                            HttpStatus.BAD_REQUEST);
                }

                if(!Objects.equals(audit.getVcPrompt(), editAiAgentRequest.getPrompt())){
                    LOGGER.debug("Exiting editAiAgent Method in "
                            + AiAgentControllerServiceImpl.class
                            + " class with response  : Prompt cannot be modified");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to edit Agent");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Prompt cannot be modified"),
                            HttpStatus.BAD_REQUEST);
                }

                if (editAiAgentRequest.getConfig() == null || editAiAgentRequest.getConfig().isEmpty()){
                    LOGGER.debug("Exiting editAiAgent Method in "
                            + AiAgentControllerServiceImpl.class
                            + " class with response  : Agent Config cannot be blank");
                    activityLogService.addActivity(loggedInUser, "Failed to edit Agent");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Agent Config cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }

                if(!Objects.equals(audit.getVcConfig(), editAiAgentRequest.getConfig())){
                    LOGGER.debug("Exiting editAiAgent Method in "
                            + AiAgentControllerServiceImpl.class
                            + " class with response  : Agent config cannot be modified");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to edit Agent");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Agent config cannot be modified"),
                            HttpStatus.BAD_REQUEST);
                }

                audit.setVcAgentName(editAiAgentRequest.getAgentName());
                audit.setVcAgentDescription(editAiAgentRequest.getAgentDescription());
                audit.setVcInitiation(editAiAgentRequest.getInitiation());
                audit.setVcRemark(editAiAgentRequest.getMakerRemark());
                try {
                    aiAgentAuditService.saveAiAgentAudit(audit);
                } catch (Exception e){
                    LOGGER.error("Error while saving agent audit: " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to edit Agent audit entry", e.toString());
                    return new ResponseEntity<>(new ApiResponse(false, ResponseMessages.GenericErrorMessage), HttpStatus.INTERNAL_SERVER_ERROR);
                }
                LOGGER.debug("Exiting editAiAgent Method in "
                        + AiAgentControllerServiceImpl.class
                        + " class with response  : Agent edition sent for approval");
                activityLogService.addActivity(loggedInUser,
                        "Agent edition sent for approval");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(true, "Agent edition sent for approval"),
                        HttpStatus.OK);
            } else {

                LOGGER.debug("Exiting editAiAgent Method in "
                        + AiAgentControllerServiceImpl.class
                        + " class with response  : with parameters type edit Agent details");
                activityLogService.addActivity(loggedInUser,
                        "Failed to access Agent details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "No pending entries found"),
                        HttpStatus.BAD_REQUEST);
            }
        } else{

            AiAgentAudit exist = null;
            try {
                exist = aiAgentAuditService.findPendingAiAgentAuditByAgentIDAndTenant(
                        editAiAgentRequest.getIagentId(), editAiAgentRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Error while fetching agent audit by Agent Id : " + editAiAgentRequest.getIagentId()
                        + "\nError : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed pending Agent entries",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (exist != null) {
                LOGGER.debug("Exiting editAiAgent Method in "
                        + AiAgentControllerServiceImpl.class
                        + " class with response  : with parameters type edit Agent details");
                activityLogService.addActivity(loggedInUser,
                        "Failed to access Agent details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Entry is already pending for action"),
                        HttpStatus.BAD_REQUEST);
            }


            AiAgent aiAgent = null;
            try {
                aiAgent = aiAgentService.findByAgentIdAndTenant(
                        editAiAgentRequest.getIagentId(), editAiAgentRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Error while fetching Agent with Agent Id: " + editAiAgentRequest.getIagentId()
                        + "\nError : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (aiAgent == null) {
                LOGGER.debug("Exiting editAiAgent Method in "
                        + AiAgentControllerServiceImpl.class
                        + " class with response  : with parameters type edit Agent details");
                activityLogService.addActivity(loggedInUser,
                        "Failed to access Agent details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Unable to find Agent"),
                        HttpStatus.BAD_REQUEST);
            }

            AiAgent existName = null;

            try {
                existName = aiAgentService.findByAgentName(editAiAgentRequest.getAgentName(), editAiAgentRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Exiting  editAiAgent Method in "
                        + AiAgentControllerServiceImpl.class
                        + " class with response  : failed to find agent with agent name");
                activityLogService.addActivity(loggedInUser, "failed to edit agent",
                        editAiAgentRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (existName != null && !Objects.equals(aiAgent.getIagentId(), existName.getIagentId())) {
                LOGGER.debug("Exiting  editAiAgent Method in "
                        + AiAgentControllerServiceImpl.class
                        + " class with response  : with parameter edit agent request");
                activityLogService.addActivity(loggedInUser, "failed to edit agent",
                        editAiAgentRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Agent name already exists"),
                        HttpStatus.CONFLICT);
            }

            AiAgentAudit existAuditName = null;

            try {
                existAuditName = aiAgentAuditService
                        .findByAgentName(editAiAgentRequest.getAgentName(), editAiAgentRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Exiting  editAiAgent Method in "
                        + AiAgentControllerServiceImpl.class
                        + " class with response  : failed to find agent audit with agent name");
                activityLogService.addActivity(loggedInUser, "failed to edit agent",
                        editAiAgentRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (existAuditName != null) {
                LOGGER.debug("Exiting  editAiAgent Method in "
                        + AiAgentControllerServiceImpl.class
                        + " class with response  : with parameter edit agent request");
                activityLogService.addActivity(loggedInUser, "failed to edit agent",
                        editAiAgentRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Agent name already exists in audit"),
                        HttpStatus.CONFLICT);
            }

            if(!Objects.equals(aiAgent.getItenantId(), editAiAgentRequest.getItenantId())){
                LOGGER.debug("Exiting editAiAgent Method in "
                        + AiAgentControllerServiceImpl.class
                        + " class with response  : Tenant cannot be modified");
                activityLogService.addActivity(loggedInUser,
                        "Tenant cannot be modified");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Tenant cannot be modified"),
                        HttpStatus.BAD_REQUEST);
            }

            if(!Objects.equals(aiAgent.getVcPolicy(), editAiAgentRequest.getPolicy())){
                LOGGER.debug("Exiting editAiAgent Method in "
                        + AiAgentControllerServiceImpl.class
                        + " class with response  : Policy cannot be modified");
                activityLogService.addActivity(loggedInUser,
                        "Policy cannot be modified");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Policy cannot be modified"),
                        HttpStatus.BAD_REQUEST);
            }

            if(!Objects.equals(aiAgent.getVcPrompt(), editAiAgentRequest.getPrompt())){
                LOGGER.debug("Exiting editAiAgent Method in "
                        + AiAgentControllerServiceImpl.class
                        + " class with response  : Prompt cannot be modified");
                activityLogService.addActivity(loggedInUser,
                        "Prompt cannot be modified");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Prompt cannot be modified"),
                        HttpStatus.BAD_REQUEST);
            }

            if(!Objects.equals(aiAgent.getVcConfig(), editAiAgentRequest.getConfig())){
                LOGGER.debug("Exiting editAiAgent Method in "
                        + AiAgentControllerServiceImpl.class
                        + " class with response  : Agent config cannot be modified");
                activityLogService.addActivity(loggedInUser,
                        "Agent config cannot be modified");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Agent config cannot be modified"),
                        HttpStatus.BAD_REQUEST);
            }

            AiAgentAudit audit = new AiAgentAudit();
            audit.setIagentId(editAiAgentRequest.getIagentId());
            audit.setVcAgentName(editAiAgentRequest.getAgentName());
            audit.setVcAgentDescription(editAiAgentRequest.getAgentDescription());
            audit.setVcInitiation(editAiAgentRequest.getInitiation());
            audit.setVcPolicy(aiAgent.getVcPolicy());
            audit.setVcPrompt(aiAgent.getVcPrompt());
            audit.setVcConfig(aiAgent.getVcConfig());
            audit.setIVersion(aiAgent.getIVersion() + 1);
            audit.setVcRemark(editAiAgentRequest.getMakerRemark());
            audit.setIrecordStatus(aiAgent.getIrecordStatus());
            audit.setItenantId(aiAgent.getItenantId());
            audit.setVcAction("M");
            audit.setBclosed(false);
            audit.setIEntryUserID(loggedInUser.getIuserID());
            audit.setIorgId(loggedInUser.getIorgId());
            audit.setDtEntryStamp(ZonedDateTime.now());

            try {
                audit = aiAgentAuditService.saveAiAgentAudit(audit);
            } catch (Exception e) {
                LOGGER.error("Error while saving agent audit: " + e + "\nParam : " +
                        loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to save Agent audit entry", e.toString());
                return new ResponseEntity<>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            LOGGER.debug("Exiting editAiAgent Method in "
                    + AiAgentControllerServiceImpl.class
                    + " class with response  : with parameters edit Agent");
            activityLogService.addActivity(loggedInUser, "Agent edition sent for approval");
            return new ResponseEntity<>(new ApiResponse(true, "Agent edition sent for approval"), HttpStatus.OK);

        }
    }

    @Override
    public ResponseEntity<?> deleteAiAgent(DeleteAiAgentRequest deleteAiAgentRequest, Authentication pr){
        LOGGER.debug("entering  class " + AiAgentControllerServiceImpl.class + " and method deleteAiAgent");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp == null || !mp.isDelete()) {
            activityLogService.addActivity(loggedInUser, "Unauthorized to delete Agent");
            LOGGER.debug("Exiting deleteAiAgent Method in " + AiAgentControllerServiceImpl.class
                    + " class with response  : unauthorized to delete Agent");
            return new ResponseEntity<>(new ApiResponse(false, "Unauthorized to delete Agent"), HttpStatus.FORBIDDEN);
        }

        AiAgentAudit exist = null;
        try {
            exist = aiAgentAuditService
                    .findPendingAiAgentAuditByAgentIDAndTenant(deleteAiAgentRequest.getIagentId(), deleteAiAgentRequest.getItenantId());
        } catch (Exception e) {
            LOGGER.error("Error while fetching agent audit with Agent Id: " + deleteAiAgentRequest.getIagentId()
                    + "\nError: " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        if (exist != null) {
            LOGGER.debug("Exiting deleteAiAgent Method in "
                    + AiAgentControllerServiceImpl.class
                    + " class with response  : Entry is already pending for action");
            activityLogService.addActivity(loggedInUser, "Entry is already pending for action");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Entry is already pending for action"),
                    HttpStatus.BAD_REQUEST);
        }

        AiAgent aiAgent = null;

        try {
            aiAgent = aiAgentService.findByAgentIdAndTenant(deleteAiAgentRequest.getIagentId(), deleteAiAgentRequest.getItenantId());
        } catch (Exception e) {
            LOGGER.error("Error while fetching Agent with Agent Id: " + deleteAiAgentRequest.getIagentId()
                    + "\nError: " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        AiAgentAudit newAudit = new AiAgentAudit();
        if (aiAgent != null) {
            newAudit = newAudit.parseToAudit(aiAgent);
            newAudit.setDtEntryStamp(ZonedDateTime.now());
            newAudit.setIEntryUserID(loggedInUser.getIuserID());
            newAudit.setIorgId(loggedInUser.getIorgId());
            newAudit.setVcAction("X");
            newAudit.setIrecordStatus(1);
            newAudit.setIstatus(null);
            newAudit.setVcRemark(deleteAiAgentRequest.getMakerRemark());
            try {
                newAudit = aiAgentAuditService.saveAiAgentAudit(newAudit);
            } catch (Exception e) {
                LOGGER.error("Error whilte saving agent audit: " + e + "\nParam : " +
                        loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to save Agent audit entry", e.toString());
                return new ResponseEntity<>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            LOGGER.debug("Exiting deleteAiAgent Method in " + AiAgentControllerServiceImpl.class
                    + " class with response  : with parameters delete Agent");
            activityLogService.addActivity(loggedInUser, "Agent deletion sent for approval");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(true, "Agent deletion sent for approval"),
                    HttpStatus.OK);
        } else {
            LOGGER.debug("Exiting deleteAiAgent Method in "
                    + AiAgentControllerServiceImpl.class
                    + " class with response  : No entry found for agent id : " + deleteAiAgentRequest.getIagentId());
            activityLogService.addActivity(loggedInUser, "Failed to delete Agent ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Agent not found"),
                    HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public ResponseEntity<?> approveAiAgent(ApproveAiAgentRequest approveAiAgentRequest, Authentication pr){
        LOGGER.debug("entering  class " + AiAgentControllerServiceImpl.class + " and method approveAiAgent");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();
        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (!mp.isApprove()){
            activityLogService.addActivity(loggedInUser, "Unauthorized to approve Agent");
            LOGGER.debug("Exiting approveAiAgent Method in " + AiAgentControllerServiceImpl.class
                    + " class with response : Unauthorized to approve Agent");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Unauthorized to approve Agent"),
                    HttpStatus.FORBIDDEN);
        }

        if (approveAiAgentRequest.getApprove()) {
            AiAgentAudit audit = null;
            try {
                audit = aiAgentAuditService.findPendingAiAgentAuditByAuditIDAndTenant(
                        approveAiAgentRequest.getIagentAuditId(), approveAiAgentRequest.getTenantId());
            } catch (Exception e) {
                LOGGER.error("Error while fetching Agent audit with Agent audit Id: " + approveAiAgentRequest.getIagentAuditId()
                        + "\nError: " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (audit != null) {
                if (Objects.equals(audit.getIEntryUserID(), loggedInUser.getIuserID())) {
                    LOGGER.debug("Exiting approveAiAgent Method in "
                            + AiAgentControllerServiceImpl.class
                            + " class with response  : with parameters type approve Agent");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to approve Agent");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Maker cannot be checker"),
                            HttpStatus.BAD_REQUEST);
                }

                String agentId = null;
                try {
                    JsonNode vcConfig = audit.getVcConfig();
                    if (vcConfig != null && vcConfig.has("agent")) {
                        agentId = vcConfig.get("agent").asText();
                    } else {
                        LOGGER.info("Missing 'agent' in vcConfig");
                        activityLogService.addActivity(loggedInUser, "Missing 'agent' in vcConfig");
                        return new ResponseEntity<>(new ApiResponse(false, "Missing 'agent' in vcConfig"), HttpStatus.BAD_REQUEST);
                    }
                } catch (Exception e) {
                    LOGGER.error("Failed to extract agentId from vcConfig: " + e.getMessage());
                    activityLogService.addActivity(loggedInUser, "Invalid vcConfig JSON in audit", e.toString());
                    return new ResponseEntity<>(new ApiResponse(false, "Invalid agent config in audit"), HttpStatus.BAD_REQUEST);
                }

                ResponseEntity<String> configResponse;
                try {
                    configResponse = agentsApiService.reloadConfig(agentId);
                } catch (Exception e) {
                    LOGGER.error("Failed to reload agent config: " + e.getMessage());
                    activityLogService.addActivity(loggedInUser, "Failed to reload agent config", e.toString());
                    return new ResponseEntity<>(new ApiResponse(false, "Failed to reload agent config"), HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (!configResponse.getStatusCode().is2xxSuccessful()) {
                    LOGGER.error("Reload config failed with response: " + configResponse.getBody());
                    activityLogService.addActivity(loggedInUser, "Reload config failed", configResponse.getBody());
                    return new ResponseEntity<>(new ApiResponse(false, "Reload config failed"), HttpStatus.INTERNAL_SERVER_ERROR);
                }

                audit.setBclosed(true);
                audit.setVcRemark("{ " + audit.getVcRemark() + " }" + "{ "
                        + approveAiAgentRequest.getCheckerRemark() + " }");
                switch (audit.getVcAction()) {
                    case "A" -> audit.setIstatus(statusCodeService.findByIStatusId(2));
                    case "M" -> audit.setIstatus(statusCodeService.findByIStatusId(3));
                    case "X" -> audit.setIstatus(statusCodeService.findByIStatusId(4));
                }
                audit.setDtApproverStamp(ZonedDateTime.now());
                audit.setIApproverUserID(loggedInUser.getIuserID());
                audit.setIorgId(loggedInUser.getIorgId());
                try{
                    audit = aiAgentAuditService.saveAiAgentAudit(audit);
                }catch (Exception e) {
                    LOGGER.error("Error while saving agent audit: " + e + "\nParam : " +
                            loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser,
                            "failed to save approve Agent audit entry", e.toString());
                    return new ResponseEntity<>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                AiAgent approvedAudit = null;

                try {
                    approvedAudit = audit.parseAudit(audit);

                    approvedAudit.setLastStatus("Approved");
                    approvedAudit.setVcRemark(approveAiAgentRequest.getCheckerRemark());
                    approvedAudit.setDtApproverStamp(ZonedDateTime.now());
                    approvedAudit = aiAgentService.saveAiAgent(approvedAudit);
                } catch (Exception e) {
                    LOGGER.error("Error while saving agent: " + e + "\nParam : "
                            + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed save Agent",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                String msg = "";
                if (audit.getVcAction().equalsIgnoreCase("A")) {
                    msg = "Agent addition approved successfully";
                } else if (audit.getVcAction().equalsIgnoreCase("M")) {
                    msg = "Agent edition approved successfully";
                } else if (audit.getVcAction().equalsIgnoreCase("X")) {
                    msg = "Agent deletion approved successfully";
                }
                LOGGER.debug("Exiting approveAiAgent Method in "
                        + AiAgentControllerServiceImpl.class
                        + " class with response  : with parameters approve Agent");
                activityLogService.addActivity(loggedInUser, msg);
                return new ResponseEntity<ApiResponse>(new ApiResponse(true, msg),
                        HttpStatus.OK);

            } else {
                LOGGER.debug("Exiting approveAiAgent Method in "
                        + AiAgentControllerServiceImpl.class
                        + " class with response  : with parameters type approve Agent");
                activityLogService.addActivity(loggedInUser,
                        "Failed to approve Agent");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "No pending entries found"),
                        HttpStatus.BAD_REQUEST);
            }
        } else {
            AiAgentAudit audit = null;
            try {
                audit = aiAgentAuditService.findPendingAiAgentAuditByAuditIDAndTenant(
                        approveAiAgentRequest.getIagentAuditId(), approveAiAgentRequest.getTenantId());
            } catch (Exception e) {
                LOGGER.error("Error while fetching Agent audit with Agent Audit Id: " +
                        approveAiAgentRequest.getIagentAuditId() + "\nError: " + e + "\nParam : " +
                        loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (audit != null) {
                if (Objects.equals(audit.getIEntryUserID(), loggedInUser.getIuserID())) {
                    LOGGER.debug("Exiting approveAiAgent Method in "
                            + AiAgentControllerServiceImpl.class
                            + " class with response  : with parameters type approve Agent");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to approve Agent");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Maker cannot be checker"),
                            HttpStatus.BAD_REQUEST);
                }

                audit.setBclosed(true);
                audit.setVcRemark("{ " + audit.getVcRemark() + " }" + "{ "
                        + approveAiAgentRequest.getCheckerRemark() + " }");
                audit.setIstatus(statusCodeService.findByIStatusId(5));
                audit.setDtApproverStamp(ZonedDateTime.now());
                audit.setIApproverUserID(loggedInUser.getIuserID());
                audit.setIorgId(loggedInUser.getIorgId());
                try{
                    audit = aiAgentAuditService.saveAiAgentAudit(audit);
                }catch (Exception e) {
                    LOGGER.error("Error while saving agent audit: " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to save approve Agent audit entry", e.toString());
                    return new ResponseEntity<>(new ApiResponse(false, ResponseMessages.GenericErrorMessage), HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (audit.getIagentId() != null) {
                    AiAgent aiAgent = null;
                    try {
                        aiAgent = aiAgentService.findByAgentIdAndTenant(audit.getIagentId(), audit.getItenantId());
                    } catch (Exception e) {
                        LOGGER.error("Error while fetching Agent with Agent Id: " + audit.getIagentId()
                                + "\nError: " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                    aiAgent.setLastStatus("Rejected");
                    aiAgent.setVcRemark(approveAiAgentRequest.getCheckerRemark());
                    aiAgent.setDtApproverStamp(ZonedDateTime.now());
                    aiAgent.setIApproverUserID(loggedInUser.getIuserID());
                    aiAgent.setIorgId(loggedInUser.getIorgId());
                    try {
                        aiAgentService.saveAiAgent(aiAgent);
                    } catch (Exception e) {
                        LOGGER.error("Error white saving agent: " + e + "\nParam : "
                                + loggerEncoderUtil.encode(pr.toString()));
                        activityLogService.addActivity(loggedInUser,
                                "failed to get user and permissions",
                                e.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                }

                String msg = "";
                if (audit.getVcAction().equalsIgnoreCase("A")) {
                    msg = "Agent addition rejected successfully";
                } else if (audit.getVcAction().equalsIgnoreCase("M")) {
                    msg = "Agent edition rejected successfully";
                } else if (audit.getVcAction().equalsIgnoreCase("X")) {
                    msg = "Agent deletion rejected successfully";
                }

                LOGGER.debug("Exiting approveAiAgent Method in "
                        + AiAgentControllerServiceImpl.class
                        + " class with response  : with parameters approve Agent");
                activityLogService.addActivity(loggedInUser, msg);
                return new ResponseEntity<ApiResponse>(new ApiResponse(true, msg),
                        HttpStatus.OK);

            } else {
                LOGGER.debug("Exiting approveAiAgent Method in "
                        + AiAgentControllerServiceImpl.class
                        + " class with response  : with parameters type approve Agent");
                activityLogService.addActivity(loggedInUser,
                        "Failed to approve Agent");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "No pending entries found"),
                        HttpStatus.BAD_REQUEST);
            }
        }
    }

}