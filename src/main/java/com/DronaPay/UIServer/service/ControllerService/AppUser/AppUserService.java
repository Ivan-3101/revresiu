package com.DronaPay.UIServer.service.ControllerService.AppUser;


import com.DronaPay.UIServer.requests.*;
import com.DronaPay.UIServer.response.ApiResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

public interface AppUserService {

    public ResponseEntity<?> getAppUsers(Authentication pr);

    public ResponseEntity<?> getAllTenants(String orgid, String menuname, Authentication pr);

    public ResponseEntity<?> getRoleGroupWorkflowClassMap(TenantListRequest request, Authentication pr);

    public ResponseEntity<?> getAppUserDetails(GetAppUserDetailsRequest gaudr, Authentication pr);

    public ResponseEntity<ApiResponse> newWebuserEntry(NewWebUserAuditRequestGt user, Authentication pr);

    public ResponseEntity<?> approveWebUserEntry(CheckerRequest cr, Authentication user);

    public ResponseEntity<?> deleteWebuser(DeleteRequest dr, Authentication user);

    public ResponseEntity<?> editWebuser(EditWebuserRequest ewr, Authentication pr);

    public ResponseEntity<?> unlockWebuser(UnlockRequest ur, Authentication user);

    public ResponseEntity<?> editLoggedInUser(EditUseObj user, Authentication pr);

    public ResponseEntity<?> changePassword(ChangePasswordRequest cp, Authentication pr);

    public ResponseEntity<?> getTimeZone(Authentication pr);

    public ResponseEntity<?> getAllWorflows(String menuname, TenantListRequest req, Authentication pr);

    public ResponseEntity<?> resetUserPassword(ResetUserPasswordRequest request, Authentication user);

    // public ResponseEntity<?> profilePicUpload(MultipartFile file, Authentication pr);
}
