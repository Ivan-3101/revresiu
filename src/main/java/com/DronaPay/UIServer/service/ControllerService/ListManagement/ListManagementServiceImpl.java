package com.DronaPay.UIServer.service.ControllerService.ListManagement;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.ResponseVO.DropdownWithObject;
import com.DronaPay.UIServer.ResponseVO.ListDropDownVO;
import com.DronaPay.UIServer.ResponseVO.ListManagementVO;
import com.DronaPay.UIServer.ResponseVO.ListMasterVo;
import com.DronaPay.UIServer.VOMapper.DropdownWithObjectMapper;
import com.DronaPay.UIServer.VOMapper.ListDropDownVoMapper;
import com.DronaPay.UIServer.VOMapper.ListManagementVOMapper;
import com.DronaPay.UIServer.VOMapper.ListMasterDTOMapper;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.repository.ListReplicaRepository;
import com.DronaPay.UIServer.repository.StatusCodeRepository;
import com.DronaPay.UIServer.requests.AddNewPaymentRequest;
import com.DronaPay.UIServer.requests.ApproveListRequest;
import com.DronaPay.UIServer.requests.DeleteListRequest;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.ListManagementResponse;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.service.CamundaService;
import com.DronaPay.UIServer.service.HelperServices.CheckerMakerHelperService;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.ListValidationUtil;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.reactive.function.client.ClientResponse;

