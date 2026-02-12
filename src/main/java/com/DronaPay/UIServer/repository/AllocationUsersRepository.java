package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.CompositeKey.AllocationUsersKey;
import com.DronaPay.UIServer.model.AllocationUsers;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AllocationUsersRepository extends JpaRepository<AllocationUsers, AllocationUsersKey> {
        // @Query("SELECT au.role1UserID FROM AllocationUsers au WHERE
        // au.role1GroupID.iGroupID=:role1groupid and " +
        // "au.role2UserID.iUserID=:role2userid and
        // au.role2GroupID.iGroupID=:role2groupid and
        // au.workflowID.workflowId=:workflowid")
        // public List<WebUser> findUser1ByUser2(@Param("role1groupid") Integer
        // role1groupid,
        // @Param("role2groupid") Integer role2groupid, @Param("role2userid") Integer
        // role2userid,
        // @Param("workflowid") Integer workflowid);

        public List<AllocationUsers> findByRole1GroupIDAndRole2GroupIDAndWorkflowIDAndItenantIdAndIorgId(
                        Integer role1groupid,
                        Integer role2groupid,
                        Integer workflowid,
                        Integer tenantid,
                        Integer orgid);

        public List<AllocationUsers> findByRole1GroupIDAndRole2GroupIDAndRole2UserIDAndWorkflowIDAndItenantIdAndIorgId(
                        Integer role1groupid,
                        Integer role2groupid,
                        Integer role2userid,
                        Integer workflowid,
                        Integer tenantid,
                        Integer orgid);

        // @Query(value = "DELETE FROM AllocationUsers au WHERE
        // au.role1GroupID.iGroupID=:role1groupid and " +
        // "au.role2UserID.iUserID=:role2userid and
        // au.role2GroupID.iGroupID=:role2groupid and
        // au.workflowID.workflowId=:workflowid")
        // @Modifying
        // @Transactional
        // public void deleteUser1ByUser2(@Param("role1groupid") Integer role1groupid,
        // @Param("role2groupid") Integer role2groupid,
        // @Param("role2userid") Integer role2userid, @Param("workflowid") Integer
        // workflowid);

        @Transactional
        public void deleteAllByRole1GroupIDAndRole2GroupIDAndRole2UserIDAndWorkflowIDAndItenantIdAndIorgId(
                        Integer role1groupid,
                        Integer role2groupid,
                        Integer role2userid,
                        Integer workflowid,
                        Integer tenantid,
                        Integer orgid);

        // @Query("SELECT au FROM AllocationUsers au WHERE
        // au.role1GroupID.vcGroupID=:parantgroupid and " +
        // "au.role1UserID.vcUserName=:paraenuserid and
        // au.role2GroupID.vcGroupID=:role2groupid and
        // au.workflowID.workflowName=:workflow")
        // public List<AllocationUsers>
        // findByGroupIDAndParentUserAndWorkflow(@Param("parantgroupid") String
        // paraentgroupid,
        // @Param("role2groupid") String role2groupid,
        // @Param("paraenuserid") String paraenuserid,
        // @Param("workflow") String workflow);

        public List<AllocationUsers> findByRole1GroupIDInAndRole2GroupIDInAndRole1UserIDAndWorkflowIDAndItenantIdAndIorgId(
                        List<Integer> role1groupid,
                        List<Integer> role2groupid,
                        Integer role1userid,
                        Integer workflowid,
                        Integer tenantid,
                        Integer orgid);

        public List<AllocationUsers> findByRole1GroupIDInAndRole2GroupIDInAndRole2UserIDAndWorkflowIDAndItenantIdAndIorgId(
                        List<Integer> role1groupid,
                        List<Integer> role2groupid,
                        Integer role2userid,
                        Integer workflowid,
                        Integer tenantid,
                        Integer orgid);
}