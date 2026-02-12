package com.DronaPay.UIServer.service.ControllerService.testing;

import java.util.List;

import com.DronaPay.UIServer.model.MenuStructureDesc;
import com.DronaPay.UIServer.model.RoleDesc;
import com.DronaPay.UIServer.model.RoleMenuAccessMap;
import com.DronaPay.UIServer.util.UserMapping;

public interface RoleMenuAccessMapService {

	public void save(RoleMenuAccessMap roleMenuAccessMap);

	public List<MenuStructureDesc> getListOfMenuUsingRole(List<RoleDesc> roleList);

	public Boolean getIsRoleApprove(UserMapping mapping, String menuName);

}
