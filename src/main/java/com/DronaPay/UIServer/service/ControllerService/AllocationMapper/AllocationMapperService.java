package com.DronaPay.UIServer.service.ControllerService.AllocationMapper;


import com.DronaPay.UIServer.requests.AddUserAllocationMapping;
import com.DronaPay.UIServer.requests.GetUserMappingRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

public interface AllocationMapperService {
    public ResponseEntity<?> getListWorkflowGroup(Integer tenantid, Authentication pr);

    public ResponseEntity<?> getUsersOfGroup(Integer groupid, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getMappedUnmappedUsers(Integer role1groupid, Integer role2groupid, Integer role2userid,
                                                    Integer workflowid, Integer tenantid,
                                                    Authentication pr);

    public ResponseEntity<?> addMappedUser(AddUserAllocationMapping req, Authentication pr);

    public ResponseEntity<?> getUserMapping(GetUserMappingRequest req, Integer itenantid, Authentication pr);
}
