package com.DronaPay.UIServer.controller.ListManagement;

import com.DronaPay.UIServer.requests.AddNewPaymentRequest;
import com.DronaPay.UIServer.requests.ApproveListRequest;
import com.DronaPay.UIServer.requests.DeleteListRequest;
import com.DronaPay.UIServer.service.ControllerService.ListManagement.ListManagementService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/testing/list-management")
public class ListManagementController {

  @Autowired private ListManagementService listMangementService;

  @GetMapping("/")
  public ResponseEntity<?> getListManagement(Authentication pr) {
    return listMangementService.getListManagement(pr);
  }

  @GetMapping("/get-master-list-dropdown/tenant-id/{tenantid}")
  public ResponseEntity<?>
  getListMasterDropdown(@PathVariable("tenantid") Integer tenantid,
                        Authentication pr) {
    return listMangementService.getListMasterDropdown(tenantid, pr);
  }

  @GetMapping("/get-white-list-dropdown")
  public ResponseEntity<?> getListWhiteDropdown(Authentication pr) {
    return listMangementService.getListWhiteDropdown(pr);
  }

  @GetMapping("/get-field-list/{itenantId}")
  public ResponseEntity<?>
  getParameterType(@PathVariable("itenantId") Integer itenantId,
                   Authentication pr) {
    return listMangementService.getParameterType(itenantId, pr);
  }

  @PostMapping("/add-list")
  public ResponseEntity<?> addList(@Valid @RequestBody AddNewPaymentRequest req,
                                   Authentication pr) {

    return listMangementService.addList(req, pr);
  }

  @PostMapping("/delete-list-item")
  public ResponseEntity<?>
  deleteListItem(@Valid @RequestBody DeleteListRequest deleteListRequest,
                 Authentication pr) {
    return listMangementService.deleteListItem(deleteListRequest, pr);
  }

  @PostMapping("/approve-list")
  public ResponseEntity<?>
  approveList(@Valid @RequestBody ApproveListRequest approveListRequest,
              Authentication pr) {
    return listMangementService.approveList(approveListRequest, pr);
  }

  @PostMapping("/edit-list")
  public ResponseEntity<?> editList(@RequestBody AddNewPaymentRequest req,
                                    Authentication pr) {

    return listMangementService.editList(req, pr);
  }

  @PostMapping("/add-list-without-audit")
  public ResponseEntity<?> addListWithoutAudit(@RequestBody String req,
                                               Authentication pr) {
    return listMangementService.addListWithoutAudit(req, pr);
  }

  @GetMapping("/get-list/{ilistid}/tenant-id/{tenantid}")
  public ResponseEntity<?>
  getListMasterDropdown(@PathVariable("ilistid") Integer ilistid,
                        @PathVariable("tenantid") Integer tenantid,
                        Authentication pr) {
    return listMangementService.getlistByIListID(ilistid, tenantid, pr);
  }

  @GetMapping("/get-decision-and-rules/tenant-id/{tenantid}")
  public ResponseEntity<?>
  getDecisionAndRules(Authentication pr,
                      @PathVariable("tenantid") Integer tenantid) {
    return listMangementService.getDecisionAndRules(pr, tenantid);
  }
}
