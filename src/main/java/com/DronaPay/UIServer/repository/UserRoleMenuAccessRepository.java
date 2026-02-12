package com.DronaPay.UIServer.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.DronaPay.UIServer.Views.UserRoleMenuAccess;

@Repository
public interface UserRoleMenuAccessRepository extends JpaRepository<UserRoleMenuAccess, Integer> {

//	public List<UserRoleMenuAccess> findAll();

	// @Query("SELECT u FROM UserRoleMenuAccess u WHERE u.iUserID = :iuserid")
	// public List<UserRoleMenuAccess> findByWebUserId(@Param("iuserid") Integer iUserID);

	public List<UserRoleMenuAccess> findByiUserIDAndIorgId(Integer iUserID, Integer orgid);
	
	// @Query("SELECT u FROM UserRoleMenuAccess u WHERE u.iUserID = :iuserid AND u.vcMenuName = :menuname" )
	// public List<UserRoleMenuAccess> findByWebUserIDAndMenuName(@Param("iuserid") Integer iUserID, @Param("menuname") String menuName);
	
	public List<UserRoleMenuAccess> findByiUserIDAndVcMenuNameAndIorgId(Integer iUserID, String menuName, Integer iorgid);

}
