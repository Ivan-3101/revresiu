package com.DronaPay.UIServer.controller.TenantMangement;


import com.DronaPay.UIServer.requests.AddTenantRequest;
import com.DronaPay.UIServer.requests.ApproveTenantRequest;
import com.DronaPay.UIServer.requests.DeleteTenantRequest;
import com.DronaPay.UIServer.requests.EditTenantRequest;
import com.DronaPay.UIServer.requests.TenantRequest;
import com.DronaPay.UIServer.service.ControllerService.TenantManagement.TenantManagementService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/tenant")
public class TenantManagementController {

    @Autowired
    private TenantManagementService tenantManagementService;

    @PatchMapping("/{vctenantid}")
    public ResponseEntity<?> patchTenant(@RequestBody TenantRequest request, @PathVariable("vctenantid") String vctenantid) {
        return tenantManagementService.patchTenant(request, vctenantid);
    }

    @GetMapping("/get-all-orgs")
    public ResponseEntity<?> getAllOrgs(Authentication pr) {
        return tenantManagementService.getAllOrgs(pr);
    }

    @GetMapping("/get-all-tenants")
    public ResponseEntity<?> getAllTenants(Authentication pr) {
        return tenantManagementService.getAllTenants(pr);
    }

    @PostMapping("/add-tenant")
    public ResponseEntity<?> addTenant(Authentication pr, @RequestBody @Valid AddTenantRequest request) {
        return tenantManagementService.addTenant(request, pr);
    }

    @PostMapping("/edit-tenant")
    public ResponseEntity<?> editTenant(Authentication pr, @RequestBody @Valid EditTenantRequest request) {
        return tenantManagementService.editTenant(request, pr);
    }

    @PostMapping("/delete-tenant")
    public ResponseEntity<?> deleteTenant(Authentication pr, @RequestBody @Valid DeleteTenantRequest request) {
        return tenantManagementService.deleteTenant(request, pr);
    }

    @PostMapping("/approve-tenant")
    public ResponseEntity<?> approveTenant(Authentication pr, @RequestBody @Valid ApproveTenantRequest request) {
        return tenantManagementService.approveTenant(request, pr);
    }

}
