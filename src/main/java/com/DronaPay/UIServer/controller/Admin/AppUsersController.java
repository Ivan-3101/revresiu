package com.DronaPay.UIServer.controller.Admin;


import com.DronaPay.UIServer.requests.*;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.service.ControllerService.AppUser.AppUserService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/admin/app-users")
public class AppUsersController {

    @Autowired
    private AppUserService appUserService;

    @PostMapping("/get-all-workflows/{menuname}")
    public ResponseEntity<?> getWorkflows(@PathVariable("menuname") String menuname, @RequestBody TenantListRequest req, Authentication pr) {
        return appUserService.getAllWorflows(menuname, req, pr);
    }

    @GetMapping("/")
    public ResponseEntity<?> getAppUsers(Authentication pr) {
        return appUserService.getAppUsers(pr);
    }

    @GetMapping("/get-all-tenants/{orgid}/{menuname}")
    public ResponseEntity<?> getAllTenants(@PathVariable("orgid") String orgid, @PathVariable("menuname") String menuname, Authentication pr) {
        return appUserService.getAllTenants(orgid, menuname, pr);
    }


    @PostMapping("/get-user-mapping-options")
    public ResponseEntity<?> getRoleGroupWorkflowClassMap(
            @RequestBody TenantListRequest request, Authentication pr) {

        return appUserService.getRoleGroupWorkflowClassMap(request, pr);
    }

    @PostMapping("/get-web-user")
    public ResponseEntity<?> getAppUserDetails(@RequestBody GetAppUserDetailsRequest gaudr, Authentication pr) {
        return appUserService.getAppUserDetails(gaudr, pr);
    }

    @PostMapping("/add-web-user")
    public ResponseEntity<ApiResponse> newWebuserEntry(@Valid @RequestBody NewWebUserAuditRequestGt user, Authentication pr) {
        return appUserService.newWebuserEntry(user, pr);
    }

    @PutMapping("/approve-webuser")
    public ResponseEntity<?> approveWebUserEntry(@Valid @RequestBody CheckerRequest cr, Authentication user) {

        return appUserService.approveWebUserEntry(cr, user);
    }

    @PostMapping("/delete-webuser")
    public ResponseEntity<?> deleteWebuser(@Valid @RequestBody DeleteRequest dr, Authentication user) {
        return appUserService.deleteWebuser(dr, user);
    }

    @PostMapping("/unlock-webuser")
    public ResponseEntity<?> unlockWebuser(@RequestBody UnlockRequest ur, Authentication user) {
        return appUserService.unlockWebuser(ur, user);
    }

    @PostMapping("/edit-webuser")
    public ResponseEntity<?> editWebuser(@Valid @RequestBody EditWebuserRequest ewr, Authentication pr) {

        return appUserService.editWebuser(ewr, pr);
    }

    @PostMapping("/edit-profile")
    public ResponseEntity<?> editUserPorfile(@Valid @RequestBody EditUseObj user, Authentication pr) {

        return appUserService.editLoggedInUser(user, pr);
    }

    @PostMapping("/change-password")
    public ResponseEntity<?> changePassword(@RequestBody ChangePasswordRequest cp, Authentication pr) {

        return appUserService.changePassword(cp, pr);
    }

    @GetMapping("/get-timezones")
    public ResponseEntity<?> getTimeZones(Authentication pr) {

        return appUserService.getTimeZone(pr);
    }

    @PostMapping("/reset-user-password")
    public ResponseEntity<?> resetUserPassword(@RequestBody ResetUserPasswordRequest request, Authentication user) {
        return appUserService.resetUserPassword(request, user);
    }


    // @PostMapping("/upload-profile-pic")
    // public ResponseEntity<?> uploadProfilePic(@RequestParam("file") MultipartFile file, Authentication pr) {
    //     return appUserService.profilePicUpload(file, pr);
    // }

}
