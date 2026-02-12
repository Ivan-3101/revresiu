package com.DronaPay.UIServer.service.ControllerService.AppUser;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.MultiTenant;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.ResponseVO.AppUser;
import com.DronaPay.UIServer.ResponseVO.DropdownWithObject;
import com.DronaPay.UIServer.ResponseVO.WorkflowResponse;
import com.DronaPay.UIServer.VOMapper.AppUserMapper;
import com.DronaPay.UIServer.VOMapper.NewWebUserAuditRequestMapper;
import com.DronaPay.UIServer.VOMapper.UserPermissionRequestMapper;
import com.DronaPay.UIServer.auditing.Checker;
import com.DronaPay.UIServer.controller.EmailServiceController.EmailController;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.requests.*;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.AppUsers;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.response.UserRoleGroupWorkflowClassMapResponse;
import com.DronaPay.UIServer.service.ControllerService.DecisionToWorkflow.DecisionToWorkflowServiceImpl;
import com.DronaPay.UIServer.service.ControllerService.testing.RoleMenuAccessMapService;
import com.DronaPay.UIServer.service.FileStorageService;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.DronaPay.UIServer.util.LoginPasswordUtil;
import com.DronaPay.UIServer.util.WebuserMappingUtil;
import com.DronaPay.UIServer.util.AllUsersMapping;
import com.DronaPay.UIServer.util.PasswordGenerator;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Service
public class AppUserServiceImpl implements AppUserService {

    private static final Logger LOGGER = LoggerFactory.getLogger(AppUserServiceImpl.class);
    final String menu_name = MenuNames.appUsers;

//    @Value("${drona.ui.url}")
//    private String drona_ui_url;

    // @Value("${UIServer.SSO}")
    // private Boolean sso;
    @Autowired
    private WebUserAuditService webUserAuditService;
    @Autowired
    private WebUserService webUserService;
    @Autowired
    private ActivityLogService activityLogService;
    @Autowired
    private UserRoleMenuAccessService userRoleMenuAccessService;
    @Autowired
    private FileStorageService fileStorageService;
    @Autowired
    private RoleDescService roleDescService;
    @Autowired
    private GroupDescService groupDescService;
    @Autowired
    private WorkflowMasterService workflowMasterService;
    @Autowired
    private TransactionClassesUiService transactionClassesUiService;
    @Autowired
    private OrganizationRepositoryService organizationRepositoryService;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private StatusCodeService statusCodeService;
    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;
    @Autowired
    private LoginPasswordUtil loginPasswordUtil;
    @Autowired
    private RoleMenuAccessMapService roleMenuAccessMapService;
    @Autowired
    private TenantRepositoryService tenantRepositoryService;
    @Autowired
    private TransactionClassesUiService transactionClassRepoService;
    @Autowired
    private Checker cheker;
    @Autowired
    private Environment env;
    @Autowired
    private AppUserMapper appUserMapper;
    @Autowired
    private NewWebUserAuditRequestMapper newWebUserAuditRequestMapper;
    @Autowired
    private WebuserMappingUtil webuserMappingUtil;
    @Autowired
    private WebuserMappingService webuserMappingService;
    @Autowired
    private PasswordGenerator passwordGenerator;
    @Autowired
    private EmailController emailController;

    @Value("${usermanagement.groupid}")
    private String usermanagement_groupid;
    @Autowired
    private ActiveLoginTokenService activeLoginTokenService;

    @Override
    public ResponseEntity<?> getAppUsers(Authentication pr) {
        LOGGER.debug(loggerEncoderUtil
                .encode("Entered getAppUsers Method in " + AppUserServiceImpl.class
                        + " class with params : " + pr));
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            AppUsers response = new AppUsers();
            List<AppUser> res = new ArrayList<>();
            List<AppUser> newRes = new ArrayList<>();
            // System.out.println(user.getIUserID());

            String vcorgid = loggedInUser.getIorgId().getVcOrgId();
            try {
                LOGGER.info("before all active user accessed");
                res.addAll(webUserAuditService.getListOfWebUsers(
                        webUserService.findAllActiveUsers(vcorgid, loggedUser), mp,
                        loggedInUser));
                LOGGER.info("all active user accessed");
                if (mp.isApprove()) {
                    res.addAll(appUserMapper.parseAuditList(
                            webUserAuditService.getAllPendingEntry(vcorgid, loggedUser), mp,
                            loggedInUser));
                    LOGGER.info("all unapproved user accessed");
                    System.out.println("size of res is " + res.size());
                } else {
                    res.addAll(appUserMapper.parseAuditList(
                            webUserAuditService.getAllPendingEntryCreatedByIUserID(
                                    loggedInUser.getIuserID()),
                            mp,
                            loggedInUser));
                    LOGGER.info("all entries created by "
                            + loggerEncoderUtil.encode(loggedInUser.getUsername())
                            + " accessed");
                }

                // newRes = res.stream()
                //         .filter(r -> r.getUsername().equals(loggedInUser.getUsername())
                //                 && r.getId() == loggedInUser.getIuserID())
                //         .collect(Collectors.toList());
                // System.out.println("size of new res 1 is " + newRes.size());
                // newRes.addAll(res.stream()
                //         .filter(r -> !r.getUsername().equals(loggedInUser.getUsername())
                //                 && r.getId() != loggedInUser.getIuserID())
                //         .collect(Collectors.toList()));
                // System.out.println("size of new res 2 is " + newRes.size());

            } catch (Exception e) {
                // e.printStackTrace();
                LOGGER.error("Error : " + e + "\nParam : "
                        + loggerEncoderUtil.encode(loggedInUser.toString()));
                activityLogService.addActivity(loggedInUser,
                        "failed to access permissions for user management",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            response.setView(mp.isView());
            response.setAdd(mp.isAdd());
            response.setApprove(mp.isApprove());
            System.out.println("before set app user");
            response.setAppUser(res);

            activityLogService.addActivity(loggedInUser, "user management Accessed");
            System.out.println("all set to return");
            LOGGER.debug(
                    "Exiting getAppUsers Method in " + AppUserServiceImpl.class
                            + " class with response" + response);
            return ResponseEntity.ok(response);
        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to accesss user management list this page");
            LOGGER.debug("Exiting getAppUsers Method in " + AppUserServiceImpl.class
                    + " class with response  : Unauthorized to accesss user management list this page");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false,
                            "Unauthorized to accesss user management list this page"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getRoleGroupWorkflowClassMap(TenantListRequest req, Authentication pr) {

        LOGGER.debug("Entered getRoleAndGroupMap Method in " + AppUserServiceImpl.class
                + " class with parameters : "
                + loggerEncoderUtil.encode(pr.toString()));
        LOGGER.debug("entering  class " + DecisionToWorkflowServiceImpl.class
                + " and method addDecisionDetails");

        List<Integer> tenantids = req.getTenants();
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser user = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            UserRoleGroupWorkflowClassMapResponse uragmr = new UserRoleGroupWorkflowClassMapResponse();

            try {
                uragmr.setRole(UserPermissionRequestMapper
                        .parseRole(roleDescService.findAllByTenantIds(tenantids)));
                uragmr.setGroup(UserPermissionRequestMapper
                        .parseGroup(groupDescService.findAllByTenantIds(tenantids)));

                UserPermissionRequest allOption = new UserPermissionRequest();
                allOption.setLabel("All");
                allOption.setValue(-1);

                List<WorkflowMasters> allWorkflows = workflowMasterService.findAllByTenants(tenantids);
                uragmr.setWorkflow(UserPermissionRequestMapper.parseWorkflow(allWorkflows));
                uragmr.getWorkflow().add(allOption);


                List<TransactionClassesUI> allClasses = transactionClassesUiService
                        .findAllByTenantIds(tenantids);

                uragmr.setTransactionClass(UserPermissionRequestMapper.parseClass(allClasses));
                uragmr.getTransactionClass().add(allOption);

                LOGGER.info(" roles, group, workflow, class accessed");
            } catch (Exception e) {

                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(user.toString()));
                activityLogService.addActivity(user, "Failed To Access Role and Group Dropdown",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            activityLogService.addActivity(user, "Role and Group Dropdown Accessed");
            LOGGER.debug("Exiting getRoleAndGroupMap Method in " + AppUserServiceImpl.class
                    + " class with reponse : "
                    + loggerEncoderUtil.encode(uragmr.toString()));
            return ResponseEntity.ok(uragmr);
        } else {
            activityLogService.addActivity(user, "unauthorized to accesss Role and Group");
            LOGGER.debug(
                    "Exiting getRoleAndGroupMap Method in AppUserServiceImpl class with response : unauthorized to accesss Role and Group");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to accesss Role and Group"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getAppUserDetails(GetAppUserDetailsRequest gaudr, Authentication pr) {
        LOGGER.debug(loggerEncoderUtil
                .encode("Entered getAppUserDetails Method in " + AppUserServiceImpl.class
                        + " class with pareameters : "
                        + gaudr + pr));

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);
        if (mp.isView() && loggedUser.allowOrg(gaudr.getVcorgid())) {
            NewWebUserAuditRequest nwuar = null;
            if (gaudr.getAudit()) {
                try {
                    nwuar = newWebUserAuditRequestMapper.parse(webUserAuditService
                            .findByWebUserAuditId(gaudr.getId(), gaudr.getVcorgid()));
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(gaudr.toString()));
                    activityLogService.addActivity(loggedInUser,
                            "failed to get details of web user ",
                            "Error : " + e.toString() + ", Parameters : " + gaudr);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
            } else {
                try {
                    nwuar = newWebUserAuditRequestMapper.parse(webUserService
                            .findByUserOrgId(gaudr.getId(), organizationRepositoryService
                                    .findOrg(gaudr.getVcorgid()).getIorgid()));
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(gaudr.toString()));
                    activityLogService.addActivity(loggedInUser,
                            "failed to get details of web user ",
                            "Error : " + e.toString() + ", Parameters : " + gaudr);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

            }
            activityLogService.addActivity(loggedInUser, "web user details accessed",
                    " Response : " + nwuar);
            LOGGER.debug("Exiting getAppUserDetails Method in " + AppUserServiceImpl.class
                    + " class with response : "
                    + nwuar);
            return ResponseEntity.ok(nwuar);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to accesss app user details");
            LOGGER.debug("Exiting getAppUserDetails Method in " + AppUserServiceImpl.class
                    + " class with response : unauthorized to accesss web user details");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to accesss web user details "),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<ApiResponse> newWebuserEntry(NewWebUserAuditRequestGt nwuar, Authentication pr) {
        LOGGER.debug(loggerEncoderUtil
                .encode("Entered newWebuserEntry Method in " + AppUserServiceImpl.class
                        + " class with parameters : "
                        + nwuar + pr));

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser user = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isAdd() && loggedUser.allowOrg(nwuar.getVcorgid())) {

            String username = nwuar.getUsername();

            String emailid = nwuar.getEmailid();

            System.out.println("username is " + username + " email id is " + emailid);
            String contact = nwuar.getContact();
            String mobile = nwuar.getMobile();
            String profileimg = nwuar.getProfileimg();
            String firstname = nwuar.getFirstname();
            String lastname = nwuar.getLastname();
            String address = nwuar.getAddress();
            String designation = nwuar.getDesignation();
            String remark = nwuar.getRemark();

            WebUserAudit wua = new WebUserAudit();

            if(nwuar.getUserpermissions().getValue() == 0){
                String errorMessage = "Cannot assign Drona God role";
                activityLogService.addActivity(user,
                        "Failed to add user - " + errorMessage);
                LOGGER.debug("Exiting newWebuserEntry Method in " + AppUserServiceImpl.class
                        + " class with response: failed to edit user - " + errorMessage);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, errorMessage),
                        HttpStatus.BAD_REQUEST);
            }

            if (username == null || username.isEmpty()) {
                activityLogService.addActivity(user,
                        "failed to add new user because email id is not given",
                        " Parameters : " + nwuar);
                LOGGER.debug("Exiting newWebuserEntry Method in " + AppUserServiceImpl.class
                        + " class with response : Please Enter username");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please Enter username"),
                        HttpStatus.BAD_REQUEST);
            } else {
                WebUser exist = null;
                try {
                    exist = webUserService.findActiveWebUserByvcUserName(username, nwuar.getVcorgid());
                } catch (Exception e) {

                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(nwuar.toString()));
                    activityLogService.addActivity(user, "failed to add new user",
                            "Error : " + e.toString() + ", Parameters : " + nwuar);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (exist != null) {
                    activityLogService.addActivity(user,
                            "failed to add new user because Username Already In Use",
                            "Parameters : " + nwuar);
                    LOGGER.debug("Exiting newWebuserEntry Method in " + AppUserServiceImpl.class
                            + " class with response : Username Already In Use. !Please try different");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Username Already In Use. !Please try different"),
                            HttpStatus.CONFLICT);
                } else {
                    WebUserAudit existaudit = null;

                    try {
                        existaudit = webUserAuditService
                                .findPendingAddEntryByUserName(username, nwuar.getVcorgid());
                    } catch (Exception e) {
                        LOGGER.error("Error : " + e + "\nParam : "
                                + loggerEncoderUtil.encode(nwuar.toString()));
                        activityLogService.addActivity(user, "failed to add new user",
                                "Error : " + e.toString() + ", Parameters : " + nwuar);
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    if (existaudit == null) {
                        Pattern p = Pattern.compile("^.{1,64}$");
                        Matcher m = p.matcher(username);
                        if (!m.matches()) {
                            activityLogService.addActivity(user,
                                    "failed to add new user because username was incorrect",
                                    "Parameters : " + nwuar);
                            LOGGER.debug("Exiting newWebuserEntry Method in "
                                    + AppUserServiceImpl.class
                                    + " class with response : Please valid usernam");
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "Please Enter valid username"),
                                    HttpStatus.BAD_REQUEST);
                        }

                        Pattern numOnly = Pattern.compile("^[0-9]*$");
                        Matcher mnum = numOnly.matcher(username);
                        if (mnum.matches()) {
                            activityLogService.addActivity(user,
                                    "failed to add new user because username was incorrect",
                                    "Parameters : " + nwuar);
                            LOGGER.debug("Exiting newWebuserEntry Method in "
                                    + AppUserServiceImpl.class
                                    + " class with response : Please valid usernam");
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "Username cannot be all numbers"),
                                    HttpStatus.BAD_REQUEST);
                        }
                        wua.setVcUserName(username);
                    } else {
                        activityLogService.addActivity(user,
                                "failed to add new user because pending entry exists",
                                "Parameters : " + nwuar);
                        LOGGER.debug("Exiting newWebuserEntry Method in "
                                + AppUserServiceImpl.class + " class");
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                                "Entry with this username already exists and is pending for approval. Please use a different username."),
                                HttpStatus.CONFLICT);
                    }
                }

            }
