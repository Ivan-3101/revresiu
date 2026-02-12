package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.response.ApiResponse;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.List;
import java.util.Optional;

public interface WebUserService {

    public WebUser loadUserByUsername(String username) throws UsernameNotFoundException;


    public String findByIUserID(String iuserid);

    public WebUser findByUserOrgId(Integer iuserid, Integer orgid);

    public WebUser findByUsername(String username, String orgid);

    public Optional<WebUser> findByUsernameAndOrgId(String username, String orgid);

    public WebUser findByUsernameForLogin(String username, String orgid);

    public List<WebUser> findAllByUsername(List<String> username) throws Exception;

//    public UserAndPermissions getUserAndPermissions(String username, String menuName) throws Exception;

    public WebUser findActiveWebUserByvcUserName(String username, String vcorgid) throws Exception;


    public void save(WebUser wua) throws Exception;

    public ApiResponse save(WebUser wua, String word) throws Exception;

    public WebUser save(WebUser wua, Integer iuserauditid) throws Exception;

    public List<WebUser> findAllActiveUsersTenant(Integer tenantid, Integer iorgid) throws Exception;

    public List<WebUser> findAllActiveUsers() throws Exception;

    public List<WebUser> findAllActiveUsers(String org, LoggedUser user) throws Exception;

    public Integer findLastIUserId() throws Exception;

    // public WebUser findByEmail(String emailid) throws Exception;

    public WebUser findActiveEmail(String emailid, String vcorgid) throws Exception;

    public WebUser findByToken(String token) throws Exception;

    public List<WebUser> findByGroupID(Integer groupid, Integer tenantid, Integer orgid) throws Exception;

    // public List<WebUser> findByVcGroupIDs(List<String> groupids) throws Exception;

    public List<WebUser> findByVcGroupIDsTenant(List<String> groupids, Integer tenant) throws Exception;

    public List<WebUser> findByRoleName(String rolename, Integer tenantid) throws Exception;

}
