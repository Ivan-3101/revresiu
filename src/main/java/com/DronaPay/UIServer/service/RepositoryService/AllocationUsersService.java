package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.AllocationUsers;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.requests.GetUserMappingRequest;

import java.util.List;

public interface AllocationUsersService {
    public List<WebUser> findUser1ByUser2(Integer role1groupid, Integer role2groupid, Integer role2userid,
            Integer workflowid, Integer tenantid, Integer orgid)
            throws Exception;

    public List<WebUser> findUser1ByGroup1Group2(Integer role1groupid, Integer role2groupid, Integer workflowid, Integer tenantid, Integer orgid) throws Exception;
    
    public List<AllocationUsers> saveAll(List<AllocationUsers> usermapping) throws Exception;

    public void deleteUser1ByUser2(Integer role1groupid, Integer role2groupid, Integer role2userid,
            Integer workflowid, Integer tenantid, Integer orgid)
            throws Exception;

    public List<WebUser> findRole1UserByRole2UserAndWorkflow(Integer itenantid, List<String> role1group, List<String> role2group, String role2user, String workflow, Integer orgid) throws Exception;
    
    public List<WebUser> findRole2UserByRole1UserAndWorkflow(Integer itenantid, List<String> parentgroup, List<String> childgroup, String role1user, String workflow, Integer orgid) throws Exception;
}
