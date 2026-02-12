package com.DronaPay.UIServer.service.ControllerService.TaskFilterConfig;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;


public interface TaskFilterService {


    ResponseEntity<?> findByTenantIdAndWorkflowId(Integer tenantId,Integer workflowId,Authentication pr) throws Exception;
}