import java.text.SimpleDateFormat;
import java.time.ZonedDateTime;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class ListManagementServiceImpl implements ListManagementService {

    private static final Logger LOGGER =
            LoggerFactory.getLogger(ListManagementServiceImpl.class);
    final String menu_name = MenuNames.listManagement;
    @Autowired
    private ActivityLogService activityLogService;
    @Autowired
    private WebUserService webUserService;
    @Autowired
    private UserRoleMenuAccessService userRoleMenuAccessService;
    @Autowired
    private TenantRepositoryService tenantRepositoryService;
    @Autowired
    private ValidationFieldsListService validationFieldsListService;

    @Autowired
    private ListAuditServiceImpl listAuditService;
    @Autowired
    private ListReplicaServiceImpl listReplicaService;
    @Autowired
    private StatusCodeRepository statusCodeRepository;
    @Autowired
    private ListReplicaRepository listReplicaRepository;

    @Autowired
    private ListMasterService listMasterService;
    @Autowired
    private CamundaService camundaService;
    @Autowired
    private DecisionUiService decisionService;

    @Autowired
    private ListManagementVOMapper listManagementVOMapper;
    // @Autowired
    // private RulesService rulesService;
    @Autowired
    private ListMasterDTOMapper listMasterDTOMapper;
    @Autowired
    private RulesTempServiceImpl rulesTempService;
    @Autowired
    private CheckerMakerHelperService<ListAuditServiceImpl, ListAudit,
            ListReplicaServiceImpl, ListReplica> checkerMakerHelperService;
    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Value("${springapi.server.url}")
    private String spring_api_url;


    @Override
    public ResponseEntity<?> getListManagement(Authentication pr) {

        LOGGER.debug("entered in class " + ListManagementServiceImpl.class +
                " in method getListManagement");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        if (mp.isView()) {
            List<Integer> tenants = loggedUser.getUserTenant();
            ListManagementResponse responseList = new ListManagementResponse();
            responseList.setAdd(mp.isAdd());
            responseList.setView(mp.isView());
            responseList.setApprove(mp.isApprove());
            responseList.setEdit(mp.isEdit());
            responseList.setDelete(mp.isDelete());
            responseList.setPublish(mp.isPublish());
            List<ListReplica> listReplicas = null;
            try {
                listReplicas =
                        listReplicaService.findAllActiveListsTenants(tenants);
                // listReplicas = listReplicaService.findAllActiveLists();
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get " +
                        "user and permissions", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            List<ListManagementVO> listManagementVOs =
                    listManagementVOMapper.parseListReplica(listReplicas,
                            mp);
            // List<ListAudit> listAudits = listAuditService
            // .findPendingEntries();
            List<ListAudit> listAudits =
                    listAuditService.findPendingEntriesTenants(tenants);
            List<ListManagementVO> listManagementVOAudit =
                    listManagementVOMapper.parseAuditList(listAudits,
                            mp,
                            loggedInUser);

            for (int i = 0; i < listManagementVOs.size(); i++) {

                for (int j = 0; j < listManagementVOAudit.size(); j++) {
                    if (listManagementVOs.get(i).getId()
                            .equals(listManagementVOAudit.get(j).getId())) {
                        listManagementVOs.get(i).setAuditExist(true);

                    }
                }
            }
            listManagementVOs.addAll(listManagementVOAudit);
            responseList.setListManagementVO(listManagementVOs);

            activityLogService.addActivity(loggedInUser, " list view table " +
                    "data accessed successfully");
            LOGGER.debug("Exiting getListManagement Method in " + ListManagementServiceImpl.class
                    + " class with response  : with list of lists");
            return ResponseEntity.ok(responseList);

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to " +
                    "access list of lists");
            LOGGER.debug("Exiting getListManagement Method in " + ListManagementServiceImpl.class
                    + " class with response  : unauthorized to access list of" +
                    " lists");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access list of " +
                            "lists"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getParameterType(Integer itenantid, Authentication pr) {

        LOGGER.debug("entered in class " + ListManagementServiceImpl.class +
                " in method getParameterType");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            // Filter data by itenantid
            List<ListDropDownVO> responses = ListDropDownVoMapper
                    .parse(validationFieldsListService.findAllByItenantid(itenantid));
            LOGGER.debug("Exiting getParameterType Method in " + ListManagementServiceImpl.class
                    + " class with response  : with parameters type dropdown");
            activityLogService.addActivity(loggedInUser, "field dropdown accessed",
                    "Parameters : " + responses.toString());
            return ResponseEntity.ok(responses);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access parameter types ");
            LOGGER.debug("Exiting getParameterType Method in " + ListManagementServiceImpl.class
                    + " class with response  : unauthorized to access parameter types");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access parameter types"),
                    HttpStatus.FORBIDDEN);
        }
    }


    @Override
    public ResponseEntity<?> deleteListItem(DeleteListRequest deleteListRequest, Authentication pr) {
        LOGGER.debug("entered in class " + ListManagementServiceImpl.class +
                " in method deleteListItem");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isDelete()) {
            ListReplica listReplica = null;
            ListAudit listAudit = new ListAudit();
            ListAudit pending = null;

            if (deleteListRequest.getMakerRemark() != null) {
                if (deleteListRequest.getMakerRemark().isEmpty()
                        || deleteListRequest.getMakerRemark().isBlank()) {
                    activityLogService.addActivity(loggedInUser, "failed to " +
                                    "delete list",
                            deleteListRequest.getListItemID());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Maker remark cannot be " +
                                    "blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                activityLogService.addActivity(loggedInUser, "failed to " +
                                "delete list",
                        deleteListRequest.getListItemID());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Maker remark cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }
            try {
                pending =
                        listAuditService.findByExternalId(deleteListRequest.getListItemID(), deleteListRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get " +
                        "user and permissions", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (pending != null) {
                activityLogService.addActivity(loggedInUser, "failed to " +
                                "delete list",
                        deleteListRequest.getListItemID());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "List is already pending for " +
                                "approval"),
                        HttpStatus.BAD_REQUEST);
            }
            try {
                listReplica =
                        listReplicaService.findByExternalId(deleteListRequest.getListItemID(), deleteListRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get " +
                        "user and permissions", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            if (listReplica != null) {
                listAudit = listReplica.parseToAudit(listReplica);
                listAudit.setVcAction("X");
                listAudit.setVcRemark(deleteListRequest.getMakerRemark());
            } else {
                activityLogService.addActivity(loggedInUser, "failed to " +
                                "delete list",
                        deleteListRequest.getListItemID());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "List is pending for approval cannot perfom " +
                                        "this action"),
                        HttpStatus.BAD_REQUEST);
            }

            Boolean status = checkerMakerHelperService.save(listAuditService,
                    listAudit, listReplicaService,
                    listReplica, loggedInUser, false, false);
            if (status) {
                activityLogService.addActivity(loggedInUser, "list entry " +
                                "deletion sent for approval",
                        "Parameters : {listItemID :" + deleteListRequest.getListItemID() + "}");
                LOGGER.debug("Exiting deleteListItem Method in " +
                        ListManagementServiceImpl.class
                        + " class with response : item deleted success fully");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(true, "List entry deletion sent for " +
                                "approval"),
                        HttpStatus.OK);
            } else {
                activityLogService.addActivity(loggedInUser, "failed to " +
                                "delete list entry",
                        "Parameters : {listItemID :" + deleteListRequest.getListItemID() + "}");
                LOGGER.error("Exiting deleteListItem Method in " +
                        ListManagementServiceImpl.class
                        + " class with response : delete list failed");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                        "Failed to delete list"),
                        HttpStatus.BAD_REQUEST);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to " +
                    "delete list item ");
            LOGGER.debug("Exiting deleteListItem Method in " + ListManagementServiceImpl.class
                    + " class with response  : unauthorized to delete list " +
                    "item ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to delete list item"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public ResponseEntity<?> addList(AddNewPaymentRequest req,
                                     Authentication pr) {

        LOGGER.debug("entered in class " + ListManagementServiceImpl.class +
                " in method addList");

        List<Integer> tenants = Arrays.asList(req.getItenantId());
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser user = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);
        if (mp.isAdd() && loggedUser.allowTenants(tenants)) {
            ListAudit listNew = new ListAudit();
            org.json.JSONObject param =
                    new org.json.JSONObject(req.getVcRequestData());

            listNew.setVcExternalListItemId(param.optString("externalId"));

            String source = param.optString("source");
            String value = param.optString("itemValue");

            if (source.isEmpty() || source.isBlank()) {
                if (value.isEmpty() || value.isBlank()) {
                    activityLogService.addActivity(user, "failed to add list " +
                            "entry");
                    LOGGER.error("Exiting Add List  Method in " + ListManagementServiceImpl.class
                            + " class with response  : failed to add list");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Please enter all " +
                                    "mandatory fields"),
                            HttpStatus.BAD_REQUEST);
                }
            }

            if (source.isEmpty() || source.isBlank()) {
                activityLogService.addActivity(user, "failed to add list " +
                        "entry");
                LOGGER.error("Exiting Add List  Method in " + ListManagementServiceImpl.class
                        + " class with response  : failed to add list");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                        "Source cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            Pattern pattern = Pattern.compile("^[a-zA-Z0-9 ,_@*#%'/\\\\()+&.-]+$");

            Matcher sourceMatcher = pattern.matcher(source);
            if (!sourceMatcher.matches()) {
                activityLogService.addActivity(user, "failed to add list entry due to invalid source format", source);
                LOGGER.debug("Exiting addList Method in " + ListManagementServiceImpl.class
                        + " class with response: Invalid Source format");
                return new ResponseEntity<>(new ApiResponse(false,
                        "Source can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), " +
                                "at (@), space, asterisk (*), hash (#), percentage (%), single quotation ('), " +
                                "forward and backward slash (/ , \\), brackets (), plus (+), ampersand (&) and dot (.)"),
                        HttpStatus.BAD_REQUEST);
            }

            if (value.isEmpty() || value.isBlank()) {
                activityLogService.addActivity(user, "failed to add list " +
                        "entry");
                LOGGER.error("Exiting Add List  Method in " + ListManagementServiceImpl.class
                        + " class with response  : failed to add list");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                        "Value cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            Matcher valueMatcher = pattern.matcher(value);
            if (!valueMatcher.matches()) {
                activityLogService.addActivity(user, "failed to add list entry due to invalid value format", value);
                LOGGER.debug("Exiting addList Method in " + ListManagementServiceImpl.class
                        + " class with response: Invalid Value format");
                return new ResponseEntity<>(new ApiResponse(false,
                        "Value can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), " +
                                "at (@), space, asterisk (*), hash (#), percentage (%), single quotation ('), " +
                                 "forward and backward slash (/ , \\), brackets (), plus (+), ampersand (&) and dot (.)"),
                        HttpStatus.BAD_REQUEST);
            }

            if (param.optString("effectiveFrom").isEmpty() || param.optString("effectiveFrom").isBlank()) {
                activityLogService.addActivity(user, "failed to add list " +
                        "entry");
                LOGGER.error("Exiting Add List  Method in " + ListManagementServiceImpl.class
                        + " class with response  : failed to add list");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Start date cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (param.optString("expiresAt").isEmpty() || param.optString(
                    "expiresAt").isBlank()) {
                activityLogService.addActivity(user, "failed to add list " +
                        "entry");
                LOGGER.error("Exiting Add List  Method in " + ListManagementServiceImpl.class
                        + " class with response  : failed to add list");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Expiry date cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            Integer type = null;
            try {
                type = param.getInt("listType");
            } catch (Exception e) {
                activityLogService.addActivity(user, "failed to add list " +
                        "entry");
                LOGGER.error("Exiting Add List  Method in " + ListManagementServiceImpl.class
                        + " class with response  : failed to add list");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                        "Type cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (type == -1) {
                if (param.optString("name").isEmpty() || param.optString(
                        "name").isBlank()) {
                    activityLogService.addActivity(user, "failed to add list " +
                            "entry");
                    LOGGER.error("Exiting Add List  Method in " + ListManagementServiceImpl.class
                            + " class with response  : failed to add list");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Name cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            }

            if (req.getMakerRemark() != null) {
                if (req.getMakerRemark().isEmpty() || req.getMakerRemark().isBlank()) {
                    activityLogService.addActivity(user, "failed to add list " +
                            "entry");
                    LOGGER.error("Exiting Add List  Method in " + ListManagementServiceImpl.class
                            + " class with response  : failed to add list");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Maker remark cannot be " +
                                    "blank"),
                            HttpStatus.BAD_REQUEST);
                }
            }
            // listNew.setItenantId(req.getItenantId());
            // listNew.setIlistType(null);
            listNew.setVcValue(param.optString("itemValue"));
            listNew.setVcField(param.optString("itemField"));
            listNew.setVcNote(param.optString("note"));
            listNew.setVcAction("A");
            listNew.setVcRemark(req.getMakerRemark());
            listNew.setVcSource(param.optString("source"));
            ObjectMapper obj = new ObjectMapper();
            JsonNode atrribs = null;
            try {
                if (!param.optString("attribs").isBlank()) {
                    atrribs = obj.readTree(param.optString("attribs"));
                    listNew.setAttribs(atrribs);
                }
            } catch (JsonProcessingException e) {
                throw new RuntimeException(e);
            }

            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T" +
                    "'HH:mm:ss.SSS'Z'");
            inputFormat.setTimeZone(TimeZone.getTimeZone("UTC"));

            try {

                ListMaster templistmaster = null;
                if (type == -1) {
                    ListMaster lm = new ListMaster();
                    lm.setVcName(param.optString("name"));
                    templistmaster = listMasterService.save(lm);
                } else {
                    templistmaster = listMasterService.findByID(type,
                            req.getItenantId());
                }

                listNew.setIlistType(templistmaster);
                if (!inputFormat.parse(param.optString("effectiveFrom"))
                        .before(inputFormat.parse(param.optString("expiresAt")))) {
                    if (!inputFormat.parse(param.optString("effectiveFrom"))
                            .equals(inputFormat.parse(param.optString(
                                    "expiresAt")))) {
                        activityLogService.addActivity(user, "failed to edit " +
                                "list entry");
                        LOGGER.error("Exiting editList  Method in "
                                + ListManagementServiceImpl.class
                                + " class with response  : failed to edit " +
                                "list");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Expiry date should be equal to or " +
                                                "greater than Start Date"),
                                HttpStatus.BAD_REQUEST);
                    }
                }

                if (templistmaster.getIForDays() != null) {
                    Date start = inputFormat.parse(param.optString(
                            "effectiveFrom"));
                    Date end = inputFormat.parse(param.optString("expiresAt"));
                    long days =
                            (end.getTime() - start.getTime()) / (1000 * 60 * 60 * 24);
                    if (days > templistmaster.getIForDays()) {
                        LOGGER.error("Exiting addList  Method in "
                                + ListManagementServiceImpl.class
                                + " class with response  : failed to edit " +
                                "list");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, "Expiry date should be" +
                                        " within "
                                        + templistmaster.getIForDays()
                                        + " days from Start Date"),
                                HttpStatus.BAD_REQUEST);
                    }
                }
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : api url "
                        + spring_api_url + " api key "
                        + "");
                activityLogService.addActivity(user, "failed to add list item",
                        "Error : " + e.toString() + ", Parameters : " + user);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                        "Something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

