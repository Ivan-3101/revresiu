package com.DronaPay.UIServer.controller.Tenant;

import com.DronaPay.UIServer.service.ControllerService.Tenant.TenantControllerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/api/v1/tenant")
public class Tenant {

    @Autowired
    private TenantControllerService tenantControllerService;

    @GetMapping("/{class_name}")
    public ResponseEntity<?> getRulesAvailableByDecisionID(@PathVariable String class_name) throws Exception {
        return tenantControllerService.getByTenantId(class_name);
    }

}
