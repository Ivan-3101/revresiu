package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.Enum.WebuserMappingType;
import com.DronaPay.UIServer.Constants.MultiTenant;
import com.DronaPay.UIServer.exception.NotFoundException;
import com.DronaPay.UIServer.model.RoleDesc;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.model.WebuserMapping;
import com.DronaPay.UIServer.model.WebuserMappingAudit;
import com.DronaPay.UIServer.repository.*;
import com.DronaPay.UIServer.response.ApiResponse;
import jakarta.transaction.Transactional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class WebUserServiceImpl implements WebUserService, UserDetailsService {

    private static final Logger LOGGER = LoggerFactory.getLogger(WebUserServiceImpl.class);

    @Autowired
    private WebUserRepository webUserRepository;

    @Autowired
    private UserRoleMenuAccessService userRoleMenuAccessService;

    @Autowired
    private WebuserMappingService webuserMappingService;
    @Autowired
    private GroupDescRepository groupDescRepository;
    @Autowired
    private RoleDescRepository roleDescRepository;

    @Autowired
    private WebuserMappingRepository webuserMappingRepository;

    @Autowired
    private WebuserMappingAuditRepository webuserMappingAuditRepository;

    @Autowired
    private WorkflowMasterService workflowMasterService;

    @Autowired
    private TenantRepositoryService tenantRepositoryService;

    @Autowired
    private PasswordHistoryService passwordHistoryService;

    @Override
    public WebUser loadUserByUsername(String username) {
        // WebUser user = webUserRepository.findActiveWebUserByvcUserName(username);

        return webUserRepository.findByiStatus_iStatusIDAndIuserID(1, Integer.parseInt(username))
                .orElseThrow(() -> new NotFoundException("failed to find user with username " + username, username));
    }

    public WebUser findByUsername(String username, String orgid) {
        return webUserRepository.findByiStatus_iStatusIDAndVcUserNameAndIorgId_VcOrgId(1, username, orgid).orElseThrow(() -> new NotFoundException("failed to find user with username " + username, username));
    }

    public Optional<WebUser> findByUsernameAndOrgId(String username, String orgid) {
        return webUserRepository.findByiStatus_iStatusIDAndVcUserNameAndIorgId_VcOrgId(1, username, orgid);
    }

    public WebUser findByUsernameForLogin(String username, String orgid) {
        return webUserRepository.findByiStatus_iStatusIDAndVcUserNameAndIorgId_VcOrgId(1, username, orgid).orElseThrow(() -> new NotFoundException("Please Enter Valid Credentials", username, "INFO"));
    }

    // public UserAndPermissions getUserAndPermissions(String username, String
    // menuName) throws Exception {
    //
    // UserAndPermissions userAndPermissions = new UserAndPermissions();
    // userAndPermissions.setUser(loadUserByUsername(username));
    // userAndPermissions.setPermissions(
    // userRoleMenuAccessService.getPermissions(userAndPermissions.getUser().getIuserID(),
    // menuName));
    // return userAndPermissions;
    // }


    public WebUser findActiveWebUserByvcUserName(String username, String orgid) throws Exception {
        // return webUserRepository.findActiveWebUserByvcUserName(username);
        return webUserRepository.findByiStatus_iStatusIDAndVcUserNameAndIorgId_VcOrgId(1, username, orgid).orElse(null);
    }

    @Override
    @Cacheable(value = "USERS", key = "#userid", unless = "#result == null")
    public String findByIUserID(String userid) {
        Integer iuserid;
        try {
            iuserid = Integer.parseInt(userid);
        } catch (Exception e) {
            return userid;
        }

        return webUserRepository.findVcUserNameByIuserID(iuserid).orElse(userid);
        // return webUserRepository.findByiUserID(iuserid);
    }

    public void save(WebUser wua) throws Exception {
        webUserRepository.save(wua);
    }

    public ApiResponse save(WebUser wua, String word) throws Exception{
        ApiResponse historyResponse = passwordHistoryService.handlePasswordHistory(wua, false, word);
        if (!historyResponse.getSuccess()) {
            return historyResponse;
        }
        try {
            webUserRepository.save(wua);
            return new ApiResponse(true, "User saved successfully.", HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error("Error saving user {}", wua.getIuserID(), e);
            return new ApiResponse(false, "Failed to save user. Please try again.", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public List<WebUser> findAllActiveUsers() throws Exception {
        // return webUserRepository.findAllActiveUsers();
        return webUserRepository.findByiStatus_iStatusIDOrderByDtApproverStampDesc(1);
    }

    public Integer findLastIUserId() throws Exception {
        // return webUserRepository.findLastIUserID();
        return webUserRepository.findTopByOrderByIuserIDDesc().getIuserID();
    }

    // public WebUser findByEmail(String emailid) throws Exception {
    //
    // return webUserRepository.findByVcEmailID(emailid);
    // }

    public WebUser findActiveEmail(String emailid, String vcorgid) throws Exception {
        return webUserRepository.findByiStatus_iStatusIDAndVcEmailIDAndIorgId_VcOrgId(1, emailid, vcorgid);
    }

    @Override
    public WebUser findByToken(String token) throws Exception {
        return webUserRepository.findByResetPasswordToken(token);
    }

    @Override
    public List<WebUser> findByGroupID(Integer groupid, Integer tenantid, Integer iorgid) {
        // return webUserRepository.findByGroupID(groupid);

        List<WebuserMapping> wbMapping = webuserMappingRepository.findAllByMappingIDAndMappingTypeAndItenantId(groupid,
                String.valueOf(WebuserMappingType.Group), tenantid);

        List<Integer> userids = wbMapping.stream().map(wb -> wb.getWebuserID()).toList();

        List<WebUser> wbList = webUserRepository.findAllByIuserIDInAndIorgId_Iorgid(userids, iorgid);
        return wbList.stream().filter(wl -> {
            if (wl.getIStatus() != null) {
                if (wl.getIStatus().getIStatusID() == 1) {
                    return true;
                } else {
                    return false;
                }
            } else {
                return false;
            }
        }).collect(Collectors.toList());
    }

    // @Override
    // public List<WebUser> findByVcGroupIDs(List<String> groupids) {
    // List<Integer> group_id_list =
    // groupDescRepository.findAllByVcGroupIDIn(groupids).stream()
    // .map(a -> a.getIgroupID()).collect(Collectors.toList());
    // List<WebUser> wbList =
    // webuserMappingService.findGroupByIDs(group_id_list).stream().map(a ->
    // a.getWebuserID())
    // .collect(Collectors.toList());
    // return wbList.stream().filter(wl -> {
    // if (wl.getIStatus() != null) {
    // if (wl.getIStatus().getIStatusID() == 1) {
    // return true;
    // } else {
    // return false;
    // }
    // } else {
    // return false;
    // }
    // }).collect(Collectors.toList());
    // }

    @Override
    public List<WebUser> findByVcGroupIDsTenant(List<String> groupids, Integer tenantid) {
        List<Integer> group_id_list = groupDescRepository.findAllByVcGroupIDInAndItenantId(groupids, tenantid)
                .stream()
                .map(a -> a.getIgroupID()).collect(Collectors.toList());

        List<WebuserMapping> wbMapping = webuserMappingRepository.findAllByMappingIDInAndMappingTypeAndItenantId(
                group_id_list, String.valueOf(WebuserMappingType.Group), tenantid);

        List<Integer> userids = wbMapping.stream().map(wb -> wb.getWebuserID()).toList();

        if (wbMapping.size() > 0) {
            List<WebUser> wbList = webUserRepository.findAllByIuserIDInAndIorgId_Iorgid(userids,
                    wbMapping.get(0).getIorgId());
            return wbList.stream().filter(wl -> {
                if (wl.getIStatus() != null) {
                    if (wl.getIStatus().getIStatusID() == 1) {
                        return true;
                    } else {
                        return false;
                    }
                } else {
                    return false;
                }
            }).collect(Collectors.toList());
        } else {
            return new ArrayList<>();
        }
    }

    @Override
    public List<WebUser> findByRoleName(String rolename, Integer tenantid) {
        RoleDesc role = roleDescRepository.findByvcRoleNameAndItenantId(rolename, tenantid);
        Integer i_role_id = role.getIRoleID();

        Integer orgId = tenantRepositoryService.findByItenantId(role.getItenantId()).getItenantid();
        List<Integer> wbListInt = webuserMappingService.findRoleByID(i_role_id).stream().map(a -> {
            return a.getWebuserID();
        }).collect(Collectors.toList());

        List<WebUser> wbList = webUserRepository.findAllByIuserIDInAndIorgId_Iorgid(wbListInt, orgId);
        return wbList.stream().filter(wl -> {
            if (wl.getIStatus() != null) {
                if (wl.getIStatus().getIStatusID() == 1) {
                    return true;
                } else {
                    return false;
                }
            } else {
                return false;
            }
        }).collect(Collectors.toList());
    }

    @Override
    public List<WebUser> findAllByUsername(List<String> username) throws Exception {
        return webUserRepository.findByVcUserNameIn(username);
    }

    @Override
    public List<WebUser> findAllActiveUsers(String org, LoggedUser loggedUser) throws Exception {
        // if admin org, fetch all users
        // else extract tenants mapped to this username and fetch list of all users
        // mapped to these tenants
        if (org.equals(MultiTenant.adminOrg)) {
            return findAllActiveUsers();
        } else {
            WebUser user = loggedUser.getWebUser();
            List<Integer> tenantids = loggedUser.getUserTenant();
            Integer iorgid = user.getIorgId().getIorgid();
            List<WebUser> userEntries = webUserRepository
                    .findByiStatus_iStatusIDAndIorgId_IorgidOrderByDtApproverStampDesc(1, iorgid);
            Map<Integer, WebUser> userEntriesMap = new HashMap<>();
            List<Integer> userEntriesInt = userEntries.stream().map(us -> {
                userEntriesMap.put(us.getIuserID(), us);
                return us.getIuserID();
            }).toList();

            Map<Integer, List<WebuserMapping>> matchingUsers = webuserMappingRepository
                    .findAllByMappingTypeAndWebuserIDInAndIorgId(String.valueOf(WebuserMappingType.Tenant),
                            userEntriesInt, iorgid)
                    .stream()
                    .collect(Collectors.groupingBy(WebuserMapping::getWebuserID));

            List<Integer> acceptUsersInt = webuserMappingRepository
                    .findAllByMappingIDInAndMappingTypeAndWebuserIDInAndIorgId(tenantids,
                            String.valueOf(WebuserMappingType.Tenant), userEntriesInt, iorgid)
                    .stream()
                    .map(wbmp -> wbmp.getWebuserID())
                    .collect(Collectors.groupingByConcurrent(Function.identity(), Collectors.counting()))
                    .entrySet()
                    .stream()
                    .filter(wbmp -> (matchingUsers.get(wbmp.getKey()).size() == wbmp.getValue()))
                    .map(wbmp -> wbmp.getKey())
                    .collect(Collectors.toList());

            return acceptUsersInt.stream().map(id -> userEntriesMap.get(id)).toList();

        }
    }

    @Override
    public List<WebUser> findAllActiveUsersTenant(Integer tenant, Integer iorgid) throws Exception {
        // int tentCount = tenants.size();

        List<Integer> matchingUsers = webuserMappingRepository
                .findAllByMappingIDAndMappingType(tenant, String.valueOf(WebuserMappingType.Tenant))
                .stream()
                .map(wb -> wb.getWebuserID())
                .distinct()
                .toList();

        return webUserRepository.findAllByIuserIDInAndIorgId_Iorgid(matchingUsers, iorgid);

    }

    @Override
    public WebUser findByUserOrgId(Integer iuserid, Integer orgid) {
        return webUserRepository.findByIuserIDAndIorgId_Iorgid(iuserid, orgid);
    }

    @Override
    @Transactional
    // @CacheEvict(value="USERS", key="#wua.iuserID")
    public WebUser save(WebUser wua, Integer iuserauditid) throws Exception {
        boolean isNewUser = (wua.getIuserID() == 0);

        WebUser wu = webUserRepository.save(wua);

        webuserMappingRepository.deleteAllByWebuserIDAndIorgId(wu.getIuserID(), wu.getIorgId().getIorgid());
        List<WebuserMappingAudit> auditList = webuserMappingAuditRepository
                .findAllByWebUserAuditIDAndIorgId(iuserauditid, wua.getIorgId().getIorgid());
        List<WebuserMapping> webuser_mapping_list = auditList
                .stream()
                .map(a -> {
                    WebuserMapping res = new WebuserMapping();
                    res.setMappingID(a.getMappingID());
                    res.setMappingType(a.getMappingType());
                    res.setWebuserID(wu.getIuserID());
                    res.setIorgId(wu.getIorgId().getIorgid());
                    res.setItenantId(a.getItenantId());
                    return res;
                }).collect(Collectors.toList());

        webuserMappingRepository.saveAll(webuser_mapping_list);

        if (isNewUser) {
            passwordHistoryService.handlePasswordHistory(wu, isNewUser, "");
        }

        return wu;
    }

}
