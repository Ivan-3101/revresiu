package com.DronaPay.UIServer.controller.ObservationManagement;

import com.DronaPay.UIServer.requests.AddObsservationRequest;
import com.DronaPay.UIServer.service.ControllerService.Observation.ObservationControllerService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/v1/testing/observation-management")
public class ObservationManagementController {

    @Autowired
    private ObservationControllerService observationControllerService;

    @GetMapping("/get-observation-list")
    public ResponseEntity<?> getListOfObservation(Authentication pr) {
        return observationControllerService.findListOfObservation(pr);
    }

    @GetMapping("/get-observation/{oid}/{wid}/{audit}/tenant-id/{tenantid}")
    public ResponseEntity<?> getObservationById(@PathVariable("oid") Integer oId, 
    @PathVariable("wid") Integer wid, @PathVariable("audit") Boolean audit,
    @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return observationControllerService.findObservationsById(oId, wid, audit, tenantid, pr);
    }

    @PostMapping("/add-observation")
    public ResponseEntity<?> addObservation(@Valid @RequestBody AddObsservationRequest addObsservationRequest, Authentication pr) {
        return observationControllerService.addObservation(addObsservationRequest, pr);
    }

    @PutMapping("/edit-observation/{oid}/{audit}")
    public ResponseEntity<?> editObservation(@RequestBody AddObsservationRequest addObsservationRequest,
                                             @PathVariable("oid") Integer oId, @PathVariable("audit") Boolean audit, Authentication pr) {
        return observationControllerService.editObservation(addObsservationRequest, oId, audit, pr);
    }

    @DeleteMapping("/delete-observation/{oid}/{wid}/{remark}/tenant-id/{tenantid}")
    public ResponseEntity<?> deleteObservation(@PathVariable("oid") Integer oId, 
    @PathVariable("wid") Integer wid, @PathVariable("remark") String remark,
    @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return observationControllerService.deleteObservation(oId, wid, remark, tenantid, pr);
    }

    @PutMapping("/approve-observation/{oauditid}/{remark}/{approve}/tenant-id/{tenantid}")
    public ResponseEntity<?> approveObservation(@PathVariable("oauditid") Integer oAuditId,
                                                @PathVariable("remark") String remark, 
                                                @PathVariable("approve") Boolean approve, 
                                                @PathVariable("tenantid") Integer tenantid,
                                                Authentication pr) {
        return observationControllerService.approveObservation(oAuditId, remark, approve,tenantid, pr);
    }


    @GetMapping("/maxid")
    public ResponseEntity<?> getMaxId(Authentication pr) {
        return observationControllerService.autoSuggestID(pr);
    }

}
