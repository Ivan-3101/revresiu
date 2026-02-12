package com.DronaPay.UIServer.controller.WindowManagement;


import com.DronaPay.UIServer.requests.AddWindowRequest;
import com.DronaPay.UIServer.service.ControllerService.WindowManagement.WindowManagementService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/v1/testing/window-management")
public class WindowManagementController {

    @Autowired
    private WindowManagementService windowManagementService;

    @GetMapping("/get-window-list")
    public ResponseEntity<?> getListOfWindows(Authentication pr) {
        return windowManagementService.getListOfWindows(pr);
    }

    @GetMapping("/get-window-details/{wid}/{audit}/tenant-id/{tenantid}")
    public ResponseEntity<?> getWindowDetails(@PathVariable("wid") Integer wId, @PathVariable("audit") Boolean audit, 
    @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return windowManagementService.getWindowDetails(wId, audit, tenantid, pr);
    }

    @PostMapping("/add-window")
    public ResponseEntity<?> addWindow(@Valid @RequestBody AddWindowRequest addWindowRequest, Authentication pr) {
        return windowManagementService.addObservationWindow(addWindowRequest, pr);
    }

    @PutMapping("/edit-window/{wid}/{audit}")
    public ResponseEntity<?> editWindow(@Valid @RequestBody AddWindowRequest addWindowRequest, @PathVariable("wid") Integer wId, @PathVariable("audit") Boolean audit, Authentication pr) {
        return windowManagementService.editObservationWidow(addWindowRequest, wId, audit, pr);
    }

    @DeleteMapping("/delete-window/{wid}/{remark}/tenant-id/{tenantid}")
    public ResponseEntity<?> deleteWindow(@PathVariable("wid") Integer wId, @PathVariable("remark") String remark,
    @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return windowManagementService.deleteObservationWindow(wId, remark, tenantid, pr);
    }

    @PutMapping("/approve-window/{wid}/{remark}/{approve}/tenant-id/{tenantid}")
    public ResponseEntity<?> approveWindow(@PathVariable("wid") Integer wAuditId, @PathVariable("remark") String remark,
                                           @PathVariable("approve") Boolean approve,
                                           @PathVariable("tenantid") Integer tenantid,Authentication pr) {
        return windowManagementService.approveWindow(wAuditId, remark, approve,tenantid, pr);
    }

    @GetMapping("/get-window-dropdowns/{tenantid}")
    public ResponseEntity<?> getWindowDropDowns(@PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return windowManagementService.getWindowDropDowns(tenantid, pr);
    }

    @GetMapping("/maxid")
    public ResponseEntity<?> getMaxID(Authentication pr) {
        return windowManagementService.autoSuggestId(pr);
    }
}