//            JsonNode settings = user.getIorgId().getAttribs();
//            Boolean sso = settings.at("/ssoConfig/uiserver.sso").asBoolean();
//            if (!sso) {
//                String wordOrig = null;
//                try {
//                    wordOrig = loginPasswordUtil.decryptUserPassword(nwuar.getPassword());
//                } catch (Exception e) {
//                    LOGGER.error("Error : " + e + "\nParam : "
//                            + loggerEncoderUtil.encode(nwuar.toString()));
//                    activityLogService.addActivity(user, "failed to add new user",
//                            "Error : " + e.toString() + ", Parameters : " + nwuar);
//                    return new ResponseEntity<ApiResponse>(
//                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
//                            HttpStatus.INTERNAL_SERVER_ERROR);
//                }
//
//                String regexPass = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{"
//                        + env.getProperty("minimum.password.length") + ","
//                        + env.getProperty("max.password.length")
//                        + "}$";
//                Pattern patternPass = Pattern.compile(regexPass);
//                Matcher matcherPass = patternPass.matcher(wordOrig);
//
//                if (!matcherPass.matches()) {
//                    // activityLogService.addActivity(
//                    // " failed to reset password becasue password is not in proper format ",
//                    // "");
//                    LOGGER.debug("Exiting newWebuserEntry Method in " + AppUserServiceImpl.class
//                            + " class with response : Please Enter Password");
//                    return new ResponseEntity<ApiResponse>(
//                            new ApiResponse(false,
//                                    "Password must meet minimum requirements mentioned in policy"),
//                            HttpStatus.BAD_REQUEST);
//                }
//
//                String word = passwordEncoder.encode(wordOrig);
//                if (word == null) {
//                    activityLogService.addActivity(user,
//                            "failed to add new user because password was not given",
//                            "Parameters : " + nwuar);
//                    LOGGER.debug("Exiting newWebuserEntry Method in " + AppUserServiceImpl.class
//                            + " class with response : Please Enter Password");
//                    return new ResponseEntity<ApiResponse>(
//                            new ApiResponse(false, "Please Enter Password"),
//                            HttpStatus.BAD_REQUEST);
//                } else {
//                    if (StringUtils.containsIgnoreCase(wordOrig, nwuar.getUsername())) {
//                        activityLogService.addActivity(user,
//                                "failed to add new user because password contains username",
//                                "Parameters : " + nwuar);
//                        LOGGER.debug("Exiting newWebuserEntry Method in "
//                                + AppUserServiceImpl.class
//                                + " class with response : Please Enter Password");
//                        return new ResponseEntity<ApiResponse>(
//                                new ApiResponse(false,
//                                        "Password cannot contain username"),
//                                HttpStatus.BAD_REQUEST);
//                    } else {
//                        wua.setVcPassword(word);
//                    }
//
//                }
//            }

            if (emailid == null) {
                activityLogService.addActivity(user,
                        "failed to add new user because email was not given",
                        "Parameters : " + nwuar);
                LOGGER.debug("Exiting newWebuserEntry Method in " + AppUserServiceImpl.class
                        + " class with response : Please Enter Email");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please Enter Email"),
                        HttpStatus.BAD_REQUEST);
            } else {
                WebUser duplicateEmail = null;
                try {
                    duplicateEmail = webUserService.findActiveEmail(emailid, nwuar.getVcorgid());
                    if (duplicateEmail != null) {
                        activityLogService.addActivity(user,
                                "failed to add new user because email was already taken",
                                "Parameters : " + nwuar);
                        LOGGER.debug("Exiting newWebuserEntry Method in "
                                + AppUserServiceImpl.class
                                + " class with response : Email id already taken");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, "Email id is already taken"),
                                HttpStatus.CONFLICT);
                    }
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(nwuar.toString()));
                    activityLogService.addActivity(user, "failed to add new user",
                            "Error : " + e.toString() + ", Parameters : " + nwuar);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                String regex = "^(.+)@(\\S+)$";
                Pattern pattern = Pattern.compile(regex);
                Matcher matcher = pattern.matcher(emailid);
                if (matcher.matches()) {
                    wua.setVcEmailID(emailid);
                } else {
                    activityLogService.addActivity(user,
                            "failed to add new user because email was not in proper format",
                            "Parameters : " + nwuar);
                    LOGGER.debug("Exiting newWebuserEntry Method in " + AppUserServiceImpl.class
                            + " class with response : Please Enter Valid Email Address");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Please Enter Valid Email Address"),
                            HttpStatus.BAD_REQUEST);
                }
            }

            if (!mobile.isBlank() && mobile != null) {
                if (mobile.length() < 10) {
                    activityLogService.addActivity(user,
                            "failed to add new user because mobile number was not valid",
                            "Parameters : " + nwuar);
                    LOGGER.debug("Exiting newWebuserEntry Method in " + AppUserServiceImpl.class
                            + " class with response : Please Enter Valid Mobile No. ");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Please Enter Valid Mobile No."),
                            HttpStatus.BAD_REQUEST);
                } else {
                    wua.setVcMobile(mobile);
                }
            }

            wua.setVcContact(contact);
            wua.setVcProfileImg(profileimg);

            if (firstname == null || firstname.isEmpty()) {
                activityLogService.addActivity(user,
                        "failed to add new user because first name is Null",
                        "Parameters : " + nwuar);
                LOGGER.debug("Exiting newWebuserEntry Method in " + AppUserServiceImpl.class
                        + " class with response : Please Enter First Name");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Please Enter First Name"),
                        HttpStatus.BAD_REQUEST);
            } else {
                wua.setVcFirstName(firstname);
            }

            if (lastname == null || lastname.isEmpty()) {
                activityLogService.addActivity(user, "failed to add new user because last name is Null",
                        "Parameters : " + nwuar);
                LOGGER.debug("Exiting newWebuserEntry Method in " + AppUserServiceImpl.class
                        + " class with response : Please Enter Last Name");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please Enter Last Name"),
                        HttpStatus.BAD_REQUEST);
            } else {
                wua.setVcLastName(lastname);
            }

            wua.setVcAddress(address);
            wua.setVcDesignation(designation);
            wua.setIorgId(organizationRepositoryService.findOrg(nwuar.getVcorgid()));

            if (remark == null || remark.isEmpty()) {
                activityLogService.addActivity(user,
                        "failed to add new user because maker remark is Null",
                        "Parameters : " + nwuar);
                LOGGER.debug("Exiting newWebuserEntry Method in " + AppUserServiceImpl.class
                        + " class with response : Please Enter Maker remark");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Please Enter Maker Remark"),
                        HttpStatus.BAD_REQUEST);
            } else {
                wua.setVcRemark(remark);
            }

            wua.setIEntryUserID(user.getIuserID());
            if (nwuar.getUserpermissions() == null) {
                activityLogService.addActivity(user,
                        "failed to add new user because role was not selected",
                        "Parameters : " + nwuar);
                LOGGER.debug("Exiting newWebuserEntry Method in " + AppUserServiceImpl.class
                        + " class with response : Please Select User Role");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Please Select User Role"),
                        HttpStatus.BAD_REQUEST);
            }

            List<Integer> tids = nwuar.getUsertenants();

            List<UserPermissionRequest> wids = new ArrayList<>();
            if (nwuar.getUserworkflows() != null) {
                wids = nwuar.getUserworkflows();
            }

            List<UserPermissionRequest> cids = new ArrayList<>();
            if (nwuar.getUserclasses() != null) {
                cids = nwuar.getUserclasses();
            }

            List<UserPermissionRequest> gids = new ArrayList<>();
            if (nwuar.getUsergroups() != null) {
                gids = nwuar.getUsergroups();
            }

            UserPermissionRequest rid = nwuar.getUserpermissions();

            Boolean isApprove = roleMenuAccessMapService.getIsRoleApprove(
                    UserPermissionRequestMapper.parseToUserMap(Arrays.asList(rid)),
                    MenuNames.appUsers);

            if (isApprove) {
                System.out.println("Adding add user");
                try {
                    GroupDesc gdesc = groupDescService.findByVcGroupID(usermanagement_groupid, tids.get(0));
                    UserPermissionRequest req = new UserPermissionRequest();
                    req.setValue(gdesc.getIgroupID());
                    req.setItenantId(gdesc.getItenantId());
                    gids.add(req);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(nwuar.toString()));
                    activityLogService.addActivity(user, "failed to add new user",
                            "Error : " + e.toString() + ", Parameters : " + nwuar);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
            }

            wua.setVcAction("A");
            try {

                webUserAuditService.save(wua,
                        webuserMappingUtil.getWebuserMappingAuditAll(rid, gids, wids, cids,
                                tids, wua));
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : "
                        + loggerEncoderUtil.encode(nwuar.toString()));
                activityLogService.addActivity(user, "failed to add new user",
                        "Error : " + e.toString() + ", Parameters : " + nwuar);
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            activityLogService.addActivity(user, "web user added to audit successfully",
                    "Parameters : " + nwuar);
            LOGGER.debug("Exiting newWebuserEntry Method in " + AppUserServiceImpl.class
                    + " class with response : Web User Added Successfully");
            return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Web User Added Successfully"),
                    HttpStatus.OK);
        } else {
            activityLogService.addActivity(user, "unauthorized to add web user audit entry");
            LOGGER.debug("Exiting newWebuserEntry Method in " + AppUserServiceImpl.class
                    + " class with response : unauthorized to add web user audit entry ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to add web user audit entry "),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> approveWebUserEntry(CheckerRequest cr, Authentication pr) {
        LOGGER.debug("Entered approveWebUserEntry Method in " + AppUserServiceImpl.class
                + " class with parameters : "
                + cr + pr);

        LOGGER.debug("entering  class " + DecisionToWorkflowServiceImpl.class
                + " and method addDecisionDetails");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);
        if (mp.isApprove() && loggedUser.allowOrg(cr.getVcorgid())) {
            WebUserAudit wua = new WebUserAudit();
            try {
                wua = webUserAuditService.findByWebUserAuditId(cr.getId(), cr.getVcorgid());
                wua.setIApproverUserID(loggedInUser.getIuserID());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(wua.toString()));
                activityLogService.addActivity(loggedInUser,
                        "failed to access permissions for approveWebUserEntry",
                        "Error : " + e.toString() + ", Parameters : " + cr);
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (wua.getIstatus() == null) {
                wua.setDtApproverStamp(ZonedDateTime.now());

                wua.setBclosed(true);
                String status = "";
                StatusCode code = new StatusCode();
                if (cr.getApproved()) {
                    switch (wua.getVcAction()) {
                        case "A":
                            code = statusCodeService.findByIStatusId(2);
                            status = "Add Entry Approved";

                            break;
                        case "M":
                            code = statusCodeService.findByIStatusId(3);
                            status = "Edit Entry Approved";
                            break;
                        case "X":
                            code = statusCodeService.findByIStatusId(4);
                            status = "Delete Entry Approved";
                            break;
                    }
                } else {
                    code = statusCodeService.findByIStatusId(5);
                    switch (wua.getVcAction()) {
                        case "A":
                            status = "Add Entry Rejected";
                            break;
                        case "M":
                            status = "Edit Entry Rejected";
                            break;
                        case "X":
                            status = "Delete Entry Rejected";
                            break;
                    }

                }
                LOGGER.info("Action status set successfully");
                wua.setIstatus(code);

                String remark = cr.getRemark();

                if (remark == null || remark.isEmpty()) {
                    activityLogService.addActivity(loggedInUser,
                            "failed to " + status + " because checker remark is Null",
                            "Parameters : " + cr);
                    LOGGER.debug("Exiting approveWebUserEntry Method in " + AppUserServiceImpl.class
                            + " class with response : Please Enter Checker remark");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Please Enter Checker Remark"),
                            HttpStatus.BAD_REQUEST);
                } else {
                    wua.setVcRemark("{" + wua.getVcRemark() + "}{" + remark + "}");

                }

                try {
                    cheker.checker(wua);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + " Param : "
                            + loggerEncoderUtil.encode(wua.toString()));
                    activityLogService.addActivity(loggedInUser,
                            "failed to access permissions for approveWebUserEntry",
                            "Error : " + e.toString() + ", Parameters : " + cr);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Something Went Wrong"),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                // List<UserRoleMapAudit> permissions = new ArrayList<>();
                // try {
                // permissions =
                // userRoleMapAuditService.findByIUserIDandActionA(wua.getTempiUserID(), "A");
                // } catch (Exception e) {
                // LOGGER.error("Error : " + e + "\nParam : " + cr);
                // activityLogService.addActivity(user, "Web User Entry " + status + " failed",
                // "Error : " + e.toString() + ", Parameters : " + wua);
                // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                // ResponseMessages.GenericErrorMessage),
                // HttpStatus.INTERNAL_SERVER_ERROR);
                // }

                // List<UserRoleMapAudit> forMaster = new ArrayList<>();
                // for (UserRoleMapAudit u : permissions) {
                // u.setIApproverUserID(user);
                // u.setDtApproverStamp(new Date());
                // if (wua.getVcAction().equalsIgnoreCase("X")) {
                // u.setVcAction("X");
                // }
                // u.setVcRemark("{" + wua.getVcRemark() + "}{" + cr.getRemark() + "}");
                // u.setBclosed(true);
                // u.setIStatus(code);
                // forMaster.add(u);
                // try {
                // userRoleMapAuditService.save(u);
                // } catch (Exception e) {
                // LOGGER.error("Error : " + e + "\nParam : " + u);
                // activityLogService.addActivity(user, "Web User Entry " + status + " failed",
                // "Error : " + e.toString() + ", Parameters : " + cr);
                // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                // ResponseMessages.GenericErrorMessage),
                // HttpStatus.INTERNAL_SERVER_ERROR);
                // }
                // }
                //
                // try {
                // cheker.checker(wua);
                // } catch (Exception e) {
                // LOGGER.error("Error : " + e + "\nParam : " + wua);
                // activityLogService.addActivity(user, "Web User Entry " + status + " failed",
                // "Error : " + e.toString() + ", Parameters : " + wua);
                // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                // ResponseMessages.GenericErrorMessage),
                // HttpStatus.INTERNAL_SERVER_ERROR);
                // }
                // if (wua.getVcAction().equalsIgnoreCase("X")) {
                // List<UserRoleMap> urm = new ArrayList<>();
                // try {
                // urm = userRoleMapService.findByiUserID(wua.getTempiUserID());
                // } catch (Exception e) {
                // LOGGER.error("Error : " + e + "\nParam : " + wua);
                // activityLogService.addActivity(user, "Web User Entry " + status + " failed",
                // "Error : " + e.toString() + ", Parameters : " + wua);
                // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                // ResponseMessages.GenericErrorMessage),
                // HttpStatus.INTERNAL_SERVER_ERROR);
                // }
                // for (UserRoleMap u : urm) {
                // u.setIApproverUserID(user);
                // u.setDtApproverStamp(new Date());
                // u.setIStatus(code.getIStatusIDForMaster());
                // u.setIEntryUserID(wua.getIEntryUserID());
                // u.setDtEntryStamp(wua.getDtEntryStamp());
                // }
                // } else {
                // if (wua.isBClosed() && code.isBUpdateMaster()) {
                // try {
                // userRoleMapService.deleteAllByIUserID(wua.getTempiUserID());
                // } catch (Exception e) {
                //
                // LOGGER.error("Error : " + e + "\nParam : " + wua);
                // activityLogService.addActivity(user, "Web User Entry " + status + " failed",
                // "Error : " + e.toString() + ", Parameters : " + wua);
                // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                // ResponseMessages.GenericErrorMessage),
                // HttpStatus.INTERNAL_SERVER_ERROR);
                //
                // }
                // for (UserRoleMapAudit u : forMaster) {
                // UserRoleMap temp = new UserRoleMap();
                // try {
                // temp.setIUserID(webUserService.findByiUserID(u.getIUserID()));
                // } catch (Exception e) {
                // LOGGER.error("Error : " + e + "\nParam : " + wua);
                // activityLogService.addActivity(user, "Web User Entry " + status + " failed",
                // "Error : " + e.toString() + ", Parameters : " + wua);
                // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                // ResponseMessages.GenericErrorMessage),
                // HttpStatus.INTERNAL_SERVER_ERROR);
                // }
                // temp.setIRoleID(u.getIRoleID());
                // temp.setIStatus(u.getIStatus());
                // temp.setIEntryUserID(u.getIEntryUserID());
                // temp.setDtEntryStamp(u.getDtEntryStamp());
                // temp.setIApproverUserID(u.getIApproverUserID());
                // temp.setDtApproverStamp(u.getDtApproverStamp());
                // try {
                // // userRoleMapService.save(temp);
                // } catch (Exception e) {
                // LOGGER.error("Error : " + e + "\nParam : " + wua);
                // activityLogService.addActivity(user, "Web User Entry " + status + " failed",
                // "Error : " + e.toString() + ", Parameters : " + wua);
                // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                // ResponseMessages.GenericErrorMessage),
                // HttpStatus.INTERNAL_SERVER_ERROR);
                // }
                //
                // }
                // }
                // }
                activityLogService.addActivity(loggedInUser, "Web User " + status + " Successfully",
                        " Parameters : " + cr);
                LOGGER.debug("Exiting approveWebUserEntry Method in "
                        + AppUserServiceImpl.class
                        + " class with response : Web User " + loggerEncoderUtil.encode(status)
                        + " Successfully, Parameters : "
                        + loggerEncoderUtil.encode(cr.toString()));
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(true, "Web User " + status + " Successfully"),
                        HttpStatus.OK);

            } else {
                activityLogService.addActivity(loggedInUser, "Webuser Entry Already closed",
                        " Parameters : " + cr);
                LOGGER.debug("Exiting newWebuserEntry Method in " + AppUserServiceImpl.class
                        + " class with response : Entry Already Approved");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Entry Already Approved"),
                        HttpStatus.BAD_REQUEST);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to approve web user ");
            LOGGER.debug("Exiting newWebuserEntry Method in " + AppUserServiceImpl.class
                    + " class with response : unauthorized to approve web user ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to approve web user "),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> deleteWebuser(DeleteRequest dr, Authentication pr) {

        LOGGER.debug("Entered deleteWebuser Method in " + AppUserServiceImpl.class + " class with parameters : "
                + loggerEncoderUtil.encode(dr.toString()) + loggerEncoderUtil.encode(pr.toString()));
        LOGGER.debug("entering  class " + DecisionToWorkflowServiceImpl.class
                + " and method addDecisionDetails");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isDelete() && loggedUser.allowOrg(dr.getVcorgid())) {
            if (dr.getAudit()) {
                WebUserAudit wua;

                try {
                    wua = webUserAuditService.findByWebUserAuditId(dr.getId(), dr.getVcorgid());
                    LOGGER.info("User entry retrived to create delete audit entry");
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(loggedInUser.toString()));
                    activityLogService.addActivity(loggedInUser,
                            "failed to add delete user audit entry", e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (loggedInUser.getIuserID().equals(wua.getIEntryUserID())) {
                    wua.setBclosed(true);
                    try {
                        webUserAuditService.save(wua);
                        activityLogService.addActivity(loggedInUser,
                                "Webuser entry deleted successfully ",
                                " Parameters : " + dr);
                        LOGGER.debug("Exiting deleteWebuser Method in "
                                + AppUserServiceImpl.class
                                + " class with response : Webuser Entry Deleted");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(true, "Webuser Entry Deleted"),
                                HttpStatus.OK);
                    } catch (Exception e) {

                        LOGGER.error("Error : " + e + "\nParam : "
                                + loggerEncoderUtil.encode(dr.toString())
                                + loggerEncoderUtil.encode(wua.toString()));
                        activityLogService.addActivity(loggedInUser,
                                "failed to delete webuser entry from audit",
                                "Error : " + e.toString() + ", Parameters : " + dr
                                        + wua);
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                } else {
                    activityLogService.addActivity(loggedInUser,
                            "Unautherized to delete this entry",
                            " Parameters : " + dr + wua);
                    LOGGER.debug("Exiting deleteWebuser Method in " + AppUserServiceImpl.class
                            + " class with response : Unautherized to delete this entry");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Unautherized to delete this entry"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                Optional<WebuserMapping> wup = webuserMappingService.findByWebuserIDAndMappingType(dr.getId(), "Role");

                if(wup.isPresent()){
                    if(wup.get().getMappingID() == 0){
                        String errorMessage = "Cannot delete user with Drona God role";
                        activityLogService.addActivity(loggedInUser,
                                "Failed to delete user - " + errorMessage);
                        LOGGER.debug("Exiting deleteWebuser Method in " + AppUserServiceImpl.class
                                + " class with response: failed to delete user - " + errorMessage);
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, errorMessage),
                                HttpStatus.BAD_REQUEST);
                    }
                }else{
                    String errorMessage = "The user is not assigned a role";
                    activityLogService.addActivity(loggedInUser,
                            "Failed to delete user - " + errorMessage);
                    LOGGER.debug("Exiting deleteWebuser Method in " + AppUserServiceImpl.class
                            + " class with response: failed to delete user - " + errorMessage);
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, errorMessage),
                            HttpStatus.BAD_REQUEST);
                }

                WebUserAudit pending = null;
                try {
                    pending = webUserAuditService.findPendingAddEntryByIUserID(dr.getId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(dr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to perform checker operation",
                            "Error : " + e.toString() + ", Parameters : " + dr);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                if(pending != null){
                    LOGGER.debug("Exiting deleteWebuser Method in " + AppUserServiceImpl.class
                            + " class with response : Entry pending already");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Entry pending already"),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                WebUser wu = null;
                try {
                    wu = webUserService.findByUserOrgId(dr.getId(), organizationRepositoryService
                            .findOrg(dr.getVcorgid()).getIorgid());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(dr.toString())
                            + loggerEncoderUtil.encode(wu.toString()));
                    activityLogService.addActivity(loggedInUser,
                            "failed to delete webuser entry from audit",
                            "Error : " + e.toString() + ", Parameters : " + dr + wu);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                WebUserAudit wua = new WebUserAudit();
                wua = WebUserAudit.parseForAudit(wu);
                wua.setVcAction("X");
                wua.setVcRemark(dr.getRemark());
                wua.setIEntryUserID(loggedInUser.getIuserID());

                try {
                    webUserAuditService.save(wua);
                    activityLogService.addActivity(loggedInUser,
                            "Web User Delete Entry Submitted Successfully",
                            " Parameters : " + dr);
                    LOGGER.debug("Exiting deleteWebuser Method in " + AppUserServiceImpl.class
                            + " class with response : User management Web User Delete Entry Submitted Successfully");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(true,
                                    "Web User Delete Entry Submitted Successfully"),
                            HttpStatus.OK);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(dr.toString())
                            + loggerEncoderUtil.encode(wua.toString()));
                    activityLogService.addActivity(loggedInUser,
                            "failed to delete webuser entry from audit",
                            "Error : " + e.toString() + ", Parameters : " + dr + wu);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
            }
        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to to delete webuser entry from audit ");
            LOGGER.debug("Exiting newWebuserEntry Method in " + AppUserServiceImpl.class
                    + " class with response : unauthorized to to delete webuser entry from audit ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to delete webuser entry from audit "),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> unlockWebuser(UnlockRequest ur, Authentication pr) {

        LOGGER.debug("Entered unlockWebuser Method in " + AppUserServiceImpl.class + " class with parameters : "
                + loggerEncoderUtil.encode(ur.toString()) + loggerEncoderUtil.encode(pr.toString()));
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser user = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isEdit() && loggedUser.allowOrg(ur.getVcorgid())) {
            if (ur.getAudit()) {
                WebUserAudit wua;

                try {
                    wua = webUserAuditService.findByWebUserAuditId(ur.getId(), ur.getVcorgid());
                    LOGGER.info("User entry retrived to create unlock audit entry");
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(user.toString()));
                    activityLogService.addActivity(user, "failed to add unlock user audit entry",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (user.getIuserID().equals(wua.getIEntryUserID())) {
                    wua.setBclosed(true);
                    wua.setLoginAttempts(0);
                    try {
                        webUserAuditService.save(wua);
                        activityLogService.addActivity(user,
                                "Webuser entry unlock successfully ",
                                " Parameters : " + ur);
                        LOGGER.debug("Exiting unlockWebuser Method in "
                                + AppUserServiceImpl.class
                                + " class with response : Webuser Entry Unlock");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(true, "Webuser Entry Unlock"),
                                HttpStatus.OK);
                    } catch (Exception e) {

                        LOGGER.error("Error : " + e + "\nParam : "
                                + loggerEncoderUtil.encode(ur.toString())
                                + loggerEncoderUtil.encode(wua.toString()));
                        activityLogService.addActivity(user,
                                "failed to unlock webuser entry from audit",
                                "Error : " + e.toString() + ", Parameters : " + ur
                                        + wua);
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                } else {
                    activityLogService.addActivity(user, "Unautherized to unlock this entry",
                            " Parameters : " + ur + wua);
                    LOGGER.debug("Exiting unlockWebuser Method in " + AppUserServiceImpl.class
                            + " class with response : Unautherized to unlock this entry");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Unautherized to delete this entry"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                WebUser wu = null;
                try {
                    wu = webUserService.findByUserOrgId(ur.getId(), organizationRepositoryService
                            .findOrg(ur.getVcorgid()).getIorgid());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(ur.toString())
                            + loggerEncoderUtil.encode(wu.toString()));
                    activityLogService.addActivity(user,
                            "failed to delete webuser entry from audit",
                            "Error : " + e.toString() + ", Parameters : " + ur + wu);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                WebUserAudit wua = new WebUserAudit();
                wua = WebUserAudit.parseForAudit(wu);
                wua.setLoginAttempts(0);
                wua.setVcAction("M");
                wua.setVcRemark(ur.getRemark());
                wua.setIEntryUserID(user.getIuserID());

                try {
                    webUserAuditService.save(wua);
                    activityLogService.addActivity(user,
                            "Web User Delete Entry Submitted Successfully",
                            " Parameters : " + ur);
                    LOGGER.debug("Exiting deleteWebuser Method in " + AppUserServiceImpl.class
                            + " class with response : User management Web User Delete Entry Submitted Successfully");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(true,
                                    "Web User Unlock Entry Submitted Successfully"),
                            HttpStatus.OK);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(ur.toString())
                            + loggerEncoderUtil.encode(wua.toString()));
                    activityLogService.addActivity(user,
                            "failed to delete webuser entry from audit",
                            "Error : " + e.toString() + ", Parameters : " + ur + wu);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
            }
        } else {
            activityLogService.addActivity(user, "unauthorized to to unlock webuser entry from audit ");
            LOGGER.debug("Exiting newWebuserEntry Method in " + AppUserServiceImpl.class
                    + " class with response : unauthorized to to delete webuser entry from audit ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to unlock webuser entry from audit "),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> editWebuser(EditWebuserRequest ewr, Authentication pr) {
        LOGGER.debug("Entered editWebuser Method in " + AppUserServiceImpl.class + " class with parameters : "
                + loggerEncoderUtil.encode(ewr.toString()) + loggerEncoderUtil.encode(pr.toString()));
        LOGGER.debug("entering  class " + AppUserServiceImpl.class
                + " and method editWebuser");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser user = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isEdit() && loggedUser.allowOrg(ewr.getVcorgid())) {

            if(ewr.getUserpermissions().getValue() == 0){
                String errorMessage = "Cannot assign Drona God role";
                activityLogService.addActivity(user,
                        "Failed to edit user - " + errorMessage);
                LOGGER.debug("Exiting editWebuser Method in " + AppUserServiceImpl.class
                        + " class with response: failed to edit user - " + errorMessage);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, errorMessage),
                        HttpStatus.BAD_REQUEST);
            }

            WebUserAudit wua;

            if (ewr.getAudit()) {
                try {
                    wua = webUserAuditService.findByWebUserAuditId(ewr.getId(), ewr.getVcorgid());
                    LOGGER.info("audit entry retrived successfully");
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(ewr.toString()));
                    activityLogService.addActivity(user, "failed to edit webuser entry",
                            "Error : " + e.toString() + ", Parameters : " + ewr);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (!user.getIuserID().equals(wua.getIEntryUserID())) {
                    activityLogService.addActivity(user, "Unautherized to edit this entry",
                            " Parameters : " + ewr);
                    LOGGER.debug("Exiting editWebuser Method in " + AppUserServiceImpl.class
                            + " class with response : Unautherized to edit this entry");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Unauthorized to edit this entry"),
                            HttpStatus.BAD_REQUEST);
                }
                if (wua.getIstatus() != null && wua.isBclosed() == true) {
                    activityLogService.addActivity(user, "Checker operation already performed",
                            " Parameters : " + ewr);
                    LOGGER.debug("Exiting editWebuser Method in " + AppUserServiceImpl.class
                            + " class with response : Checker operation already performed");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Checker operation already performed"),
                            HttpStatus.BAD_REQUEST);
                }

            } else {

                Optional<WebuserMapping> wup = webuserMappingService.findByWebuserIDAndMappingType(ewr.getId(), "Role");

                if(wup.isPresent()){
                    if(wup.get().getMappingID() == 0){
                        String errorMessage = "Cannot edit user with Drona God role";
                        activityLogService.addActivity(user,
                                "Failed to edit user - " + errorMessage);
                        LOGGER.debug("Exiting editWebuser Method in " + AppUserServiceImpl.class
                                + " class with response: failed to edit user - " + errorMessage);
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, errorMessage),
                                HttpStatus.BAD_REQUEST);
                    }
                }else{
                    String errorMessage = "The user is not assigned a role";
                    activityLogService.addActivity(user,
                            "Failed to edit user - " + errorMessage);
                    LOGGER.debug("Exiting editWebuser Method in " + AppUserServiceImpl.class
                            + " class with response: failed to edit user - " + errorMessage);
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, errorMessage),
                            HttpStatus.BAD_REQUEST);
                }

                WebUserAudit pending = null;
                try {
                    pending = webUserAuditService.findPendingAddEntryByIUserID(ewr.getId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(ewr.toString()));
                    activityLogService.addActivity(user, "failed to perform checker operation",
                            "Error : " + e.toString() + ", Parameters : " + ewr);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                if (pending == null) {
                    try {
                        WebUser wu = webUserService.findByUserOrgId(ewr.getId(),
                                organizationRepositoryService.findOrg(ewr.getVcorgid())
                                        .getIorgid());
                        wua = WebUserAudit.parseForAudit(wu);
                        wua.setIUserID(wu.getIuserID());
                        wua.setVcAction("M");
                    } catch (Exception e) {
                        LOGGER.error("Error : " + e + "\nParam : "
                                + loggerEncoderUtil.encode(ewr.toString()));
                        activityLogService.addActivity(user, "failed to edit webuser entry",
                                "Error : " + e.toString() + ", Parameters : " + ewr);
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                } else {
                    LOGGER.debug("Exiting editWebuser Method in " + AppUserServiceImpl.class
                            + " class with response : Entry pending already");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Entry pending already"),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
            }
            String username = ewr.getEmailid();
            Pattern p = Pattern.compile("^.{1,64}$");
            Matcher m = p.matcher(ewr.getUsername());
            if (!m.matches()) {
                activityLogService.addActivity(user,
                        "failed to add new user because username was incorrect",
                        "Parameters : " + ewr);
                LOGGER.debug("Exiting newWebuserEntry Method in " + AppUserServiceImpl.class
                        + " class with response : Please valid usernam");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Please Enter valid username"),
                        HttpStatus.BAD_REQUEST);
            }

            Pattern numOnly = Pattern.compile("^[0-9]*$");
            Matcher mnum = numOnly.matcher(username);
            if (mnum.matches()) {
                activityLogService.addActivity(user,
                        "failed to add new user because username was incorrect",
                        "Parameters : " + ewr);
                LOGGER.debug("Exiting newWebuserEntry Method in " + AppUserServiceImpl.class
                        + " class with response : Please valid usernam");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Username cannot be all numbers"),
                        HttpStatus.BAD_REQUEST);
            }
