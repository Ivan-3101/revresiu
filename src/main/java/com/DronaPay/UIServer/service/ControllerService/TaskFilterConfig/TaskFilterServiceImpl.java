package com.DronaPay.UIServer.service.ControllerService.TaskFilterConfig;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;

import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.model.WorkflowMasters;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.service.ControllerService.CaseManagement.TasksServiceImpl;
import com.DronaPay.UIServer.service.RepositoryService.ActivityLogService;
import com.DronaPay.UIServer.service.RepositoryService.WorkflowMasterService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TaskFilterServiceImpl implements TaskFilterService {

        final String menu_name = MenuNames.Tasks;

      

        @Autowired
        private ActivityLogService activityLogService;

        @Autowired
        private WorkflowMasterService workflowMasterService;

        @Override
        public ResponseEntity<?> findByTenantIdAndWorkflowId(Integer tenantId, Integer workflowId, Authentication pr) throws Exception {

                LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

                WebUser loggedInUser = loggedUser.getWebUser();
                MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

                if (mp.isView()) {

                        WorkflowMasters workflowMasters = workflowMasterService.findByWorkflowID(workflowId, tenantId);
                        if (workflowMasters == null) {

                                log.error(
                                                "Error : task filter Config is null \nParam : tenantid " + tenantId
                                                                + " workflowid "
                                                                + workflowId);
                                activityLogService.addActivity(loggedInUser, "failed to get task list",
                                                "Error :  task filter Config is null \n Parameters : tenantid "
                                                                + tenantId + " workflowid "
                                                                + workflowId);
                                return new ResponseEntity<ApiResponse>(
                                                new ApiResponse(false, String.format(
                                                                "Filter config not found for tenant id:%s and workflow id : %s ",
                                                                tenantId, workflowId)),
                                                HttpStatus.NOT_FOUND);

                        }

                        log.debug(
                                        "Succes : task filter Config is accessed \nParam : tenantid " + tenantId
                                                        + " workflowid "
                                                        + workflowId);
                        activityLogService.addActivity(loggedInUser, "Success task filter Config is accessed",
                                        "Success :  task filter Config is accessed \n Parameters : tenantid " + tenantId
                                                        + " workflowid "
                                                        + workflowId);

                        return ResponseEntity.ok().body(workflowMasters.getDisplayConfig());

                } else {
                        activityLogService.addActivity(loggedInUser, "unauthorized to access case management dropdown");
                        log.debug("Exiting getListDropDown Method in " + TasksServiceImpl.class
                                        + " class with response  : unauthorized to access case management dropdown");
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, "unauthorized to access case management dropdown"),
                                        HttpStatus.FORBIDDEN);
                }

        }

}
