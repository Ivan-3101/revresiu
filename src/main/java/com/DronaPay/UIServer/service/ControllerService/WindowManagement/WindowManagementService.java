package com.DronaPay.UIServer.service.ControllerService.WindowManagement;


import com.DronaPay.UIServer.requests.AddWindowRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

public interface WindowManagementService {

    public ResponseEntity<?> getListOfWindows(Authentication pr);

    public ResponseEntity<?> getWindowDetails(Integer wId, Boolean audit, Integer tenantid, Authentication pr);

    public ResponseEntity<?> addObservationWindow(AddWindowRequest addWindowRequest, Authentication pr);

    public ResponseEntity<?> editObservationWidow(AddWindowRequest addWindowRequest, Integer wId, Boolean audit, Authentication pr);

    public ResponseEntity<?> deleteObservationWindow(Integer wId, String remark, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getWindowDropDowns(Integer tenantid, Authentication pr);

    public ResponseEntity<?> approveWindow(Integer wAuditId, String remark, Boolean approve,Integer tenantId, Authentication pr);

    public ResponseEntity<?> autoSuggestId(Authentication pr);
}