//            JsonNode settings = user.getIorgId().getAttribs();
//            Boolean sso = settings.at("/ssoConfig/uiserver.sso").asBoolean();
//            if (!sso) {
//                String wordOrig = null;
//                try {
//                    wordOrig = loginPasswordUtil.decryptUserPassword(ewr.getPassword());
//                } catch (Exception e) {
//                    LOGGER.error("Error w.r.t pass: " + e + "\nParam : "
//                            + loggerEncoderUtil.encode(ewr.toString()));
//                    activityLogService.addActivity(user, "failed to edit webuser entry",
//                            "Error : " + e.toString() + ", Parameters : " + ewr);
//                    return new ResponseEntity<ApiResponse>(
//                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
//                            HttpStatus.INTERNAL_SERVER_ERROR);
//                }
//
//                String word;
//                if (wordOrig.equals(wua.getVcPassword())) {
//                    word = wordOrig;
//                } else {
//                    word = passwordEncoder.encode(wordOrig);
//                }
//
//                if (word == null) {
//                    activityLogService.addActivity(user,
//                            "failed to edit web user because password is not provided",
//                            " Parameters : " + ewr);
//                    LOGGER.debug("Exiting editWebuser Method in " + AppUserServiceImpl.class
//                            + " class with response : Please Enter Password");
//                    return new ResponseEntity<ApiResponse>(
//                            new ApiResponse(false, "Please Enter Password"),
//                            HttpStatus.BAD_REQUEST);
//                } else {
//                    if (StringUtils.containsIgnoreCase(wordOrig, ewr.getUsername())) {
//                        activityLogService.addActivity(user,
//                                "failed to edit web user because password cannot contain username",
//                                " Parameters : " + ewr);
//                        LOGGER.debug("Exiting editWebuser Method in " + AppUserServiceImpl.class
//                                + " class with response : Please Enter Password");
//                        return new ResponseEntity<ApiResponse>(
//                                new ApiResponse(false,
//                                        "Password cannot contain username"),
//                                HttpStatus.BAD_REQUEST);
//                    } else {
//                        wua.setVcPassword(word);
//                    }
//
//                }
//            }
            String emailid = ewr.getEmailid();
            String contact = ewr.getContact();
            String mobile = ewr.getMobile();
            String profileimg = ewr.getProfileimg();
            String firstname = ewr.getFirstname();
            String lastname = ewr.getLastname();
            String address = ewr.getAddress();
            String designation = ewr.getDesignation();
            String remark = ewr.getRemark();

            if (emailid == wua.getVcEmailID() && username == wua.getVcUserName()
                    && contact == wua.getVcContact()
                    && mobile == wua.getVcMobile() && profileimg == wua.getVcProfileImg()
                    && firstname == wua.getVcFirstName() && lastname == wua.getVcLastName()
                    && designation == wua.getVcDesignation() && address == wua.getVcAddress()
                    && remark == wua.getVcRemark()) {
                activityLogService.addActivity(user,
                        "failed to edit web user because user details not updated",
                        " Parameters : " + ewr);
                LOGGER.debug("Exiting editWebuser Method in " + AppUserServiceImpl.class
                        + " class with response : Please Update Details ");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please Update Details "),
                        HttpStatus.BAD_REQUEST);
            }

            if (username == null || username.isEmpty()) {
                activityLogService.addActivity(user,
                        "failed to edit web user because email id not provided",
                        " Parameters : " + ewr);
                LOGGER.debug("Exiting editWebuser Method in " + AppUserServiceImpl.class
                        + " class with response : Please Enter Email Id ");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please Enter Email Id"),
                        HttpStatus.BAD_REQUEST);
            } else {

                WebUser duplicateUsername = null;
                Optional<WebUser> dup = null;
                try {
                    // duplicateUsername=webUserService.findByUsername(username);
                    try {
                        dup = webUserService.findByUsernameAndOrgId(username, ewr.getVcorgid());
                        //Create similar method and call it without throwing error
                    } catch (UsernameNotFoundException e) {
                        // TODO: handle exception
                        LOGGER.error("Error : " + e + "\nParam : "
                                + loggerEncoderUtil.encode(ewr.toString()));
                        activityLogService.addActivity(user, "failed to edit webuser entry",
                                "Error : " + e.toString() + ", Parameters : " + ewr);
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    if (dup.isPresent()) {
                        if (!dup.get().getIuserID().equals(ewr.getId()) && ewr.getAudit() == false) {
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "Username already taken"),
                                    HttpStatus.CONFLICT);
                        }
                    }

                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(ewr.toString()));
                    activityLogService.addActivity(user, "failed to edit webuser entry",
                            "Error : " + e.toString() + ", Parameters : " + ewr);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (!username.equals(wua.getVcUserName())) {
                    WebUserAudit existaudit = null;
                    try {
                        // exist = webUserAuditService.findLastEntryByUserName(username);
                        existaudit = webUserAuditService
                                .findPendingAddEntryByUserName(username, ewr.getVcorgid());
                    } catch (Exception e) {

                        LOGGER.error("Error : " + e + "\nParam : "
                                + loggerEncoderUtil.encode(ewr.toString()));
                        activityLogService.addActivity(user, "failed to edit webuser entry",
                                "Error : " + e.toString() + ", Parameters : " + ewr);
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                    if (existaudit == null) {
                        WebUser dupU = null;
                        try {

                            dupU = webUserService.findByUsername(username, ewr.getVcorgid());
                        } catch (Exception e) {
                            dupU = null;
                        }
                        WebUserAudit uw = null;
                        try {
                            uw = webUserAuditService.findByUserName(username, ewr.getVcorgid());
                        } catch (Exception e) {
                            uw = null;
                        }

                        if (dupU != null && uw != null) {
                            if (dupU.getIuserID() != uw.getIUserID()) {
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                "Username already taken "),
                                        HttpStatus.CONFLICT);
                            }
                        }
                        WebUserAudit dupH = null;
                        try {
                            dupH = webUserAuditService.findByUserId(ewr.getId());
                        } catch (Exception e) {
                            dupH = null;
                        }

                        if (dupU != null && dupH != null && ewr.getAudit() == true) {
                            if (dupH.getIUserID() != null) {
                                if (dupU.getIuserID() != dupH.getIUserID()) {
                                    return new ResponseEntity<ApiResponse>(
                                            new ApiResponse(false,
                                                    "Username already taken "),
                                            HttpStatus.CONFLICT);
                                }
                            }

                        }
                        if (dupU != null && dupH == null) {
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "Username already taken "),
                                    HttpStatus.CONFLICT);
                        }

                        wua.setVcUserName(username);
                    } else {
                        WebUser dupU = null;
                        try {

                            dupU = webUserService.findByUsername(username, ewr.getVcorgid());
                        } catch (Exception e) {
                            dupU = null;
                        }
                        WebUser dupE = null;
                        try {
                            dupE = webUserService.findActiveEmail(emailid, ewr.getVcorgid());
                        } catch (Exception e) {
                            dupE = null;
                        }
                        if (existaudit.getIUserID() != dupU.getIuserID()) {
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "Username already taken"),
                                    HttpStatus.CONFLICT);
                        }

                        if (dupE != null) {
                            if (dupE.getVcEmailID().equals(existaudit.getVcEmailID())
                                    && !Objects.equals(dupE.getIuserID(), existaudit
                                    .getIUserID())) {
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                "Email id  already taken"),
                                        HttpStatus.CONFLICT);
                            }
                        }
                        WebUser exist = null;
                        try {
                            exist = webUserService.findByUsername(username, ewr.getVcorgid());
                        } catch (Exception e) {

                            LOGGER.error("Error : " + e + "\nParam : "
                                    + loggerEncoderUtil.encode(ewr.toString()));
                            activityLogService.addActivity(user,
                                    "failed to edit webuser entry",
                                    "Error : " + e.toString() + ", Parameters : "
                                            + ewr);
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                        if (exist != null) {
                            activityLogService.addActivity(user,
                                    "failed to edit web user because Username Already In Use",
                                    " Parameters : " + ewr);
                            LOGGER.debug("Exiting editWebuser Method in "
                                    + AppUserServiceImpl.class
                                    + " class with response : Username Already In Use. !Please try different ");
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "Username Already In Use. !Please try different"),
                                    HttpStatus.CONFLICT);
                        } else {
                            activityLogService.addActivity(user,
                                    "failed to edit web user because Entry with this username already exists and is pending for approval",
                                    " Parameters : " + ewr);
                            LOGGER.debug("Exiting editWebuser Method in "
                                    + AppUserServiceImpl.class
                                    + " class with response : Entry with this username already exists and is pending for approval. Please use a different username.");
                            return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                                    "Entry with this username already exists and is pending for approval. Please use a different username."),
                                    HttpStatus.CONFLICT);
                        }
                    }
                }
            }

            if (ewr.getAudit() == true) {
                WebUser dupE = null;
                try {
                    dupE = webUserService.findActiveEmail(emailid, ewr.getVcorgid());
                } catch (Exception e) {
                    dupE = null;
                }
                WebUserAudit dupAE = null;
                try {
                    dupAE = webUserAuditService.findByUserId(ewr.getId());
                } catch (Exception e) {
                    dupAE = null;
                }
                WebUserAudit dupEm = null;
                try {
                    dupEm = webUserAuditService.findByEmail(ewr.getEmailid(), ewr.getVcorgid());
                } catch (Exception e) {
                    dupEm = null;
                }
                WebUserAudit liW = null;
                try {
                    liW = webUserAuditService.findByUserName(ewr.getUsername(), ewr.getVcorgid());
                } catch (Exception e) {
                    liW = null;
                }

                if (dupEm == null) {
                    if (dupE != null) {
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, "Email id  already taken"),
                                HttpStatus.CONFLICT);
                    }
                }

                if (liW != null) {
                    if (liW.getIUserAuditID() != ewr.getId()) {
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, "Username already taken"),
                                HttpStatus.CONFLICT);
                    }
                }
                if (dupEm != null && dupAE != null) {
                    if (dupEm.getIUserID() != null && dupAE.getIUserID() != null) {
                        if (!dupEm.getIUserID().equals(dupAE.getIUserID())) {
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "Email id  already taken"),
                                    HttpStatus.CONFLICT);
                        }
                    }
                    if (dupEm.getIUserID() == null) {
                        WebUser dupEmail = null;
                        try {
                            dupEmail = webUserService.findActiveEmail(ewr.getEmailid(), ewr.getVcorgid());
                        } catch (Exception e) {
                            dupEmail = null;
                        }
                        if (dupEmail != null && dupEmail.getIStatus().getIStatusID() != 4) {
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "Email id  already taken"),
                                    HttpStatus.CONFLICT);
                        }

                        WebUser dupUsername = null;
                        try {
                            dupUsername = webUserService.findByUsername(ewr.getUsername(), ewr.getVcorgid());
                        } catch (Exception e) {
                            dupUsername = null;
                        }
                        if (dupUsername != null) {
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "Username already taken"),
                                    HttpStatus.CONFLICT);
                        }
                    }

                }

                if (dupAE != null && dupE != null) {
                    if (dupAE.getVcEmailID().equals(dupE.getVcEmailID())) {
                        if (!Objects.equals(dupAE.getIUserID(), dupE.getIuserID())) {
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "Email id  already taken"),
                                    HttpStatus.CONFLICT);
                        }
                    }
                    if (dupAE.getIUserID() != null) {
                        if (dupE.getVcEmailID().equals(ewr.getEmailid())
                                && !dupAE.getIUserID().equals(dupE.getIuserID())) {

                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "Email id  already taken"),
                                    HttpStatus.CONFLICT);

                        }
                    }
                }
            } else {
                WebUserAudit dupEm = null;
                try {
                    dupEm = webUserAuditService.findByEmail(ewr.getEmailid(), ewr.getVcorgid());
                } catch (Exception e) {
                    dupEm = null;
                }
                WebUserAudit liW = null;
                try {
                    liW = webUserAuditService.findByUserName(ewr.getUsername(), ewr.getVcorgid());
                } catch (Exception e) {
                    liW = null;
                }

                if (dupEm != null) {
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Email id  already taken"),
                            HttpStatus.CONFLICT);
                }

                if (liW != null) {
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Username already taken"),
                            HttpStatus.CONFLICT);
                }

            }

            if (emailid == null) {
                activityLogService.addActivity(user,
                        "failed to edit web user because email is not provided",
                        " Parameters : " + ewr);
                LOGGER.debug("Exiting editWebuser Method in " + AppUserServiceImpl.class
                        + " class with response : Please Enter Email");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please Enter Email"),
                        HttpStatus.BAD_REQUEST);
            } else {

                WebUser duplicateEmail = null;
                try {
                    duplicateEmail = webUserService.findActiveEmail(emailid, ewr.getVcorgid());
                    if (duplicateEmail != null) {

                        if (!duplicateEmail.getUsername().equals(username)
                                && duplicateEmail.getIuserID() != ewr.getId()
                                && ewr.getAudit() == false) {
                            if (duplicateEmail.getVcEmailID().equals(emailid)) {
                                activityLogService.addActivity(user,
                                        "failed to edit user because email was already taken",
                                        "Parameters : " + ewr);
                                LOGGER.debug("Exiting newWebuserEntry Method in "
                                        + AppUserServiceImpl.class
                                        + " class with response : Email id already taken");
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                "Email id is already taken"),
                                        HttpStatus.CONFLICT);
                            }
                        }

                        if (ewr.getAudit() == true) {
                            WebUserAudit wb = webUserAuditService.findByEmail(emailid, ewr.getVcorgid());
                            if (wb != null) {
                                if (wb.getIUserAuditID() != ewr.getId()) {
                                    activityLogService.addActivity(user,
                                            "failed to edit user because email was already taken",
                                            "Parameters : " + ewr);
                                    LOGGER.debug("Exiting newWebuserEntry Method in "
                                            + AppUserServiceImpl.class
                                            + " class with response : Email id already taken");
                                    return new ResponseEntity<ApiResponse>(
                                            new ApiResponse(false,
                                                    "Email id is already taken"),
                                            HttpStatus.CONFLICT);
                                }
                            }

                        }

                    }
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(ewr.toString()));
                    activityLogService.addActivity(user, "failed to edit user",
                            "Error : " + e.toString() + ", Parameters : " + ewr);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                String regex = "^(.+)@(\\S+)$";
                Pattern pattern = Pattern.compile(regex);
                Matcher matcher = pattern.matcher(emailid);
                if (matcher.matches()) {
                    wua.setVcEmailID(emailid);
                } else {
                    activityLogService.addActivity(user,
                            "failed to edit web user because email is not valid",
                            " Parameters : " + ewr);
                    LOGGER.debug("Exiting editWebuser Method in " + AppUserServiceImpl.class
                            + " class with response : Please Enter Email");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Please Enter Valid Email Address"),
                            HttpStatus.BAD_REQUEST);
                }
            }
            if (mobile != null) {
                if (!mobile.isBlank()) {
                    if (mobile.length() < 10) {
                        activityLogService.addActivity(user,
                                "failed to edit web user because valid mobile number is not provided",
                                " Parameters : " + ewr);
                        LOGGER.debug("Exiting editWebuser Method in " + AppUserServiceImpl.class
                                + " class with response : Please Enter Valid Mobile No.");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, "Please Enter Valid Mobile No."),
                                HttpStatus.BAD_REQUEST);
                    } else {
                        wua.setVcMobile(mobile);
                    }
                }
            }
            wua.setVcContact(contact);
            wua.setVcProfileImg(profileimg);

            if (firstname == null || firstname.isEmpty()) {
                activityLogService.addActivity(user,
                        "failed to edit web user because first name is not provided",
                        " Parameters : " + ewr);
                LOGGER.debug("Exiting editWebuser Method in " + AppUserServiceImpl.class
                        + " class with response : Please Enter First Name");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Please Enter First Name"),
                        HttpStatus.BAD_REQUEST);
            } else {
                wua.setVcFirstName(firstname);
            }

            if (lastname == null || lastname.isEmpty()) {
                activityLogService.addActivity(user,
                        "failed to edit web user because last name is not provided",
                        " Parameters : " + ewr);
                LOGGER.debug("Exiting editWebuser Method in " + AppUserServiceImpl.class
                        + " class with response : Please Enter Last Name");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please Enter Last Name"),
                        HttpStatus.BAD_REQUEST);
            } else {
                wua.setVcLastName(lastname);
            }

            wua.setVcAddress(address);
            wua.setVcDesignation(designation);

            if (remark == null || remark.isEmpty()) {
                activityLogService.addActivity(user,
                        "failed to add new user because maker remark is Null",
                        "Parameters : " + ewr);
                LOGGER.debug("Exiting editWebuserEntry Method in " + AppUserServiceImpl.class
                        + " class with response : Please Enter Maker remark");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Please Enter Maker Remark"),
                        HttpStatus.BAD_REQUEST);
            } else {
                wua.setVcRemark(remark);
            }

            wua.setIEntryUserID(user.getIuserID());

            List<Integer> tids = ewr.getUsertenants();

            List<UserPermissionRequest> wids = new ArrayList<>();
            if (ewr.getUserworkflows() != null) {
                wids = ewr.getUserworkflows();
            }

            List<UserPermissionRequest> cids = new ArrayList<>();
            if (ewr.getUserclasses() != null) {
                cids = ewr.getUserclasses();
            }

            List<UserPermissionRequest> gids = new ArrayList<>();
            if (ewr.getUsergroups() != null) {
                gids = ewr.getUsergroups();
            }

            UserPermissionRequest rid = ewr.getUserpermissions();

            Boolean isApprove = roleMenuAccessMapService.getIsRoleApprove(
                    UserPermissionRequestMapper.parseToUserMap(Arrays.asList(rid)),
                    MenuNames.appUsers);

            if (isApprove) {
                System.out.println("Adding add user");
                try {
                    GroupDesc gdesc = groupDescService.findByVcGroupID(usermanagement_groupid, tids.get(0));
                    UserPermissionRequest req = new UserPermissionRequest();
                    req.setValue(gdesc.getIgroupID());
                    req.setItenantId(gdesc.getItenantId());
                    gids.add(req);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(ewr.toString()));
                    activityLogService.addActivity(user, "failed to add new user",
                            "Error : " + e.toString() + ", Parameters : " + ewr);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
            }

            try {

                webUserAuditService.save(wua,
                        webuserMappingUtil.getWebuserMappingAuditAll(rid, gids, wids, cids,
                                tids, wua));
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(ewr.toString()));
                activityLogService.addActivity(user, "failed to add new user",
                        "Error : " + e.toString() + ", Parameters : " + ewr);
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            activityLogService.addActivity(user, "web user edit entry added", " Parameters : " + wua);
            LOGGER.debug("Exiting editWebuser Method in " + AppUserServiceImpl.class
                    + " class with response : Entry Recorded Successfully ");
            return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Entry Recorded Successfully"),
                    HttpStatus.OK);
        } else {
            activityLogService.addActivity(user, "unauthorized to edit web user entry ");
            LOGGER.debug("Exiting editWebuser Method in " + AppUserServiceImpl.class
                    + " class with response : unauthorized to edit web user entry ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, " unauthorized to edit web user entry "),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> editLoggedInUser(EditUseObj euo, Authentication pr) {
        LOGGER.debug("Entered editLoggedInUser Method in " + AppUserServiceImpl.class + " class ");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser user = loggedUser.getWebUser();

        if (euo.getVcFirstName() == null || euo.getVcFirstName() == "") {
            LOGGER.debug("Exiting editLoggedInUser Method in " + AppUserServiceImpl.class
                    + " class with response : First name cannot be empty ");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "First name cannot be empty"),
                    HttpStatus.BAD_REQUEST);
        }

        if (euo.getVcLastName() == null || euo.getVcLastName() == "") {
            LOGGER.debug("Exiting editLoggedInUser Method in " + AppUserServiceImpl.class
                    + " class with response : Last name cannot be empty");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Last name cannot be empty"),
                    HttpStatus.BAD_REQUEST);
        }

