package com.DronaPay.UIServer.service.ControllerService.TryOut;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.ResponseVO.DropdownWithObject;
import com.DronaPay.UIServer.ResponseVO.RuleAvailableVO;
import com.DronaPay.UIServer.ResponseVO.RuleBuilderVO;
import com.DronaPay.UIServer.VOMapper.RuleAvailableDTOMapper;
import com.DronaPay.UIServer.VOMapper.RuleDraftDTOMapper;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.requests.AddRulesAvailableRequest;
import com.DronaPay.UIServer.requests.TestRule;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.response.MetadataResponse;
import com.DronaPay.UIServer.response.RuleBlocksReponse;
import com.DronaPay.UIServer.service.ApiServices.SimulationApiService;
import com.DronaPay.UIServer.service.ControllerService.RuleConfigurator.RuleConfiguratorServiceImpl;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
public class RuleBuilderControllerServiceImpl implements RuleBuilderControllerService {

    final String menu_name = MenuNames.ruleBuilder;
    @Autowired
    private WebUserService webUserService;
    @Autowired
    private ActivityLogService activityLogService;
    @Autowired
    private RulesAvailableUiService rulesAvailableUiService;
    @Autowired
    private RulesDraftUiService rulesDraftUiService;
    @Autowired
    private RuleAvailableDTOMapper ruleAvailableDTOMapper;
    @Autowired
    private RuleDraftDTOMapper ruleDraftDTOMapper;
    @Autowired
    private LoggerEncoderUtil logEncoderUtil;
    @Autowired
    private HistoricProfilesService historicProfilesService;
    @Autowired
    private ObservationsUiService observationsUiService;

//    @Autowired
//    private CamundaService camundaService;
    @Autowired
    private WorkflowMasterService workflowMasterService;
    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;
    @Autowired
    private SimulationApiService simulationApiService;

    private TenantRepositoryService  tenantRepositoryService;

