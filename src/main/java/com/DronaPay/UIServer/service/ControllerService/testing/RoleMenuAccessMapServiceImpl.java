package com.DronaPay.UIServer.service.ControllerService.testing;

import java.util.ArrayList;
import java.util.List;

import com.DronaPay.UIServer.repository.RoleMenuAccessMapRepository;
import com.DronaPay.UIServer.util.UserMapping;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.MenuStructureDesc;
import com.DronaPay.UIServer.model.RoleDesc;
import com.DronaPay.UIServer.model.RoleMenuAccessMap;

@Service
public class RoleMenuAccessMapServiceImpl implements RoleMenuAccessMapService {

	@Autowired
	private RoleMenuAccessMapRepository roleMenuAccessMapRepository;

	public void save(RoleMenuAccessMap roleMenuAccessMap) {
		roleMenuAccessMapRepository.save(roleMenuAccessMap);
	}

	public List<MenuStructureDesc> getListOfMenuUsingRole(List<RoleDesc> roleList) {
		List<RoleMenuAccessMap> rmamlist = new ArrayList<RoleMenuAccessMap>();

		//roleList.stream().map(m -> rmamlist.addAll(roleMenuAccessMapRepository.findByRoleId(m.getIRoleID())));
		roleList.stream().map(m -> rmamlist.addAll(roleMenuAccessMapRepository.findByiRoleID(m.getIRoleID())));

//        for(RoleDesc role: roleList) {
//            rmamlist.addAll(roleMenuAccessMapRepository.findByRoleId(role.getIRoleID()));
//        }

		List<MenuStructureDesc> res = new ArrayList<MenuStructureDesc>();

		rmamlist.stream().filter(m -> !res.contains(m.getImenuID())).map(m -> res.add(m.getImenuID()));
//        for(RoleMenuAccessMap rmam: rmamlist)
//        {
//            if(!res.contains(rmam.getIMenuID()))
//            {
//                res.add(rmam.getIMenuID());
//            }
//        }
		return res;

	}

	@Override
	public Boolean getIsRoleApprove(UserMapping mapping, String menuName) {
		List<RoleMenuAccessMap> roleAccessList = roleMenuAccessMapRepository.findByiRoleIDInAndItenantIdInAndImenuID_VcMenuName(mapping.getMappingIds(), mapping.getTenantids(), menuName);
		return roleAccessList.stream().anyMatch(rl->rl.isBApprove());
	}
}
