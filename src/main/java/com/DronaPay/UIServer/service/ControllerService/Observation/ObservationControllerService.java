package com.DronaPay.UIServer.service.ControllerService.Observation;


import com.DronaPay.UIServer.requests.AddObsservationRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

public interface ObservationControllerService {

    public ResponseEntity<?> findListOfObservation(Authentication pr);

    public ResponseEntity<?> findObservationsById(Integer oId, Integer wid, Boolean audit, Integer tenantid, Authentication pr);

    public ResponseEntity<?> addObservation(AddObsservationRequest addObsservationRequest, Authentication pr);

    public ResponseEntity<?> editObservation(AddObsservationRequest addObsservationRequest, Integer oId, Boolean audit, Authentication pr);

    public ResponseEntity<?> deleteObservation(Integer oId, Integer wid, String remark, Integer tenantid, Authentication pr);

    public ResponseEntity<?> approveObservation(Integer oId, String remark, Boolean approve,Integer tenantId, Authentication pr);

    public ResponseEntity<?> autoSuggestID(Authentication pr);

}