    @Override
    public ResponseEntity<?> addToRulesAvailable(AddRulesAvailableRequest req, Authentication pr) {
        log.debug("entered in class " + RuleBuilderControllerServiceImpl.class + " in method addToRulesAvailable");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        if (mp.isAdd()) {
            RulesAvailableUi rulesAvail = new RulesAvailableUi();
            rulesAvail.setBCustom(req.getBcustom());
            rulesAvail.setBPayee(req.getBpayee());
            rulesAvail.setBPayer(req.getBpayer());
            rulesAvail.setBTransaction(req.getBtransaction());
            rulesAvail.setBactive(req.getBactive());
            rulesAvail.setBdelete(false);
            rulesAvail.setVcLabel(req.getVclabel());
            rulesAvail.setVcRuleDescription(req.getVcruledescription());
            rulesAvail.setVcRuleDetail(req.getVcruledetail());
            rulesAvail.setVcRuleDimension(req.getRuledimension());
            rulesAvail.setVcRuleName(req.getVcrulename());
            rulesAvail.setVcRuleParams(req.getVcruleparams());
            rulesAvail.setVcRuleState(req.getRulestate());
            rulesAvail.setVcRuleType(req.getVcruletype());
            rulesAvail.setItenantId(req.getTenantId());
            try {
                rulesAvailableUiService.save(rulesAvail);
                log.debug("Exiting addToRulesAvailable Method in " + RuleBuilderControllerServiceImpl.class
                        + " class with response rule saved");
                activityLogService.addActivity(loggedInUser, "rule available saved in database");
                return new ResponseEntity<>(new ApiResponse(true, "Rule available saved"), HttpStatus.OK);
            } catch (Exception e) {
                log.error("Error : " + e + " while saving rules");
                log.debug("Exiting addToRulesAvailable Method in " + RuleBuilderControllerServiceImpl.class
                        + " class with response  : unable to save rule");
                activityLogService.addActivity(loggedInUser, "unable to save rule ", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access addToRulesAvailable");
            log.debug("Exiting addToRulesAvailable Method in " + RuleBuilderControllerServiceImpl.class
                    + " class with response  : unauthorized to access rule creation");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access rule creation"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> addToRulesDraft(AddRulesAvailableRequest req, Authentication pr) {
        log.debug("entered in class " + RuleBuilderControllerServiceImpl.class + " in method addToRulesDraft");
        System.out.println("Request is " + req);
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);
        


        if (mp.isAdd()) {
            RulesDraftUi rulesDraft = new RulesDraftUi();
            rulesDraft.setBCustom(req.getBcustom());
            rulesDraft.setBPayee(req.getBpayee());
            rulesDraft.setBPayer(req.getBpayer());
            rulesDraft.setBTransaction(req.getBtransaction());
            rulesDraft.setBactive(req.getBactive());
            rulesDraft.setBdelete(false);
            rulesDraft.setVcLabel(req.getVclabel());
            rulesDraft.setVcRuleDescription(req.getVcruledescription());
            rulesDraft.setVcRuleDetail(req.getVcruledetail());
            rulesDraft.setVcRuleDimension(req.getRuledimension());
            rulesDraft.setVcRuleName(req.getVcrulename());
            rulesDraft.setVcRuleParams(req.getVcruleparams());
            rulesDraft.setVcRuleState(req.getRulestate());
            rulesDraft.setVcRuleType(req.getVcruletype());
            rulesDraft.setItenantId(req.getTenantId());
            try {
                rulesDraftUiService.save(rulesDraft);
                log.debug("Exiting addToRulesDraft Method in " + RuleBuilderControllerServiceImpl.class
                        + " class with response rule saved");
                activityLogService.addActivity(loggedInUser, "rule draft saved in database");
                return new ResponseEntity<>(new ApiResponse(true, "Rule draft saved"), HttpStatus.OK);
            } catch (Exception e) {
                log.error("Error : " + e + " while saving rules");
                log.debug("Exiting addToRulesDraft Method in " + RuleBuilderControllerServiceImpl.class
                        + " class with response  : unable to save rule");
                activityLogService.addActivity(loggedInUser,"unable to save rule ", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access addToRulesDraft");
            log.debug("Exiting addToRulesDraft Method in " + RuleBuilderControllerServiceImpl.class
                    + " class with response  : unauthorized to access rule creation");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access rule creation"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getRulesDraft(Authentication pr) {
        log.debug("entered in class " + RuleBuilderControllerServiceImpl.class + " in method getRulesDraft");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        if (mp.isView()) {
            try {
                List<RulesDraftUi> rulesDraft = rulesDraftUiService.findAllActiveNonDeleted();
                List<RuleAvailableVO> rulesRes = rulesDraft.stream().map(ruleDraftDTOMapper)
                        .collect(Collectors.toList());
                return ResponseEntity.ok(rulesRes);
            } catch (Exception e) {
                log.error("Error : " + e + " while fetching draft rules");
                log.debug("Exiting getRulesDraft Method in " + RuleBuilderControllerServiceImpl.class
                        + " class with response  : unable to fetch draft rules");
                activityLogService.addActivity(loggedInUser, "unable to fetch draft rules ", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access getRulesDraft");
            log.debug("Exiting addToRulesDraft Method in " + RuleBuilderControllerServiceImpl.class
                    + " class with response  : unauthorized to access rule creation");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access rule creation"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> getRulesAvailable(String menuname, Integer tenantid, Authentication pr) {
        log.debug("entered in class " + RuleBuilderControllerServiceImpl.class + " in method getRulesAvailable");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menuname);


        if (mp.isView()) {
            try {
                List<RulesAvailableUi> rulesAvail = rulesAvailableUiService.findAllActiveNonDeletedTenant(tenantid);
                List<RuleAvailableVO> rulesRes = rulesAvail.stream().map(ruleAvailableDTOMapper)
                        .collect(Collectors.toList());
                return ResponseEntity.ok(rulesRes);
            } catch (Exception e) {
                log.error("Error : " + e + " while fetching available rules");
                log.debug("Exiting getRulesAvailable Method in " + RuleBuilderControllerServiceImpl.class
                        + " class with response  : unable to fetch available rules");
                activityLogService.addActivity(loggedInUser, "unable to fetch available rules ", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access getRulesAvailable");
            log.debug("Exiting addToRulesDraft Method in " + RuleBuilderControllerServiceImpl.class
                    + " class with response  : unauthorized to access rule creation");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access rule creation"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getRuleBuilderData(Integer tenantId,Authentication pr) {
        log.debug(
                "entered in class " + RuleBuilderControllerServiceImpl.class + " in method getMetaDataAndObservations");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        if (mp.isView()) {
        //     List<MetaData> metaData = new ArrayList<>();
        //     List<ObservationsUi> observationsUi = new ArrayList<>();

        //     try {
        //         metaData = historicProfilesService.findAllData();
        //         observationsUi = observationsUiService.findAllNonDeleted();
        //     } catch (Exception e) {
        //         log.error("Error : " + e + "\nParam : " + logEncoderUtil.encode(pr.toString()));
        //         activityLogService.addActivity("failed to get list of metadata and observations", e.toString());
        //         return new ResponseEntity<>(
        //                 new ApiResponse(false, ResponseMessages.GenericErrorMessage),
        //                 HttpStatus.INTERNAL_SERVER_ERROR);
        //     }

        //     RuleBlocksReponse metaobs = new RuleBlocksReponse();
        //     List<MetadataResponse> list1 = new ArrayList<>();
        //     metaData.stream().map(md -> {
        //         ObjectMapper mapper = new ObjectMapper();
        //         JsonNode emptyPath = null;
        //         try {
        //             emptyPath = mapper.readTree("[{\"Path\": \"\" }]");
        //         } catch (JsonProcessingException e) {
        //             log.error("Error in parsing" + e);
        //         }
        //         list1.add(MetadataResponse.builder().vcpath(md.getVcpath())
        //                 .vcroot(md.getVcroot())
        //                 .path(md.getVcPrefix().equals(emptyPath) ? md.getVcpath()
        //                         : md.getVcroot() + "." + md.getVcpath())
        //                 .vcprefix(md.getVcPrefix())
        //                 .description(md.getVcdescription())
        //                 .config(md.getConfig())
        //                 .build());
        //         return null;
        //     }).collect(Collectors.toList());

        //     metaobs.setMetadata(list1);

        //     List<String> list2 = observationsUi.stream()
        //             .map(ObservationsUi::getOname)
        //             .collect(Collectors.toList());
        //     metaobs.setObservations(list2);

            List<RuleAvailableVO> rulesAvailList = null;
            try {
                List<RulesAvailableUi> rulesAvail = rulesAvailableUiService.findAllActiveNonDeletedTenant(tenantId);
                rulesAvailList = rulesAvail.stream().map(ruleAvailableDTOMapper)
                        .collect(Collectors.toList());
            } catch (Exception e) {
                log.error("Error : " + e + " while fetching available rules");
                log.debug("Exiting getRulesAvailable Method in " + RuleBuilderControllerServiceImpl.class
                        + " class with response  : unable to fetch available rules");
                activityLogService.addActivity(loggedInUser, "unable to fetch available rules ", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            List<RuleAvailableVO> rulesDraftList = null;
            try {
                List<RulesDraftUi> rulesDraft = rulesDraftUiService.findAllActiveNonDeletedByTenant(tenantId);
                rulesDraftList = rulesDraft.stream().map(ruleDraftDTOMapper)
                        .collect(Collectors.toList());
            } catch (Exception e) {
                log.error("Error : " + e + " while fetching draft rules");
                log.debug("Exiting getRulesDraft Method in " + RuleBuilderControllerServiceImpl.class
                        + " class with response  : unable to fetch draft rules");
                activityLogService.addActivity(loggedInUser, "unable to fetch draft rules ", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        //     List<WorkflowMasters> allWorkflows = null;
        //     try {
        //         allWorkflows = workflowMasterService.findAll();
        //     } catch (Exception e) {
        //         log.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
        //         activityLogService.addActivity("failed to get user and permissions", e.toString());
        //         return new ResponseEntity<ApiResponse>(
        //                 new ApiResponse(false, ResponseMessages.GenericErrorMessage),
        //                 HttpStatus.INTERNAL_SERVER_ERROR);
        //     }


        //     List<DropdownWithObject> resWorkFlows = allWorkflows.stream().map(a -> {
        //         return DropdownWithObject
        //                 .builder()
        //                 .value(a.getWorkflowKey())
        //                 .label(a.getWorkflowName()).build();
        //     }).collect(Collectors.toList());

            RuleBuilderVO response = new RuleBuilderVO();
        //     response.setMetadataObservations(metaobs);
            response.setRulesAvailable(rulesAvailList);
            response.setRulesDraft(rulesDraftList);
        //     response.setWorkflowList(resWorkFlows);
            return ResponseEntity.ok(response);
        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access metadata and observations list");
            log.debug("Exiting getMetaDataAndObservations Method in " + RuleConfiguratorServiceImpl.class
                    + " class with response  : unauthorized to access list of metadata and observations");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access list of metadata and observations"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getMetaDataAndObservations(Authentication pr) {
        log.debug(
                "entered in class " + RuleBuilderControllerServiceImpl.class + " in method getMetaDataAndObservations");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        if (mp.isView()) {

            List<MetaData> metaData = new ArrayList<>();
            List<ObservationsUi> observationsUi = new ArrayList<>();

            try {
                metaData = historicProfilesService.findAllData();
                observationsUi = observationsUiService.findAllNonDeleted();
            } catch (Exception e) {
                log.error("Error : " + e + "\nParam : " + logEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get list of metadata and observations", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            RuleBlocksReponse responses = new RuleBlocksReponse();

            List<MetadataResponse> list1 = new ArrayList<>();
            metaData.stream().map(md -> {
                ObjectMapper mapper = new ObjectMapper();
                JsonNode emptyPath = null;
                try {
                    emptyPath = mapper.readTree("[{\"Path\": \"\" }]");
                } catch (JsonProcessingException e) {
                    log.error("Error in parsing" + e);
                }
                System.out.println(md.getVcpath() + " desc " + md.getVcdescription());
                list1.add(MetadataResponse.builder().vcpath(md.getVcpath())
                        .vcroot(md.getVcroot())
                        .path(md.getVcPrefix().equals(emptyPath) ? md.getVcpath()
                                : md.getVcroot() + "." + md.getVcpath())
                        .vcprefix(md.getVcPrefix())
                        .description(md.getVcdescription())
                        .build());
                return null;
            }).collect(Collectors.toList());

            responses.setMetadata(list1);

            List<String> list2 = observationsUi.stream()
                    .map(ObservationsUi::getOname)
                    .collect(Collectors.toList());
            responses.setObservations(list2);

            log.debug("Exiting getMetaDataAndObservations Method in "
                    + RuleConfiguratorServiceImpl.class
                    + " class with response  : with parameters list of metadata and observations");
            activityLogService.addActivity(loggedInUser, "List of metadata and observations accessed");

            return ResponseEntity.ok(responses);

        } else {

            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access metadata and observations list");
            log.debug("Exiting getMetaDataAndObservations Method in " + RuleConfiguratorServiceImpl.class
                    + " class with response  : unauthorized to access list of metadata and observations");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access list of metadata and observations"),
                    HttpStatus.FORBIDDEN);
        }

    }

    public ResponseEntity<?> testRule(TestRule testRule, Authentication pr) {
        log.debug(
                "entered in class " + RuleBuilderControllerServiceImpl.class + " in method getMetaDataAndObservations");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        if (mp.isView()) {

            ResponseEntity<String> api_response;
            try {
                api_response = simulationApiService.testRule(testRule);
            } catch (Exception e) {
                log.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(testRule.toString()));
                activityLogService.addActivity(loggedInUser, "failed to test rule", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            log.info(
                    " add run api response code : " + api_response.getStatusCode() + "\n Body : " + api_response.getBody());
            if (api_response.getStatusCode() == HttpStatus.OK) {

                return ResponseEntity.ok(api_response.getBody());
            } else {
                log.error("Error : " + api_response.getBody() + "\nParam : " + loggerEncoderUtil.encode(testRule.toString()));
                activityLogService.addActivity(loggedInUser, "failed to test rule", api_response.getBody());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {

            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access test rule");
            log.debug("Exiting testRule Method in " + RuleConfiguratorServiceImpl.class
                    + " class with response  : unauthorized to access test rule");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access test rule"),
                    HttpStatus.FORBIDDEN);
        }
    }

}
