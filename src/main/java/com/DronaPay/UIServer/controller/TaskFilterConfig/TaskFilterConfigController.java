package com.DronaPay.UIServer.controller.TaskFilterConfig;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.DronaPay.UIServer.service.ControllerService.TaskFilterConfig.TaskFilterService;

@RestController
@RequestMapping("/api/v1/task/filter")
public class TaskFilterConfigController {
    
    @Autowired
    private TaskFilterService taskFilterService;

    @GetMapping("/config/{tenantid}/{workflowid}")
    public ResponseEntity<?> findByTenantIdAndWorkflowId(@PathVariable(name = "tenantid",required = true) Integer tenantId,@PathVariable(name = "workflowid",required = true) Integer workflowId,Authentication pr) throws Exception{
        return taskFilterService.findByTenantIdAndWorkflowId(tenantId, workflowId, pr);
    }
    
}
