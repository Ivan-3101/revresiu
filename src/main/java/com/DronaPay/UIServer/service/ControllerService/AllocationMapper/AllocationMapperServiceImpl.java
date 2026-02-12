package com.DronaPay.UIServer.service.ControllerService.AllocationMapper;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.ResponseVO.DropDownVo;
import com.DronaPay.UIServer.ResponseVO.UserAndPermissions;
import com.DronaPay.UIServer.ResponseVO.UserEntryVO;
import com.DronaPay.UIServer.VOMapper.DropDownVoMapper;
import com.DronaPay.UIServer.VOMapper.UserEntryVOMapper;
import com.DronaPay.UIServer.model.AllocationUsers;
import com.DronaPay.UIServer.model.GroupDesc;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.model.WorkflowMasters;
import com.DronaPay.UIServer.requests.AddUserAllocationMapping;
import com.DronaPay.UIServer.requests.GetUserMappingRequest;
import com.DronaPay.UIServer.response.AllocationMapperResponse;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.response.UserMappingResponse;
import com.DronaPay.UIServer.service.CamundaService;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.AllUsersMapping;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.DronaPay.UIServer.util.WebuserMappingUtil;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.ClientResponse;

import java.util.*;

@Service
public class AllocationMapperServiceImpl implements AllocationMapperService {
    private static final Logger LOGGER = LoggerFactory.getLogger(AllocationMapperServiceImpl.class);
    final String menu_name = MenuNames.allocationMapper;
    @Autowired
    private ActivityLogService activityLogService;
    @Autowired
    private WebUserService webUserService;
    @Autowired
    private WorkflowMasterService workflowMasterRepositoryService;
    @Autowired
    private GroupDescService groupDescService;
    @Autowired
    private WorkflowMasterService workflowMasterService;
    @Autowired
    private AllocationUsersService allocationUsersService;
    @Autowired
    private CamundaService camundaService;
    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Autowired
    private TenantRepositoryService tenantRepositoryService;

    @Autowired
    private WebuserMappingUtil webuserMappingUtil;

