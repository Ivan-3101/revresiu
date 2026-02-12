package com.DronaPay.UIServer.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.DronaPay.UIServer.model.RoleMenuAccessMap;

@Repository
public interface RoleMenuAccessMapRepository extends JpaRepository<RoleMenuAccessMap, Integer>{

	
	// @Query("SELECT rmam FROM RoleMenuAccessMap rmam WHERE rmam.iRoleID.iRoleID = :roleid")
	// public List<RoleMenuAccessMap> findByRoleId(@Param("roleid") int roleid);

	public List<RoleMenuAccessMap> findByiRoleID(int roleid);
	
	// @Query("SELECT rmam FROM RoleMenuAccessMap rmam WHERE rmam.iMenuID.vcMenuName = :menuname")
	// public List<RoleMenuAccessMap> findByMenuName(@Param("menuname") String menuName);

	public List<RoleMenuAccessMap> findByimenuID_VcMenuName(String menuName);

	public List<RoleMenuAccessMap> findByiRoleIDInAndItenantIdInAndImenuID_VcMenuName(List<Integer> roleid, List<Integer> tenantid, String menuName);
	
}
