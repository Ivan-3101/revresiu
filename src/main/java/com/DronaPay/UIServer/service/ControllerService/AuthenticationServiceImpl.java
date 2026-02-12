package com.DronaPay.UIServer.service.ControllerService;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.Enum.DronaGodMenu;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.VOMapper.UserInfoResponseMapper;
import com.DronaPay.UIServer.Views.UserRoleMenuAccess;
import com.DronaPay.UIServer.controller.EmailServiceController.EmailController;
import com.DronaPay.UIServer.exception.TokenNotValid;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.requests.*;
import com.DronaPay.UIServer.response.*;
import com.DronaPay.UIServer.response.Records.SSOConfigResponse;
import com.DronaPay.UIServer.security.JWTTokenHelper;
import com.DronaPay.UIServer.security.WebUserAuthProvider;
import com.DronaPay.UIServer.service.ControllerService.CaseManagement.TasksServiceImpl;
import com.DronaPay.UIServer.service.FileStorageService;
import com.DronaPay.UIServer.service.KafkaServices.EmailRequestPublisherService;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.service.SSOService;
import com.DronaPay.UIServer.util.*;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
//import net.bytebuddy.utility.RandomString;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.time.ZonedDateTime;
import java.util.*;
import java.util.function.Function;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Service
public class AuthenticationServiceImpl implements AuthenticationService {

    public static final Logger LOGGER = LoggerFactory.getLogger(AuthenticationServiceImpl.class);
    final String menu_name = MenuNames.profile;
    @Autowired
    private WebUserAuthProvider webUserAuthProvider;
    @Autowired
    private ActivityLogService activityLogService;
    @Autowired
    private WebUserService webUserService;

    // @Autowired
    // private UserDetailsService userDetailsService;
    @Autowired
    private JWTTokenHelper jWTTokenHelper;
    @Autowired
    private UserRoleMenuAccessService userRoleMenuAccessService;

    // @Autowired
    // private EmailControllerService emailGenericService;
    @Autowired
    private FileStorageService fileStorageService;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private Environment env;
    @Autowired
    private ActiveLoginTokenService activeLoginTokenService;
    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;
    @Autowired
    private LoginPasswordUtil loginPasswordUtil;
    @Autowired
    private MenuStructureDescService menuStructureDescService;

    @Value("${user.login.public.key}")
    private String user_login_public_key;


    @Value("${bulk.processing.limit}")
    private Long bulkProcessingLimit;

    @Value("${42c.UsfbIvrLink}")
    private String usfbIvrLink;

    @Value("${42c.CubIvrLink}")
    private String cubIvrLink;

    @Value("${42c.ESAFIvrLink}")
    private String esafIvrLink;

    @Value("${42c.SSFBIvrLink}")
    private String ssfbIvrLink;

//    @Value("${drona.ui.url}")
//    private String drona_ui_url;

//    @Value(value = "${drona.ui.authorize}")
//    private String authorizeurl;
//
//    @Value(value = "${drona.ui.logout.url}")
//    private String logouturl;
//
//    @Value(value = "${drona.ui.redirect.url}")
//    private String dronauiurl;

//        @Value(value = "${drona.ui.clientid}")
//        private String clientid;

//    @Value(value = "${drona.ui.scope}")
//    private String scope;

//    @Value("${UIServer.SSO}")
//    private Boolean sso;

    //    @Value("${UIServer.SSO.type}")
//    private String ssoType;
    @Autowired
    private SSOService ssoService;

    //    @Value("${spring.security.oauth2.resourceserver.jwt.user-name-attribute}")
//    private String userNameAttrib;
    @Value("${jwt.auth.expires_in}")
    private Integer expirein;

    @Value("${change.password.expiry}")
    private Long passwordExpire;

    @Value("${logo.directory}")
    private String logo_directory;

    @Value("${idle.token.expiry.time}")
    private Integer tokenExpiryTime;

    //     @Value(value = "${pismo.processing.enabled}")
//     private Boolean pismoEnabled;
    @Autowired
    private EmailRequestPublisherService emailProducerService;
    @Autowired
    private EmailController emailController;
    @Autowired
    private OrganizationRepositoryService organizationRepositoryService;
    @Autowired
    private RoleDescService roleDescService;
    @Autowired
    private TenantRepositoryService tenantRepositoryService;

    @Autowired
    private WebuserMappingUtil webuserMappingUtil;

    @Autowired
    private FilePathChecker filePathChecker;

