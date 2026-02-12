package com.DronaPay.UIServer.controller.HistoricProfileManagement;

import com.DronaPay.UIServer.requests.AddHistoricProfile;
import com.DronaPay.UIServer.requests.ApproveProfileRequest;
import com.DronaPay.UIServer.requests.DeleteProfileRequest;
import com.DronaPay.UIServer.service.ControllerService.HistoricProfileManagement.HistoricProfileManagementService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/v1/testing/historic-profile-management")
public class HistoricProfileManagement {

    @Autowired
    private HistoricProfileManagementService historicProfileManagementService;

    @GetMapping("/get-profile-list")
    public ResponseEntity<?> getListOfProfiles(Authentication pr) {
        return historicProfileManagementService.getListOfProfiles(pr);
    }

    @PostMapping("/add-profile")
    public ResponseEntity<?> addProfile(@RequestBody @Valid AddHistoricProfile addNewProfile, Authentication pr) {
        return historicProfileManagementService.addProfile(addNewProfile, pr);
    }

    @PostMapping("/approve-profile")
    public ResponseEntity<?> approveProfile(@RequestBody @Valid ApproveProfileRequest req, Authentication pr) {
        return historicProfileManagementService.approveProfile(req, pr);
    }

    @PostMapping("/delete-profile")
    public ResponseEntity<?> deleteProfile(@RequestBody @Valid DeleteProfileRequest req, Authentication pr) {
        return historicProfileManagementService.deleteProfile(req, pr);
    }

    @PostMapping("/edit-profile")
    public ResponseEntity<?> editProfile(@RequestBody @Valid AddHistoricProfile editProfile, Authentication pr) {
        return historicProfileManagementService.editProfile(editProfile, pr);
    }

    @GetMapping("/get-aggregate-types")
    public ResponseEntity<?> getAggregateTypes(Authentication pr) {
        return historicProfileManagementService.getAggregateTypes(pr);
    }
}