//            try {
            listNew.setDtEffectiveFrom(ZonedDateTime.parse(param.optString(
                    "effectiveFrom")));
            listNew.setDtExpiresAt(ZonedDateTime.parse(param.optString(
                    "expiresAt")));
//            } catch (ParseException e) {
//                LOGGER.error("Error : " + e + "\nParam : api url " +
//                spring_api_url
//                        + " api key "
//                        + env.getProperty("score.server.key"));
//                activityLogService.addActivity(user, "failed to add list
//                item",
//                        "Error : " + e.toString() + ", Parameters : " + user);
//                return new ResponseEntity<ApiResponse>(new ApiResponse
//                (false, "Something went wrong"),
//                        HttpStatus.INTERNAL_SERVER_ERROR);
//            }

            // ListReplica listReplica = listNew.parseAudit(listNew);
            ListValidationUtil listValidationUtil =
                    new ListValidationUtil(listReplicaService);
            listValidationUtil.DoValdiations(listNew.getVcField(), listNew.getVcValue(), listNew.getIlistType().getId().getIListMasterID(), listNew.getDtEffectiveFrom(),
                    listNew.getDtExpiresAt(), listNew.getIlistType().getId().getItenantId().getItenantid(), param.optString("attribs"), false);
            if (listValidationUtil.getSuccess() == false) {

                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                listValidationUtil.getMessage()
                        ),
                        HttpStatus.BAD_REQUEST);
            }
            ListAudit status =
                    checkerMakerHelperService.saveWithObj(listAuditService,
                            listNew, user);
            if (status != null && (atrribs != null || param.opt(
                    "processInstanceId") != null)) {

                if ((atrribs != null && atrribs.get("processInstanceId") != null)
                        || param.opt("processInstanceId") != null) {

                    String processInstanceId =
                            param.opt("processInstanceId") != null
                                    ? param.get("processInstanceId").toString()
                                    : (atrribs != null ? atrribs.get("processInstanceId").asText() : "");

                    String list_id = param.getInt("listType") == 0
                            ? "        \"blacklist_id\": {\n" +
                            "            \"type\": \"Integer\",\n" +
                            "            \"value\": "
                            + status.getIListItemAuditId() + "\n" +
                            "        },\n"
                            : "        \"whitelist_id\": {\n" +
                            "            \"type\": \"Integer\",\n" +
                            "            \"value\": "
                            + status.getIListItemAuditId() + "\n" +
                            "        },\n";

                    if (!processInstanceId.isBlank()) {
                        JSONObject body = new JSONObject("{\n" +
                                "    \"modifications\": {\n" +
                                list_id +
                                "        \"address\": {\n" +
                                "            \"type\": \"string\",\n" +
                                "            \"value\":  \""
                                + param.optString("itemField")
                                + "\"\n" +
                                "        },\n" +
                                "        \"maker_remark\": {\n" +
                                "            \"type\": \"string\",\n" +
                                "            \"value\": \"" + req.getMakerRemark()
                                + "\"\n" +
                                "        }\n" +
                                "        \n" +
                                "    }\n" +
                                "}");

                        LOGGER.debug("Variable Body : " + String.valueOf(body));

                        LOGGER.debug("update camunda body  : " + String.valueOf(body));
                        System.out.println("Camunda update " + body.toString());
                        ResponseEntity<String> variableupdate;
                        try {
                            variableupdate =
                                    camundaService.addVariable(processInstanceId,
                                            body, user);
                        } catch (Exception e) {
                            TransactionAspectSupport.currentTransactionStatus()
                                    .setRollbackOnly();
                            activityLogService.addActivity(user,
                                    "failed to add variable in camunda");
                            LOGGER.error("Exiting Add List  Method in "
                                    + ListManagementServiceImpl.class
                                    + " class with response  : failed to add " +
                                    "variable in camunda");
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "Failed to add list audit entry " +
                                                    "because error in camunda"),
                                    HttpStatus.BAD_REQUEST);
                        }
//                        variableupdate.releaseBody();
                        if (variableupdate.getStatusCode() != HttpStatus.NO_CONTENT) {
                            TransactionAspectSupport.currentTransactionStatus()
                                    .setRollbackOnly();
                            activityLogService.addActivity(user,
                                    " failed to add list audit entry ");
                            LOGGER.error("Exiting Add List  Method in "
                                    + ListManagementServiceImpl.class
                                    + " class with response  : failed to add " +
                                    "list audit entry because camunda api " +
                                    "status code is  "
                                    + variableupdate.getStatusCode());
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "Failed to add list audit entry " +
                                                    "because error in camunda"),
                                    HttpStatus.BAD_REQUEST);
                        }
//                        LOGGER.info("veriable update api response "
//                                + variableupdate.statusCode()
//                                + "   body "
//                                + variableupdate.bodyToMono(String.class).block());
                        LOGGER.info("veriable update api response "
                                + variableupdate.getStatusCode()
                                + "   body "
                                + variableupdate.getBody());
