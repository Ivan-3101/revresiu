package com.DronaPay.UIServer.service.ControllerService.TryOut;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.model.sim.Simulations;
import com.DronaPay.UIServer.requests.AddRunRequest;
import com.DronaPay.UIServer.requests.AddSimulationApiRequest;
import com.DronaPay.UIServer.requests.AddSimulationRequest;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.service.ApiServices.SimulationApiServiceImpl;
import com.DronaPay.UIServer.service.ControllerService.Observation.ObservationControllerServiceImpl;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.service.RepositoryService.sim.SimulationsService;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;


@RestController
@RequestMapping("/api/v1/try-out/run-simulator")
public class RunSimulationControllerServiceImpl implements RunSimulationControllerService {

    private static final Logger LOGGER = LoggerFactory.getLogger(RunSimulationControllerServiceImpl.class);
    final String menu_name = MenuNames.runSimulation;
    private String classname = String.valueOf(RunSimulationControllerServiceImpl.class);
    @Autowired
    private SimulationsService simulationsService;
    @Autowired
    private WebUserService webUserService;
    @Autowired
    private ActivityLogService activityLogService;
    @Autowired
    private DecisionUiServiceImpl decisionUiServiceImpl;
    @Autowired
    private RulesDraftUiService rulesDraftUiService;
    @Autowired
    private RulesAvailableUiService rulesAvailableUiService;
    @Autowired
    private RulesTempServiceImpl rulesTempService;
    @Autowired
    private SimulationApiServiceImpl simulationApiService;
    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    public ResponseEntity<?> getSimulationDropDown(Authentication pr, Integer tenantid) {
        LOGGER.debug("entered in class " + classname + " in method getSimulationDropDown");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            List<Simulations> simulations_list = new ArrayList<>();
            try {
                simulations_list = simulationsService.findAll(tenantid);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to find all simulations ", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            Map<String, List<Map<String, Object>>> response = new HashMap<>();
            new ArrayList<>();

            List<DecisionUi> decisionaActiveList;
            try {
                decisionaActiveList = decisionUiServiceImpl.findAllActive(tenantid);

            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, 
                        "failed to get retrieve list of active decision list for run simulation ", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, MenuNames.listManagement),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            List<Map<String, Object>> resdecisionlist = new ArrayList<>();

            try {

                resdecisionlist = decisionaActiveList.stream().map(decision -> {
                    Map<String, Object> adddecisiontores = new HashMap<>();
                    adddecisiontores.put("label", decision.getVcDecisionName());
                    adddecisiontores.put("value", decision.getIDecisionID());
                    List<Rules> ruleslist;
                    try {
                        ruleslist = rulesTempService.findAllByIDecisionID(decision.getIDecisionID(), tenantid);
                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }
                    List<Map<String, Object>> rulesreslist = ruleslist.stream().map(rule -> {
                        Map<String, Object> rulesres = new HashMap<>();
                        rulesres.put("label", rule.getVcRuleName());
                        rulesres.put("value", rule.getIRuleID());
                        rulesres.put("decisionId", decision.getIDecisionID());
                        return rulesres;
                    }).collect(Collectors.toList());

                    adddecisiontores.put("rules", rulesreslist);
                    return adddecisiontores;

                }).collect(Collectors.toList());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, 
                        "failed to get retrieve list of active rules list by decision id for run simulation",
                        e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, MenuNames.listManagement),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            response.put("decisionList", resdecisionlist);

            List<Map<String, Object>> simulations_dropdown = simulations_list.stream().map(simulations -> {
                Map<String, Object> add_to_simulation_dropdown = new HashMap<>();
                add_to_simulation_dropdown.put("label", simulations.getSimid());
                add_to_simulation_dropdown.put("value", simulations);
                return add_to_simulation_dropdown;
            }).collect(Collectors.toList());

            response.put("simulation_dropdown", simulations_dropdown);

            List<RulesDraftUi> rulesDraft = new ArrayList<>();

            try {
                rulesDraft = rulesDraftUiService.findAllActiveNonDeletedByTenant(tenantid);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get retrieve list of draft rules ", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, MenuNames.listManagement),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            List<Map<String, Object>> rulesdraft_dropdown = rulesDraft.stream().map(rule -> {
                Map<String, Object> add_to_dropdown = new HashMap<>();
                add_to_dropdown.put("label", rule.getVcRuleName());
                add_to_dropdown.put("value", rule.getIRuleDraftID());
                return add_to_dropdown;
            }).collect(Collectors.toList());

            response.put("rulesdraft_dropdown", rulesdraft_dropdown);

            List<RulesAvailableUi> rulesAvailable = new ArrayList<>();

            try {
                rulesAvailable = rulesAvailableUiService.findAllActiveNonDeletedTenant(tenantid);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get retrieve list of draft rules ", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, MenuNames.listManagement),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            List<Map<String, Object>> rulesavailable_dropdown = rulesAvailable.stream().map(rule -> {
                Map<String, Object> add_to_dropdown = new HashMap<>();
                add_to_dropdown.put("label", rule.getVcRuleName());
                add_to_dropdown.put("value", rule.getIRuleAvailableID());
                return add_to_dropdown;
            }).collect(Collectors.toList());

