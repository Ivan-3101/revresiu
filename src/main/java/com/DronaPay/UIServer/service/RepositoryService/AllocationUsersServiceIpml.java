package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.requests.GetUserMappingRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.AllocationUsers;
import com.DronaPay.UIServer.model.WebUser;

import java.util.List;
import java.util.stream.Collectors;

import com.DronaPay.UIServer.repository.AllocationUsersRepository;
import com.DronaPay.UIServer.repository.GroupDescRepository;
import com.DronaPay.UIServer.repository.WebUserRepository;
import com.DronaPay.UIServer.repository.WorkflowMastersRepository;



@Service
public class AllocationUsersServiceIpml implements AllocationUsersService {
    @Autowired
    private AllocationUsersRepository allocationUsersRepository;

    @Autowired
    private WebUserRepository webUserRepository;

    @Autowired
    private WorkflowMastersRepository workflowMastersRepository;

    @Autowired
    private GroupDescRepository groupDescRepository;

    @Override
    public List<WebUser> findUser1ByUser2(Integer role1groupid, Integer role2groupid, Integer role2userid,
            Integer workflowid, Integer tenantid, Integer orgid)
            throws Exception {
        // return allocationUsersRepository.findUser1ByUser2(role1groupid, role2groupid,
        // role2userid, workflowid);
        List<AllocationUsers> allocationUsers = allocationUsersRepository
                .findByRole1GroupIDAndRole2GroupIDAndRole2UserIDAndWorkflowIDAndItenantIdAndIorgId(
                        role1groupid,
                        role2groupid,
                        role2userid,
                        workflowid,
                        tenantid,
                        orgid);
        return webUserRepository.findAllByIuserIDInAndIorgId_Iorgid(allocationUsers.stream().map(x -> x.getRole1UserID()).collect(Collectors.toList()),
         orgid);
        // return allocationUsers.stream().map(x -> x.getRole1UserID()).collect(Collectors.toList());
    }

    @Override
    public List<AllocationUsers> saveAll(List<AllocationUsers> usermapping) throws Exception {
        return allocationUsersRepository.saveAll(usermapping);
    }

    @Override
    public void deleteUser1ByUser2(Integer role1groupid, Integer role2groupid, Integer role2userid, Integer workflowid, Integer tenantid, Integer orgid)
            throws Exception {
        allocationUsersRepository
                .deleteAllByRole1GroupIDAndRole2GroupIDAndRole2UserIDAndWorkflowIDAndItenantIdAndIorgId(
                        role1groupid, role2groupid, role2userid, workflowid, tenantid, orgid);
    }

    @Override
    public List<WebUser> findRole2UserByRole1UserAndWorkflow(Integer itenantid, List<String> role1group,
            List<String> role2group, String role1user, String workflow, Integer orgid) throws Exception {

        List<Integer> role1groupids = groupDescRepository.findAllByVcGroupIDInAndItenantId(role1group, itenantid).
        stream().map(x->x.getIgroupID()).toList();
        List<Integer> role2groupids = groupDescRepository.findAllByVcGroupIDInAndItenantId(role2group, itenantid).
        stream().map(x->x.getIgroupID()).toList();
        Integer workflowid = workflowMastersRepository.findByWorkflowKeyAndItenantId_Itenantid(workflow, itenantid).getWorkflowId();
        Integer role1userid = Integer.parseInt(role1user);

        List<AllocationUsers> allocationUsers = allocationUsersRepository
                .findByRole1GroupIDInAndRole2GroupIDInAndRole1UserIDAndWorkflowIDAndItenantIdAndIorgId(
                       role1groupids,
                        role2groupids,
                        role1userid,
                        workflowid,
                        itenantid,
                        orgid);
        
        return webUserRepository.findAllByIuserIDInAndIorgId_Iorgid(allocationUsers.stream().map(x -> x.getRole2UserID()).collect(Collectors.toList()),
         orgid);
        // return allocationUsers.stream().map(al -> al.getRole2UserID()).collect(Collectors.toList());
    }

    @Override
    public List<WebUser> findRole1UserByRole2UserAndWorkflow(Integer itenantid, List<String> role1group,
            List<String> role2group, String role2user, String workflow, Integer orgid) throws Exception {
         List<Integer> role1groupids = groupDescRepository.findAllByVcGroupIDInAndItenantId(role1group, itenantid).
        stream().map(x->x.getIgroupID()).toList();
        List<Integer> role2groupids = groupDescRepository.findAllByVcGroupIDInAndItenantId(role2group, itenantid).
        stream().map(x->x.getIgroupID()).toList();
        Integer workflowid = workflowMastersRepository.findByWorkflowKeyAndItenantId_Itenantid(workflow, itenantid).getWorkflowId();
        Integer role2userid = Integer.parseInt(role2user);

        List<AllocationUsers> allocationUsers = allocationUsersRepository
                .findByRole1GroupIDInAndRole2GroupIDInAndRole2UserIDAndWorkflowIDAndItenantIdAndIorgId(
                        role1groupids,
                        role2groupids,
                        role2userid,
                        workflowid,
                        itenantid,
                        orgid);
        return webUserRepository.findAllByIuserIDInAndIorgId_Iorgid(allocationUsers.stream().map(x -> x.getRole1UserID()).collect(Collectors.toList()),
         orgid);
        // return allocationUsers.stream().map(al -> al.getRole1UserID()).collect(Collectors.toList());
    }

    @Override
    public List<WebUser> findUser1ByGroup1Group2(Integer role1groupid, Integer role2groupid, Integer workflowid, Integer tenantid, Integer orgid)
            throws Exception {
        List<AllocationUsers> allocationUsers = allocationUsersRepository
                .findByRole1GroupIDAndRole2GroupIDAndWorkflowIDAndItenantIdAndIorgId(role1groupid, role2groupid,
                        workflowid, tenantid, orgid);
        return webUserRepository.findAllByIuserIDInAndIorgId_Iorgid(allocationUsers.stream().map(x -> x.getRole1UserID()).collect(Collectors.toList()),
         orgid);
        // return allocationUsers.stream().map(al -> al.getRole1UserID()).collect(Collectors.toList());
    }
}