//                        variableupdate.releaseBody();
                    }
                }
            }

            if (status != null) {
                activityLogService.addActivity(user, "List entry addition " +
                                "sent for approval",
                        "Parameters : " + req.toString());
                LOGGER.debug("Exiting addList Method in " + ListManagementServiceImpl.class
                        + " class with response  : item added successfully");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(true, "List entry addition sent for " +
                                "approval"),
                        HttpStatus.CREATED);
            } else {
                activityLogService.addActivity(user, "failed to add list " +
                        "entry");
                LOGGER.error("Exiting Add List  Method in " + ListManagementServiceImpl.class
                        + " class with response  : failed to add list");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                        "Failed to add list"),
                        HttpStatus.BAD_REQUEST);
            }

        } else {
            activityLogService.addActivity(user, "unauthorized to add list " +
                    "item");
            LOGGER.debug("Exiting deleteListItem Method in " + ListManagementServiceImpl.class
                    + " class with response  : unauthorized to add list item");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                    "unauthorized to add list item"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> approveList(ApproveListRequest approveListRequest, Authentication pr) {
        LOGGER.debug("entered in class " + ListManagementServiceImpl.class +
                " in method approveList");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        if (mp.isApprove()) {
            if (approveListRequest.getExternalID() != null) {
                ListAudit listAudit = null;
                ListReplica listReplica = null;
                if (approveListRequest.getCheckerRemark() != null) {
                    if (approveListRequest.getCheckerRemark().isEmpty()
                            || approveListRequest.getCheckerRemark().isBlank()) {
                        activityLogService.addActivity(loggedInUser,
                                "list add entry failed to approve");
                        LOGGER.debug("Exiting approveList Method in "
                                + ListManagementServiceImpl.class
                                + " class with response  : item failed to " +
                                "approve");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Checker remark cannot be blank"),
                                HttpStatus.BAD_REQUEST);
                    }
                } else {
                    LOGGER.debug("Exiting approveList Method in " + ListManagementServiceImpl.class
                            + " class with response  : item failed to approve");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Checker remark cannot be " +
                                    "blank"),
                            HttpStatus.BAD_REQUEST);
                }
                try {
                    listAudit = listAuditService
                            .findByExternalId(approveListRequest.getExternalID(), approveListRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to " +
                                    "get user and permissions",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                if (listAudit != null) {

                    if (listAudit.getIEntryUserID() == loggedInUser.getIuserID()) {
                        LOGGER.error("Error : " + loggerEncoderUtil.encode(loggedInUser.getVcUserName())
                                + " user not allowed to approve this entry " +
                                "which is created by himself ilistauditid "
                                + loggerEncoderUtil.encode(String.valueOf(
                                listAudit.getIListItemAuditId())));
                        activityLogService.addActivity(loggedInUser,
                                "user not allowed to approve this entry which" +
                                        " is created by himself",
                                "Error : " + loggedInUser.getVcUserName() +
                                        " ilistauditid "
                                        + listAudit.getIListItemAuditId());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "user not allowed to approve this " +
                                                "entry which is created by " +
                                                "himself"),
                                HttpStatus.FORBIDDEN);
                    }

                    listReplica = listAudit.parseAudit(listAudit);
                    listAudit.setVcRemark("{" + listAudit.getVcRemark() + "}"
                            + "{" + approveListRequest.getCheckerRemark() +
                            "}");
                    Boolean status = false;
                    if (approveListRequest.getApprove()) {
                        status =
                                checkerMakerHelperService.save(listAuditService, listAudit,
                                        listReplicaService,
                                        listReplica, loggedInUser, true, false);
                    } else {
                        status =
                                checkerMakerHelperService.save(listAuditService, listAudit,
                                        listReplicaService,
                                        listReplica, loggedInUser, false, true);
                    }
                    JsonNode atrribs = listAudit.getAttribs();
                    if (status != null && atrribs != null) {

                        if (atrribs.get("processInstanceId") != null
                                || approveListRequest.getProcessInstanceId() != null) {
                            String processInstanceId = approveListRequest
                                    .getProcessInstanceId() != null
                                    ? approveListRequest
                                    .getProcessInstanceId()
                                    : atrribs.get("processInstanceId")
                                    .asText();
                            if (!processInstanceId.isBlank()) {
                                String value = approveListRequest.getApprove()
                                        ? "Approved"
                                        : "Not Approved";

                                JSONObject body = new JSONObject("{\n" +
                                        "    \"modifications\": {\n" +
                                        "        " +
                                        "\"checker_action_whitelist_obj\": {\n"
                                        +
                                        "            \"type\": \"string\",\n" +
                                        "            \"value\": " +
                                        "\"{\\\"user\\\": \\\""
                                        + loggedInUser.getVcUserName()
                                        + "\\\",\\\"value\\\": \\\"" + value
                                        + "\\\"}\"\n" +
                                        "        },\n" +
                                        "        \"checker_action_whitelist" +
                                        "\": {\n"
                                        +
                                        "            \"type\": \"string\",\n" +
                                        "            \"value\": \"" + value
                                        + "\"\n" +
                                        "        },\n" +
                                        "        " +
                                        "\"checker_action_blacklist_obj\": {\n"
                                        +
                                        "            \"type\": \"string\",\n" +
                                        "            \"value\": " +
                                        "\"{\\\"user\\\": \\\""
                                        + loggedInUser.getVcUserName()
                                        + "\\\",\\\"value\\\": \\\"" + value
                                        + "\\\"}\"\n" +
                                        "        },\n" +
                                        "        \"checker_action_blacklist" +
                                        "\": {\n"
                                        +
                                        "            \"type\": \"string\",\n" +
                                        "            \"value\": \"" + value
                                        + "\"\n" +
                                        "        },\n" +
                                        "        \"checker_remark\": {\n" +
                                        "            \"type\": \"string\",\n" +
                                        "            \"value\": \""
                                        + approveListRequest.getCheckerRemark()
                                        + "\"\n" +
                                        "        }\n" +
                                        "        \n" +
                                        "    }\n" +
                                        "}");
                                System.out.println(body);
                                ResponseEntity<String>  variableupdate;
                                try {
                                    variableupdate = camundaService.addVariable(
                                            processInstanceId, body,
                                            loggedInUser);
                                } catch (Exception e) {

                                    TransactionAspectSupport
                                            .currentTransactionStatus()
                                            .setRollbackOnly();
                                    activityLogService.addActivity(loggedInUser,
                                            "failed to add variable in " +
                                                    "camunda");
                                    LOGGER.error("Exiting Add List  Method in "
                                            + ListManagementServiceImpl.class
                                            + " class with response  : failed" +
                                            " to add variable in camunda");
                                    return new ResponseEntity<ApiResponse>(
                                            new ApiResponse(false,
                                                    "Failed to approve audit " +
                                                            "entry because " +
                                                            "error in camunda"),
                                            HttpStatus.BAD_REQUEST);
                                }
//                                variableupdate.releaseBody();
                                if (variableupdate
                                        .getStatusCode() != HttpStatus.NO_CONTENT) {
                                    TransactionAspectSupport
                                            .currentTransactionStatus()
                                            .setRollbackOnly();
                                    activityLogService.addActivity(loggedInUser,
                                            "Failed to approve audit entry");
                                    LOGGER.error("Exiting Add List  Method in "
                                            + ListManagementServiceImpl.class
                                            + " class with response  : Failed" +
                                            " to approve audit entry because " +
                                            "camunda api status code is  "
                                            + variableupdate.getStatusCode());
                                    return new ResponseEntity<ApiResponse>(
                                            new ApiResponse(false,
                                                    "Failed to approve audit " +
                                                            "entry because " +
                                                            "error in camunda"),
                                            HttpStatus.BAD_REQUEST);
                                }
                                LOGGER.info("veriable update api response "
                                        + variableupdate.getStatusCode()
                                        + "   body "
                                        + variableupdate.getBody());

                            }
                        }
                    }
                    if (approveListRequest.getApprove()) {
                        if (listAudit.getVcAction().equals("A")) {
                            if (status) {
                                activityLogService.addActivity(loggedInUser,
                                        "list add entry approved successfully");
                                LOGGER.debug("Exiting approveList Method in "
                                        + ListManagementServiceImpl.class
                                        + " class with response  : item added" +
                                        " successfully");
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(true,
                                                "List addition entry approved" +
                                                        " successfully"),
                                        HttpStatus.CREATED);
                            } else {
                                activityLogService.addActivity(loggedInUser,
                                        "list addition entry failed to " +
                                                "approve");
                                LOGGER.debug("Exiting approveList Method in "
                                        + ListManagementServiceImpl.class
                                        + " class with response  : item added" +
                                        " successfully");
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                "List addition entry failed " +
                                                        "to approve"),
                                        HttpStatus.BAD_REQUEST);
                            }
                        } else if (listAudit.getVcAction().equals("M")) {
                            if (status) {
                                activityLogService.addActivity(loggedInUser,
                                        "list edit entry approved " +
                                                "successfully");
                                LOGGER.debug("Exiting approveList Method in "
                                        + ListManagementServiceImpl.class
                                        + " class with response  : item added" +
                                        " successfully");
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(true,
                                                "List edition entry approved " +
                                                        "successfully"),
                                        HttpStatus.CREATED);
                            } else {
                                activityLogService.addActivity(loggedInUser,
                                        "list edition entry failed to approve");
                                LOGGER.debug("Exiting approveList Method in "
                                        + ListManagementServiceImpl.class
                                        + " class with response  : item added" +
                                        " successfully");
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                "List edition entry failed to" +
                                                        " approve"),
                                        HttpStatus.BAD_REQUEST);
                            }
                        } else if (listAudit.getVcAction().equals("X")) {
                            if (status) {
                                listAudit.setIRecordStatus(1);
                                listReplica.setIrecordStatus(1);
                                activityLogService.addActivity(loggedInUser,
                                        "list deletion entry approved " +
                                                "successfully");
                                LOGGER.debug("Exiting approveList Method in "
                                        + ListManagementServiceImpl.class
                                        + " class with response  : item added" +
                                        " successfully");
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(true,
                                                "List deletion entry approved" +
                                                        " successfully"),
                                        HttpStatus.CREATED);
                            } else {
                                activityLogService.addActivity(loggedInUser,
                                        "list deletion entry failed to " +
                                                "approve");
                                LOGGER.debug("Exiting approveList Method in "
                                        + ListManagementServiceImpl.class
                                        + " class with response  : item added" +
                                        " successfully");
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                "List deletion entry failed " +
                                                        "to approve"),
                                        HttpStatus.BAD_REQUEST);
                            }
                        } else {
                            activityLogService.addActivity(loggedInUser,
                                    "list entry failed to approve or reject");
                            LOGGER.debug("Exiting approveList Method in "
                                    + ListManagementServiceImpl.class
                                    + " class with response  : list entry " +
                                    "failed for approval");
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false, "Something went " +
                                            "wrong"),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                    } else {
                        if (listAudit.getVcAction().equals("A")) {
                            if (status) {
                                activityLogService.addActivity(loggedInUser,
                                        "list addition entry rejected " +
                                                "successfully");
                                LOGGER.debug("Exiting approveList Method in "
                                        + ListManagementServiceImpl.class
                                        + " class with response  : item added" +
                                        " successfully");
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(true,
                                                "List addition entry rejected" +
                                                        " successfully"),
                                        HttpStatus.CREATED);
                            } else {
                                activityLogService.addActivity(loggedInUser,
                                        "list add entry failed to reject");
                                LOGGER.debug("Exiting approveList Method in "
                                        + ListManagementServiceImpl.class
                                        + " class with response  : item added" +
                                        " successfully");
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                "List addition entry failed " +
                                                        "to reject"),
                                        HttpStatus.BAD_REQUEST);
                            }
                        } else if (listAudit.getVcAction().equals("M")) {
                            if (status) {
                                activityLogService.addActivity(loggedInUser,
                                        "list edition entry rejected " +
                                                "successfully");
                                LOGGER.debug("Exiting approveList Method in "
                                        + ListManagementServiceImpl.class
                                        + " class with response  : item added" +
                                        " successfully");
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(true,
                                                "List edition entry rejected " +
                                                        "successfully"),
                                        HttpStatus.CREATED);
                            } else {
                                activityLogService.addActivity(loggedInUser,
                                        "list edit entry failed to reject");
                                LOGGER.debug("Exiting approveList Method in "
                                        + ListManagementServiceImpl.class
                                        + " class with response  : item added" +
                                        " successfully");
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                "List edit entry failed to " +
                                                        "reject"),
                                        HttpStatus.BAD_REQUEST);
                            }
                        } else if (listAudit.getVcAction().equals("X")) {
                            if (status) {
                                activityLogService.addActivity(loggedInUser,
                                        "list deletion entry rejected " +
                                                "successfully");
                                LOGGER.debug("Exiting approveList Method in "
                                        + ListManagementServiceImpl.class
                                        + " class with response  : item added" +
                                        " successfully");
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(true,
                                                "List deletion entry rejected" +
                                                        " successfully"),
                                        HttpStatus.CREATED);
                            } else {
                                activityLogService.addActivity(loggedInUser,
                                        "list deletion entry failed to reject");
                                LOGGER.debug("Exiting approveList Method in "
                                        + ListManagementServiceImpl.class
                                        + " class with response  : item added" +
                                        " successfully");
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                "List deletion entry failed " +
                                                        "to reject"),
                                        HttpStatus.BAD_REQUEST);
                            }
                        } else {
                            activityLogService.addActivity(loggedInUser,
                                    "list entry failed to approve or reject");
                            LOGGER.debug("Exiting approveList Method in "
                                    + ListManagementServiceImpl.class
                                    + " class with response  : list entry " +
                                    "failed for approval");
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false, "Something went " +
                                            "wrong"),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                    }

                } else {
                    activityLogService.addActivity(loggedInUser,
                            "list entry failed to approve or reject");
                    LOGGER.debug("Exiting approveList Method in " + ListManagementServiceImpl.class
                            + " class with response  : list entry failed for " +
                            "approval");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Something went wrong"),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

            } else {
                activityLogService.addActivity(loggedInUser,
                        "list enrtry failed for approve or reject action");
                LOGGER.debug("Exiting approveList Method in " + ListManagementServiceImpl.class
                        + " class with response  : failed to approve list");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "External id cannot be null"),
                        HttpStatus.BAD_REQUEST);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to " +
                    "approve list item");
            LOGGER.debug("Exiting approveList Method in " + ListManagementServiceImpl.class
                    + " class with response  : unauthorized to approve list " +
                    "item");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to approve list item"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> editList(AddNewPaymentRequest addNewPaymentRequest, Authentication pr) {
        LOGGER.debug("entered in class " + ListManagementServiceImpl.class +
                " in method editList");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser user = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isEdit() && loggedUser.allowTenants(Arrays.asList(addNewPaymentRequest.getItenantId()))) {
            ListAudit listAudit = null;
            org.json.JSONObject param =
                    new org.json.JSONObject(addNewPaymentRequest.getVcRequestData());
            try {
                listAudit =
                        listAuditService.findByExternalId(param.optString(
                                        "externalId"),
                                addNewPaymentRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(user, "failed to get user and " +
                        "permissions", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            String source = param.optString("source");
            String value = param.optString("itemValue");

            if (source.isEmpty() || source.isBlank()) {
                if (value.isEmpty() || value.isBlank()) {
                    activityLogService.addActivity(user, "failed to edit list" +
                            " entry");
                    LOGGER.error("Exiting editList  Method in " + ListManagementServiceImpl.class
                            + " class with response  : failed to edit list");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "All fields are mandatory"),
                            HttpStatus.BAD_REQUEST);
                }
            }

            if (source.isEmpty() || source.isBlank()) {
                activityLogService.addActivity(user, "failed to edit list " +
                        "entry");
                LOGGER.error("Exiting editList  Method in " + ListManagementServiceImpl.class
                        + " class with response  : failed to edit list");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                        "Source cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            Pattern pattern = Pattern.compile("^[a-zA-Z0-9 ,_@*#%'/\\\\()+&.-]+$");

            Matcher sourceMatcher = pattern.matcher(source);
            if (!sourceMatcher.matches()) {
                activityLogService.addActivity(user, "failed to edit list entry due to invalid source format", source);
                LOGGER.debug("Exiting editList Method in " + ListManagementServiceImpl.class
                        + " class with response: Invalid Source format");
                return new ResponseEntity<>(new ApiResponse(false,
                        "Source can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), " +
                                "at (@), space, asterisk (*), hash (#), percentage (%), single quotation ('), " +
                                "forward and backward slash (/ , \\), brackets (), plus (+), ampersand (&) and dot (.)"),
                        HttpStatus.BAD_REQUEST);
            }

            if (value.isEmpty() || value.isBlank()) {
                activityLogService.addActivity(user, "failed to edit list " +
                        "entry");
                LOGGER.error("Exiting editList  Method in " + ListManagementServiceImpl.class
                        + " class with response  : failed to edit list");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                        "Value cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            Matcher valueMatcher = pattern.matcher(value);
            if (!valueMatcher.matches()) {
                activityLogService.addActivity(user, "failed to edit list entry due to invalid value format", value);
                LOGGER.debug("Exiting editList Method in " + ListManagementServiceImpl.class
                        + " class with response: Invalid Value format");
                return new ResponseEntity<>(new ApiResponse(false,
                        "Value can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), " +
                                "at (@), space, asterisk (*), hash (#), percentage (%), single quotation ('), " +
                                "forward and backward slash (/ , \\), brackets (), plus (+), ampersand (&) and dot (.)"),
                        HttpStatus.BAD_REQUEST);
            }

            if (param.optString("effectiveFrom").isEmpty() || param.optString("effectiveFrom").isBlank()) {
                activityLogService.addActivity(user, "failed to edit list " +
                        "entry");
                LOGGER.error("Exiting editList  Method in " + ListManagementServiceImpl.class
                        + " class with response  : failed to edit list");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Start date cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (param.optString("expiresAt").isEmpty() || param.optString(
                    "expiresAt").isBlank()) {
                activityLogService.addActivity(user, "failed to edit list " +
                        "entry");
                LOGGER.error("Exiting editList  Method in " + ListManagementServiceImpl.class
                        + " class with response  : failed to edit list");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Expiry date cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addNewPaymentRequest.getMakerRemark() == null) {
                activityLogService.addActivity(user, "failed to edit list " +
                        "entry");
                LOGGER.error("Exiting editList  Method in " + ListManagementServiceImpl.class
                        + " class with response  : failed to edit list");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Maker remark cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addNewPaymentRequest.getMakerRemark() != null) {
                if (addNewPaymentRequest.getMakerRemark().isEmpty()
                        || addNewPaymentRequest.getMakerRemark().isBlank()) {
                    activityLogService.addActivity(user, "failed to edit list" +
                            " entry");
                    LOGGER.error("Exiting editList  Method in " + ListManagementServiceImpl.class
                            + " class with response  : failed to edit list");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Maker remark cannot be " +
                                    "blank"),
                            HttpStatus.BAD_REQUEST);
                }
            }

            Integer type = null;
            try {
                type = param.getInt("listType");
            } catch (Exception e) {
                activityLogService.addActivity(user, "failed to add list " +
                        "entry");
                LOGGER.error("Exiting Add List  Method in " + ListManagementServiceImpl.class
                        + " class with response  : failed to add list");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                        "Type cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (listAudit != null) {
                ListAudit editSave = new ListAudit();
                editSave.setVcExternalListItemId(param.optString("externalId"));
                editSave.setIListItemAuditId(listAudit.getIListItemAuditId());
                editSave.setVcSource(param.optString("source"));

                ObjectMapper obj = new ObjectMapper();
                try {
                    if (!param.optString("attribs").isBlank()) {
                        editSave.setAttribs(obj.readTree(param.optString("attribs")));
                    }
                } catch (JsonProcessingException e) {
                    throw new RuntimeException(e);
                }
                editSave.setVcValue(param.optString("itemValue"));
                editSave.setVcField(param.optString("itemField"));
                editSave.setVcNote(param.optString("note"));
                // listAudit.setVcAction("M");
                editSave.setVcRemark(addNewPaymentRequest.getMakerRemark());
                editSave.setVcAction(listAudit.getVcAction());

                SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM" +
                        "-dd'T'HH:mm:ss.SSS'Z'");
                inputFormat.setTimeZone(TimeZone.getTimeZone("UTC"));

                try {
                    ListMaster temp = listMasterService.findByID(type,
                            addNewPaymentRequest.getItenantId());
                    editSave.setIlistType(temp);
                    if (!inputFormat.parse(param.optString("effectiveFrom"))
                            .before(inputFormat.parse(param.optString(
                                    "expiresAt")))) {
                        if (!inputFormat.parse(param.optString("effectiveFrom"))
                                .equals(inputFormat
                                        .parse(param.optString("expiresAt")))) {
                            activityLogService.addActivity(user,
                                    "failed to edit list entry");
                            LOGGER.error("Exiting editList  Method in "
                                    + ListManagementServiceImpl.class
                                    + " class with response  : failed to edit" +
                                    " list");
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "Start date should be less than " +
                                                    "equal to expiry date"),
                                    HttpStatus.BAD_REQUEST);
                        }
                    }

                    if (temp.getIForDays() != null) {
                        Date start = inputFormat.parse(param.optString(
                                "effectiveFrom"));
                        Date end = inputFormat.parse(param.optString(
                                "expiresAt"));
                        long days =
                                (end.getTime() - start.getTime()) / (1000 * 60 * 60 * 24);
                        if (days > temp.getIForDays()) {
                            LOGGER.error("Exiting editList  Method in "
                                    + ListManagementServiceImpl.class
                                    + " class with response  : failed to edit" +
                                    " list");
                            return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                                    "Expiry date should be within "
                                            + temp.getIForDays()
                                            + " days from Start Date"),
                                    HttpStatus.BAD_REQUEST);
                        }

                    }

                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : api url "
                            + spring_api_url + " api key "
                            + "");
                    activityLogService.addActivity(user, "failed to add list " +
                                    "item",
                            "Error : " + e.toString() + ", Parameters : " + user);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Something went wrong"),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

