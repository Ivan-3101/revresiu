package com.DronaPay.UIServer.service.ControllerService.HistoricProfileManagement;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.ResponseVO.DropDownVo;
import com.DronaPay.UIServer.ResponseVO.HistoricProfileVO;
import com.DronaPay.UIServer.VOMapper.DropDownVoMapper;
import com.DronaPay.UIServer.VOMapper.HistoricProfileVOMapper;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.requests.AddHistoricProfile;
import com.DronaPay.UIServer.requests.ApproveProfileRequest;
import com.DronaPay.UIServer.requests.DeleteProfileRequest;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.HistoricProfileView;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.service.HelperServices.CheckerMakerHelperService;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

@Service
public class HistoricProfileManagementServiceImpl
    implements HistoricProfileManagementService {

  private static final Logger LOGGER =
      LoggerFactory.getLogger(HistoricProfileManagementServiceImpl.class);
  final String menu_name = MenuNames.HistoricProfile;
  @Autowired private ActivityLogService activityLogService;
  @Autowired private WebUserService webUserService;
  @Autowired private HistoricProfilesService historicProfilesService;
  @Autowired private TenantRepositoryService tenantRepositoryService;
  @Autowired private MetadataUiServiceImpl metadataUiService;
  @Autowired private MetadataAuditServiceImpl metadataAuditService;
  @Autowired private LoggerEncoderUtil loggerEncoderUtil;
  @Autowired
  private CheckerMakerHelperService<MetadataAuditServiceImpl, MetadataUiAudit,
                                    MetadataUiServiceImpl, MetadataUi>
      checkerMakerHelperService;

  @Override
  public ResponseEntity<?> getListOfProfiles(Authentication pr) {
    LOGGER.debug("entered in class " +
                 HistoricProfileManagementServiceImpl.class +
                 " in method getListOfProfiles");

    LoggedUser loggedUser = (LoggedUser)pr.getPrincipal();

    WebUser loggedInUser = loggedUser.getWebUser();
    MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

    HistoricProfileView listView = new HistoricProfileView();
    listView.setAdd(mp.isAdd());
    listView.setApprove(mp.isApprove());
    listView.setDelete(mp.isDelete());
    listView.setEdit(mp.isEdit());
    listView.setView(mp.isView());
    listView.setPublish(mp.isPublish());

    if (mp.isView()) {

      List<MetadataUi> metadataUi = null;

      try {
        metadataUi = metadataUiService.findAllActiveMetadataTenants(
            loggedUser.getUserTenant());
      } catch (Exception e) {
        LOGGER.error("Error : " + e +
                     "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
        activityLogService.addActivity(
            loggedInUser, "failed to get list of historic profiles",
            e.toString());
        return new ResponseEntity<>(
            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
            HttpStatus.INTERNAL_SERVER_ERROR);
      }
      List<Tenant> tenants = new ArrayList<>();

      try {
        tenants = tenantRepositoryService.findNonDeletedTenants();
        System.out.println(tenants.toString());
      } catch (Exception e) {
        LOGGER.error("Error : " + e +
                     "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
        activityLogService.addActivity(
            loggedInUser, "failed to get list of historic profiles",
            e.toString());
        return new ResponseEntity<>(
            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
            HttpStatus.INTERNAL_SERVER_ERROR);
      }

      List<HistoricProfileVO> historicProfileVOs =
          HistoricProfileVOMapper.parseMetadataUi(metadataUi, tenants);
      List<MetadataUiAudit> metadataAudits =
          metadataAuditService.findPendingEntriesTenants(
              loggedUser.getUserTenant());
      List<HistoricProfileVO> historicProfileVOAudit =
          HistoricProfileVOMapper.parseMetadataAudit(metadataAudits,
                                                     loggedInUser, tenants);

      for (int i = 0; i < historicProfileVOs.size(); i++) {

        for (int j = 0; j < historicProfileVOAudit.size(); j++) {
          if (historicProfileVOs.get(i).getVcroot().equals(
                  historicProfileVOAudit.get(j).getVcroot()) &&
              historicProfileVOs.get(i).getVcpath().equals(
                  historicProfileVOAudit.get(j).getVcpath())) {
            historicProfileVOs.get(i).setAuditExist(true);
          }
        }
      }
      historicProfileVOs.addAll(historicProfileVOAudit);

      listView.setHistoricProfileVO(historicProfileVOs);

      LOGGER.debug("Exiting getListOfProfiles Method in " +
                   HistoricProfileManagementServiceImpl.class +
                   (" class with response  : with parameters list of " +
                    "historic profiles"));
      activityLogService.addActivity(loggedInUser,
                                     "List of historic profiles accessed");

      return ResponseEntity.ok(listView);

    } else {

      activityLogService.addActivity(
          loggedInUser, "unauthorized to access historic profiles list");
      LOGGER.debug("Exiting getListOfProfiles Method in " +
                   HistoricProfileManagementServiceImpl.class +
                   (" class with response  : unauthorized to access list of " +
                    "historic profiles"));
      return new ResponseEntity<ApiResponse>(
          new ApiResponse(false,
                          "unauthorized to access list of historic profiles"),
          HttpStatus.FORBIDDEN);
    }
  }

  @Override
  public ResponseEntity<?> editProfile(AddHistoricProfile req,
                                       Authentication pr) {
    LOGGER.debug("entered in class " +
                 HistoricProfileManagementServiceImpl.class +
                 " in method editProfile");

    LoggedUser loggedUser = (LoggedUser)pr.getPrincipal();

    WebUser loggedInUser = loggedUser.getWebUser();
    MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

    if (mp.isEdit() &&
        loggedUser.allowTenants(Arrays.asList(req.getItenantId()))) {
      MetadataUi exist = null;
      MetadataUiAudit existAudit = null;
      try {
        exist = metadataUiService.findById(req.getId());
        existAudit = metadataAuditService.findByMetadatUiId(req.getId(),
                                                            req.getItenantId());
      } catch (Exception e) {
        LOGGER.error("Error : " + e +
                     "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
        activityLogService.addActivity(
            loggedInUser, "failed to get user and permissions", e.toString());
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
            HttpStatus.INTERNAL_SERVER_ERROR);
      }
      if (exist == null) {
        LOGGER.info("Error : Metadata with vcroot and vcpath does not exists");
        activityLogService.addActivity(
            loggedInUser, "Metadata with vcroot and vcpath does not exists");
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(false,
                            "Metadata with vcroot and vcpath does not exists"),
            HttpStatus.BAD_REQUEST);
      }
      if (existAudit != null) {
        LOGGER.info("Error : Action for metadata entry with requested vcroot " +
                    "and vcpath pending");
        activityLogService.addActivity(loggedInUser,
                                       "Action for metadata entry with " +
                                       "requested vcroot and vcpath pending");
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(false, "Action for metadata entry with requested " +
                                   "vcroot and vcpath pending"),
            HttpStatus.BAD_REQUEST);
      }

      MetadataUiAudit metaAudit = new MetadataUiAudit();
      metaAudit.setBui(true);
      metaAudit.setBscore(true);
      metaAudit.setBml(false);
      metaAudit.setVcpath(req.getVcpath());
      metaAudit.setVcroot(req.getVcroot());
      metaAudit.setVcdtype(req.getDataType());
      metaAudit.setVccolumnname(req.getName());
      metaAudit.setConfig(req.getParams());
      metaAudit.setVcdescription(req.getDescription());
      metaAudit.setVcRemark(req.getMakerRemark());
      metaAudit.setVcquery(req.getQuery());
      metaAudit.setVcAction("M");
      metaAudit.setIMetadataId(exist.getIMetadataId());
      MetadataUiAudit status = checkerMakerHelperService.saveWithObj(
          metadataAuditService, metaAudit, loggedInUser);
      if (status != null) {
        activityLogService.addActivity(loggedInUser,
                                       "Profile edition sent for approval",
                                       "Parameters : " + req.toString());
        LOGGER.debug("Exiting addList Method in " +
                     HistoricProfileManagementServiceImpl.class +
                     " class with response  : item added successfully");
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(true, "Profile edition sent for approval"),
            HttpStatus.CREATED);
      } else {
        activityLogService.addActivity(loggedInUser,
                                       "failed to edit profile entry");
        LOGGER.error("Exiting editProfile  Method in " +
                     HistoricProfileManagementServiceImpl.class +
                     " class with response  : failed to edit profile");
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(false, "Failed to edit profile"),
            HttpStatus.BAD_REQUEST);
      }

    } else {
      activityLogService.addActivity(loggedInUser,
                                     "unauthorized to add profile ");
      LOGGER.info("Exiting addProfile Method in " +
                  HistoricProfileManagementServiceImpl.class +
                  " class with response  : unauthorized to add profile");
      return new ResponseEntity<ApiResponse>(
          new ApiResponse(false, "unauthorized to add profile"),
          HttpStatus.FORBIDDEN);
    }
  }

  @Override
  public ResponseEntity<?> addProfile(AddHistoricProfile req,
                                      Authentication pr) {
    LOGGER.debug("entered in class " +
                 HistoricProfileManagementServiceImpl.class +
                 " in method addProfile");

    Integer tenantid = req.getItenantId();
    LoggedUser loggedUser = (LoggedUser)pr.getPrincipal();

    WebUser loggedInUser = loggedUser.getWebUser();
    MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

    if (mp.isAdd() && loggedUser.allowTenants(Arrays.asList(tenantid))) {

      if(req.getIsHistoricProfile()){
        Pattern pattern = Pattern.compile("^[a-zA-Z0-9 ./\\\\_&-]+$");
        Matcher matcher = pattern.matcher(req.getName());

        if (!matcher.matches()) {
          activityLogService.addActivity(loggedInUser, "failed to add profile entry due to invalid name");
          LOGGER.error("Exiting addProfile  Method in " + HistoricProfileManagementServiceImpl.class +
                  " class with response  : failed to add profile due to invalid name");
          return new ResponseEntity<ApiResponse>(
                  new ApiResponse(false, "Name can only contain alphabets, numbers, dot (.), " +
                          "empty space, hyphen (-), forward and backward slash (/ , \\), ampersand (&) and underscore (_)"),
                  HttpStatus.BAD_REQUEST);
        }

        if (req.getParams().has("label")) {
          Pattern labelPattern = Pattern.compile("^[a-zA-Z0-9 ,_@*#%'/\\\\&.-]+$");
          Matcher labelMatcher = labelPattern.matcher(req.getParams().get("label").asText());

          if (!labelMatcher.matches()) {
            activityLogService.addActivity(loggedInUser, "failed to add profile entry due to invalid label");
            LOGGER.error("Exiting addProfile  Method in " + HistoricProfileManagementServiceImpl.class +
                    " class with response  : failed to add profile due to invalid label");
            return new ResponseEntity<>(
                    new ApiResponse(false, "Label can only contain alphabets, numbers, hyphen (-), " +
                            "comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), " +
                            "single quotation ('), forward and backward slash (/ , \\), ampersand (&), and dot (.)"),
                    HttpStatus.BAD_REQUEST);
          }
        }

        if (req.getParams().has("window")) {
          Pattern windowPattern = Pattern.compile("^[a-zA-Z0-9]+$");
          Matcher windowMatcher = windowPattern.matcher(req.getParams().get("window").asText());

          if (!windowMatcher.matches()) {
            activityLogService.addActivity(loggedInUser, "failed to add profile entry due to invalid window");
            LOGGER.error("Exiting addProfile  Method in " + HistoricProfileManagementServiceImpl.class +
                    " class with response  : failed to add profile due to invalid window");
            return new ResponseEntity<>(
                    new ApiResponse(false, "Window can only contain alphabets and numbers"),
                    HttpStatus.BAD_REQUEST);
          }
        }

      }else {
        Pattern pattern = Pattern.compile("^[a-zA-Z0-9 ,_@*#%'/\\\\&.\\-{}()><\\[\\]]+$");
        Matcher matcher = pattern.matcher(req.getName());

        if (!matcher.matches()) {
          activityLogService.addActivity(loggedInUser, "failed to add profile entry due to invalid name");
          LOGGER.error("Exiting addProfile  Method in " + HistoricProfileManagementServiceImpl.class +
                  " class with response  : failed to add profile due to invalid name");
          return new ResponseEntity<ApiResponse>(
                  new ApiResponse(false, "Name can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), at (@), space, " +
"asterisk (*), hash (#), percentage (%), single quotation ('), forward slash (/), backward slash (\\), " +
"ampersand (&), dot (.), curly braces ({ }), parentheses (()), greater than (>), and square brackets ([])."),
                  HttpStatus.BAD_REQUEST);
        }

        Pattern pathPattern = Pattern.compile("^[a-zA-Z0-9.>_'-{}()\\[\\]]+$");
        Matcher pathMatcher = pathPattern.matcher(req.getVcpath());

        if (!pathMatcher.matches()) {
          activityLogService.addActivity(loggedInUser, "failed to add profile entry due to invalid path");
          LOGGER.error("Exiting addProfile  Method in " + HistoricProfileManagementServiceImpl.class +
                  " class with response  : failed to add profile due to invalid path");
          return new ResponseEntity<>(
                  new ApiResponse(false, "Path can only contain alphabets, numbers, hyphen (-), dot (.), greater than (>), underscore (_), " +
"curly braces ({ }), parentheses (()), and square brackets ([])."),
                  HttpStatus.BAD_REQUEST);
        }
      }

      String label = null;
      if (req.getParams().has("label")) {
        label = req.getParams().get("label").asText();
      }

      String window = null;
      if (req.getParams().has("window")) {
        window = req.getParams().get("window").asText();
      }

      List<MetadataUiAudit> audits = metadataAuditService.findDUplicate(
          label, window, req.getVcroot(), req.getVcpath(), req.getItenantId());
      System.out.println(audits);

      if (audits.size() > 0) {
        activityLogService.addActivity(loggedInUser,
                                       "failed to add profile entry");
        LOGGER.error("Exiting addProfile  Method in " +
                     HistoricProfileManagementServiceImpl.class +
                     " class with response  : failed to add profile");
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(false, "Duplicate entry pending in audit"),
            HttpStatus.CONFLICT);
      }

      List<MetadataUi> masterExist = metadataUiService.findDUplicate(
          label, window, req.getVcroot(), req.getVcpath(), req.getItenantId());
      System.out.println(audits);

      if (masterExist.size() > 0) {
        activityLogService.addActivity(loggedInUser,
                                       "failed to add profile entry");
        LOGGER.info("Exiting addProfile  Method in " +
                    HistoricProfileManagementServiceImpl.class +
                    " class with response  : failed to add profile");
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(false, "Duplicate entry in masters"),
            HttpStatus.CONFLICT);
      }

      MetadataUiAudit metaAudit = new MetadataUiAudit();
      metaAudit.setBui(true);
      metaAudit.setBscore(true);
      metaAudit.setBml(false);
      metaAudit.setVcpath(req.getVcpath());
      metaAudit.setVcroot(req.getVcroot());
      metaAudit.setVcdtype(req.getDataType());
      metaAudit.setVccolumnname(req.getName());
      metaAudit.setConfig(req.getParams());
      metaAudit.setVcdescription(req.getDescription());
      metaAudit.setVcRemark(req.getMakerRemark());
      metaAudit.setVcquery(req.getQuery());
      metaAudit.setVcAction("A");
      metaAudit.setItenantId(tenantid);
      ObjectMapper mapper = new ObjectMapper();
      String vcprefix = "";
      if (req.getIsHistoricProfile()) {

        switch (req.getVcroot()) {
          case "account_weekly":
          case "account_monthly":
          case "vpa_monthly":
          case "vpa_weekly":
          case "location_weekly":
          case "location_monthly":
            vcprefix = "[{\"Path\": \"observations.profile\" }]";
            break;
          case "account":
            vcprefix =
                "[{\"Side\": \"Payer\", \"Path\": \"profile.payeracc\" },{ " +
                "\"Side\": \"Payee\", \"Path\": \"profile.payeeacc\"}]";
            break;
          case "vpa":
            vcprefix = "[{ \"Side\": \"Payer\", \"Path\": \"profile.payer\" " +
                      "},{ \"Side\": \"Payee\", \"Path\": \"profile.payee\"}]";
            break;
          case "mcc":
            vcprefix = "[{\"Path\": \"profile.mcc\" }]";
            break;
          case "location":
            vcprefix = "[{\"Path\": \"profile.location\" }]";
            break;
          default:
            vcprefix = "[{ \"Path\": \"\" }]";
        }
      } else
        vcprefix = "[{ \"Path\": \"\" }]";

      try {
        metaAudit.setVcPrefix(mapper.readTree(vcprefix));
      } catch (JsonProcessingException e) {
        LOGGER.error("Error in json parsing");
      }
      MetadataUiAudit status = checkerMakerHelperService.saveWithObj(
          metadataAuditService, metaAudit, loggedInUser);
      if (status != null) {
        activityLogService.addActivity(loggedInUser,
                                       "Profile addition sent for approval",
                                       "Parameters : " + req.toString());
        LOGGER.debug("Exiting addList Method in " +
                     HistoricProfileManagementServiceImpl.class +
                     " class with response  : item added successfully");
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(true, "Profile addition sent for approval"),
            HttpStatus.CREATED);
      } else {
        activityLogService.addActivity(loggedInUser,
                                       "failed to add profile entry");
        LOGGER.error("Exiting addProfile  Method in " +
                     HistoricProfileManagementServiceImpl.class +
                     " class with response  : failed to add profile");
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(false, "Failed to add profile"),
            HttpStatus.BAD_REQUEST);
      }

    } else {
      activityLogService.addActivity(loggedInUser,
                                     "unauthorized to add profile ");
      LOGGER.error("Exiting addProfile Method in " +
                   HistoricProfileManagementServiceImpl.class +
                   " class with response  : unauthorized to add profile");
      return new ResponseEntity<ApiResponse>(
          new ApiResponse(false, "unauthorized to add profile"),
          HttpStatus.FORBIDDEN);
    }
  }

  @Override
  public ResponseEntity<?> deleteProfile(DeleteProfileRequest req,
                                         Authentication pr) {
    LOGGER.debug("entered in class " +
                 HistoricProfileManagementServiceImpl.class +
                 " in method deleteProfile");

    Integer tenantid = req.getItenantId();
    LoggedUser loggedUser = (LoggedUser)pr.getPrincipal();

    WebUser loggedInUser = loggedUser.getWebUser();
    MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

    if (mp.isDelete() &&
        loggedUser.allowTenants(Arrays.asList(req.getItenantId()))) {
      MetadataUi exist = null;
      MetadataUiAudit existAudit = null;
      try {
        exist = metadataUiService.findById(req.getId());
        existAudit = metadataAuditService.findByMetadatUiId(req.getId(),
                                                            req.getItenantId());
      } catch (Exception e) {
        LOGGER.error("Error : " + e +
                     "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
        activityLogService.addActivity(
            loggedInUser, "failed to get user and permissions", e.toString());
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
            HttpStatus.INTERNAL_SERVER_ERROR);
      }
      if (exist == null) {
        LOGGER.error(
            "Error : No profile exists with requested vcroot and vcpath");
        activityLogService.addActivity(
            loggedInUser, "No profile exists with requested vcroot and vcpath");
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(
                false, "No profile exists with requested vcroot and vcpath"),
            HttpStatus.BAD_REQUEST);
      }
      if (existAudit != null) {
        LOGGER.error("Error : Action for metadata entry with requested " +
                     "vcroot and vcpath pending");
        activityLogService.addActivity(loggedInUser,
                                       "Action for metadata entry with " +
                                       "requested vcroot and vcpath pending");
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(false, "Action for metadata entry with requested " +
                                   "vcroot and vcpath pending"),
            HttpStatus.BAD_REQUEST);
      }

      MetadataUiAudit metaAudit = new MetadataUiAudit();
      metaAudit.setVcpath(exist.getVcpath());
      metaAudit.setVcroot(exist.getVcroot());
      metaAudit.setBml(exist.getBml());
      metaAudit.setBscore(exist.getBscore());
      metaAudit.setBui(exist.getBui());
      metaAudit.setConfig(exist.getConfig());
      metaAudit.setVcquery(exist.getVcquery());
      metaAudit.setVccolumnname(exist.getVccolumnname());
      metaAudit.setVcdescription(exist.getVcdescription());
      metaAudit.setVcPrefix(exist.getVcPrefix());
      metaAudit.setItenantId(exist.getItenantId());
      metaAudit.setVcRemark(req.getMakerRemark());
      metaAudit.setVcAction("X");
      metaAudit.setIMetadataId(exist.getIMetadataId());
      MetadataUiAudit status = checkerMakerHelperService.saveWithObj(
          metadataAuditService, metaAudit, loggedInUser);
      if (status != null) {
        activityLogService.addActivity(loggedInUser,
                                       "Profile deletion sent for approval",
                                       "Parameters : " + req.toString());
        LOGGER.debug("Exiting addList Method in " +
                     HistoricProfileManagementServiceImpl.class +
                     " class with response  : item added successfully");
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(true, "Profile deletion sent for approval"),
            HttpStatus.CREATED);
      } else {
        activityLogService.addActivity(loggedInUser,
                                       "failed to delete profile entry");
        LOGGER.error("Exiting deleteProfile  Method in " +
                     HistoricProfileManagementServiceImpl.class +
                     " class with response  : failed to delete profile");
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(false, "Failed to delete profile"),
            HttpStatus.BAD_REQUEST);
      }

    } else {
      activityLogService.addActivity(loggedInUser,
                                     "unauthorized to delete profile ");
      LOGGER.error("Exiting deleteProfile Method in " +
                   HistoricProfileManagementServiceImpl.class +
                   " class with response  : unauthorized to delete profile");
      return new ResponseEntity<ApiResponse>(
          new ApiResponse(false, "unauthorized to delete profile"),
          HttpStatus.FORBIDDEN);
    }
  }

  @Override
  public ResponseEntity<?> approveProfile(ApproveProfileRequest req,
                                          Authentication pr) {
    LOGGER.debug("entered in class " +
                 HistoricProfileManagementServiceImpl.class +
                 " in method approveProfile");
    System.out.println("finding meta audit");
    Integer tenantid = req.getItenantId();
    LoggedUser loggedUser = (LoggedUser)pr.getPrincipal();
    System.out.println("finding meta audit 2");

    WebUser loggedInUser = loggedUser.getWebUser();
    System.out.println("finding meta audit 3");
    MenuPermissions mp = loggedUser.getPermissions().get(menu_name);
    System.out.println("finding meta audit 4");
    if (mp.isApprove() &&
        loggedUser.allowTenants(Arrays.asList(req.getItenantId()))) {
      System.out.println("finding meta audit 5");

      MetadataUiAudit metaAudit = null;
      try {
        metaAudit = metadataAuditService.findByMetadatUiId(req.getAuditId(),
                                                           req.getItenantId());
      } catch (Exception e) {
        LOGGER.error("Error : " + e +
                     "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
        activityLogService.addActivity(
            loggedInUser, "failed to get user and permissions", e.toString());
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
            HttpStatus.INTERNAL_SERVER_ERROR);
      }
      System.out.println("finding meta audit 6 " + metaAudit);
      if (metaAudit != null) {
        if (metaAudit.getIEntryUserID() == loggedInUser.getIuserID()) {
          LOGGER.error("Error : " +
                       loggerEncoderUtil.encode(loggedInUser.getVcUserName()) +
                       (" user not allowed to approve this entry which is " +
                        "created by himself"));
          activityLogService.addActivity(loggedInUser,
                                         "user not allowed to approve this " +
                                         "entry which is created by himself",
                                         "Error : " +
                                             loggedInUser.getVcUserName());
          return new ResponseEntity<ApiResponse>(
              new ApiResponse(false, "user not allowed to approve this entry " +
                                     "which is created by himself"),
              HttpStatus.FORBIDDEN);
        }
        MetadataUi metaUi = null;
        if (metaAudit.getVcAction().equals("A")) {
          metaUi = metaAudit.parseAudit(metaAudit);
        } else if (metaAudit.getVcAction().equals("M")) {
          MetadataUi metaUiOld = null;
          try {
            metaUiOld = metadataUiService.findByVcrootVcPathTenant(
                req.getVcroot(), req.getVcpath(), tenantid);
          } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " +
                         loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser,
                                           "failed to get user and permissions",
                                           e.toString());
            return new ResponseEntity<ApiResponse>(
                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                HttpStatus.INTERNAL_SERVER_ERROR);
          }
          metaUi = metaAudit.parseAudit(metaAudit);
          metaUi.setIMetadataId(metaUiOld.getIMetadataId());
        } else if (metaAudit.getVcAction().equals("X")) {
          try {
            metaUi = metadataUiService.findById(metaAudit.getIMetadataId());
          } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " +
                         loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser,
                                           "failed to get user and permissions",
                                           e.toString());
            return new ResponseEntity<ApiResponse>(
                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                HttpStatus.INTERNAL_SERVER_ERROR);
          }
        }
        if (metaUi != null) {
          metaAudit.setVcRemark("{" + metaAudit.getVcRemark() + "}"
                                + "{" + req.getCheckerRemark() + "}");
          Boolean status = false;
          String msg = "";
          if (req.getApprove()) {
            if (metaAudit.getVcAction().equals("X")) {
              metaUi.setIrecordStatus(1);
            }
            status = checkerMakerHelperService.save(
                metadataAuditService, metaAudit, metadataUiService, metaUi,
                loggedInUser, true, false);
            if (metaAudit.getVcAction().equals("A")) {
              msg = ((status == true)
                         ? "Profile entry addition successfully approved"
                         : "Profile entry addition approval failed");
            } else if (metaAudit.getVcAction().equals("M")) {
              msg = ((status == true)
                         ? "Profile entry edition successfully approved"
                         : "Profile entry edition approval failed");
            } else {
              msg = ((status == true)
                         ? "Profile entry deletion successfully approved"
                         : "Profile entry deletion approval failed");
            }
          } else {
            System.out.println("rejected request");
            status = checkerMakerHelperService.save(
                metadataAuditService, metaAudit, metadataUiService, metaUi,
                loggedInUser, false, true);
            if (metaAudit.getVcAction().equals("A")) {
              msg = ((status == true)
                         ? "Profile entry addition successfully rejected"
                         : "Profile entry addition rejection failed");
            } else if (metaAudit.getVcAction().equals("M")) {
              msg = ((status == true)
                         ? "Profile entry edition successfully rejected"
                         : "Profile entry edition rejection failed");
            } else {
              msg = ((status == true)
                         ? "Profile entry deletion successfully rejected"
                         : "Profile entry deletion rejection failed");
            }
            System.out.println("audit saved");
          }
          if (status) {
            activityLogService.addActivity(loggedInUser, msg);
            LOGGER.debug("Exiting approveList Method in " +
                         HistoricProfileManagementServiceImpl.class +
                         " class with response " + msg);
            return new ResponseEntity<ApiResponse>(new ApiResponse(true, msg),
                                                   HttpStatus.CREATED);
          } else {
            activityLogService.addActivity(loggedInUser, msg);
            LOGGER.error("Exiting approveList Method in " +
                         HistoricProfileManagementServiceImpl.class +
                         " class with response " + msg);
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, msg),
                                                   HttpStatus.BAD_REQUEST);
          }

        } else {
          activityLogService.addActivity(
              loggedInUser, "metadata entry failed to approve or reject");
          LOGGER.error(
              "Exiting approveList Method in " +
              HistoricProfileManagementServiceImpl.class +
              " class with response  : metadata entry failed for approval");
          return new ResponseEntity<ApiResponse>(
              new ApiResponse(false, "Something went wrong"),
              HttpStatus.INTERNAL_SERVER_ERROR);
        }
      } else {
        activityLogService.addActivity(
            loggedInUser, "profile entry failed to approve or reject");
        LOGGER.error(
            "Exiting approveList Method in " +
            HistoricProfileManagementServiceImpl.class +
            " class with response  : profile entry failed for approval");
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(false, "Something went wrong"),
            HttpStatus.INTERNAL_SERVER_ERROR);
      }

    } else {
      activityLogService.addActivity(loggedInUser,
                                     "unauthorized to add profile ");
      LOGGER.error("Exiting addProfile Method in " +
                   HistoricProfileManagementServiceImpl.class +
                   " class with response  : unauthorized to approve profile");
      return new ResponseEntity<ApiResponse>(
          new ApiResponse(false, "unauthorized to approve profile"),
          HttpStatus.FORBIDDEN);
    }
  }

  @Override
  public ResponseEntity<?> getAggregateTypes(Authentication pr) {
    LOGGER.debug("entered in class " +
                 HistoricProfileManagementServiceImpl.class +
                 " in method get aggregation types");

    LoggedUser loggedUser = (LoggedUser)pr.getPrincipal();

    WebUser loggedInUser = loggedUser.getWebUser();
    MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

    if (!mp.isView()) {
      activityLogService.addActivity(loggedInUser,
                                     "unauthorized to add profile ");
      LOGGER.error("Exiting addProfile Method in " +
                   HistoricProfileManagementServiceImpl.class +
                   " class with response  : unauthorized to add profile");
      return new ResponseEntity<ApiResponse>(
          new ApiResponse(false, "unauthorized to add profile"),
          HttpStatus.FORBIDDEN);
    }
    List<MetaData> profileAll = null;
    try {
      profileAll = historicProfilesService.findAllData();
    } catch (Exception e) {
      LOGGER.error("Error : " + e +
                   "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
      activityLogService.addActivity(
          loggedInUser, "failed to get user and permissions", e.toString());
      return new ResponseEntity<ApiResponse>(
          new ApiResponse(false, ResponseMessages.GenericErrorMessage),
          HttpStatus.INTERNAL_SERVER_ERROR);
    }

    List<String> types = profileAll.stream()
                             .map(md -> md.getVcpath())
                             .filter(path -> path.contains("{window}"))
                             .map(path -> path.split("\\.")[0])
                             .distinct()
                             .collect(Collectors.toList());
    List<DropDownVo> response = new ArrayList<>();
    response = DropDownVoMapper.parseAggregateTypes(types);

    return ResponseEntity.ok(response);
  }
}
