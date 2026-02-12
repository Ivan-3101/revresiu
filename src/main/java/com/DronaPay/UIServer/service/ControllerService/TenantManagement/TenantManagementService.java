package com.DronaPay.UIServer.service.ControllerService.TenantManagement;


import com.DronaPay.UIServer.requests.AddTenantRequest;
import com.DronaPay.UIServer.requests.ApproveTenantRequest;
import com.DronaPay.UIServer.requests.DeleteTenantRequest;
import com.DronaPay.UIServer.requests.EditTenantRequest;
import com.DronaPay.UIServer.requests.TenantRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

public interface TenantManagementService {

    public ResponseEntity<?> getAllOrgs(Authentication pr);

    public ResponseEntity<?> getAllTenants(Authentication pr);

    public ResponseEntity<?> addTenant(AddTenantRequest request, Authentication pr);

    public ResponseEntity<?> editTenant(EditTenantRequest request, Authentication pr);

    public ResponseEntity<?> deleteTenant(DeleteTenantRequest request, Authentication pr);

    public ResponseEntity<?> approveTenant(ApproveTenantRequest request, Authentication pr);

    public ResponseEntity<?> patchTenant(TenantRequest request, String vctenantid);


}
