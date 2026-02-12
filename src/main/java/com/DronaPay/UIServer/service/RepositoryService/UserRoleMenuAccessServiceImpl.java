package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.Constants.Enum.DronaGodMenu;
import com.DronaPay.UIServer.Views.UserRoleMenuAccess;
import com.DronaPay.UIServer.model.MenuStructureDesc;
import com.DronaPay.UIServer.model.WebuserMapping;
import com.DronaPay.UIServer.repository.UserRoleMenuAccessRepository;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.service.ControllerService.AppUser.AppUserServiceImpl;
import com.DronaPay.UIServer.util.UserMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserRoleMenuAccessServiceImpl implements UserRoleMenuAccessService {

    private static final Logger LOGGER = LoggerFactory.getLogger(UserRoleMenuAccessServiceImpl.class);
    @Autowired
    private UserRoleMenuAccessRepository userRoleMenuAccessRepository;

    @Autowired
    private WebuserMappingService webuserMappingService;

    @Autowired
    private MenuStructureDescService menuStructureDescService;

    public List<UserRoleMenuAccess> findAll() {
        return userRoleMenuAccessRepository.findAll();
    }

    public List<UserRoleMenuAccess> findUniqueMenuByWebUserId(int iUserID, Integer iorgid) {

        // List<UserRoleMenuAccess> rmamlist =
        // userRoleMenuAccessRepository.findByWebUserId(iUserID);
        List<UserRoleMenuAccess> rmamlist = userRoleMenuAccessRepository.findByiUserIDAndIorgId(iUserID, iorgid);
        List<UserRoleMenuAccess> res = new ArrayList<UserRoleMenuAccess>();
        List<Integer> menuidlist = new ArrayList<>();
        for (UserRoleMenuAccess rmam : rmamlist) {
            if (!menuidlist.contains(rmam.getIMenuID())) {
                menuidlist.add(rmam.getIMenuID());
                res.add(rmam);

            }
        }
        return res;
    }

    public List<UserRoleMenuAccess> findByWebUserIDAndMenuName(int iUserID, String menuName, Integer iorgid) {

        // return userRoleMenuAccessRepository.findByWebUserIDAndMenuName(iUserID,
        // menuName);
        return userRoleMenuAccessRepository.findByiUserIDAndVcMenuNameAndIorgId(iUserID, menuName, iorgid);
    }

    public MenuPermissions getPermissions(int iUserID, String menuName, Integer iorgid) throws Exception {
        // List<UserRoleMenuAccess> lMenu =
        // userRoleMenuAccessRepository.findByWebUserIDAndMenuName(iUserID, menuName);
        List<UserRoleMenuAccess> lMenu = userRoleMenuAccessRepository.findByiUserIDAndVcMenuNameAndIorgId(iUserID, menuName, iorgid);
        MenuPermissions mp = new MenuPermissions();

        for (UserRoleMenuAccess urma : lMenu) {
            if (urma.getBAdd()) {
                mp.setAdd(true);
            }

            if (urma.getBApprove()) {
                mp.setApprove(true);
            }
            if (urma.getBDelete()) {
                mp.setDelete(true);
            }

            if (urma.getBedit()) {
                mp.setEdit(true);
            }
            if (urma.getBPublish()) {
                mp.setPublish(true);
            }
            if (urma.getBView()) {
                mp.setView(true);
            }
        }
        return mp;
    }


    public Map<String, MenuPermissions> getPermissions(int iUserID, Integer iorgid, UserMapping roleIds) {

        Map<String, MenuPermissions> res = new HashMap<>();

        List<MenuStructureDesc> allMenus = menuStructureDescService.findAll();

        for (MenuStructureDesc menu : allMenus) {
            MenuPermissions defaultPermissions = new MenuPermissions();
            defaultPermissions.setAdd(false);
            defaultPermissions.setApprove(false);
            defaultPermissions.setDelete(false);
            defaultPermissions.setEdit(false);
            defaultPermissions.setPublish(false);
            defaultPermissions.setView(false);
            res.put(menu.getVcMenuName(), defaultPermissions);
        }


        if (roleIds.getMappingIds().getFirst() == 0) {
            for (DronaGodMenu allowedMenu : DronaGodMenu.values()) {
                MenuPermissions mp = res.get(allowedMenu.getDisplayName());
                mp.setAdd(true);
                mp.setApprove(true);
                mp.setDelete(true);
                mp.setEdit(true);
                mp.setPublish(true);
                mp.setView(true);

                res.put(allowedMenu.getDisplayName(), mp);
            }
        }else{
            List<UserRoleMenuAccess> listMenu = userRoleMenuAccessRepository.findByiUserIDAndIorgId(iUserID, iorgid);

            Map<String, List<UserRoleMenuAccess>> temp = listMenu.stream()
                    .collect(
                            Collectors.groupingBy(UserRoleMenuAccess::getVcMenuName)
                    );

            Set<String> listmenuname = temp.keySet();


            listmenuname.forEach(menuname ->
            {
                List<UserRoleMenuAccess> lMenu = temp.get(menuname);

                MenuPermissions mp = res.get(menuname);

                for (UserRoleMenuAccess urma : lMenu) {


                    if (urma.getBAdd()) {
                        mp.setAdd(true);
                    }

                    if (urma.getBApprove()) {
                        mp.setApprove(true);
                    }

                    if (urma.getBDelete()) {
                        mp.setDelete(true);
                    }

                    if (urma.getBedit()) {
                        mp.setEdit(true);
                    }

                    if (urma.getBPublish()) {
                        mp.setPublish(true);
                    }

                    if (urma.getBView()) {
                        mp.setView(true);
                    }

                }
                res.put(menuname, mp);

            });
        }

        //System.out.println(res);

        return res;

    }

    // @Override
    // public MenuPermissions getPermissions(String orgid, List<Integer> reqtenantids, WebUser user, String menuName)
    // 		throws Exception {
    // 	String userOrg = user.getIorgId().getVcOrgId();
    // 	if (userOrg.equals(MultiTenant.adminOrg)) {
    // 		return getPermissions(user.getIuserID(), menuName);
    // 	} else if ((userOrg.equals(orgid)) &&
    // 			user.getUserTenant().stream()
    // 					.filter(tid -> reqtenantids.contains(tid))
    // 					.collect(Collectors.toList()).size() == reqtenantids.size()) {
    // 		return getPermissions(user.getIuserID(), menuName);
    // 	} else {
    // 		return new MenuPermissions();
    // 	}
    // }

    // @Override
    // public MenuPermissions getPermissions(String orgid, WebUser user, String menuName) throws Exception {
    // 	String userOrg = user.getIorgId().getVcOrgId();
    // 	if (userOrg.equals(MultiTenant.adminOrg) || userOrg.equals(orgid)) {
    // 		return getPermissions(user.getIuserID(), menuName);
    // 	} else {
    // 		return new MenuPermissions();
    // 	}
    // }

}