//                try {
                editSave.setDtEffectiveFrom(
                        ZonedDateTime.parse(param.optString("effectiveFrom")));
                editSave.setDtExpiresAt(ZonedDateTime.parse(param.optString(
                        "expiresAt")));
//                } catch (ParseException e) {
//                    LOGGER.error("Error : " + e + "\nParam : api url "
//                            + spring_api_url + " api key "
//                            + env.getProperty("score.server.key"));
//                    activityLogService.addActivity(user, "failed to add
//                    list item",
//                            "Error : " + e.toString() + ", Parameters : " +
//                            user);
//                    return new ResponseEntity<ApiResponse>(
//                            new ApiResponse(false, "Something went wrong"),
//                            HttpStatus.INTERNAL_SERVER_ERROR);
//                }
                // editSave.setItenantId(addNewPaymentRequest.getItenantId());
                ListReplica listReplica = listAudit.parseAudit(editSave);

                ListValidationUtil listValidationUtil =
                        new ListValidationUtil(listReplicaService);
                listValidationUtil.DoValdiations(editSave.getVcField(), editSave.getVcValue(), editSave.getIlistType().getId().getIListMasterID(), editSave.getDtEffectiveFrom(),
                        editSave.getDtExpiresAt(), editSave.getIlistType().getId().getItenantId().getItenantid(), param.optString("attribs"), false);
                if (listValidationUtil.getSuccess() == false) {

                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    listValidationUtil.getMessage()
                            ),
                            HttpStatus.BAD_REQUEST);
                }
                Boolean status =
                        checkerMakerHelperService.save(listAuditService,
                                editSave,
                                listReplicaService,
                                listReplica,
                                user, false, false);

                if (status) {
                    activityLogService.addActivity(user, "list entry edition " +
                                    "sent for approval",
                            "Parameters : " + addNewPaymentRequest.toString());
                    LOGGER.debug("Exiting editList Method in " + ListManagementServiceImpl.class
                            + " class with response  : item added " +
                            "successfully");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(true, "List entry edition sent " +
                                    "for approval"),
                            HttpStatus.CREATED);
                } else {
                    activityLogService.addActivity(user, "failed to edit list" +
                            " entry");
                    LOGGER.error("Exiting editList  Method in " + ListManagementServiceImpl.class
                            + " class with response  : failed to edit list");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Failed to edit list"),
                            HttpStatus.BAD_REQUEST);
                }

            } else {
                ListReplica listReplica = null;
                try {
                    listReplica = listReplicaService
                            .findByExternalId(param.optString("externalId"),
                                    addNewPaymentRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(user, "failed to get user " +
                                    "and permissions",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                if (listReplica != null) {
                    ListReplica editSave = new ListReplica();
                    editSave.setVcExternalListItemId(param.optString(
                            "externalId"));
                    editSave.setIListitemId(listReplica.getIListitemId());
                    editSave.setVcSource(param.optString("source"));

                    ObjectMapper obj = new ObjectMapper();
                    try {
                        if (!param.optString("attribs").isBlank()) {
                            editSave.setAttribs(obj.readTree(param.optString("attribs")));
                        }
                    } catch (JsonProcessingException e) {
                        throw new RuntimeException(e);
                    }
                    editSave.setVcValue(param.optString("itemValue"));
                    editSave.setVcField(param.optString("itemField"));
                    editSave.setVcNote(param.optString("note"));
                    editSave.setIrecordStatus(listReplica.getIrecordStatus());
                    // listAudit.setVcAction("M");

                    SimpleDateFormat inputFormat = new SimpleDateFormat(
                            "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
                    inputFormat.setTimeZone(TimeZone.getTimeZone("UTC"));

                    try {
                        ListMaster temp = listMasterService.findByID(type,
                                addNewPaymentRequest.getItenantId());
                        editSave.setIlistType(temp);
                        if (!inputFormat.parse(param.optString("effectiveFrom"))
                                .before(inputFormat
                                        .parse(param.optString("expiresAt")))) {
                            if (!inputFormat.parse(param.optString(
                                            "effectiveFrom"))
                                    .equals(inputFormat.parse(param
                                            .optString("expiresAt")))) {
                                activityLogService.addActivity(user,
                                        "failed to edit list entry");
                                LOGGER.error("Exiting editList  Method in "
                                        + ListManagementServiceImpl.class
                                        + " class with response  : failed to " +
                                        "edit list");
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                "Start date should be less " +
                                                        "than equal to expiry" +
                                                        " date"),
                                        HttpStatus.BAD_REQUEST);
                            }
                        }

                        if (temp.getIForDays() != null) {
                            Date start = inputFormat
                                    .parse(param.optString("effectiveFrom"));
                            Date end = inputFormat.parse(param.optString(
                                    "expiresAt"));
                            long days = (end.getTime() - start.getTime())
                                    / (1000 * 60 * 60 * 24);
                            if (days > temp.getIForDays()) {
                                LOGGER.error("Exiting editList  Method in "
                                        + ListManagementServiceImpl.class
                                        + " class with response  : failed to " +
                                        "edit list");
                                return new ResponseEntity<ApiResponse>(new ApiResponse(
                                        false,
                                        "Expiry date should be within "
                                                + temp.getIForDays()
                                                + " days from Start Date"),
                                        HttpStatus.BAD_REQUEST);
                            }
                        }

                    } catch (Exception e) {
                        LOGGER.error(
                                loggerEncoderUtil.encode("Error : " + e
                                        + "\nParam : api url "
                                        + spring_api_url
                                        + " api key "
                                        + ""));
                        activityLogService.addActivity(user, "failed to add " +
                                        "list item",
                                "Error : " + e.toString() + ", Parameters : " + user);
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, "Something went wrong"),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

//                    try {
                    editSave.setDtEffectiveFrom(
                            ZonedDateTime.parse(param.optString(
                                    "effectiveFrom")));
                    editSave.setDtExpiresAt(
                            ZonedDateTime.parse(param.optString("expiresAt")));
//                    } catch (ParseException e) {
//                        LOGGER.error("Error : " + e + "\nParam : api url "
//                                + spring_api_url
//                                + " api key "
//                                + env.getProperty("score.server.key"));
//                        activityLogService.addActivity(user, "failed to add
//                        list item",
//                                "Error : " + e.toString() + ", Parameters :
//                                " + user);
//                        return new ResponseEntity<ApiResponse>(
//                                new ApiResponse(false, "Something went
//                                wrong"),
//                                HttpStatus.INTERNAL_SERVER_ERROR);
//                    }
                    ListAudit listAuditNew = null;

                    listAuditNew = editSave.parseToAudit(editSave);
                    listAuditNew.setVcAction("M");
                    listAuditNew.setVcRemark(addNewPaymentRequest.getMakerRemark());

                    Boolean status =
                            checkerMakerHelperService.save(listAuditService,
                                    listAuditNew,
                                    listReplicaService,
                                    editSave,
                                    user, false, false);

                    if (status) {
                        activityLogService.addActivity(user,
                                "list entry edition sent for approval",
                                "Parameters : " + addNewPaymentRequest.toString());
                        LOGGER.debug("Exiting editList Method in "
                                + ListManagementServiceImpl.class
                                + " class with response  : item added " +
                                "successfully");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(true,
                                        "List entry edition sent for approval"),
                                HttpStatus.CREATED);
                    } else {
                        activityLogService.addActivity(user, "failed to edit " +
                                "list entry");
                        LOGGER.error("Exiting editList  Method in "
                                + ListManagementServiceImpl.class
                                + " class with response  : failed to edit " +
                                "list");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, "Failed to edit list"),
                                HttpStatus.BAD_REQUEST);
                    }

                } else {
                    activityLogService.addActivity(user, "Failed to edit list" +
                            " item");
                    LOGGER.debug("Exiting edit Method in " + ListManagementServiceImpl.class
                            + " class with response  : unauthorized to edit " +
                            "list item");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Failed to edit list item"),
                            HttpStatus.BAD_REQUEST);
                }

            }
        } else {
            activityLogService.addActivity(user, "unauthorized to edit list " +
                    "item");
            LOGGER.debug("Exiting edit Method in " + ListManagementServiceImpl.class
                    + " class with response  : unauthorized to edit list item");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                    "unauthorized to edit list item"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> addListWithoutAudit(String req,
                                                 Authentication pr) {
        ListReplica listNew = new ListReplica();
        org.json.JSONObject param = new org.json.JSONObject(req);

        listNew.setVcExternalListItemId(param.optString("externalId"));

        if (param.optString("source").isEmpty() || param.optString("source").isBlank()) {
            if (param.optString("itemValue").isEmpty() || param.optString(
                    "itemValue").isBlank()) {
                // activityLogService.addActivity("failed to add list entry",
                // req);
                LOGGER.error("Exiting Add List  Method in " + ListManagementServiceImpl.class
                        + " class with response  : failed to add list");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Please enter all mandatory " +
                                "fields"),
                        HttpStatus.BAD_REQUEST);
            }
        }

        if (param.optString("source").isEmpty() || param.optString("source").isBlank()) {
            //     activityLogService.addActivity("failed to add list entry",
            //     req);
            LOGGER.error("Exiting Add List  Method in " + ListManagementServiceImpl.class
                    + " class with response  : failed to add list");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                    "Source cannot be blank"),
                    HttpStatus.BAD_REQUEST);
        }

        if (param.optString("itemValue").isEmpty() || param.optString(
                "itemValue").isBlank()) {
            //     activityLogService.addActivity("failed to add list entry",
            //     req);
            LOGGER.error("Exiting Add List  Method in " + ListManagementServiceImpl.class
                    + " class with response  : failed to add list");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                    "Value cannot be blank"),
                    HttpStatus.BAD_REQUEST);
        }

        if (param.optString("effectiveFrom").isEmpty() || param.optString(
                "effectiveFrom").isBlank()) {
            //     activityLogService.addActivity("failed to add list entry",
            //     req);
            LOGGER.error("Exiting Add List  Method in " + ListManagementServiceImpl.class
                    + " class with response  : failed to add list");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                    "Start date cannot be blank"),
                    HttpStatus.BAD_REQUEST);
        }

        if (param.optString("expiresAt").isEmpty() || param.optString(
                "expiresAt").isBlank()) {
            //     activityLogService.addActivity("failed to add list entry",
            //     req);
            LOGGER.error("Exiting Add List  Method in " + ListManagementServiceImpl.class
                    + " class with response  : failed to add list");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                    "Expiry date cannot be blank"),
                    HttpStatus.BAD_REQUEST);
        }

        Integer type = null;
        try {
            type = param.getInt("listType");
        } catch (Exception e) {
            //     activityLogService.addActivity("failed to add list entry",
            //     req);
            LOGGER.error("Exiting Add List  Method in " + ListManagementServiceImpl.class
                    + " class with response  : failed to add list");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                    "Type cannot be blank"),
                    HttpStatus.BAD_REQUEST);
        }

        if (param.optString("remark").isEmpty() || param.optString("remark").isBlank()) {
            //     activityLogService.addActivity("failed to add list entry",
            //     req);
            LOGGER.error("Exiting Add List  Method in " + ListManagementServiceImpl.class
                    + " class with response  : failed to add list");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                    "Maker remark cannot be blank"),
                    HttpStatus.BAD_REQUEST);
        }

        listNew.setVcValue(param.optString("itemValue"));
        listNew.setVcField(param.optString("itemField"));
        listNew.setVcNote(param.optString("note"));
        listNew.setDtEntryDateTime(ZonedDateTime.now());
        listNew.setIrecordStatus(0);
        listNew.setIstatus(statusCodeRepository.getById(2).getIStatusIDForMaster());
        // listNew.setVcAction("A");
        // listNew.setVcRemark(param.optString("remark"));

        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH" +
                ":mm:ss.SSS'Z'");
        inputFormat.setTimeZone(TimeZone.getTimeZone("UTC"));

        try {

            ListMaster temp = listMasterService.findByID(type, param.optInt(
                    "tenantId"));
            listNew.setIlistType(temp);
            if (!inputFormat.parse(param.optString("effectiveFrom"))
                    .before(inputFormat.parse(param.optString("expiresAt")))) {
                if (!inputFormat.parse(param.optString("effectiveFrom"))
                        .equals(inputFormat.parse(param.optString("expiresAt")))) {
                    //     activityLogService.addActivity("failed to edit
                    //     list entry", req);
                    LOGGER.error("Exiting editList  Method in " + ListManagementServiceImpl.class
                            + " class with response  : failed to edit list");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Expiry date should be equal to or " +
                                            "greater than Start Date"),
                            HttpStatus.BAD_REQUEST);
                }
            }

        } catch (Exception e) {
            LOGGER.error(
                    loggerEncoderUtil.encode(
                            "Error : " + e + "\nParam : api url "
                                    + spring_api_url
                                    + " api key "
                                    + ""));
            //     activityLogService.addActivity("failed to add list item",
            //             "Error : " + e.toString() + ", Parameters : " + req);
            return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                    "Something went wrong"),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

