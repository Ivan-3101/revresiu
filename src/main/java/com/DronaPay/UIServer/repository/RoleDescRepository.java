package com.DronaPay.UIServer.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.DronaPay.UIServer.model.RoleDesc;

@Repository
public interface RoleDescRepository extends JpaRepository<RoleDesc, Integer>  {

	public RoleDesc findByvcRoleNameAndItenantId(String vcRoleName, Integer itenantid);

	public List<RoleDesc> findAllByItenantIdIn(List<Integer> tenantids);

	public List<RoleDesc> findAllByiRoleIDInAndItenantIdIn(List<Integer> roleids, List<Integer> tenantids);

}