//                if (euo.getVcMobile() == null || euo.getVcMobile() == "") {
//                        LOGGER.debug("Exiting editLoggedInUser Method in " + AppUserServiceImpl.class
//                                        + " class with response : Mobile number cannot be empty");
//                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Mobile number cannot be empty"),
//                                        HttpStatus.BAD_REQUEST);
//                }

        if (euo.getVcEmailID() == null || euo.getVcEmailID() == "") {
            LOGGER.debug("Exiting editLoggedInUser Method in " + AppUserServiceImpl.class
                    + " class with response : Email cannot be empty");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Email cannot be empty"),
                    HttpStatus.BAD_REQUEST);
        }

        String regex = "^(.+)@(\\S+)$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(euo.getVcEmailID());
        if (matcher.matches()) {
            user.setVcEmailID(euo.getVcEmailID());
        } else {
            LOGGER.debug("Exiting editLoggedInUser Method in " + AppUserServiceImpl.class
                    + " class with response : Invalid email id");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Invalid email id"),
                    HttpStatus.BAD_REQUEST);
        }

        try {
            user.setVcFirstName(euo.getVcFirstName());
            user.setVcLastName(euo.getVcLastName());
            user.setVcDesignation(euo.getVcDesignation());
            user.setVcAddress(euo.getVcAddress());
            user.setVcContact(euo.getVcContact());
            user.setVcMobile(euo.getVcMobile());
            user.setTimeZone(euo.getTimezone());
            // loggedInUser.setVcProfileImg(user.getVcProfileImg());
        } catch (Exception e) {

            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(euo.toString()));
            activityLogService.addActivity(user, "failed to edit profile",
                    "Error : " + e.toString() + ", Parameters : " + euo);
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        try {
            webUserService.save(user);
            LOGGER.debug("Exiting editLoggedInUser Method in " + AppUserServiceImpl.class
                    + " class with response : Profile edited successfully");
            return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Profile edited successfully"),
                    HttpStatus.OK);
        } catch (Exception e) {

            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(euo.toString()));
            activityLogService.addActivity(user, "failed to edit profile",
                    "Error : " + e.toString() + ", Parameters : " + euo);
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @Override
    public ResponseEntity<?> changePassword(ChangePasswordRequest cp, Authentication pr) {

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        JsonNode settings = loggedInUser.getIorgId().getAttribs();
        Boolean sso = settings.at("/ssoConfig/uiserver.sso").asBoolean();
        if (!sso) {
            String wordOrigOld = null;
            String wordOrigNew = null;
            String wordOrigNewConfirm = null;
            try {
                wordOrigOld = loginPasswordUtil.decryptUserPassword(cp.getOldPassword());
                wordOrigNew = loginPasswordUtil.decryptUserPassword(cp.getNewPassword());
                wordOrigNewConfirm = loginPasswordUtil.decryptUserPassword(cp.getConfirmNewPassword());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : "
                        + loggerEncoderUtil.encode(loggedInUser.toString()));
                activityLogService.addActivity(loggedInUser, "failed to decrypt password",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (wordOrigOld == null || wordOrigOld == "") {
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Please enter old password"),
                        HttpStatus.BAD_REQUEST);
            }

            if (wordOrigNew == null || wordOrigNew == "") {
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Please enter new password"),
                        HttpStatus.BAD_REQUEST);
            }

            if (wordOrigNewConfirm == null || wordOrigNewConfirm == "") {
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Please enter confirm password"),
                        HttpStatus.BAD_REQUEST);
            }

            if (!passwordEncoder.matches(wordOrigOld, loggedInUser.getVcPassword())) {
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Old password is wrong"),
                        HttpStatus.BAD_REQUEST);
            }

            if (!wordOrigNew.equals(wordOrigNewConfirm)) {
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Confirm Password doesn't match with new password"),
                        HttpStatus.BAD_REQUEST);
            }

            String newEncodeWord = passwordEncoder.encode(wordOrigNew);
            if (passwordEncoder.matches(wordOrigNew, loggedInUser.getVcPassword())) {
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "New password cannot be same as old password"),
                        HttpStatus.BAD_REQUEST);
            }

            if (wordOrigNew.equals(loggedInUser.getVcUserName())) {
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Password cannot be same username"),
                        HttpStatus.BAD_REQUEST);
            }

            if (StringUtils.containsIgnoreCase(wordOrigNew, loggedInUser.getUsername())) {
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Password cannot contain username"),
                        HttpStatus.BAD_REQUEST);
            }

            String regex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{"
                    + env.getProperty("minimum.password.length") + ","
                    + env.getProperty("max.password.length") + "}$";
            Pattern pattern = Pattern.compile(regex);
            Matcher matcher = pattern.matcher(wordOrigNew);
            if (!matcher.matches()) {
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Password must meet minimum requirements mentioned in policy"),
                        HttpStatus.BAD_REQUEST);
            }

            try {
                loggedInUser.setVcPassword(newEncodeWord);
                loggedInUser.setDtLastPasswordUpdated(ZonedDateTime.now());
                ApiResponse saveResponse = webUserService.save(loggedInUser, wordOrigNew);

                if (!saveResponse.getSuccess()) {
                    LOGGER.debug("Exiting class " + AppUserServiceImpl.class
                            + " and method changePassword with response: " + saveResponse.getMessage());
                    return new ResponseEntity<>(saveResponse, saveResponse.getStatus());
                }
                activeLoginTokenService.deleteTokenByUserID(loggedInUser);
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(true, "Password Changed successfully"),
                        HttpStatus.OK);

            } catch (Exception e) {

                LOGGER.error("Error : " + e + ", Parameters : "
                        + loggerEncoderUtil.encode(cp.toString()));
                activityLogService.addActivity(loggedInUser, "failed to add new user ",
                        "Error : " + e.toString() + ", Parameters : " + cp);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            LOGGER.error("Error : SSO is enabled password change is not allowed , Parameters : "
                    + loggerEncoderUtil.encode(cp.toString()));
            activityLogService.addActivity(loggedInUser, "Failed to update password because SSO is enabled",
                    "Error : Failed to update password because SSO is enabled, Parameters : " + cp);
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Failed to update password because SSO is enabled"),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    public ResponseEntity<?> getTimeZone(Authentication pr) {
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();

        Set<String> timeZones = ZoneId.getAvailableZoneIds();
        List<String> t = new ArrayList<>();

        List<DropdownWithObject> response = new ArrayList<>();
        t.addAll(timeZones);
        try {
            for (int i = 0; i < t.size(); i++) {
                DropdownWithObject obj = DropdownWithObject.builder()
                        .label(t.get(i))
                        .value(t.get(i))
                        .build();
                response.add(obj);
            }
        } catch (Exception e) {

            LOGGER.error("Error : " + e);
            activityLogService.addActivity(loggedInUser, "failed to add new user ",
                    "Error : " + e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return ResponseEntity.ok(response);
    }
    // @Override
    // public ResponseEntity<?> profilePicUpload(MultipartFile file, Authentication
    // pr) {
    // WebUser userObj = webUserService.loadUserByUsername(pr.getName());
    // String fileName;
    // if (file.getOriginalFilename().startsWith(".")) {
    // activityLogService.addActivity(userObj, "failed to upload profile pic ");
    // return new ResponseEntity<ApiResponse>(
    // new ApiResponse(false, "Invalid file ,file name cannot start with '.'"),
    // HttpStatus.UNSUPPORTED_MEDIA_TYPE);
    // }
    // if (env.getProperty("profilepic.file.types").contains(file.getContentType())
    // || file.getSize() < 5) {
    // try {
    // fileName = fileStorageService.storeFile(file);
    // } catch (Exception e) {
    // e.printStackTrace();
    // LOGGER.error("Error : " + e.toString());
    // activityLogService.addActivity(userObj, "failed to get sidebar data",
    // "{ \"Username\": \"" + pr.getName() + "\"}");
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went
    // wrong"),
    // HttpStatus.INTERNAL_SERVER_ERROR);
    // }

    @Override
    public ResponseEntity<?> getAllTenants(String orgid, String menuname, Authentication pr) {
        LOGGER.debug("entering  class " + AppUserServiceImpl.class
                + " and method getAllTenants");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser user = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menuname);
        if (mp.isView()) {

            List<Tenant> allTenants = new ArrayList<>();
            String userOrg = user.getIorgId().getVcOrgId();
            // if user's org is admin org, then provide all tenants of requested org (to
            // handle user management's dropdown in admin org)
            // else provide tenants that the user has access to (to handle tenant dropdowns
            // for all screens in individual org)
            if (userOrg.equals(MultiTenant.adminOrg)) {
                try {
                    allTenants = tenantRepositoryService.findByOrgId(orgid);
                } catch (Exception e) {
                    LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString()) + "\nParam : "
                            + loggerEncoderUtil.encode(user.toString()));
                    activityLogService.addActivity(user, "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
            } else {
                allTenants = loggedUser.getTenant();
            }

            List<UserPermissionRequest> resp = new ArrayList<>();
            resp = UserPermissionRequestMapper.parseTenant(allTenants);
            return ResponseEntity.ok(resp);
        } else {
            activityLogService.addActivity(user, "unauthorized to get list of tenants");
            LOGGER.debug("Exiting editWebuser Method in " + AppUserServiceImpl.class
                    + " class with response : unauthorized to get list of tenants ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, " unauthorized to get list of tenants"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getAllWorflows(String menuname, TenantListRequest req, Authentication pr) {
        LOGGER.debug("entering  class " + AppUserServiceImpl.class
                + " and method getAllWorkflows");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser user = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menuname);
        if (!mp.isView()) {
            activityLogService.addActivity(user, "unauthorized to get list of tenants");
            LOGGER.debug("Exiting editWebuser Method in " + AppUserServiceImpl.class
                    + " class with response : unauthorized to get list of tenants ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, " unauthorized to get list of tenants"),
                    HttpStatus.FORBIDDEN);
        }

        // // if empty, then request is for all tenants of loggedin user
        // if (tenantIds.isEmpty()) {
        // tenantIds = user.getUserTenant();
        // }

        List<WorkflowMasters> allWorkflows = loggedUser.getWorkflows().stream()
                .filter(wfl -> (req.getTenants().contains(wfl.getItenantId().getItenantid())
                        && wfl.getIsFilterDisplay()))
                .toList();

        List<WorkflowResponse> resp = allWorkflows.stream()
                .map(wfl -> {
                    return WorkflowResponse.builder()
                            .label(wfl.getWorkflowName())
                            .value(wfl.getWorkflowId())
                            .workflowKey(wfl.getWorkflowKey())
                            .itenantId(wfl.getItenantId().getItenantid())
                            .build();
                }).collect(Collectors.toList());
        return ResponseEntity.ok(resp);

    }

    // String fileDownloadUri = "/api/v1/downloadFile/" + fileName;

    // try {
    // if (file.getSize() < 10) {
    // userObj.setVcProfileImg(null);
    // } else {
    // userObj.setVcProfileImg(fileDownloadUri);
    // }
    // webUserService.save(userObj);

    // } catch (Exception e) {

    // e.printStackTrace();
    // LOGGER.error("Error : ", e + ", Parameters : " + fileName);
    // activityLogService.addActivity(userObj, "failed to change profile pic ",
    // "Error : " + e.toString() + ", Parameters : " + fileName);
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went
    // wrong"),
    // HttpStatus.INTERNAL_SERVER_ERROR);
    // }

    // ServletUriComponentsBuilder.fromCurrentContextPath().path("/api/v1/downloadFile/").path(fileName)
    // .toUriString();
    // activityLogService.addActivity(userObj, "file uploaded successfully",
    // "{ \"filename\": \"" + fileName + "\"}");
    // return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Profile pic
    // changed successfully"),
    // HttpStatus.OK);
    // } else {
    // activityLogService.addActivity(userObj, "failed to upload profile pic ");
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please upload
    // jpg/png only"),
    // HttpStatus.UNSUPPORTED_MEDIA_TYPE);
    // }

    // }

    @Override
    public ResponseEntity<?> resetUserPassword(ResetUserPasswordRequest request, Authentication user) {
        LOGGER.debug("Entered resetUserPassword method in " + AppUserServiceImpl.class
                + " class with parameters: " + request);

        LoggedUser loggedUser = (LoggedUser) user.getPrincipal();
        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isApprove() && loggedUser.allowOrg(request.getVcOrgId())) {
            try {
                WebUser resetPasswordUser = webUserService.findActiveEmail(request.getUsername(), request.getVcOrgId());
                if (resetPasswordUser != null) {
                    // Generate random password
                    String temporary = passwordGenerator.generateSecurePassword();

                    ZonedDateTime now = ZonedDateTime.now();
                    if (resetPasswordUser.getDtLastPasswordEmailSentAt() != null
                            && resetPasswordUser.getDtLastPasswordEmailSentAt().plusMinutes(15).isAfter(now)) {
                        LOGGER.error("Reset password email request limit exceeded for user: " + request.getUsername());
                        return new ResponseEntity<>(
                                new ApiResponse(false, "Reset password email request limit exceeded. Please try again after 15 minutes"),
                                HttpStatus.TOO_MANY_REQUESTS);
                    }

                    String drona_ui_url = loggedInUser.getIorgId().geturl();
                    // Send email
                    EmailRequest emailRequest = new EmailRequest();
                    emailRequest.setTemplateid(33);
                    emailRequest.setToEmail(Arrays.asList(request.getUsername()));
                    Map<String, Object> subjectParams = new HashMap<>();
                    subjectParams.put("temporaryPassword", temporary);
                    subjectParams.put("loginurl", drona_ui_url + "/dronaui/" +
                            resetPasswordUser.getIorgId().getVcOrgId() + "/auth/login");
                    emailRequest.setBodyParams(subjectParams);
                    emailRequest.setSensitiveVariables(Collections.singletonList("temporaryPassword"));
                    ObjectMapper mapper = new ObjectMapper();
                    String emailReqString = mapper.writeValueAsString(emailRequest);
                    AllUsersMapping allMappingInfo = webuserMappingUtil.getWebUserMappings(
                            Arrays.asList(resetPasswordUser.getIuserID()), resetPasswordUser.getIorgId().getIorgid());
                    ResponseEntity<?> emailResponse = emailController.sendEmail(emailReqString, allMappingInfo.getUserTenant().get(resetPasswordUser.getIuserID()).get(0));
                    if (!emailResponse.getStatusCode().equals(HttpStatus.OK)) {
                        return emailResponse;
                    }
                    // Update user details
                    resetPasswordUser.setDtLastPasswordEmailSentAt(now);
                    resetPasswordUser.setDtLastPasswordUpdated(null);
                    resetPasswordUser.setVcPassword(passwordEncoder.encode(temporary));

                    // Save updated user details
                    ApiResponse saveResponse = webUserService.save(resetPasswordUser, temporary);

                    if (!saveResponse.getSuccess()) {
                        LOGGER.debug("Exiting class " + AppUserServiceImpl.class
                                + " and method resetUserPassword with response: " + saveResponse.getMessage());
                        return new ResponseEntity<>(saveResponse, saveResponse.getStatus());
                    }

                    LOGGER.debug("Exiting class " + AppUserServiceImpl.class
                            + " and method resetUserPassword with response: Email sent successfully");

                    return new ResponseEntity<>(new ApiResponse(true, "Password reset email sent successfully"), HttpStatus.OK);
                } else {
                    LOGGER.debug("Exiting class " + AppUserServiceImpl.class
                            + " and method resetUserPassword with response: User not found");
                    return new ResponseEntity<>(
                            new ApiResponse(false, "Failed to send reset password email. User not found"),
                            HttpStatus.BAD_REQUEST);
                }
            } catch (Exception e) {
                LOGGER.error("Error: " + loggerEncoderUtil.encode(e.toString()) + "\nParam: "
                        + loggerEncoderUtil.encode(request.getUsername()));
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "Unauthorized attempt to reset user password");
            LOGGER.debug("Exiting resetUserPassword method in " + AppUserServiceImpl.class
                    + " class with response: Unauthorized to reset user password");
            return new ResponseEntity<>(
                    new ApiResponse(false, "You do not have permission to reset user passwords"),
                    HttpStatus.FORBIDDEN);
        }
    }


}