    @Override
    public ResponseEntity<?> getListWorkflowGroup(Integer tenantid, Authentication pr) {
        LOGGER.debug("entered in class " + AllocationMapperServiceImpl.class
                + " in method getListWorkflowGroup");
        List<Integer> tenants = Arrays.asList(tenantid);
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView() && loggedUser.allowTenants(tenants)) {
            AllocationMapperResponse allocationMapperResponse = new AllocationMapperResponse();
            allocationMapperResponse.setAdd(mp.isAdd());
            allocationMapperResponse.setView(mp.isView());
            allocationMapperResponse.setApprove(mp.isApprove());
            allocationMapperResponse.setEdit(mp.isEdit());
            allocationMapperResponse.setDelete(mp.isDelete());
            // List<DropDownVo> workflowList;
            try {
                // workflowList = DropDownVoMapper
                // .parseWorkflow(workflowMasterRepositoryService.findAll());
                List<DropDownVo> groupList = DropDownVoMapper.parseGroup(groupDescService.findAllByTenantIds(tenants));
                // allocationMapperResponse.setListWorkflow(workflowList);
                allocationMapperResponse.setListGroups(groupList);
            } catch (Exception e) {
                LOGGER.debug("Caught exception while fetching workflow list or group list");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "error while fetching workflow or group list"),
                        HttpStatus.PARTIAL_CONTENT);
            }

            LOGGER.debug("Exiting getListWorkflowGroup Method in " + AllocationMapperServiceImpl.class
                    + " class with response : with workflow list dropdown");
            activityLogService.addActivity(loggedInUser, "workflow and group list drop down accessed",
                    "Parameters : " + allocationMapperResponse.toString());
            return ResponseEntity.ok(allocationMapperResponse);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access workflow list");
            LOGGER.debug("Exiting getListWorkflows Method in " +
                    AllocationMapperServiceImpl.class
                    + " class with response : unauthorized to access workflow list");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access workflow list"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getUsersOfGroup(Integer groupid, Integer tenantid, Authentication pr) {
        LOGGER.debug("entered in class " + AllocationMapperServiceImpl.class
                + " in method getUsersofGroup");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            List<DropDownVo> responses = new ArrayList<DropDownVo>();
            try {
            
                responses = DropDownVoMapper
                        .parseWebUser(webUserService.findByGroupID(groupid, tenantid, loggedInUser.getIorgId().getIorgid()));
            } catch (Exception e) {
                // TODO Auto-generated catch block
                LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString()) + "\nParam : "
                        + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            return ResponseEntity.ok(responses);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access users list");
            LOGGER.debug("Exiting getListWorkflows Method in " +
                    AllocationMapperServiceImpl.class
                    + " class with response : unauthorized to access users list");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access users list"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getMappedUnmappedUsers(Integer role1groupid, Integer role2groupid, Integer role2userid,
            Integer workflowid, Integer tenantid,
            Authentication pr) {
        LOGGER.debug("entered in class " + AllocationMapperServiceImpl.class
                + " in method getUsersofGroup");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            UserMappingResponse response = new UserMappingResponse();
            try {
                
                List<UserEntryVO> unmappedUsers = UserEntryVOMapper.parseWebUser(
                        webUserService.findByGroupID(role1groupid, tenantid, loggedInUser.getIorgId().getIorgid()));

                List<UserEntryVO> mappedToAny = UserEntryVOMapper.parseWebUser(
                        allocationUsersService.findUser1ByGroup1Group2(role1groupid, role2groupid, workflowid, tenantid, loggedInUser.getIorgId().getIorgid()));
                // first find all users, then delete mapped users to any parent from list

                for (UserEntryVO vMUser : mappedToAny) {
                    unmappedUsers.remove(vMUser);
                }

                response.setUnmappedUsers(unmappedUsers);
                List<UserEntryVO> mappedUsers = UserEntryVOMapper.parseWebUser(
                        allocationUsersService.findUser1ByUser2(role1groupid, role2groupid,
                                role2userid, workflowid, tenantid, loggedInUser.getIorgId().getIorgid()));
                response.setMappedUsers(mappedUsers);

            } catch (Exception e) {
                // TODO Auto-generated catch block
                LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString()) + "\nParam : "
                        + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            return ResponseEntity.ok(response);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access mapping list");
            LOGGER.debug("Exiting getUser1ByUser2 Method in " +
                    AllocationMapperServiceImpl.class
                    + " class with response : unauthorized to access mapping list");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access mapping list"),
                    HttpStatus.FORBIDDEN);

        }
    }

    @Override
    public ResponseEntity<?> addMappedUser(AddUserAllocationMapping req, Authentication pr) {
        LOGGER.debug("entered in class " + AllocationMapperServiceImpl.class
                + " in method addMappedUser");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isAdd() && loggedUser.allowWorkflowId(req.getWorkflowid())) {
            List<AllocationUsers> usermappingList = new ArrayList<AllocationUsers>();
            for (Integer role1UserID : req.getRole1userids()) {
                AllocationUsers usermapping = new AllocationUsers();
                usermapping.setRole1UserID(role1UserID);
                usermapping.setRole2UserID(req.getRole2userid());
                usermapping.setRole1GroupID(req.getRole1groupid());
                usermapping.setRole2GroupID(req.getRole2groupid());
                usermapping.setWorkflowID(req.getWorkflowid());
                usermapping.setItenantId(req.getItenantId());
                usermapping.setIorgId(loggedInUser.getIorgId().getIorgid());
                usermappingList.add(usermapping);
            }
            try {
                // delete all enteries first corresponding to this role1groupid, workflowid,
                // role2userid and role2groupid
                allocationUsersService.deleteUser1ByUser2(req.getRole1groupid(), req.getRole2groupid(),
                        req.getRole2userid(), req.getWorkflowid(), req.getItenantId(), loggedInUser.getIorgId().getIorgid());
                allocationUsersService.saveAll(usermappingList);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to save user mapping",
                        e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                        menu_name),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Mapping Entries Added"),
                    HttpStatus.OK);

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access add mapping list");
            LOGGER.debug("Exiting addMappedUser Method in " +
                    AllocationMapperServiceImpl.class
                    + " class with response : unauthorized to access add mapping list");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access add mapping list"),
                    HttpStatus.FORBIDDEN);

        }
    }

    public Integer getTaskCount(Integer itenantid, String workflowKey, String userId) {
        JSONObject requestbody = new JSONObject();
        requestbody.put("processDefinitionKey", workflowKey);
        requestbody.put("tenantIdIn", Arrays.asList(itenantid));
        requestbody.put("assignee", userId);

        ResponseEntity<String> taskcountResponse = null;
        try {
            taskcountResponse = camundaService.getTaskListPostCount(requestbody);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(requestbody.toString()));
            // activityLogService.addActivity("failed to get count for request body :" +
            // requestbody,
            // e.toString());
        }

        if (taskcountResponse.getStatusCode() == HttpStatus.OK) {
//            Map<String, Object> myObject = taskcountResponse.bodyToMono(Map.class).block();
//            taskcountResponse.releaseBody();
            try {
                Map<String, Object> myObject = new ObjectMapper().readValue(taskcountResponse.getBody(), Map.class);
                return (Integer) myObject.get("count");
            } catch (Exception e) {
                LOGGER.error("Error while processing or mapping JSON: " + e);
                return 0;
            }
        } else {
            // addtolist.put("noOfTasksOfThisProcess", 0);
//            String response = taskcountResponse.bodyToMono(String.class).block();
            String response = taskcountResponse.getBody();
//            taskcountResponse.releaseBody();
            System.out.println(taskcountResponse.getStatusCode());

            LOGGER.error("Error : failed to get count for \nResponse  : " + response);
            // activityLogService.addActivity("failed to get count for request body ",
            // requestbody.toString());
            return 0;
        }

    }

    public ResponseEntity<?> getUserMapping(GetUserMappingRequest req, Integer itenantid, Authentication pr) {

        List<Map<String, Object>> res = new ArrayList<>();

        List<String> targetGroups = new ArrayList<>();
        List<WebUser> userList = new ArrayList<>();
        
        Integer orgid = tenantRepositoryService.findByItenantId(itenantid).getIorgId().getIorgid();
        //first scenario, for first user task
        if (req.getChildUserName() == null && req.getParentUserName() == null) {
            LOGGER.info("Neither parent not child user present");
            if (req.getParentUserGroupID() != null) {
                targetGroups = req.getParentUserGroupID();
            } else if (req.getChildUserGroupID() != null) {
                targetGroups = req.getChildUserGroupID();
            }
        } else if (req.getChildUserName() != null && req.getParentUserName() == null) {
            // second scenario, fetch parent group users
            LOGGER.info("Fetch users of parent group based on child user");
            targetGroups = req.getParentUserGroupID();
            try {
                userList = allocationUsersService.findRole2UserByRole1UserAndWorkflow(itenantid,
                        req.getChildUserGroupID(),
                        req.getParentUserGroupID(),
                        req.getChildUserName(),
                        req.getWorkflowKey(),
                        orgid);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                // activityLogService.addActivity("failed to get user and permissions",
                // e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else if (req.getChildUserName() == null && req.getParentUserName() != null) {
            // second scenario, fetch child group users
            LOGGER.info("Fetch users of child group based on parent user");
            targetGroups = req.getChildUserGroupID();
            try {
                userList = allocationUsersService.findRole1UserByRole2UserAndWorkflow(itenantid,
                        req.getChildUserGroupID(),
                        req.getParentUserGroupID(),
                        req.getParentUserName(),
                        req.getWorkflowKey(),
                        orgid);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                // activityLogService.addActivity("failed to get user and permissions",
                // e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }

        // fetch users of target group if mapping not found or scenario 1
        if (userList.isEmpty()) {
            try {
                LOGGER.info("Fetching from webuser groups " + loggerEncoderUtil.encode(targetGroups.toString()));
                userList = webUserService.findByVcGroupIDsTenant(targetGroups, itenantid);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                // activityLogService.addActivity("failed to get user and permissions",
                // e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }

        Map<Integer, Boolean> userExists = new HashMap<>();

        // create username,group,noOfTasksOfThisProcess
        AllUsersMapping allMappingInfo = null;
        if (userList.size() > 0) {
            allMappingInfo = webuserMappingUtil.getWebUserMappings(
                    userList.stream().map(us -> us.getIuserID()).toList(), userList.get(0).getIorgId().getIorgid());
        }

        for (WebUser wb : userList) {
            if (userExists.containsKey(wb.getIuserID())) {
                continue;
            }
            userExists.put(wb.getIuserID(), true);
            Map<String, Object> addtolist = new HashMap<>();
            List<String> matchedGroups = new ArrayList<>();
            List<GroupDesc> grouplist = groupDescService.findAllById(allMappingInfo.getUserGroup().get(wb.getIuserID()));
            for (GroupDesc gp : grouplist) {
                if (targetGroups.stream().anyMatch(g -> g.equals(gp.getVcGroupID()) == true)) {
                    matchedGroups.add(gp.getVcGroupID());
                }
            }
            addtolist.put("username", wb.getIuserID());
            addtolist.put("group", String.join(",", matchedGroups));
            Integer count = getTaskCount(itenantid, req.getWorkflowKey(), wb.getIuserID().toString());
            addtolist.put("noOfTasksOfThisProcess", count);
            res.add(addtolist);
        }

        return ResponseEntity.ok(res);
    }

}
