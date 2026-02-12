package com.DronaPay.UIServer.controller.AllocationMapper;

import com.DronaPay.UIServer.requests.AddUserAllocationMapping;
import com.DronaPay.UIServer.requests.GetUserMappingRequest;
import com.DronaPay.UIServer.service.ControllerService.AllocationMapper.AllocationMapperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/v1/testing/allocation-mapper")
public class AllocationMapperController {
    @Autowired
    AllocationMapperService allocationMapperService;

    @GetMapping("/get-group-list-dropdown/tenant-id/{tenantid}")
    public ResponseEntity<?> getListWorkflowGroupDropdown(@PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return allocationMapperService.getListWorkflowGroup(tenantid, pr);
    }

    @GetMapping("/get-users-group-dropdown")
    public ResponseEntity<?> getUsersOfGroup(@RequestParam("groupid") Integer groupid, @RequestParam("tenantid") Integer tenantid, Authentication pr) {
        return allocationMapperService.getUsersOfGroup(groupid, tenantid, pr);
    }

    @GetMapping("/get-mapped-unmapped-users-list")
    public ResponseEntity<?> getMappedUnmappedUsers(@RequestParam("role1groupid") Integer role1groupid,
                                                    @RequestParam("role2groupid") Integer role2groupid, @RequestParam("role2userid") Integer role2userid,
                                                    @RequestParam("workflowid") Integer workflowid,
                                                    @RequestParam("tenantid") Integer tenantid,
                                                    Authentication pr) {
        return allocationMapperService.getMappedUnmappedUsers(role1groupid, role2groupid, role2userid, workflowid, tenantid, pr);
    }

    @PostMapping("/add-user-mapping")
    public ResponseEntity<?> addMapperUser(@RequestBody AddUserAllocationMapping req, Authentication pr) {
        return allocationMapperService.addMappedUser(req, pr);
    }


    @PostMapping("/get-user-mapping/tenant-id/{tenantid}")
    public ResponseEntity<?> getUserMapping(@RequestBody GetUserMappingRequest req, @PathVariable("tenantid") Integer itenantid, Authentication pr) {
        return allocationMapperService.getUserMapping(req, itenantid, pr);
    }
}