    @Override
    public ResponseEntity<?> logAuth(AuthenticationRequest authenticationRequest, HttpServletRequest request)
            throws InvalidKeySpecException, NoSuchAlgorithmException {
        Authentication authentication = null;
        WebUser findUser = null;
        //findUser = webUserService.loadUserByUsername(authenticationRequest.getUserName());
        findUser = webUserService.findByUsernameForLogin(authenticationRequest.getUserName(), authenticationRequest.getOrgId());
        //System.out.println("user id is " + findUser.getIuserID() + "user org " + findUser.getIorgId());
        if (findUser != null) {
            if (!findUser.getIorgId().getVcOrgId().equals(authenticationRequest.getOrgId())) {
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Please Enter Valid Credentials"),
                        HttpStatus.BAD_REQUEST);
            }
            if (findUser.getLoginAttempts() >= Integer.parseInt(env.getProperty("account.lock.attempts"))) {

                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Account locked please contact admin"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            findUser.setLoginAttempts(findUser.getLoginAttempts() + 1);
            try {
                webUserService.save(findUser);
            } catch (Exception e) {
                LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString()) + "\nParam : "
                        + loggerEncoderUtil.encode(authenticationRequest.getUserName()));
                activityLogService.addActivity(findUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }
        String word = null;
        try {
            word = loginPasswordUtil.decryptUserPassword(authenticationRequest.getPassword());
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : { \"Username\": \""
                    + loggerEncoderUtil.encode(authenticationRequest.getUserName())
                    + "\", \"IPAddress\" : \"" + loggerEncoderUtil.encode(request.getRemoteAddr()) + "\"}");
            activityLogService.addActivity(findUser, "Login Failed",
                    "{ \"Username\": \"" + authenticationRequest.getUserName()
                            + "\", \"IPAddress\" : \"" + request.getRemoteAddr()
                            + "\"}");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        try {
            authentication = webUserAuthProvider.authenticate(new UsernamePasswordAuthenticationToken(
                    findUser.getIuserID(), word));
            SecurityContextHolder.getContext().setAuthentication(authentication);
        } catch (BadCredentialsException e) {
            LOGGER.info("Error : " + loggerEncoderUtil.encode(e.toString())
                    + "\nParam : { \"Username\": \""
                    + loggerEncoderUtil.encode(authenticationRequest.getUserName())
                    + "\", \"IPAddress\" : \"" + loggerEncoderUtil.encode(request.getRemoteAddr())
                    + "\"}");
            activityLogService.addActivity(findUser, "Login Failed",
                    "{ \"Username\": \"" + authenticationRequest.getUserName()
                            + "\", \"IPAddress\" : \"" + request.getRemoteAddr() + "\"}");

            if (findUser.getLoginAttempts() == Integer.parseInt(env.getProperty("account.lock.attempts"))) {
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Account locked please contact admin"),
                        HttpStatus.BAD_REQUEST);
            }
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please Enter Valid Credentials"),
                    HttpStatus.BAD_REQUEST);
        }

