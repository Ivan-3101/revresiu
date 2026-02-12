package com.DronaPay.UIServer.service.ControllerService.HistoricProfileManagement;


import com.DronaPay.UIServer.requests.AddHistoricProfile;
import com.DronaPay.UIServer.requests.ApproveProfileRequest;
import com.DronaPay.UIServer.requests.DeleteProfileRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;


public interface HistoricProfileManagementService {

    public ResponseEntity<?> getListOfProfiles(Authentication pr);

    public ResponseEntity<?> addProfile(AddHistoricProfile addHistoricProfile, Authentication pr);

    public ResponseEntity<?> approveProfile(ApproveProfileRequest approveRequest, Authentication pr);

    public ResponseEntity<?> deleteProfile(DeleteProfileRequest deleteRequest, Authentication pr);

    public ResponseEntity<?> editProfile(AddHistoricProfile editReq, Authentication pr);

    public ResponseEntity<?> getAggregateTypes(Authentication pr);
}