//        try {
        listNew.setDtEffectiveFrom(ZonedDateTime.parse(param.optString(
                "effectiveFrom")));
        listNew.setDtExpiresAt(ZonedDateTime.parse(param.optString("expiresAt"
        )));
//        } catch (ParseException e) {
//            LOGGER.error(loggerEncoderUtil
//                    .encode("Error : " + e + "\nParam : api url "
//                            + spring_api_url + " api key "
//                            + env.getProperty("score.server.key")));
//            //     activityLogService.addActivity("failed to add list item",
//            //             "Error : " + e.toString() + ", Parameters : " +
//            req);
//            return new ResponseEntity<ApiResponse>(new ApiResponse(false,
//            "Something went wrong"),
//                    HttpStatus.INTERNAL_SERVER_ERROR);
//        }

        // ListReplica listReplica = listNew.parseAudit(listNew);
        listNew = listReplicaService.saveAudit(listNew);

        if (listNew != null) {
            LOGGER.info("List added successfully" + loggerEncoderUtil.encode(req.toString()));
            //     activityLogService.addActivity("List added successfully",
            //     req);
            return new ResponseEntity<ApiResponse>(new ApiResponse(true,
                    "List added successfully"),
                    HttpStatus.ACCEPTED);
        } else {
            LOGGER.error("Failed to add list" + loggerEncoderUtil.encode(req.toString()));
            //     activityLogService.addActivity("failed to add list", req);
            return new ResponseEntity<ApiResponse>(new ApiResponse(true,
                    "Failed to add list"),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @Override
    public ResponseEntity<?> getListMasterDropdown(Integer tenantid,
                                                   Authentication pr) {

        LOGGER.debug("entered in class " + ListManagementServiceImpl.class
                + " in method getListMasterDropdown");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        if (mp.isView()) {

            List<ListMaster> temp = null;
            try {
                temp = listMasterService.findAllTenant(tenantid);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                // activityLogService.addActivity("failed to get user and
                // permissions", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            List<ListMasterVo> list = new ArrayList<>();
            temp.stream().forEach(lsm -> {

                list.add(listMasterDTOMapper.apply(lsm));
            });

            activityLogService.addActivity(loggedInUser, " list master " +
                    "dropdown accessed successfully");
            LOGGER.debug("Exiting getListMasterDropdown Method in " + ListManagementServiceImpl.class
                    + " class with response  : with list master dropdown ");
            return ResponseEntity.ok(list);

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to " +
                    "access list of lists");
            LOGGER.debug("Exiting getListMasterDropdown Method in " + ListManagementServiceImpl.class
                    + " class with response  : unauthorized to access list " +
                    "master dropdown ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access list " +
                            "master dropdown "),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getListWhiteDropdown(Authentication pr) {

        LOGGER.debug("entered in class " + ListManagementServiceImpl.class +
                " in method getListWhiteDropdown");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            List<ListMaster> temp = null;
            try {
                temp = listMasterService.findByName("White");
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                // activityLogService.addActivity("failed to get user and
                // permissions", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            List<DropdownWithObject> responseList = new ArrayList<>();
            responseList = DropdownWithObjectMapper.parse(temp);

            activityLogService.addActivity(loggedInUser, " list white " +
                    "dropdown accessed successfully");
            LOGGER.debug("Exiting getListWhiteDropdown Method in " + ListManagementServiceImpl.class
                    + " class with response  : with list white dropdown ");
            return ResponseEntity.ok(responseList);

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to " +
                    "access list of lists");
            LOGGER.debug("Exiting getListWhiteDropdown Method in " + ListManagementServiceImpl.class
                    + " class with response  : unauthorized to access list " +
                    "white dropdown ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access list white" +
                            " dropdown "),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> getlistByIListID(Integer ilistid,
                                              Integer tenantID,
                                              Authentication pr) {

        LOGGER.debug("entered in class " + ListManagementServiceImpl.class +
                " in method getListManagement");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            ListAudit entry = null;
            try {
                entry = listAuditService.findById(ilistid, tenantID);
            } catch (Exception e) {
                activityLogService.addActivity(loggedInUser,
                        "failed to retrive list entry by id " + ilistid);
                LOGGER.debug("Exiting getlistByIListID Method in " + ListManagementServiceImpl.class
                        + " class with response  : failed to retrive list " +
                        "entry by id "
                        + loggerEncoderUtil.encode(ilistid.toString()));
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "failed to retrive list entry " +
                                "by id " + ilistid),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (entry == null) {
                activityLogService.addActivity(loggedInUser,
                        " list entry for id " + ilistid + "does not exist");
                LOGGER.debug("Exiting getlistByIListID Method in " + ListManagementServiceImpl.class
                        + " class with response  :  list entry for id "
                        + loggerEncoderUtil.encode(ilistid.toString()) +
                        "does not exist");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                " list entry for id " + ilistid + "does not " +
                                        "exist"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            ListManagementVO res = listManagementVOMapper.parseAudit(entry,
                    mp, loggedInUser);

            activityLogService.addActivity(loggedInUser, " list view table " +
                    "data accessed successfully");
            LOGGER.debug("Exiting getListManagement Method in " + ListManagementServiceImpl.class
                    + " class with response  : with list of lists");
            return ResponseEntity.ok(res);

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to " +
                    "access list of lists");
            LOGGER.debug("Exiting getListManagement Method in " + ListManagementServiceImpl.class
                    + " class with response  : unauthorized to access list of" +
                    " lists");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access list of " +
                            "lists"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> getDecisionAndRules(Authentication pr,
                                                 Integer tenantid) {

        LOGGER.debug("entered in class " + ListManagementServiceImpl.class +
                " in method getDecisionAndRules");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            ListValidationUtil listValidationUtil = new ListValidationUtil( activityLogService, loggerEncoderUtil,decisionService,rulesTempService);
            return listValidationUtil.getDecisionAndRules(pr,tenantid,loggedInUser,MenuNames.listManagement);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to " +
                    "access decisions and rules ");
            LOGGER.debug("Exiting getDecisionAndRules Method in " + ListManagementServiceImpl.class
                    + " class with response  : unauthorized to access " +
                    "decisions and rules ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access decisions " +
                            "and rules "),
                    HttpStatus.FORBIDDEN);
        }
    }

}
