package com.DronaPay.UIServer.service.ControllerService.TryOut;


import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.model.sim.Runs;
import com.DronaPay.UIServer.model.sim.Simulations;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.service.RepositoryService.ActivityLogService;
import com.DronaPay.UIServer.service.RepositoryService.WebUserService;
import com.DronaPay.UIServer.service.RepositoryService.sim.RunsService;
import com.DronaPay.UIServer.service.RepositoryService.sim.SimulationsService;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;
import java.util.stream.Collectors;


@RestController
@RequestMapping("/api/v1/try-out/run-simulator")
public class AnalyzeSimulationControllerServiceImpl implements AnalyzeSimulationControllerService {

    private static final Logger LOGGER = LoggerFactory.getLogger(AnalyzeSimulationControllerServiceImpl.class);
    final String menu_name = MenuNames.analyzeSimulation;
    private String classname = String.valueOf(AnalyzeSimulationControllerServiceImpl.class);
    @Autowired
    private RunsService runsService;
    @Autowired
    private SimulationsService simulationsService;
    @Autowired
    private WebUserService webUserService;
    @Autowired
    private ActivityLogService activityLogService;

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    public ResponseEntity<?> getSimulationAndRunDropDown(Authentication pr, Integer tenantid) {
        LOGGER.debug("entered in class " + classname + " in method getSimulationAndRunDropDown");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            List<Runs> runs_list = new ArrayList<>();
            try {
                runs_list = runsService.findAll(tenantid);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to find all runs ", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            Map<String, List<Runs>> runs_map_by_simid = runs_list
                    .stream().collect(Collectors.groupingBy(Runs::getSimid));

            List<Map<String, Object>> response = new ArrayList<>();
            for (String key : runs_map_by_simid.keySet()) {
                Map<String, Object> run_to_add_in_response = new HashMap<>();
                run_to_add_in_response.put("label", key);
                run_to_add_in_response.put("value", key);
                Optional<Simulations> simulation;
                try {
                    simulation = simulationsService.findBySimid(key, tenantid);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : simid " + loggerEncoderUtil.encode(key));
                    activityLogService.addActivity(loggedInUser, "failed to find simulation ", e.toString());
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                run_to_add_in_response.put("simulation", simulation);

                List<Runs> list_of_run_by_simid = runs_map_by_simid.get(key);

                List<Map<String, Object>> list_of_run_dropdown = new ArrayList<>();

                for (Runs run : list_of_run_by_simid) {
                    Map<String, Object> run_to_add = new HashMap<>();
                    run_to_add.put("label", run.getRunID());
                    run_to_add.put("value", run.getRunID());

                    run_to_add.put("run", run);

                    list_of_run_dropdown.add(run_to_add);

                }
                run_to_add_in_response.put("run_dropdown", list_of_run_dropdown);

                response.add(run_to_add_in_response);

            }

            LOGGER.debug("Exiting getSimulationAndRunDropDown Method in "
                    + classname
                    + " class with response  : with dropdown options of simulations and runs");
            activityLogService.addActivity(loggedInUser, "simulation and runs dropdown accessed for analyze simulation ");
            return ResponseEntity.ok(response);

        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access windows list");
            LOGGER.debug("Exiting getListOfWindows Method in " + classname
                    + " class with response  : unauthorized to access list of windows");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access list of windows"),
                    HttpStatus.FORBIDDEN);
        }
    }
}