            response.put("rulesavailable_dropdown", rulesavailable_dropdown);
            LOGGER.debug("Exiting getSimulationDropDown Method in "
                    + classname
                    + " class with response  : with dropdown options of simulations");
            activityLogService.addActivity(loggedInUser, "simulation dropdown accessed for run simulation ");
            return ResponseEntity.ok(response);

        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access simulation dropdown for run simulation ");
            LOGGER.debug("Exiting getSimulationDropDown Method in " + classname
                    + " class with response  : unauthorized to access list of windows");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access simulation dropdown for run simulation "),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> addSimulation(String simid, AddSimulationRequest addSimulationRequest, Authentication pr) {
        LOGGER.debug("entered in class " + classname + " in method addSimulation");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isAdd()) {

            if (simid.isBlank()) {
                activityLogService.addActivity(loggedInUser, "failed to add simulation because simid is empty ", simid);
                LOGGER.error("Exiting Add List  Method in " + loggerEncoderUtil.encode(classname)
                        + " class with response  : failed to add simulation because simid is empty");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please enter Simulation Name"),
                        HttpStatus.BAD_REQUEST);
            }

            Pattern pattern = Pattern.compile("^[a-zA-Z0-9 ,_/%\\\\.-]+$");
            Matcher matcher = pattern.matcher(simid);

            if (!matcher.matches()) {
                LOGGER.debug("Exiting addSimulation Method in " + RunSimulationControllerServiceImpl.class
                        + " class with response: Invalid Simulation name format");
                activityLogService.addActivity(loggedInUser, "failed to add simulation due to invalid Simulation name", simid);
                return new ResponseEntity<>(
                        new ApiResponse(false, "Simulation name can only contain alphabets, numbers, " +
                                "underscore (_), hyphen (-), empty space, percentage (%), forward slash (/), " +
                                "backward slash (\\), comma (,) and dot (.)"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addSimulationRequest.getIsbatch() == null) {
                activityLogService.addActivity(loggedInUser, "failed to add simulation because type is null ",
                        addSimulationRequest.toString());
                LOGGER.error("Exiting Add List  Method in " + loggerEncoderUtil.encode(classname)
                        + " class with response  : failed to add simulation because type is null");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Type cannot be null"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addSimulationRequest.getIdecisionid() == null) {
                activityLogService.addActivity(loggedInUser, "failed to add simulation because decision id is null ",
                        addSimulationRequest.toString());
                LOGGER.error("Exiting Add List  Method in " + loggerEncoderUtil.encode(classname)
                        + " class with response  : failed to add simulation because decision id is null");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Decision cannot be null"),
                        HttpStatus.BAD_REQUEST);
            }

            AddSimulationApiRequest addApiRequest = new AddSimulationApiRequest();
            addApiRequest.setIsbatch(addSimulationRequest.getIsbatch());
            addApiRequest.setNote(addSimulationRequest.getNote());
            addApiRequest.setItenantid(addSimulationRequest.getItenantid());
          
            ObjectMapper mapper = new ObjectMapper();
            if (addSimulationRequest.getIdecisionid() > 0) {
                addApiRequest.setIdecisionid(addSimulationRequest.getIdecisionid());
                addApiRequest.setIruleid(addSimulationRequest.getIruleid());
                System.out.println("adding master");
            } else if (addSimulationRequest.getIdecisionid() == -2) {
                try {
                    RulesDraftUi rule = rulesDraftUiService.findById(addSimulationRequest.getIruleid());
                    addApiRequest.setIdecisionid(-2);
                    addApiRequest.setIruleid(addSimulationRequest.getIruleid());
                    addApiRequest.setVcruledetail(mapper.readTree(rule.getVcRuleDetail()));
                    addApiRequest.setVcruleparams(mapper.readTree(rule.getVcRuleParams()));
                    System.out.println("adding draft");
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get retrieve draft rule details ", e.toString());
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, MenuNames.listManagement),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
            } else if (addSimulationRequest.getIdecisionid() == -1) {
                try {
                    RulesAvailableUi rule = rulesAvailableUiService.findById(addSimulationRequest.getIruleid());
                    addApiRequest.setIdecisionid(-1);
                    addApiRequest.setIruleid(addSimulationRequest.getIruleid());
                    addApiRequest.setVcruledetail(mapper.readTree(rule.getVcRuleDetail()));
                    addApiRequest.setVcruleparams(mapper.readTree(rule.getVcRuleParams()));
                    System.out.println("adding available");
                } catch (Exception e) {
                    LOGGER.error("Error : adding available" + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get retrieve draft rule details ", e.toString());
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, MenuNames.listManagement),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
            } else {
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Unknown rule type"),
                        HttpStatus.BAD_REQUEST);
            }

            ResponseEntity<String> api_response;
            try {
                api_response = simulationApiService.addSimulation(addApiRequest, simid);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(addApiRequest.toString()));
                activityLogService.addActivity(loggedInUser, "failed to add simulation", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            LOGGER.info(" add simulatioon api response code : " + api_response.getStatusCode() + "\n Body : "
                    + api_response.getBody());
            if (api_response.getStatusCode() == HttpStatus.OK) {
                org.json.JSONObject respObj = new JSONObject();
                respObj.put("message", "New Simulation ID " + simid + " added successfully");
                return ResponseEntity.ok(respObj.toString());
            } else {
                LOGGER.error("Error : " + api_response.getBody() + "\nParam : " + loggerEncoderUtil.encode(addSimulationRequest.toString()));
                activityLogService.addActivity(loggedInUser, "failed to add simulation", api_response.getBody());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to add simulation ");
            LOGGER.debug("Exiting addSimulation Method in " + classname
                    + " class with response  : unauthorized to add simulation ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to add simulation"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> addRun(String simid, AddRunRequest addRunRequest, Authentication pr) {
        LOGGER.debug("entered in class " + classname + " in method addSimulation");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isAdd()) {

            if (addRunRequest.getDtfrom() == null) {
                activityLogService.addActivity(loggedInUser, "failed to add run because from date is null ",
                        addRunRequest.toString());
                LOGGER.error("Exiting Add List  Method in " + loggerEncoderUtil.encode(classname)
                        + " class with response  : failed to add run because from date is null ");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "From date cannot be null"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addRunRequest.getDtto() == null) {
                activityLogService.addActivity(loggedInUser, "failed to add run because to date is null ",
                        addRunRequest.toString());
                LOGGER.error("Exiting Add List  Method in " + loggerEncoderUtil.encode(classname)
                        + " class with response  : failed to add run because to date is null ");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "To date cannot be null"),
                        HttpStatus.BAD_REQUEST);
            }

            ResponseEntity<String> api_response;
            try {
                api_response = simulationApiService.addRun(addRunRequest, simid);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(addRunRequest.toString()));
                activityLogService.addActivity(loggedInUser, "failed to add run", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            LOGGER.info(
                    " add run api response code : " + api_response.getStatusCode() + "\n Body : " + api_response.getBody());
            if (api_response.getStatusCode() == HttpStatus.OK) {
                org.json.JSONObject respObj = new JSONObject();
                respObj.put("message", "Run for Simulation ID " + simid + " initiated.\nPlease check Analyze Simulation for results.");
                System.out.println("returning " + respObj.toString());
                return ResponseEntity.ok(respObj.toString());
            } else {
                LOGGER.error("Error : " + api_response.getBody() + "\nParam : " + loggerEncoderUtil.encode(addRunRequest.toString()));
                activityLogService.addActivity(loggedInUser, "failed to add run", api_response.getBody());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to add run ");
            LOGGER.debug("Exiting addSimulation Method in " + classname
                    + " class with response  : unauthorized to add run ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to add run"),
                    HttpStatus.FORBIDDEN);
        }
    }


    public ResponseEntity<?> validateSimulation(AddRunRequest requestBody, String simid, Authentication pr){
        LOGGER.debug("entered in class " + classname + " in method validateSimulation");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isAdd()) {

            if (simid.isBlank() || simid.isEmpty()) {
                activityLogService.addActivity(loggedInUser, "failed to validate simulation because simid is empty ", simid);
                LOGGER.error("Exiting validateSimulation Method in " + loggerEncoderUtil.encode(classname)
                        + " class with response  : failed to validate simulation because simid is empty");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please enter Simulation Name"),
                        HttpStatus.BAD_REQUEST);
            }
            ResponseEntity<String> api_response;
            try {
                api_response = simulationApiService.validateSimulation(requestBody,simid);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + simid);
                activityLogService.addActivity(loggedInUser, "failed to validate simulation", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            LOGGER.info(" add simulatioon api response code : " + api_response.getStatusCode() + "\n Body : "
                    + api_response.getBody());
            if (api_response.getStatusCode() == HttpStatus.OK) {
                return ResponseEntity.ok(api_response);
            } else {
                LOGGER.error("Error : " + api_response.getBody() + "\nParam : " + simid);
                activityLogService.addActivity(loggedInUser, "failed to validate simulation", api_response.getBody());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to add simulation ");
            LOGGER.debug("Exiting validateSimulation Method in " + classname
                    + " class with response  : unauthorized to add simulation ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to add simulation"),
                    HttpStatus.FORBIDDEN);
        }
    }

}
