package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.WebUser;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface WebUserRepository extends JpaRepository<WebUser, Integer> {

    public WebUser findByvcUserName(String userName);

    @Query("SELECT w.vcUserName FROM WebUser w WHERE w.iuserID = :iuserID")
    public Optional<String> findVcUserNameByIuserID(@Param("iuserID") Integer iuserID);
    
    public WebUser findByIuserID(Integer iuserid);

    public WebUser findByIuserIDAndIorgId_Iorgid(Integer userid, Integer orgid);

    public List<WebUser> findAllByIuserIDInAndIorgId_Iorgid(List<Integer> userid, Integer orgid);

    // @Query("SELECT wu FROM WebUser wu WHERE wu.iStatus.iStatusID = 1 and wu.vcUserName= :username")
    // public WebUser findActiveWebUserByvcUserName(@Param("username") String userName);
    public Optional<WebUser> findByiStatus_iStatusIDAndVcUserNameAndIorgId_VcOrgId(Integer one, String userName, String orgid);

    public Optional<WebUser> findByiStatus_iStatusIDAndIuserID(Integer one, Integer iuserid);

    // @Query("SELECT wu FROM WebUser wu WHERE wu.iStatus.iStatusID = 1 order by wu.dtApproverStamp desc")
    // public List<WebUser> findAllActiveUsers();
    public List<WebUser> findByiStatus_iStatusIDOrderByDtApproverStampDesc(Integer one);
    
    public List<WebUser> findByiStatus_iStatusIDAndIorgId_IorgidOrderByDtApproverStampDesc(Integer one, Integer orgid);

    public List<WebUser> findByVcUserNameIn(List<String> username);

    // public WebUser findByiUserID(int iuserid);

    // @Query("SELECT max(iUserID) FROM WebUser")
    // public Integer findLastIUserID();
    public WebUser findTopByOrderByIuserIDDesc();

    // public WebUser findByVcEmailID(String emailid);

    // @Query("SELECT wu FROM WebUser wu WHERE wu.iStatus.iStatusID = 1 and wu.vcEmailID= :email")
    // public WebUser findActiveEmail(@Param("email") String email);
    public WebUser findByiStatus_iStatusIDAndVcEmailIDAndIorgId_VcOrgId(Integer one, String email, String orgid);

    public WebUser findByResetPasswordToken(String token);

    // @Query("SELECT wu from WebUser as wu join wu.userGroup wg where wg.igroupID = :groupid")
    // public List<WebUser> findByGroupID(@Param("groupid") Integer groupid);

//    public List<WebUser> findByUserGroupIgroupID(Integer groupid);
//
//    public List<WebUser> findByUserGroupVcGroupIDIn(List<String> groupids);
//
//    public List<WebUser> findByUserPermissionsVcRoleName(String rolename);
}