        if (authentication != null) {
            WebUser user = findUser;
            LoginResponse response = new LoginResponse();
            response.setTokentype("Bearer");
            Organization org = user.getIorgId();
            JsonNode settings = org.getAttribs();
            Boolean sso = settings.at("/ssoConfig/uiserver.sso").asBoolean();
            if (!sso) {
                try {

//                    if (TimeUnit.MILLISECONDS
//                            .toDays(new Date().getTime()
//                                    - user.getDtLastPasswordUpdated()
//                                    .getTime()) >= Integer
//                            .parseInt(env.getProperty(
//                                    "change.password.expiry")))
                    if (user.getDtLastPasswordUpdated().plusDays(passwordExpire).isBefore(ZonedDateTime.now())) {
                        response.setChangePassword(true);
                    } else {
                        response.setChangePassword(false);
                    }
                } catch (NullPointerException e) {

                    response.setChangePassword(true);

                }
            } else {
                response.setChangePassword(false);
            }

            user.setDtLastLoginDate(ZonedDateTime.now());
            user.setLoginAttempts(0);
            try {
                webUserService.save(user);
            } catch (Exception e) {
                LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString())
                        + "\nParam : { \"Username\": \""
                        + loggerEncoderUtil.encode(authenticationRequest.getUserName())
                        + "\", \"IPAddress\" : \""
                        + loggerEncoderUtil.encode(request.getRemoteAddr()) + "\"}");
                activityLogService.addActivity(findUser, "Login Failed",
                        "{ \"Username\": \"" + authenticationRequest.getUserName()
                                + "\", \"IPAddress\" : \"" + request.getRemoteAddr()
                                + "\"}");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            String jwtToken = jWTTokenHelper.generateToken(user.getUsername());
            String refresh = UUID.randomUUID().toString();
            try {
                activeLoginTokenService.deleteTokenByUserID(user);
                activeLoginTokenService.saveToken(jwtToken, user, refresh, false);
                activeLoginTokenService.deletePastWeeksToken(
                        Integer.parseInt(env.getProperty("token.cleanup.day")));
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : "
                        + loggerEncoderUtil.encode(authenticationRequest.getUserName()));
                activityLogService.addActivity(findUser, "failed to save token", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            response.setToken(jwtToken);
            response.setRefreshToken(refresh);
            response.setExpirein(expirein);
            activityLogService.addActivity(user, "Login Success", "{ \"Username\": \"" + user.getUsername()
                    + "\", \"IPAddress\" : \"" + request.getRemoteAddr() + "\"}");
            LOGGER.debug("Exiting logAuth Method in " + AuthenticationServiceImpl.class
                    + " class with response  :  jwt token");
            return ResponseEntity.ok(response);
        } else {
            activityLogService.addActivity(findUser, "Login failed because authentication object is null",
                    "{ \"Username\": \""
                            + authenticationRequest.getUserName() + "\", \"IPAddress\" : \""
                            + request.getRemoteAddr() + "\"}");
            LOGGER.debug("Exiting logAuth Method in " + TasksServiceImpl.class
                    + " class with response  : authentication failed message");

            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "authentication object is null"),
                    HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public ResponseEntity<?> getUserInfo(Authentication user) {
        LOGGER.debug("entered in class " + AuthenticationServiceImpl.class + " in method getUserInfo");

        if (user != null) {

            LoggedUser loggedUser = (LoggedUser) user.getPrincipal();
            WebUser userObj = loggedUser.getWebUser();
            UserInfoResponse userInfo = UserInfoResponseMapper.parse(userObj);
            userInfo.setBView(true);
            activityLogService.addActivity(userObj, "webuser info accessed",
                    "{ \"Username\": \"" + user.getName() + "\"}");
            LOGGER.debug("Exiting getUserInfo Method in " + TasksServiceImpl.class
                    + " class with response  : webuser info accessed");
            return ResponseEntity.ok(userInfo);
        } else {
            //     activityLogService.addActivity(user, "failed to access webuser info",
            //             "{ \"Username\": \"" + user.getName() + "\"}");
            LOGGER.debug("Exiting getUserInfo Method in " + TasksServiceImpl.class
                    + " class with response  : failed to access webuser info");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please Enter User Id"),
                    HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public ResponseEntity<?> getSideBar(Authentication authentication) {
        LOGGER.debug("entered in class " + AuthenticationServiceImpl.class + " in method getSideBar");
        LoggedUser loggedUser = (LoggedUser) authentication.getPrincipal();
        WebUser loggedInUser = loggedUser.getWebUser();
        List<RoleDesc> role_desc_list = loggedUser.getRoleDescs();
        Map<Integer, MenuStructureDesc> defaultload = role_desc_list.stream()
                .filter(c -> c.getIMenuStructureDesc() != null)
                .map(RoleDesc::getIMenuStructureDesc)
                .collect(Collectors.toMap(MenuStructureDesc::getIMenuID, Function.identity()));

        List<MenuStructureResponse> rMenu = new ArrayList<MenuStructureResponse>();

        if (role_desc_list.getFirst().getIRoleID() == 0) {
            for (DronaGodMenu allowedMenu : DronaGodMenu.values()) {
                try {
                    Integer menuId = menuStructureDescService.findByVcMenuName(allowedMenu.getDisplayName(), loggedInUser);
                    Optional<MenuStructureDesc> menuDesc = menuStructureDescService.findById(menuId);
                    if(menuDesc.isPresent() && menuDesc.get().getIParentMenu() == null){
                        try {
                            rMenu.add(createMenuFromDesc(menuDesc.get(), defaultload));
                        } catch (Exception e) {

                            LOGGER.error(loggerEncoderUtil
                                    .encode("Error : " + e + "\nParam : " + loggedInUser.getVcUserName()));
                            activityLogService.addActivity(loggedInUser, "failed to get sidebar data",
                                    "{ \"Username\": \"" + loggedInUser.getVcUserName() + "\"}");
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                    }
                } catch (Exception e) {
                    LOGGER.error("Error while fetching menu for Drona God user: " + e);
                    activityLogService.addActivity(loggedInUser, "Failed to get sidebar data", "{ \"Username\": \"" + loggedInUser.getVcUserName() + "\"}");
                    return new ResponseEntity<>(new ApiResponse(false, ResponseMessages.GenericErrorMessage), HttpStatus.INTERNAL_SERVER_ERROR);
                }
            }
        }else{
            List<UserRoleMenuAccess> lMenu = userRoleMenuAccessService
                    .findUniqueMenuByWebUserId(loggedInUser.getIuserID(), loggedInUser.getIorgId().getIorgid());
            lMenu.sort((c1, c2) -> c1.getISortOrder() - c2.getISortOrder());
            // System.out.println(lMenu);
            lMenu = lMenu.stream().filter(c -> c.getBView() != false).collect(Collectors.toList());

            for (UserRoleMenuAccess m : lMenu) {
                if (m.getIParentMenu() == null) {
                    try {
                        rMenu.add(createMenu(m, lMenu, defaultload));
                    } catch (Exception e) {

                        LOGGER.error(loggerEncoderUtil
                                .encode("Error : " + e + "\nParam : " + loggedInUser.getVcUserName()));
                        activityLogService.addActivity(loggedInUser, "failed to get sidebar data",
                                "{ \"Username\": \"" + loggedInUser.getVcUserName() + "\"}");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                }
            }
        }
        activityLogService.addActivity(loggedInUser, "side bar accessed successfully", "Response : " + rMenu);
        LOGGER.debug("Exiting getSideBar Method in " + TasksServiceImpl.class
                + " class with response  : side bar accessed successfully ");
        return ResponseEntity.ok(rMenu);
    }

    private MenuStructureResponse createMenuFromDesc(MenuStructureDesc menuDesc,
                                                     Map<Integer,MenuStructureDesc> defaultload)
            throws Exception {
        MenuStructureResponse res = MenuStructureResponse.builder().name(menuDesc.getVcMenuName())
                .collapse(menuDesc.isBCollapse()).rtlName(menuDesc.getVcRtlName()).icon(menuDesc.getVcIcon())
                .state(menuDesc.getVcState()).mini(menuDesc.getVcMini()).layout(menuDesc.getVcLayout())
                .path(menuDesc.getVcPath())
                .defaultload(defaultload.get(menuDesc.getIMenuID()) != null ? true : false)
                .build();
        res.setViews(createSubMenuFromDesc(menuStructureDescService.findAllByIParentMenu(menuDesc.getIMenuID()), menuDesc.getIMenuID(), defaultload));
        return res;
    }


    private MenuStructureResponse createMenu(UserRoleMenuAccess menu, List<UserRoleMenuAccess> lMenu,
                                             Map<Integer, MenuStructureDesc> defaultload)
            throws Exception {
        MenuStructureResponse res = MenuStructureResponse.builder().name(menu.getVcMenuName())
                .collapse(menu.getBCollapse()).rtlName(menu.getVcRtlName()).icon(menu.getVcIcon())
                .state(menu.getVcState()).mini(menu.getVcMini()).layout(menu.getVcLayout())
                .path(menu.getVcPath())
                .defaultload(defaultload.get(menu.getIMenuID()) != null ? true : false)
                .build();
        res.setViews(createSubMenu(lMenu, menu.getIMenuID(), defaultload));
        // if (menu.getBCollapse() == true) {
        // }
        return res;
    }

    private List<MenuStructureResponse> createSubMenuFromDesc(List<MenuStructureDesc> lMenu, int ParentMenuID,
                                                              Map<Integer, MenuStructureDesc> defaultload)
            throws Exception {
        List<MenuStructureResponse> subMenu = new ArrayList<>();
        for (MenuStructureDesc m : lMenu) {
            boolean isValidMenu = false;
            for (DronaGodMenu allowedMenu : DronaGodMenu.values()) {
                if (allowedMenu.getDisplayName().equals(m.getVcMenuName())) {
                    isValidMenu = true;
                    break;
                }
            }
            if (isValidMenu) {
                subMenu.add(createMenuFromDesc(m, defaultload));
            }
        }
        return subMenu;
    }


    private List<MenuStructureResponse> createSubMenu(List<UserRoleMenuAccess> lMenu, int ParentMenu,
                                                      Map<Integer, MenuStructureDesc> defaultload)
            throws Exception {
        List<MenuStructureResponse> subMenu = new ArrayList<>();
        for (UserRoleMenuAccess m : lMenu) {
            if (m.getIParentMenu() != null) {
                if (m.getIParentMenu() == ParentMenu) {
                    subMenu.add(createMenu(m, lMenu, defaultload));
                }
            }
        }
        return subMenu;
    }

    @Override
    public ResponseEntity<?> addActivity(ActivityLogRequest alr, Authentication pr) {
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();

        activityLogService.addActivity(loggedInUser, alr.getActivity(),
                alr.getParameters());
        return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Activity Logged"), HttpStatus.OK);
    }

    @Override
    public ResponseEntity<?> uploadFile(MultipartFile file, Authentication pr) {

        LOGGER.debug("entered in class " + AuthenticationServiceImpl.class + " in method uploadFile");

        WebUser loggedInUser = webUserService.loadUserByUsername(pr.getName());
        String fileName;
        if (file.getOriginalFilename().startsWith(".")) {
            activityLogService.addActivity(loggedInUser, "failed to upload document");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Invalid file ,file name cannot start with '.'"),
                    HttpStatus.UNSUPPORTED_MEDIA_TYPE);
        }
        if (env.getProperty("nonallowable.file.types").contains(file.getContentType())) {
            activityLogService.addActivity(loggedInUser, "Failed to upload file", file.getContentType());
            LOGGER.debug("exiting  class " + TasksServiceImpl.class
                    + " and method getTaskList with response : Failed to upload file");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Executables files are not allowed"),
                    HttpStatus.BAD_REQUEST);
        }
        try {

            fileName = fileStorageService.storeFile(file);
        } catch (Exception e) {

            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(loggedInUser.toString()));
            activityLogService.addActivity(loggedInUser, "failed to upload file", e.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);

        }

        String fileDownloadUri = "/api/v1/downloadFile/" + fileName;

        ServletUriComponentsBuilder.fromCurrentContextPath().path("/api/v1/downloadFile/").path(fileName)
                .toUriString();
        activityLogService.addActivity(loggedInUser, "file uploaded successfully",
                "{ \"filename\": \"" + fileName + "\"}");
        LOGGER.debug("exiting  class " + TasksServiceImpl.class
                + " and method getTaskList with response : file uploaded successfully");
        return ResponseEntity
                .ok(new UploadFileResponse(fileName, fileDownloadUri, file.getContentType(),
                        file.getSize()));
    }

    @Override
    public ResponseEntity<?> downloadFile(String fileName, HttpServletRequest
            request) throws IOException {
        LOGGER.debug("entered in class " + AuthenticationServiceImpl.class + " in method downloadFile");

        Resource resource = fileStorageService.loadFileAsResource(fileName);
        // Try to determine file's content type
        String contentType = null;
        try {
            contentType =
                    request.getServletContext().getMimeType(resource.getFile().getAbsolutePath());
        } catch (IOException e) {

            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(fileName));
            //     activityLogService.addActivity("failed to download file", e.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        // Fallback to the default content type if type could not be determined
        if (contentType == null) {
            contentType = "application/octet-stream";
        }
        // activityLogService.addActivity("file downloaded successfully", "{\"filename\": \"" + fileName + "\"}");
        LOGGER.debug("exiting class " + TasksServiceImpl.class
                + " and method getTaskList with response : file downloaded successfully");

        return ResponseEntity.ok().contentType(MediaType.parseMediaType(contentType))
                .header(HttpHeaders.CONTENT_DISPOSITION,
                        "attachment; filename=\"" + resource.getFilename() + "\"")
                .body(resource);
    }


    @Override
    public ResponseEntity<?> downloadLogo(String fileName, HttpServletRequest
            request) throws IOException {
        LOGGER.debug("entered in class " + AuthenticationServiceImpl.class + " in method downloadLogo");

        Path fileStorageLocation = Paths.get(logo_directory + "//" + fileName).toAbsolutePath()
                .normalize();
        Resource resource = new UrlResource(fileStorageLocation.toUri());


        // Try to determine file's content type
        String contentType = null;
        try {
            contentType =
                    request.getServletContext().getMimeType(resource.getFile().getAbsolutePath());
        } catch (IOException e) {

            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(fileName));
            //     activityLogService.addActivity("failed to download file", e.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }


        // Fallback to the default content type if type could not be determined
        if (contentType == null) {
            contentType = "application/octet-stream";
        }
        // activityLogService.addActivity("file downloaded successfully", "{\"filename\": \"" + fileName + "\"}");
        LOGGER.debug("exiting class " + AuthenticationServiceImpl.class
                + " and method downloadLogo with response : file downloaded successfully");

        return ResponseEntity.ok().contentType(MediaType.parseMediaType(contentType))
                .header(HttpHeaders.CONTENT_DISPOSITION,
                        "attachment; filename=\"" + resource.getFilename() + "\"")
                .body(resource);
    }


    @Override
    public ResponseEntity<?> forgotPassword(String emailId, String vcorgid) {
        LOGGER.debug("entered in class " + AuthenticationServiceImpl.class + " in method forgotPassword");

        try {
            WebUser forgotPasswordUser = webUserService.findActiveEmail(emailId, vcorgid);
            if (forgotPasswordUser != null && forgotPasswordUser.getIorgId().getVcOrgId().equals(vcorgid)) {
//                String token = RandomString.make(30);
                ZonedDateTime now = ZonedDateTime.now();
                if (forgotPasswordUser.getDtLastPasswordEmailSentAt() != null
                        && forgotPasswordUser.getDtLastPasswordEmailSentAt().plusMinutes(15).isAfter(now)) {
                    LOGGER.info("Forgot password email request limit exceeded for user: " + emailId);
                    return new ResponseEntity<>(
                            new ApiResponse(false, "Forgot password email request limit exceeded. Please try again after 15 minutes"),
                            HttpStatus.TOO_MANY_REQUESTS);
                }
                String token = UUID.randomUUID().toString().replace("-", "").substring(0, 30);
//                forgotPasswordUser.setResetPasswordToken(token);
//                webUserService.save(forgotPasswordUser);
                // emaiService.sendEmail(emailId, token);
                String drona_ui_url = forgotPasswordUser.getIorgId().geturl();
                EmailRequest emailRequest = new EmailRequest();
                emailRequest.setTemplateid(5);
                emailRequest.setToEmail(Arrays.asList(emailId));
                Map<String, Object> subjectParams = new HashMap<>();
                subjectParams.put("dronauiurl", drona_ui_url
                        + "/dronaui/" + forgotPasswordUser.getIorgId().getVcOrgId());
                subjectParams.put("resetToken", token);
                emailRequest.setBodyParams(subjectParams);
                ObjectMapper mapper = new ObjectMapper();
                String emailReqString = mapper.writeValueAsString(emailRequest);
                AllUsersMapping allMappingInfo = webuserMappingUtil.getWebUserMappings(Arrays.asList(forgotPasswordUser.getIuserID()), forgotPasswordUser.getIorgId().getIorgid());

                ResponseEntity<?> emailResponse = emailController.sendEmail(emailReqString,
                        allMappingInfo.getUserTenant().get(forgotPasswordUser.getIuserID()).get(0));
                forgotPasswordUser.setResetPasswordToken(token);
                if (emailResponse.getStatusCode() == HttpStatus.OK) {
                    forgotPasswordUser.setDtLastPasswordEmailSentAt(now);
                }
                webUserService.save(forgotPasswordUser);
                LOGGER.debug("exiting  class " + TasksServiceImpl.class
                        + " and method forgotPassword with response : from send email controller service");
                // return emailGenericService.sendEmail(emailRequest);
                return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Email sent successfully"),
                        HttpStatus.OK);
            } else {
                // activityLogService.addActivity("failed to access forget password ",
                //         "parameters : " + emailId);
                LOGGER.debug("exiting  class " + TasksServiceImpl.class
                        + " and method forgotPassword with response : email is not associated to any email address");
                LOGGER.info("User with email ID " + emailId + " does not exist");
                return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Email sent successfully"),
                        HttpStatus.OK);
            }
        } catch (Exception e) {

            LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString()) + "\nParam : "
                    + loggerEncoderUtil.encode(emailId));
            //     activityLogService.addActivity("Forgot Email", "{ \"email\": \"" + emailId + "\"}");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    public ResponseEntity<?> validateToken(String token) {
        LOGGER.debug("entered in class " + AuthenticationServiceImpl.class + " in method validateToken");

        try {
            WebUser validUser = webUserService.findByToken(token);
            if (validUser != null) {
                activityLogService.addActivity(validUser, " reset password token is  valid",
                        "{ \"token\": \"" + token + "\"}");
                LOGGER.debug("exiting  class " + TasksServiceImpl.class
                        + " and method forgotPassword with response : reset password token is valid");
                return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Link is valid"),
                        HttpStatus.OK);
            }
            //     activityLogService.addActivity(" reset password token is not valid",
            //             "{ \"token\": \"" + token + "\"}");
            LOGGER.debug("exiting  class " + TasksServiceImpl.class
                    + " and method forgotPassword with response : reset password token is not valid");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Link is invalid"),
                    HttpStatus.BAD_REQUEST);
        } catch (Exception e) {

            LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString()) + "\nParam : "
                    + loggerEncoderUtil.encode(token));
            //     activityLogService.addActivity("failed to validate reset password token",
            //             "{ \"token\": \"" + token + "\"}");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    public ResponseEntity<?> resetPassword(ResetPasswordRequest resetPassword) {
        LOGGER.debug("entered in class " + AuthenticationServiceImpl.class + " in method resetPassword");

        try {
            WebUser validUser = webUserService.findByToken(resetPassword.getResetToken());

            if (validUser != null) {

                String wordOrig;
                String confirmWordOrig;
                try {
                    wordOrig = loginPasswordUtil
                            .decryptUserPassword(resetPassword.getNewPassword());
                    confirmWordOrig = loginPasswordUtil
                            .decryptUserPassword(resetPassword.getConfirmNewPassword());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(resetPassword.toString()));
                    activityLogService.addActivity(validUser, "failed to edit webuser entry",
                            "Error : " + e.toString() + ", Parameters : " + resetPassword);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (wordOrig == null || wordOrig == "") {
                    activityLogService
                            .addActivity(validUser, " failed to reset password becasue password is not in proper format ",
                                    "");
                    LOGGER.debug("exiting  class " + TasksServiceImpl.class
                            + " and method forgotPassword with response : New Password cannot be empty or null");

                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "New Password cannot be empty or null"),
                            HttpStatus.BAD_REQUEST);
                }

                if (confirmWordOrig == null
                        || confirmWordOrig == "") {
                    activityLogService
                            .addActivity(validUser, " failed to reset password becasue password is not in proper format ",
                                    "");
                    LOGGER.debug("exiting  class " + TasksServiceImpl.class
                            + " and method forgotPassword with response : Confirm new password cannot be empty or null");

                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Confirm new password cannot be empty or null"),
                            HttpStatus.BAD_REQUEST);
                }

                if (!confirmWordOrig.equals(wordOrig)) {
                    activityLogService
                            .addActivity(validUser, " failed to reset password becasue password is not in proper format ",
                                    "");
                    LOGGER.debug("exiting  class " + TasksServiceImpl.class
                            + " and method forgotPassword with response : New password and confirm password doesn't match");

                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "New password and confirm password doesn't match"),
                            HttpStatus.BAD_REQUEST);
                }

                String regex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{"
                        + env.getProperty("minimum.password.length") + ","
                        + env.getProperty("max.password.length")
                        + "}$";
                Pattern pattern = Pattern.compile(regex);
                Matcher matcher = pattern.matcher(wordOrig);
                if (!matcher.matches()) {
                    activityLogService
                            .addActivity(validUser, " failed to reset password becasue password is not in proper format ",
                                    "");
                    LOGGER.debug("exiting  class " + TasksServiceImpl.class
                            + " and method forgotPassword with response : Password must meet minimum requirements mentioned in policy");

                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Password must meet minimum requirements mentioned in policy"),
                            HttpStatus.BAD_REQUEST);
                }
                validUser.setVcPassword(passwordEncoder.encode(wordOrig));
                validUser.setResetPasswordToken(null);
                ApiResponse saveResponse = webUserService.save(validUser, wordOrig);

                if (!saveResponse.getSuccess()) {
                    LOGGER.debug("Exiting class " + AuthenticationServiceImpl.class
                            + " and method resetPassword with response: " + saveResponse.getMessage());
                    return new ResponseEntity<>(saveResponse, saveResponse.getStatus());
                }
                activeLoginTokenService.deleteTokenByUserID(validUser);
                activityLogService.addActivity(validUser, "Password reset successfully", "");
                LOGGER.debug("exiting  class " + TasksServiceImpl.class
                        + " and method forgotPassword with response : Password reset successfully");

                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(true, "Password reset successfully"),
                        HttpStatus.OK);
            }
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Link is invalid"),
                    HttpStatus.BAD_REQUEST);
        } catch (Exception e) {

            LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString()) + "\nParam : "
                    + loggerEncoderUtil.encode(resetPassword.toString()));
            //     activityLogService.addActivity(validUser, "Reset password",
            //             "{ \"resetPassword\": \"" + resetPassword + "\"}");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    public ResponseEntity<?> logOut(Authentication pr, HttpServletRequest request) {
        LOGGER.debug("entered in class " + AuthenticationServiceImpl.class + " in method logOut");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        String token = jWTTokenHelper.getToken(request);
        activityLogService.addActivity(loggedInUser,"logout request received", "Token : " + token);

        try {
            activeLoginTokenService.deleteToken(token);
            activityLogService.addActivity(loggedInUser,"logout successful", "Token : " + token);
        } catch (Exception e) {
            LOGGER.error("Error : " + loggerEncoderUtil.encode(e.toString()) + "\nParam : "
                    + loggerEncoderUtil.encode(token));
            //     activityLogService.addActivity("failed to validate reset password token",
            //             "{ \"token\": \"" + token + "\"}");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
        // activityLogService.addActivity(loggedInUser, "Logged out successfully", "");
        LOGGER.debug("exiting  class " + TasksServiceImpl.class
                + " and method forgotPassword with response : Logged out successfully");

        return new ResponseEntity<ApiResponse>(
                new ApiResponse(true, "Logged out successfully"),
                HttpStatus.OK);
    }

    public ResponseEntity<?> token(CodeBody code) {
        Organization org = organizationRepositoryService.findOrg(code.getOrg());
        ResponseEntity<String> clientResponse = null;
        JsonNode attribs = org.getAttribs();
        try {
            clientResponse = ssoService.getToken(code, attribs);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(code.toString()));
            //     activityLogService.addActivity("failed to get token",
            //             "Error : " + e.toString() + ", Parameters : " + code);
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

//        String responsebody = clientResponse.bodyToMono(String.class).block();
        String responsebody = clientResponse.getBody();
//        clientResponse.releaseBody();
        if (clientResponse.getStatusCode() == HttpStatus.OK) {

            JSONObject res = new JSONObject(responsebody);


            String tokentype = attribs.at("/ssoConfig/uiserver.sso.tokentype").asText();


            String jwtToken = res.optString(tokentype);
            String refresh = res.optString("refresh_token");
//            System.out.println(jwtToken);

            String[] chunks = jwtToken.split("\\.");

            Base64.Decoder decoder = Base64.getUrlDecoder();

            String payload = new String(decoder.decode(chunks[1]));

            JSONObject json = new JSONObject(payload);


            String userNameAttrib = attribs.at("/ssoConfig/spring.security.oauth2.resourceserver.jwt.user-name-attribute").asText();
            String username = json.optString(userNameAttrib);

            // System.out.println(jwtToken);
            // System.out.println(username);

            WebUser loggedinuser = webUserService.findByUsernameForLogin(username, org.getVcOrgId());


            try {
                activeLoginTokenService.deleteTokenByUserID(loggedinuser);
                loggedinuser.setDtLastLoginDate(ZonedDateTime.now());
                webUserService.save(loggedinuser);
                activeLoginTokenService.saveToken(jwtToken, loggedinuser, refresh, false);
                activeLoginTokenService.deletePastWeeksToken(
                        Integer.parseInt(env.getProperty("token.cleanup.day")));
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(code.toString()));
                // activityLogService.addActivity("failed to save token", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            LoginResponse response = new LoginResponse();
            response.setTokentype("Bearer");
            response.setToken(jwtToken);
            response.setRefreshToken(refresh);
            response.setExpirein(res.optInt("expires_in"));
            response.setIdtoken(res.optString("id_token"));
            activityLogService.addActivity(loggedinuser, "token generated successfully",
                    "parameters : " + code);
            LOGGER.debug(
                    "Exiting token Method in " + AuthenticationServiceImpl.class
                            + " class with success response ");
            return ResponseEntity.ok(response);
        } else {
            //     activityLogService.addActivity("failed to generate access token", "Parameters : " + code);
            LOGGER.error(loggerEncoderUtil
                    .encode("Exiting token Method in " + AuthenticationServiceImpl.class
                            + " class with response  : "
                            + responsebody));
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, responsebody),
                    clientResponse.getStatusCode());
        }
    }

    public ResponseEntity<?> getSSO(String orgId) {
        LOGGER.debug("entered in class " + AuthenticationServiceImpl.class + " in method getSSO");
        String authorizeurl = "";
        String scope = "";
        Boolean sso = null;
        String dronauiurl = "";
        String ssoType = "";
        String logouturl = "";
        Boolean pismoEnabled = null;
        String logourl = "";
        Organization org = null;
        String clientid = null;
        String logoStyle = "";
        JsonNode dashboardAutoSearch;
        JsonNode caseManagementConfig;

        org = organizationRepositoryService.findOrg(orgId);
        try {
            
            JsonNode settings = org.getAttribs();
            authorizeurl = settings.at("/ssoConfig/drona.ui.authorize").asText();
            scope = settings.at("/ssoConfig/drona.ui.scope").asText();
            sso = settings.at("/ssoConfig/uiserver.sso").asBoolean();
            dronauiurl = settings.at("/ssoConfig/drona.ui.redirect.url").asText();
            ssoType = settings.at("/ssoConfig/uiserver.sso.type").asText();
            logouturl = settings.at("/ssoConfig/drona.ui.logout.url").asText();
            pismoEnabled = settings.at("/pismo.processing.enabled").asBoolean();
            if (settings.at("/vclogourl") != null) {
                logourl = settings.at("/vclogourl").asText();
            }

            clientid = settings.at("/ssoConfig/drona.ui.clientid").asText();
            if (settings.at("/logoStyle") != null) {
                logoStyle = settings.at("/logoStyle").toString();
            }
            dashboardAutoSearch = settings.get("dashboardAutoSearch");
            caseManagementConfig = settings.get("caseManagementConfig");
        } catch (Exception e) {
            LOGGER.error("Error : " + e);
            //     activityLogService.addActivity("failed to get organization", e.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
        usfbIvrLink = usfbIvrLink.replace("DOLLAR", "$");
        cubIvrLink = cubIvrLink.replace("DOLLAR", "$");
        esafIvrLink = esafIvrLink.replace("DOLLAR", "$");
        ssfbIvrLink = ssfbIvrLink.replace("DOLLAR", "$");

        return ResponseEntity.ok(new SSOConfigResponse(
                authorizeurl, clientid, scope, sso, dronauiurl, ssoType,
                logouturl, pismoEnabled, logourl, logoStyle, user_login_public_key, usfbIvrLink, esafIvrLink, cubIvrLink, ssfbIvrLink, bulkProcessingLimit, tokenExpiryTime,
                dashboardAutoSearch, caseManagementConfig));
    }

    public ResponseEntity<?> refreshToken(RefreshToken request) {
        Optional<ActiveLoginToken> activelogin = activeLoginTokenService
                .findByRefreshTokens(request.getRefreshToken());
        return activelogin.map(activeLoginTokenService::verifyExpiry)
                .map(activeLoginTokenService::findUserbyToken)
                .map(user -> {
                    String token;
                    String refresh;
                    Integer expire = expirein;
                    try {
                        Organization org = user.getIorgId();
                        JsonNode settings = org.getAttribs();
                        Boolean sso = settings.at("/ssoConfig/uiserver.sso").asBoolean();
                        if (sso) {

                            ResponseEntity<String> cr = ssoService
                                    .getRefresh(request, settings);
//                            String responsebody = cr.bodyToMono(String.class).block();
                            String responsebody = cr.getBody();
                            System.out.println(responsebody);
//                            cr.releaseBody();
                            if (cr.getStatusCode() == HttpStatus.OK) {
                                JSONObject res = new JSONObject(responsebody);
                                String tokentype = settings.at("/ssoConfig/uiserver.sso.tokentype").asText();
                                token = res.optString(tokentype);
                                String temptoken = res.optString("refresh_token");
                                refresh = temptoken.equalsIgnoreCase("") ? request.getRefreshToken() : temptoken;
                                expire = res.optInt("expires_in");
                            } else {
                                LOGGER.error(loggerEncoderUtil
                                        .encode("Exiting token Method in "
                                                + AuthenticationServiceImpl.class
                                                + " class with response  : "
                                                + responsebody));
                                throw new RuntimeException("failed to get token");
                            }
                        } else {
                            refresh = UUID.randomUUID().toString();
                            token = jWTTokenHelper.generateToken(user.getVcUserName());
                        }
                    } catch (InvalidKeySpecException e) {
                        throw new RuntimeException(e);
                    } catch (NoSuchAlgorithmException e) {
                        throw new RuntimeException(e);
                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }
                    ActiveLoginToken temp = new ActiveLoginToken();
                    try {
                        temp.setRefreshToken(refresh);
                        temp.setActiveLoginToken(token);
                        activeLoginTokenService.saveToken(token, user, refresh, true);
                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }
                    LoginResponse response = new LoginResponse();
                    response.setToken(token);
                    response.setRefreshToken(refresh);
                    response.setExpirein(expire);

                    JsonNode settings = user.getIorgId().getAttribs();
                    Boolean sso = settings.at("/ssoConfig/uiserver.sso").asBoolean();
                    if (!sso) {
                        try {
//                            if (TimeUnit.MILLISECONDS
//                                    .toDays(new Date().getTime()
//                                            - user.getDtLastPasswordUpdated()
//                                            .getTime()) >= Integer
//                                    .parseInt(env.getProperty(
//                                            "change.password.expiry")))
                            if (user.getDtLastPasswordUpdated().plusDays(passwordExpire).isAfter(ZonedDateTime.now())) {

                                response.setChangePassword(true);
                            } else {
                                response.setChangePassword(false);
                            }
                        } catch (NullPointerException e) {
                            response.setChangePassword(true);
                        }
                    } else {
                        response.setChangePassword(false);
                    }
                    activityLogService.addActivity(user, "refresh token generated successfully", "response : " + response);
                    return ResponseEntity.ok(response);
                })
                .orElseThrow(() -> new TokenNotValid("Please provide valid token", request.toString()));
    }

    public ResponseEntity<?> getapikey(int tenantid) {
        return ResponseEntity.ok(tenantRepositoryService.findAPIKeyTenant(tenantid));
    }
}
