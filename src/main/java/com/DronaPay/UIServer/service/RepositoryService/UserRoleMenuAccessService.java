package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.Views.UserRoleMenuAccess;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.util.UserMapping;

import java.util.List;
import java.util.Map;

public interface UserRoleMenuAccessService {

    public List<UserRoleMenuAccess> findAll();

    public List<UserRoleMenuAccess> findUniqueMenuByWebUserId(int iUserID, Integer iorgid);

    public List<UserRoleMenuAccess> findByWebUserIDAndMenuName(int iUserID, String menuName, Integer iorgid);

    // public MenuPermissions getPermissions(String orgid, WebUser user, String menuName) throws Exception;

    // public MenuPermissions getPermissions(String orgid, List<Integer> reqtenantids, WebUser user, String menuName) throws Exception;

    public MenuPermissions getPermissions(int iUserID, String menuName, Integer iorgid) throws Exception;

    public Map<String, MenuPermissions> getPermissions(int iUserID, Integer iorgid, UserMapping roleIds);
}
