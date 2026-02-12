package com.DronaPay.UIServer.service.ControllerService.CustomTransctionClasses;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.ResponseVO.DropdownWithObject;
import com.DronaPay.UIServer.ResponseVO.ParameterTypeVO;
import com.DronaPay.UIServer.ResponseVO.ViewParameterVO;
import com.DronaPay.UIServer.VOMapper.ParameterTypeVOMapper;
import com.DronaPay.UIServer.VOMapper.ViewParameterVOMapper;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.repository.DecisionAuditRepository;
import com.DronaPay.UIServer.requests.*;
import com.DronaPay.UIServer.response.*;
import com.DronaPay.UIServer.service.ApiServices.DecisionApiService;
import com.DronaPay.UIServer.service.ApiServices.TransactionClassApiService;
import com.DronaPay.UIServer.service.ApiServices.TransactionClassApiServiceImpl;
import com.DronaPay.UIServer.service.CamundaService;
import com.DronaPay.UIServer.service.ControllerService.testing.ProductService;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.DronaPay.UIServer.util.UserMapping;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import java.net.http.HttpResponse;
import java.time.ZonedDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class CustomTransactionClassesImpl implements CustomTransactionClasses {

    private static final Logger LOGGER = LoggerFactory.getLogger(CustomTransactionClassesImpl.class);
    final String menu_name = MenuNames.TransactionToDecision;
    @Autowired
    private DecisionService decisionService;
    @Autowired
    private WebUserService webUserService;
    @Autowired
    private TransactionClassesService transactionClassesService;
    @Autowired
    private ActivityLogService activityLogService;
    @Autowired
    private ParameterService parameterService;
    @Autowired
    private CamundaService camundaService;
    @Autowired
    private ProductService productService;
    @Autowired
    private ChannelService channelService;
    @Autowired
    private TenantRepositoryService tenantRepositoryService;
    @Autowired
    private TransactionClassesUiService transactionClassesUiService;
    @Autowired
    private DecisionUiServiceImpl decisionUiService;
    @Autowired
    private HistoricProfilesService historicProfilesService;
    @Autowired
    private TransactionClassesUiAuditServiceImpl transactionClassessUiAuditService;
    @Autowired
    private StatusCodeService statusCodeService;
    @Autowired
    private DecisionApiService decisionApiService;
    @Autowired
    private TransactionClassApiServiceImpl transactionClassApiServiceImpl;
    @Autowired
    private TransactionClassApiService transactionClassApiService;
    @Autowired
    private DecisionAuditServiceImpl decisionAuditService;
    @Autowired
    private DecisionUiWorkflowAuditServiceImpl decisionWorkFlowAuditServiceImpl;
    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;
    @Autowired
    private ObservationsUiService observationsUiService;

    @Autowired
    private DecisionAuditRepository decisionAuditRepository;

    @Override
    public ResponseEntity<?> getInitialData(Authentication pr) {

        LOGGER.debug("entered in class " + CustomTransactionClassesImpl.class +
                " in method getInitialData");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (!mp.isView()) {
            activityLogService.addActivity(
                    loggedInUser,
                    "unauthorized to access decision dropdown for Transaction to decision");
            LOGGER.debug(
                    "Exiting getAllUploadChargeBacks Method in " +
                            CustomTransactionClassesImpl.class +
                            " class with response  : unauthorized to access list of lists");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access list of lists"),
                    HttpStatus.FORBIDDEN);
        } else {

            // List<DecisionUi> decisionList = new ArrayList<>();
            // List<DecisionDropDown> responsesOne = new ArrayList<>();
            // responsesOne.add(DecisionDropDown.builder()
            // .label("Add New Decision")
            // .value(null)
            // .productid(null)
            // .build());

            try {
                // decisionList = decisionUiService.findAllNonDeleted();
                // decisionList = decisionList.stream()
                // .filter(c -> c.getIRecordStatus() != 1)
                // .collect(Collectors.toList());
                // decisionList.sort(
                // (c1,
                // c2) -> c1.getDtApproverStamp().compareTo(c2.getDtApproverStamp()));

                // decisionList.stream()
                // .map(d -> responsesOne.add(
                // DecisionDropDown.builder()
                // .label(d.getVcDecisionName())
                // .value(d.getIDecisionID())
                // .productid(d.getIProductID().getIProductID())
                // .attribs(d.getAttribs())
                // .detail(d.getVcDecisionDetail())
                // .masterdecisionid(d.getMasterDecisionId())
                // .build()))
                // .collect(Collectors.toList());
                // LOGGER.debug("Exiting getTransactionClassesAndDecision Method in " +
                // CustomTransactionClassesImpl.class +
                // " class with response : with parameters type dropdown");
                // activityLogService.addActivity(loggedInUser,
                // "Decision Dropdown accessed");

                // HashMap<String, List<ViewParameterVO>> temp = new HashMap<>();
                // List<String> parameterTypes = parameterService
                //         .getAllParameterTypeForCustomTransaction();

                // for (String parameterType : parameterTypes) {
                //     temp.put(
                //             parameterType,
                //             ViewParameterVOMapper.parse(
                //                     parameterService
                //                             .findAllByIProductIDAndvAndVcParameterTypeForCustomTransactionClasses(
                //                                     parameterType)));
                //     // temp.put(parameterType, ViewParameterVO
                //     // .parse(parameterService.findAllByIProductIDAndvAndVcParameterType(iProductID,
                //     // parameterType)));
                // }
                // // List<ParameterTypeVO> responsesTwo = ParameterTypeVO.parse(temp);
                // List<ParameterTypeVO> responsesTwo =
                // ParameterTypeVOMapper.parse(temp); LOGGER.debug("Exiting
                // getParameterType Method in " +
                // CustomTransactionClassesImpl.class +
                // " class with response : with parameters type");
                // activityLogService.addActivity(loggedInUser,
                // "Parameter types accessed");

                List<Products> productList = new ArrayList<>();
                List<DropdownWithObject> responsesThree = new ArrayList<>();

                productList = productService.findALL();
                // System.out.println(productList);
                productList.stream()
                        .map(c -> responsesThree.add(DropdownWithObject.builder()
                                .value(c.getIProductID())
                                .label(c.getVcProductName())
                                .build()))
                        .collect(Collectors.toList());
                LOGGER.debug("Exiting getAllProducts Method in " +
                        CustomTransactionClassesImpl.class +
                        " class with response  : with parameters type dropdown");
                activityLogService.addActivity(loggedInUser,
                        "Products Dropdown  accessed");

                List<Channels> channelList = new ArrayList<>();
                List<DropdownWithObject> responsesFour = new ArrayList<>();

                channelList = channelService.findAll();
                channelList.stream()
                        .map(c -> responsesFour.add(DropdownWithObject.builder()
                                .value(c.getIChannelId())
                                .label(c.getVcChannelName())
                                .build()))
                        .collect(Collectors.toList());
                LOGGER.debug("Exiting getAllChannels Method in " +
                        CustomTransactionClassesImpl.class +
                        " class with response  : with parameters type dropdown");
                activityLogService.addActivity(loggedInUser,
                        "Decision Dropdown  accessed");
                Map<String, Object> finalResponse = new HashMap();
                // finalResponse.put("decisionList", responsesOne);
                // finalResponse.put("parameterList", responsesTwo);
                finalResponse.put("productList", responsesThree);
                finalResponse.put("channelList", responsesFour);
                // List<MetaData> metaData = new ArrayList<>();
                // List<ObservationsUi> observationsUi = new ArrayList<>();

                // try {
                // metaData = historicProfilesService.findAllData();
                // observationsUi = observationsUiService.findAllNonDeleted();
                // } catch (Exception e) {
                // LOGGER.error("Error : " + e + "\nParam : "
                // + loggerEncoderUtil.encode(pr.toString()));
                // activityLogService.addActivity(
                // "failed to get list of metadata and observations",
                // e.toString());
                // return new ResponseEntity<>(
                // new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                // HttpStatus.INTERNAL_SERVER_ERROR);
                // }

                // RuleBlocksReponse metaObs = new RuleBlocksReponse();

                // List<MetadataResponse> list1 = new ArrayList<>();
                // metaData.stream().map(md -> {
                // ObjectMapper mapper = new ObjectMapper();
                // JsonNode emptyPath = null;
                // try {
                // emptyPath = mapper.readTree("[{\"Path\": \"\" }]");
                // } catch (JsonProcessingException e) {
                // LOGGER.error("Error in parsing" + e);
                // }
                // list1.add(MetadataResponse.builder().vcpath(md.getVcpath())
                // .vcroot(md.getVcroot())
                // .path(md.getVcPrefix().equals(emptyPath) ? md.getVcpath()
                // : md.getVcroot() + "." + md.getVcpath())
                // .vcprefix(md.getVcPrefix())
                // .config(md.getConfig())
                // .build());
                // return null;
                // }).collect(Collectors.toList());

                // metaObs.setMetadata(list1);

                // List<String> list2 = observationsUi.stream()
                // .map(ObservationsUi::getOname)
                // .collect(Collectors.toList());
                // metaObs.setObservations(list2);

                // finalResponse.put("metaDataObservations", metaObs);

                return ResponseEntity.ok(finalResponse);
                // return ResponseEntity.ok(responsesFour);
                // return ResponseEntity.ok(responsesThree);
                // return ResponseEntity.ok(responsesTwo);
                // return ResponseEntity.ok(responsesOne);
            } catch (Exception e) {
                LOGGER.error("Error : " + e +
                        "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get decision details",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }
    }

    @Override
    public ResponseEntity<?> getAllDecision(Integer itenantid, Authentication pr) {
        LOGGER.debug("entered in class " + CustomTransactionClassesImpl.class +
                " in method getAllDecisions");
        List<Integer> tenant = Arrays.asList(itenantid);
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView() && loggedUser.allowTenants(tenant)) {
            List<DecisionUi> decisionList = new ArrayList<>();
            List<DecisionDropDown> responses = new ArrayList<>();
            try {
                decisionList = decisionUiService.findAllNonDeletedTenants(tenant);
                decisionList = decisionList.stream()
                        .filter(c -> c.getIRecordStatus() != 1)
                        .collect(Collectors.toList());
                decisionList.sort(
                        (c1,
                         c2) -> c1.getDtApproverStamp()
                                .compareTo(c2.getDtApproverStamp()));

                decisionList.stream()
                        .map(d -> responses.add(
                                DecisionDropDown.builder()
                                        .label(d.getVcDecisionName())
                                        .value(d.getIDecisionID())
                                        .productid(d.getIProductID()
                                                .getIProductID())
                                        .detail(d.getVcDecisionDetail())
                                        .masterdecisionid(
                                                d.getMasterDecisionId())
                                        .build()))
                        .collect(Collectors.toList());
                LOGGER.debug("Exiting getTransactionClassesAndDecision Method in " +
                        CustomTransactionClassesImpl.class +
                        " class with response  : with parameters type dropdown");
                activityLogService.addActivity(loggedInUser,
                        "Decision Dropdown  accessed");
                return ResponseEntity.ok(responses);
            } catch (Exception e) {
                LOGGER.error("Error : " + e +
                        "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get decision details",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {
            activityLogService.addActivity(
                    loggedInUser,
                    "unauthorized to access decision dropdown for Transaction to decision");
            LOGGER.debug(
                    "Exiting getAllUploadChargeBacks Method in " +
                            CustomTransactionClassesImpl.class +
                            " class with response  : unauthorized to access decisions");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access decisions"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getListOfTransactionClasses(Authentication pr) {
        LOGGER.debug("entered in class " + CustomTransactionClassesImpl.class +
                " in method getAllDecisions");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        TransactionToDecisionListView transactionToDecisionListView = new TransactionToDecisionListView();
        transactionToDecisionListView.setAdd(mp.isAdd());
        transactionToDecisionListView.setEdit(mp.isEdit());
        transactionToDecisionListView.setApprove(mp.isApprove());
        transactionToDecisionListView.setDelete(mp.isDelete());
        transactionToDecisionListView.setView(mp.isView());
        transactionToDecisionListView.setPublish(mp.isPublish());

        if (mp.isView()) {
            List<TransactionClassesUI> res = new ArrayList<>();
            List<TransactionClassesUiAudit> resAudit = new ArrayList<>();
            List<CustomTransactionResponse> response = new ArrayList<>();
            try {
                // res = transactionClassesUiService.findAll();
                UserMapping classIds = loggedUser.getUserClass();
                if (classIds.getMappingIds().contains(-1)) {
                    res = transactionClassesUiService
                            .findAllByTenantIds(loggedUser.getUserTenant());
                } else {
                    res = transactionClassesUiService.findByTenantClass(classIds);
                }
                // res = loggedUser.getTransactionClasses();
                for (int i = 0; i < res.size(); i++) {
                    response.add(CustomTransactionResponse.builder()
                            .iClassID(res.get(i).getIclassID())
                            .vcClassName(res.get(i).getVcClassName())
                            .bActive(res.get(i).isBActive())
                            .auditEntry(false)
                            .auditExist(false)
                            .lastStatus(res.get(i).getLastStatus())
                            .decisionParams(res.get(i).getVcDecisionParams())
                            .attribs(res.get(i).getAttribs())
                            .lastUpdate(res.get(i).getDtApproverStamp())
                            .latestRemark(res.get(i).getLatestRemark())
                            .makerChecker("M")
                            .itenantId(res.get(i).getItenantId())
                            .tenantName(tenantRepositoryService
                                    .findByItenantId(res.get(i).getItenantId())
                                    .getTenantName())
                            .build());
                }

                // resAudit = transactionClassessUiAuditService.findPendingEntries();
                resAudit = transactionClassessUiAuditService.findPendingEntriesTenantClass(
                        loggedUser.getUserTenant(),
                        loggedUser.getUserClass().getMappingIds());
                for (int h = 0; h < response.size(); h++) {
                    for (int f = 0; f < resAudit.size(); f++) {
                        if (resAudit.get(f).getIclassID() != null) {
                            if (response.get(h).getIClassID() == resAudit.get(f)
                                    .getIclassID()) {
                                response.get(h).setAuditExist(true);
                            }
                        }
                    }
                }
                for (int j = 0; j < resAudit.size(); j++) {
                    response.add(
                            CustomTransactionResponse.builder()
                                    .iClassID(resAudit.get(j).getIclassID() != null
                                            ? resAudit.get(j).getIclassID()
                                            : -1)
                                    .iClassAuditID(resAudit.get(j)
                                            .getIclassAuditID())
                                    .vcClassName(resAudit.get(j).getVcClassName())
                                    .bActive(resAudit.get(j).isBActive())
                                    .auditEntry(true)
                                    .auditExist(false)
                                    .lastStatus("Pending")
                                    .itenantId(resAudit.get(j).getItenantId())
                                    .tenantName(tenantRepositoryService
                                            .findByItenantId(resAudit.get(j)
                                                    .getItenantId())
                                            .getTenantName())
                                    .decisionParams(resAudit.get(j)
                                            .getVcDecisionParams())
                                    .attribs(resAudit.get(j).getAttribs())
                                    .lastUpdate(resAudit.get(j).getDtEntryStamp())
                                    .latestRemark(resAudit.get(j).getVcRemark())
                                    .action(resAudit.get(j).getVcAction())
                                    .makerChecker(
                                            (resAudit.get(j).getIEntryUserID() == loggedInUser
                                                    .getIuserID())
                                                    ? "M"
                                                    : "C")
                                    .build());
                }
                LOGGER.debug("Exiting getListOfTransactionClasses Method in " +
                        CustomTransactionClassesImpl.class +
                        " class with response  : with parameters type dropdown");
                activityLogService.addActivity(loggedInUser,
                        "Transaction Classes Accessed");
                transactionToDecisionListView.setTransactionClass(response);
                return ResponseEntity.ok(transactionToDecisionListView);

            } catch (Exception e) {
                // e.printStackTrace();
                LOGGER.error("Error : " + e +
                        "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get decision details",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            activityLogService.addActivity(
                    loggedInUser, "unauthorized to access transaction class list");
            LOGGER.debug(
                    "Exiting getAllUploadChargeBacks Method in " +
                            CustomTransactionClassesImpl.class +
                            " class with response  : unauthorized to access list of lists");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false,
                            "unauthorized to access transaction classes lists"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getListOfParameters(Authentication pr) {
        LOGGER.debug("entered in class " + CustomTransactionClassesImpl.class +
                " in method getParameterType");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            HashMap<String, List<ViewParameterVO>> temp = new HashMap<>();
            List<String> parameterTypes = parameterService.getAllParameterTypeForCustomTransaction();

            for (String parameterType : parameterTypes) {
                temp.put(
                        parameterType,
                        ViewParameterVOMapper.parse(
                                parameterService
                                        .findAllByIProductIDAndvAndVcParameterTypeForCustomTransactionClasses(
                                                parameterType)));
                // temp.put(parameterType, ViewParameterVO
                // .parse(parameterService.findAllByIProductIDAndvAndVcParameterType(iProductID,
                // parameterType)));
            }
            // List<ParameterTypeVO> responses = ParameterTypeVO.parse(temp);
            List<ParameterTypeVO> responses = ParameterTypeVOMapper.parse(temp);
            LOGGER.debug("Exiting getParameterType Method in " +
                    CustomTransactionClassesImpl.class +
                    " class with response  : with parameters type");
            activityLogService.addActivity(loggedInUser, "Parameter types accessed");
            return ResponseEntity.ok(responses);
        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access parameter types ");
            LOGGER.debug(
                    "Exiting getParameterType Method in " +
                            CustomTransactionClassesImpl.class +
                            " class with response  : unauthorized to access parameter types");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access parameter types"),
                    HttpStatus.FORBIDDEN);
        }
    }

    // @Override
    // public ResponseEntity<?>
    // saveNewTransactionClass(AddNewCustomTransactionClassRequest actcr,
    // Authentication pr) {
    // LOGGER.debug("entered in class " + CustomTransactionClassesImpl.class +
    // " in method saveNewTransactionClass");
    // LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

    // WebUser loggedInUser = loggedUser.getWebUser();
    // MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

    // if (mp.isAdd()) {
    // DecisionUi defaultDecision = null;
    // // Decisions defaultDec = null;
    // try {
    // defaultDecision =
    // decisionUiService.findByiDecisionID(actcr.getDefaultDecisionId(),
    // actcr.getItenantid);
    // // defaultDec =
    // // decisionService.findByiDecisionID(actcr.getDefaultDecisionId());
    // } catch (Exception e) {
    // LOGGER.error("Error : " + e +
    // "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
    // activityLogService.addActivity("failed to get decision", e.toString());
    // return new ResponseEntity<ApiResponse>(
    // new ApiResponse(false, ResponseMessages.GenericErrorMessage),
    // HttpStatus.INTERNAL_SERVER_ERROR);
    // }
    // try {
    // List<TransactionClasses> duplList = transactionClassesService.findAll();
    // if (duplList.stream()
    // .filter(c -> c.getVcClassName().equals(
    // actcr.getTransactionIdentifier()))
    // .collect(Collectors.toList())
    // .size() > 0) {
    // activityLogService.addActivity(
    // loggedInUser, "failed add class name already taken ");
    // LOGGER.debug(
    // "Exiting saveNewTransactionClass Method in " +
    // CustomTransactionClassesImpl.class +
    // " class with response : unauthorized to save transaction class");
    // return new ResponseEntity<ApiResponse>(
    // new ApiResponse(false, "Class name already taken"),
    // HttpStatus.BAD_REQUEST);
    // }
    // } catch (Exception e) {
    // LOGGER.error("Error : " + e +
    // "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
    // activityLogService.addActivity("failed to get decision", e.toString());
    // return new ResponseEntity<ApiResponse>(
    // new ApiResponse(false, ResponseMessages.GenericErrorMessage),
    // HttpStatus.INTERNAL_SERVER_ERROR);
    // }
    // TransactionClasses newSave = new TransactionClasses();
    // TransactionClassesUI transUi = new TransactionClassesUI();
    // newSave.setVcClassName(actcr.getTransactionIdentifier());
    // if (defaultDecision != null) {
    // // newSave.setIDecisionID(defaultDec);
    // //newSave.setIProductID(defaultDecision.getIProductID());
    // transUi.setIDecisionID(defaultDecision.getIDecisionID());
    // transUi.setIProductID(defaultDecision.getIProductID());
    // }
    // // System.out.println(actcr);
    // newSave.setBPayeeMandatory(actcr.getPayee() != null ? actcr.getPayee()
    // : null);
    // newSave.setBPayerMandatory(actcr.getPayer() != null ? actcr.getPayer()
    // : null);
    // newSave.setBActive(true);
    // newSave.setIRecordStatus(1);
    // newSave.setIChannelID(actcr.getChannelID());
    // newSave.setDtEntryDateTime(new Date());
    // transUi.setBPayeeMandatory(actcr.getPayee() != null ? actcr.getPayee()
    // : null);
    // transUi.setBPayerMandatory(actcr.getPayer() != null ? actcr.getPayer()
    // : null);
    // transUi.setBActive(true);
    // transUi.setIRecordStatus(1);
    // transUi.setIChannelID(actcr.getChannelID());
    // transUi.setDtEntryDateTime(new Date());

    // try {
    // transactionClassesService.save(newSave);
    // transactionClassesUiService.save(transUi);
    // } catch (Exception e) {
    // LOGGER.error("Error : " + e +
    // "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
    // activityLogService.addActivity("failed to save transaction class",
    // e.toString());
    // return new ResponseEntity<ApiResponse>(
    // new ApiResponse(false, ResponseMessages.GenericErrorMessage),
    // HttpStatus.INTERNAL_SERVER_ERROR);
    // }

    // return new ResponseEntity<ApiResponse>(
    // new ApiResponse(true, "Transaction class saved successfully"),
    // HttpStatus.ACCEPTED);

    // } else {
    // activityLogService.addActivity(loggedInUser,
    // "unauthorized to save transaction class ");
    // LOGGER.debug(
    // "Exiting saveNewTransactionClass Method in " +
    // CustomTransactionClassesImpl.class +
    // " class with response : unauthorized to save transaction class");
    // return new ResponseEntity<ApiResponse>(
    // new ApiResponse(false, "unauthorized to save transaction class"),
    // HttpStatus.FORBIDDEN);
    // }
    // }

    @Override
    public ResponseEntity<?> editDecisionRules(Integer classID,
                                               EditDecisionRuleOfTransaction editDecisionRuleOfTransaction,
                                               Authentication pr) {
        // TODO Auto-generated method stub
        // System.out.println(editDecisionRuleOfTransaction);

        LOGGER.debug("entered in class " + CustomTransactionClassesImpl.class +
                " editDecisionRules");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isEdit()) {

            Decisions defaultDecision = null;
            try {
                defaultDecision = decisionService.findByiDecisionID(
                        editDecisionRuleOfTransaction.getDecisionId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e +
                        "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get decision", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            TransactionClasses editClass = null;
            TransactionClassesUI editUiClass = null;
            try {
                // System.out.println(classID);
                editClass = transactionClassesService.findByiClassID(classID);
                /// service not in user hence passing dummy value for tenantid
                editUiClass = transactionClassesUiService.findByiClassID(classID, 0);
            } catch (Exception e) {
                LOGGER.error("Error : " + e +
                        "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to edit transaction class",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            try {
                List<TransactionClasses> dupl = transactionClassesService.findAll();
                if (dupl.stream()
                        .filter(d -> d.getVcClassName().equals(
                                editDecisionRuleOfTransaction
                                        .getTransactionIdentifier()))
                        .collect(Collectors.toList())
                        .size() > 0) {

                    for (int h = 0; h < dupl.size(); h++) {
                        if (dupl.get(h).getIClassID() != classID &&
                                dupl.get(h).getVcClassName().equals(
                                        editDecisionRuleOfTransaction
                                                .getTransactionIdentifier())) {
                            // System.out.println(dupl);
                            // System.out.println(dupl.get(h).getIClassID());
                            // System.out.println(dupl.get(h).getVcClassName());
                            // System.out.println(classID);
                            activityLogService.addActivity(
                                    loggedInUser,
                                    "failed add class name already taken ");
                            LOGGER.debug(
                                    "Exiting saveNewTransactionClass Method in " +
                                            CustomTransactionClassesImpl.class
                                            +
                                            " class with response  : unauthorized to save transaction class");
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "Class name already taken"),
                                    HttpStatus.CONFLICT);
                        }
                    }
                }
            } catch (Exception e) {
                LOGGER.error("Error : " + e +
                        "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get decision", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            try {
                editClass.setBActive(true);
                editUiClass.setBActive(true);
                if (!editClass.getVcClassName().equals(
                        editDecisionRuleOfTransaction.getTransactionIdentifier())) {

                    editClass.setVcClassName(
                            editDecisionRuleOfTransaction.getTransactionIdentifier());
                    editUiClass.setVcClassName(
                            editDecisionRuleOfTransaction.getTransactionIdentifier());
                }
                if (defaultDecision != null) {
                    editClass.setIDecisionID(defaultDecision);
                    editClass.setIDecisionID(defaultDecision);
                    // editClass.setIProductID(defaultDecision.getIProductID());
                }

                org.json.JSONObject param = new org.json.JSONObject(
                        editDecisionRuleOfTransaction.getVcDecisionParams());
                String formattedQ = param.opt("formattedquery").toString();
                // editClass.setVcDecisionParams(formattedQ);
                ObjectMapper mapper = new ObjectMapper();
                JsonNode actualObj = mapper.readTree(formattedQ);
                editClass.setVcDecisionParams(actualObj);
                JsonNode allObj = mapper.readTree(
                        editDecisionRuleOfTransaction.getVcDecisionParams());

                editUiClass.setVcDecisionParams(allObj);
                LOGGER.debug(
                        "Exiting editTransaction Method in " +
                                CustomTransactionClassesImpl.class +
                                " class with response  : with parameters type edit transaction");
                activityLogService.addActivity(
                        loggedInUser, "Transaction class edited successfully",
                        "Parameters : " + editDecisionRuleOfTransaction.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(true, "Parameters Edited Successfully"),
                        HttpStatus.OK);
            } catch (Exception e) {
                LOGGER.error("Error : " + e +
                        "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to edit transaction class",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {
            activityLogService.addActivity(
                    loggedInUser, "unauthorized to edit decision params of transaction class ");
            LOGGER.debug(
                    "Exiting editDecisionRules Method in " +
                            CustomTransactionClassesImpl.class +
                            " class with response  : unauthorized to save transaction class");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to save transaction class"),
                    HttpStatus.FORBIDDEN);
        }
    }

    // @Override
    // public ResponseEntity<?> editResultParam(Integer classID,
    // EditResultParamOfTransaction eResultParamOfTransaction,
    // Authentication pr) {
    // LOGGER.debug(
    // "entered in class " + CustomTransactionClassesImpl.class + "
    // editResultParam");
    // UserAndPermissions userAndPermissions = null;
    // try {
    // userAndPermissions = webUserService.getUserAndPermissions(pr.getName(),
    // MenuNames.Tasks);
    // } catch (Exception e) {
    // LOGGER.error("Error : " + e + "\nParam : " + pr);
    // activityLogService.addActivity("failed to get user and permissions",
    // e.toString());
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
    // ResponseMessages.GenericErrorMessage),
    // HttpStatus.INTERNAL_SERVER_ERROR);
    // }

    // WebUser user = userAndPermissions.getUser();
    // MenuPermissions mp = userAndPermissions.getPermissions();

    // if (mp.isEdit()) {
    // TransactionClasses editClass = null;
    // try {
    // // System.out.println(classID);
    // editClass = transactionClassesService.findByiClassID(classID);
    // // System.out.println(editClass);
    // } catch (Exception e) {
    // LOGGER.error("Error : " + e + "\nParam : " + pr);
    // activityLogService.addActivity("failed to edit transaction class",
    // e.toString());
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
    // ResponseMessages.GenericErrorMessage),
    // HttpStatus.INTERNAL_SERVER_ERROR);
    // }

    // org.json.JSONObject param = new
    // org.json.JSONObject(eResultParamOfTransaction.getVcResultParams());
    // JSONArray actionArr = param.optJSONArray("action");
    // for (int i = 0; i < actionArr.length(); i++) {
    // if (actionArr.optJSONObject(i).opt("bworkflow") != null) {
    // actionArr.optJSONObject(i).put("bworkflow", true);
    // }
    // }

    // param.put("action", actionArr);

    // try {

    // // editClass.setVcResultParams(param.toString());
    // LOGGER.debug("Exiting editDefaultRule Method in " +
    // CustomTransactionClassesImpl.class
    // + " class with response : with parameters type dropdown");
    // activityLogService.addActivity(user, "Default rule edited successfully",
    // "Parameters : " + eResultParamOfTransaction.toString());
    // return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Parameters
    // Edited Successfully"),
    // HttpStatus.OK);
    // } catch (Exception e) {
    // LOGGER.error("Error : " + e + "\nParam : " + pr);
    // activityLogService.addActivity("failed to edit transaction class",
    // e.toString());
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
    // ResponseMessages.GenericErrorMessage),
    // HttpStatus.INTERNAL_SERVER_ERROR);
    // }

    // } else {
    // activityLogService.addActivity(user, "unauthorized to result param of
    // transaction class ");
    // LOGGER.debug("Exiting editResultParam Method in " +
    // CustomTransactionClassesImpl.class
    // + " class with response : unauthorized to save transaction class");
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized
    // to save transaction class"),
    // HttpStatus.FORBIDDEN);
    // }
    // }

    @Override
    public ResponseEntity<?> inactivatedTransactionClass(Integer classID,
                                                         Authentication pr) {
        LOGGER.debug("entered in class " + CustomTransactionClassesImpl.class +
                " inactivatedTransactionClass");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isEdit()) {
            TransactionClasses editClass = null;
            TransactionClassesUI ediClassesUI = null;
            try {
                // System.out.println(classID);
                editClass = transactionClassesService.findByiClassID(classID);

                // service not in user hence passing hardcoded tenantid value
                ediClassesUI = transactionClassesUiService.findByiClassID(classID, 0);
                // System.out.println(editClass);
            } catch (Exception e) {
                LOGGER.error("Error : " + e +
                        "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to edit transaction class",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            try {
                editClass.setBActive(false);
                ediClassesUI.setBActive(false);

                LOGGER.debug("Exiting editDefaultRule Method in " +
                        CustomTransactionClassesImpl.class +
                        " class with response  : with parameters type dropdown");
                activityLogService.addActivity(loggedInUser,
                        "Default rule edited successfully");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(true, "Transaction class disabled Successfully"),
                        HttpStatus.OK);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to disable transaction class",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {
            activityLogService.addActivity(
                    loggedInUser, "unauthorized to result param of transaction class ");
            LOGGER.debug(
                    "Exiting editResultParam Method in " +
                            CustomTransactionClassesImpl.class +
                            " class with response  : unauthorized to save transaction class");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to save transaction class"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getAllProducts(Authentication pr) {
        LOGGER.debug("entered in class " + CustomTransactionClassesImpl.class +
                " in method getAllProducts");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            List<Products> productList = new ArrayList<>();
            List<DropdownWithObject> responses = new ArrayList<>();

            try {
                productList = productService.findALL();
                // System.out.println(productList);
                productList.stream()
                        .map(c -> responses.add(DropdownWithObject.builder()
                                .value(c.getIProductID())
                                .label(c.getVcProductName())
                                .build()))
                        .collect(Collectors.toList());
                LOGGER.debug("Exiting getAllProducts Method in " +
                        CustomTransactionClassesImpl.class +
                        " class with response  : with parameters type dropdown");
                activityLogService.addActivity(loggedInUser,
                        "Products Dropdown  accessed");
                return ResponseEntity.ok(responses);
            } catch (Exception e) {
                LOGGER.error("Error : " + e +
                        "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get decision details",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {
            activityLogService.addActivity(
                    loggedInUser,
                    "unauthorized to access decision dropdown for Transaction to decision");
            LOGGER.debug(
                    "Exiting getAllProducts Method in " +
                            CustomTransactionClassesImpl.class +
                            " class with response  : unauthorized to access list of lists");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access list of products"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getAllChannels(Authentication pr) {
        LOGGER.debug("entered in class " + CustomTransactionClassesImpl.class +
                " in method getAllChannels");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            List<Channels> channelList = new ArrayList<>();
            List<DropdownWithObject> responses = new ArrayList<>();

            try {
                channelList = channelService.findAll();
                channelList.stream()
                        .map(c -> responses.add(DropdownWithObject.builder()
                                .value(c.getIChannelId())
                                .label(c.getVcChannelName())
                                .build()))
                        .collect(Collectors.toList());
                LOGGER.debug("Exiting getAllChannels Method in " +
                        CustomTransactionClassesImpl.class +
                        " class with response  : with parameters type dropdown");
                activityLogService.addActivity(loggedInUser,
                        "Decision Dropdown  accessed");
                return ResponseEntity.ok(responses);
            } catch (Exception e) {
                LOGGER.error("Error : " + e +
                        "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get decision details",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {
            activityLogService.addActivity(
                    loggedInUser,
                    "unauthorized to access decision dropdown for Transaction to decision");
            LOGGER.debug(
                    "Exiting getAllChannels Method in " +
                            CustomTransactionClassesImpl.class +
                            " class with response  : unauthorized to access list of lists");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access list of channel"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public ResponseEntity<?> saveNewDecision(AddNewDecisionRequestGt addNewDecisionRequest, Authentication pr) {
        LOGGER.debug("entered in class " + CustomTransactionClassesImpl.class +
                " in method saveNewDecision");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isAdd()) {
            // Decisions saveNew = new Decisions();
            DecisionUi saveNewUi = new DecisionUi();
            // saveNew.setBActive(addNewDecisionRequest.getActive());
            // saveNew.setDtEntryDatetime(new Date());
            saveNewUi.setBactive(addNewDecisionRequest.getActive());
            saveNewUi.setDtEntryDatetime(ZonedDateTime.now());
            saveNewUi.setDtApproverStamp(ZonedDateTime.now());
            saveNewUi.setIApproverUserID(loggedInUser.getIuserID());
            saveNewUi.setIorgId(loggedInUser.getIorgId());
            saveNewUi.setIstatus(
                    statusCodeService.findByIStatusId(2).getIStatusIDForMaster());
            saveNewUi.setLastStatus("Approved");
            saveNewUi.setLatestRemark("New Added");

            if (addNewDecisionRequest.getVcDecisionName() != null) {
                if (addNewDecisionRequest.getVcDecisionName().isBlank() ||
                        addNewDecisionRequest.getVcDecisionName().isEmpty()) {
                    LOGGER.debug(
                            "Exiting saveNewDecision Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter add new decision");
                    activityLogService.addActivity(loggedInUser, "failed to save decision",
                            addNewDecisionRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Decision name cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                LOGGER.debug("Exiting saveNewDecision Method in " +
                        CustomTransactionClassesImpl.class +
                        " class with response  : with parameter add new decision");
                activityLogService.addActivity(loggedInUser, "failed to save decision",
                        addNewDecisionRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Decision name cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addNewDecisionRequest.getProductId() == null ||
                    addNewDecisionRequest.getProductId() == 0) {
                LOGGER.debug("Exiting saveNewDecision Method in " +
                        CustomTransactionClassesImpl.class +
                        " class with response  : with parameter add new decision");
                activityLogService.addActivity(loggedInUser, "failed to save decision",
                        addNewDecisionRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Product id cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addNewDecisionRequest.getVcDecisionDetail() != null) {
                if (addNewDecisionRequest.getVcDecisionDetail().isBlank() ||
                        addNewDecisionRequest.getVcDecisionDetail().isEmpty()) {
                    LOGGER.debug(
                            "Exiting saveNewDecision Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter add new decision");
                    activityLogService.addActivity(loggedInUser, "failed to save decision",
                            addNewDecisionRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Decision details cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                activityLogService.addActivity(loggedInUser, "failed to save decision",
                        addNewDecisionRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Decision details cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            Products findProducts = null;
            try {
                findProducts = productService.findByiProductID(
                        addNewDecisionRequest.getProductId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e +
                        "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get product details",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            if (findProducts != null) {
                // saveNew.setIProductID(findProducts);
                saveNewUi.setIProductID(findProducts);
            } else {
                activityLogService.addActivity(loggedInUser, "failed to get product details",
                        addNewDecisionRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            // saveNew.setIRecordStatus(1);
            saveNewUi.setIRecordStatus(1);
            List<DecisionUi> allDec = new ArrayList<>();
            try {
                allDec = decisionUiService.findAll();
            } catch (Exception e1) {
                // TODO Auto-generated catch block
                LOGGER.error("Error " + e1);
            }

            if (allDec.size() != 0) {
                for (int g = 0; g < allDec.size(); g++) {
                    if (allDec.get(g).getVcDecisionName().equals(
                            addNewDecisionRequest.getVcDecisionName())) {
                        activityLogService.addActivity(loggedInUser, "failed to save decision",
                                addNewDecisionRequest.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, "Decision name already taken"),
                                HttpStatus.CONFLICT);
                    }
                }
            }

            // saveNew.setVcDecisionName(addNewDecisionRequest.getVcDecisionName());
            // saveNew.setVcDecisionDetail(addNewDecisionRequest.getVcDecisionDetail());
            saveNewUi.setVcDecisionName(addNewDecisionRequest.getVcDecisionName());
            saveNewUi.setVcDecisionDetail(
                    addNewDecisionRequest.getVcDecisionDetail());

            try {

                // decisionService.save(saveNew);
                saveNewUi = decisionUiService.save(saveNewUi);

                ResponseEntity<String> res = decisionApiService.addDecision(saveNewUi);
                // System.out.println(res.statusCode());
                // System.out.println(res);

                if (res.getStatusCode() != HttpStatus.OK) {
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    activityLogService.addActivity(loggedInUser, "failed to save decision",
                            saveNewUi.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "something went wrong"),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                LOGGER.debug("Exiting saveNewDecision Method in " +
                        CustomTransactionClassesImpl.class +
                        " class with response  : with parameter add new decision");
                activityLogService.addActivity(loggedInUser, "Decision added successfully",
                        "Parameters : " +
                                addNewDecisionRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(true, "Decision added successfully"),
                        HttpStatus.OK);
            } catch (Exception e) {
                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                LOGGER.error("Error : " + e +
                        "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to save decision", e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to save decision ");
            LOGGER.debug(
                    "Exiting saveNewDecision Method in " +
                            CustomTransactionClassesImpl.class +
                            " class with response  : unauthorized to save transaction class");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to save decision"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> getTransactionClassDetail(Integer iclassId, Boolean audit, Integer tenantid,
                                                       Authentication pr) {
        LOGGER.debug("entered in class " + CustomTransactionClassesImpl.class +
                " in method getTransactionClassDetail");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            if (audit) {
                TransactionClassesUiAudit detail = null;
                detail = transactionClassessUiAuditService.findTransactionDetail(iclassId, tenantid);
                if (detail != null) {
                    TransactionClassDetailResponse res = new TransactionClassDetailResponse();
                    res.setBactive(detail.isBActive());
                    res.setChannelid(detail.getIChannelID());
                    res.setIclassid(detail.getIclassAuditID());
                    res.setItenantId(detail.getItenantId());
                    res.setTenantName(tenantRepositoryService.findByItenantId(detail.getItenantId())
                            .getTenantName());
                    if (detail.getIdecisionID() != null) {

                        res.setIdecisionid(detail.getIdecisionID());
                        res.setAddNewDecisionRequest(null);
                    } else {
                        res.setIdecisionid(null);
                    }

                    if (detail.getIDecisionIDAudit() != null) {
                        // AddNewDecisionRequest addNewDecision = new AddNewDecisionRequest();
                        // addNewDecision.setProductId(
                        // detail.getIDecisionIDAudit().getIProductID()
                        // .getIProductID());
                        // addNewDecision.setVcDecisionDetail(
                        // detail.getIDecisionIDAudit().getVcDecisionDetail());
                        // addNewDecision.setVcDecisionName(
                        // detail.getIDecisionIDAudit().getVcDecisionName());
                        // addNewDecision.setActive(detail.getIDecisionIDAudit().isBActive());
                        res.setAddNewDecisionRequest(null);
                        res.setIdecisionid(null);
                    } else {
                        res.setAddNewDecisionRequest(null);
                    }
                    res.setIproductid(detail.getIProductID().getIProductID());
                    res.setPayee(detail.isBPayeeMandatory());
                    res.setPayer(detail.isBPayerMandatory());
                    res.setVcclassname(detail.getVcClassName());
                    res.setVcdecisionparams(detail.getVcDecisionParams());
                    res.setAttribs(detail.getAttribs());
                    res.setSkipProcessing(detail.getSkipProcessing());
                    return ResponseEntity.ok(res);
                } else {
                    LOGGER.debug(
                            "Exiting getTransactionClassDetail Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter add new decision");
                    activityLogService.addActivity(loggedInUser, "Decision added successfully",
                            "Parameters : " + iclassId);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "No pending entries found"),
                            HttpStatus.BAD_REQUEST);
                }

            } else {
                TransactionClassesUI detail = null;
                try {
                    detail = transactionClassesUiService.findByiClassID(iclassId, tenantid);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e +
                            "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to save decision",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "something went wrong"),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (detail != null) {
                    TransactionClassDetailResponse res = new TransactionClassDetailResponse();
                    res.setBactive(detail.isBActive());
                    res.setChannelid(detail.getIChannelID());
                    res.setIclassid(detail.getIclassID());
                    res.setIdecisionid(detail.getIDecisionID());
                    res.setIproductid(detail.getIProductID().getIProductID());
                    res.setPayee(detail.isBPayeeMandatory());
                    res.setPayer(detail.isBPayerMandatory());
                    res.setVcclassname(detail.getVcClassName());
                    res.setVcdecisionparams(detail.getVcDecisionParams());
                    res.setAttribs(detail.getAttribs());
                    res.setSkipProcessing(detail.getSkipProcessing());
                    res.setItenantId(detail.getItenantId());
                    res.setTenantName(tenantRepositoryService.findByItenantId(detail.getItenantId())
                            .getTenantName());
                    return ResponseEntity.ok(res);
                } else {
                    LOGGER.debug(
                            "Exiting getTransactionClassDetail Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter add new decision");
                    activityLogService.addActivity(loggedInUser, "Decision added successfully",
                            "Parameters : " + iclassId);
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "No Class found for class id " + iclassId),
                            HttpStatus.BAD_REQUEST);
                }
            }

        } else {
            activityLogService.addActivity(
                    loggedInUser, "unauthorized to getTransactionClassDetail ");
            LOGGER.debug(
                    "Exiting getTransactionClassDetail Method in " +
                            CustomTransactionClassesImpl.class +
                            " class with response  : unauthorized to get transaction class detail");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to save decision"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> editTransactionClass(EditTransactionClassRequest editTransactionClassRequest,
                                                  Authentication pr) {
        // System.out.println(editTransactionClassRequest);
        LOGGER.debug("entered in class " + CustomTransactionClassesImpl.class +
                " in method editTransactionClass");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isEdit() && loggedUser.allowTenants(Arrays.asList(editTransactionClassRequest.getItenantId()))) {

            if (editTransactionClassRequest.getMakerRemark() != null) {
                if (editTransactionClassRequest.getMakerRemark().isEmpty() ||
                        editTransactionClassRequest.getMakerRemark().isBlank()) {
                    LOGGER.debug(
                            "Exiting editTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter edit transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to edit transaction class",
                            "Parameters : " + editTransactionClassRequest.getIclassId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Maker remark cannot be empty"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {

                LOGGER.debug(
                        "Exiting editTransactionClass Method in " +
                                CustomTransactionClassesImpl.class +
                                " class with response  : with parameter edit transaction class");
                activityLogService.addActivity(
                        loggedInUser, "Failed to edit transaction class",
                        "Parameters : " + editTransactionClassRequest.getIclassId());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Maker remark cannot be empty"),
                        HttpStatus.BAD_REQUEST);
            }

            if (editTransactionClassRequest.getAudit() == true) {
                TransactionClassesUiAudit audit = null;
                audit = transactionClassessUiAuditService.findTransactionDetail(
                        editTransactionClassRequest.getIclassId(),
                        editTransactionClassRequest.getItenantId());

                if (editTransactionClassRequest.getIclassId() == null) {
                    LOGGER.debug(
                            "Exiting editTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter edit transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to edit transaction class",
                            "Parameters : " + editTransactionClassRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Class id is null"),
                            HttpStatus.BAD_REQUEST);
                }

                if (editTransactionClassRequest.getDefaultDecisionId() == null &&
                        editTransactionClassRequest.getAddNewDecision() == null) {
                    LOGGER.debug(
                            "Exiting editTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter edit transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to edit transaction class",
                            "Parameters : " + editTransactionClassRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Default decision cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }

                if (editTransactionClassRequest.getChannelId() == null) {
                    LOGGER.debug(
                            "Exiting editTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter edit transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to edit transaction class",
                            "Parameters : " + editTransactionClassRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Channel id cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }

                if (editTransactionClassRequest.getPayee() == null) {
                    LOGGER.debug(
                            "Exiting editTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter edit transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to edit transaction class",
                            "Parameters : " + editTransactionClassRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Payee mandatory is null"),
                            HttpStatus.BAD_REQUEST);
                }

                if (editTransactionClassRequest.getPayer() == null) {
                    LOGGER.debug(
                            "Exiting editTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter edit transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to edit transaction class",
                            "Parameters : " + editTransactionClassRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Payer mandatory is null"),
                            HttpStatus.BAD_REQUEST);
                }

                if (audit != null) {
                    if (audit.getIEntryUserID() != loggedInUser.getIuserID()) {
                        LOGGER.debug(
                                "Exiting editTransactionClass Method in " +
                                        CustomTransactionClassesImpl.class +
                                        " class with response  : with parameter edit transaction class");
                        activityLogService.addActivity(
                                loggedInUser, "Failed to edit transaction class",
                                "Parameters : " + editTransactionClassRequest
                                        .getIclassId());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Only Maker can edit this entry"),
                                HttpStatus.BAD_REQUEST);
                    }

                    if (editTransactionClassRequest.getDefaultDecisionId() != null &&
                            editTransactionClassRequest.getAddNewDecision() == null) {
                        DecisionUiWorkflowAudit exist = null;
                        try {
                            exist = decisionWorkFlowAuditServiceImpl
                                    .findPendingDecisionByID(
                                            editTransactionClassRequest
                                                    .getDefaultDecisionId(),
                                            editTransactionClassRequest
                                                    .getItenantId());
                        } catch (Exception e) {
                            LOGGER.error(
                                    loggerEncoderUtil.encode("Error : " + e
                                            + "\nParam : " + pr));
                            activityLogService.addActivity(loggedInUser,
                                    "failed to get user and permissions",
                                    e.toString());
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }

                        if (exist != null) {
                            if (exist.getVcAction().equals("X")) {
                                LOGGER.debug(
                                        "Exiting addTransactionClass Method in "
                                                +
                                                CustomTransactionClassesImpl.class
                                                +
                                                " class with response  : with parameters type add transaction class");
                                activityLogService.addActivity(
                                        loggedInUser,
                                        "Failed to access decision details");
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                "Decision is pending delete approval"),
                                        HttpStatus.BAD_REQUEST);
                            }
                        }

                        if (audit.getIDecisionIDAudit() != null) {
                            try {

                                DecisionUiAudit decisionAudit = decisionAuditRepository
                                        .getReferenceById(audit
                                                .getIDecisionIDAudit());
                                decisionAudit.setBclosed(true);
                                decisionAudit.setIstatus(
                                        statusCodeService.findByIStatusId(5));
                                decisionAudit.setDtApproverStamp(ZonedDateTime.now());
                                decisionAudit.setIApproverUserID(
                                        loggedInUser.getIuserID());
                                decisionAudit.setIorgId(loggedInUser.getIorgId());
                                decisionAudit.setVcRemark("Rejected");
                                decisionAuditService.saveDeicisonUiAudit(decisionAudit);
                            } catch (Exception e) {
                                LOGGER.error("Error : " + e + "\nParam : " +
                                        loggerEncoderUtil
                                                .encode(pr.toString()));
                                activityLogService.addActivity(loggedInUser,
                                        "failed to get user and permissions",
                                        e.toString());
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }
                        }
                        audit.setIDecisionIDAudit(null);
                        DecisionUi defaultDecision = null;
                        try {
                            defaultDecision = decisionUiService.findByiDecisionID(
                                    editTransactionClassRequest
                                            .getDefaultDecisionId(),
                                    editTransactionClassRequest.getItenantId());
                        } catch (Exception e) {
                            LOGGER.error(
                                    loggerEncoderUtil.encode("Error : " + e
                                            + "\nParam : " + pr));
                            activityLogService.addActivity(loggedInUser,
                                    "failed to get user and permissions",
                                    e.toString());
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                        if (defaultDecision != null) {
                            audit.setIdecisionID(editTransactionClassRequest
                                    .getDefaultDecisionId());
                        } else {
                            LOGGER.debug(
                                    "Exiting editTransactionClass Method in " +
                                            CustomTransactionClassesImpl.class
                                            +
                                            " class with response  : with parameter edit transaction class");
                            activityLogService.addActivity(
                                    loggedInUser,
                                    "Failed to edit transaction class",
                                    "Parameters : " +
                                            editTransactionClassRequest
                                                    .getDefaultDecisionId());
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(
                                            false,
                                            "No Decision found for decision id :- "
                                                    +
                                                    editTransactionClassRequest
                                                            .getDefaultDecisionId()),
                                    HttpStatus.BAD_REQUEST);
                        }
                    } else if (editTransactionClassRequest.getAddNewDecision() != null &&
                            editTransactionClassRequest.getDefaultDecisionId() == null) {
                        List<DecisionUi> allDec = new ArrayList<>();
                        try {
                            allDec = decisionUiService.findAll();
                        } catch (Exception e1) {
                            // TODO Auto-generated catch block
                            LOGGER.error("Error " + e1);
                        }

                        if (allDec.size() != 0) {
                            for (int g = 0; g < allDec.size(); g++) {
                                if (allDec.get(g).getVcDecisionName().equals(
                                        editTransactionClassRequest
                                                .getAddNewDecision()
                                                .getVcDecisionName())) {
                                    activityLogService.addActivity(loggedInUser,
                                            "failed to save decision",
                                            editTransactionClassRequest
                                                    .getAddNewDecision()
                                                    .toString());
                                    return new ResponseEntity<ApiResponse>(
                                            new ApiResponse(false,
                                                    "Decision name already taken"),
                                            HttpStatus.CONFLICT);
                                }
                            }
                        }
                        audit.setIdecisionID(null);
                        if (editTransactionClassRequest.getAddNewDecision()
                                .getProductId() == null) {
                            LOGGER.debug(
                                    "Exiting addNewTransactionClass Method in " +
                                            CustomTransactionClassesImpl.class
                                            +
                                            " class with response  : with parameter add transaction class");
                            activityLogService.addActivity(loggedInUser,
                                    "Failed to add transaction class",
                                    "Parameters : product id is null");
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "Product id of new decison cannot be blank"),
                                    HttpStatus.BAD_REQUEST);
                        }

                        Products products = null;
                        try {
                            products = productService.findByiProductID(
                                    editTransactionClassRequest.getAddNewDecision()
                                            .getProductId());
                        } catch (Exception e) {
                            LOGGER.error(
                                    loggerEncoderUtil.encode("Error : " + e
                                            + "\nParam : " + pr));
                            activityLogService.addActivity(loggedInUser,
                                    "failed to get user and permissions",
                                    e.toString());
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }

                        if (editTransactionClassRequest.getAddNewDecision()
                                .getVcDecisionDetail() != null) {
                            if (editTransactionClassRequest.getAddNewDecision()
                                    .getVcDecisionDetail()
                                    .isEmpty() ||
                                    editTransactionClassRequest.getAddNewDecision()
                                            .getVcDecisionDetail()
                                            .isBlank()) {
                                LOGGER.debug(
                                        "Exiting addNewTransactionClass Method in "
                                                +
                                                CustomTransactionClassesImpl.class
                                                +
                                                " class with response  : with parameter add transaction class");
                                activityLogService.addActivity(
                                        loggedInUser,
                                        "Failed to add transaction class",
                                        "Parameters : product id is null");
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                "Decision detail cannot be blank"),
                                        HttpStatus.BAD_REQUEST);
                            }
                        } else {
                            LOGGER.debug(
                                    "Exiting addNewTransactionClass Method in " +
                                            CustomTransactionClassesImpl.class
                                            +
                                            " class with response  : with parameter add transaction class");
                            activityLogService.addActivity(loggedInUser,
                                    "Failed to add transaction class",
                                    "Parameters : product id is null");
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "Decision detail cannot be blank"),
                                    HttpStatus.BAD_REQUEST);
                        }

                        if (editTransactionClassRequest.getAddNewDecision()
                                .getVcDecisionName() == null) {
                            if (editTransactionClassRequest.getAddNewDecision()
                                    .getVcDecisionName()
                                    .isEmpty() ||
                                    editTransactionClassRequest.getAddNewDecision()
                                            .getVcDecisionName()
                                            .isBlank()) {
                                LOGGER.debug(
                                        "Exiting addNewTransactionClass Method in "
                                                +
                                                CustomTransactionClassesImpl.class
                                                +
                                                " class with response  : with parameter add transaction class");
                                activityLogService.addActivity(
                                        loggedInUser,
                                        "Failed to add transaction class",
                                        "Parameters : product id is null");
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                "Decision name cannot be blank"),
                                        HttpStatus.BAD_REQUEST);
                            }
                        }

                        if (audit.getIDecisionIDAudit() == null) {
                            DecisionUiAudit decisionUiAudit = new DecisionUiAudit();
                            decisionUiAudit.setBActive(
                                    editTransactionClassRequest.getAddNewDecision()
                                            .getActive());
                            decisionUiAudit.setDtEntryDatetime(ZonedDateTime.now());
                            decisionUiAudit.setBclosed(false);
                            decisionUiAudit.setDtEntryStamp(ZonedDateTime.now());

                            if (products != null) {

                                decisionUiAudit.setIProductID(products);
                            } else {
                                LOGGER.debug(
                                        "Exiting addNewTransactionClass Method in "
                                                +
                                                CustomTransactionClassesImpl.class
                                                +
                                                " class with response  : with parameter add transaction class");
                                activityLogService.addActivity(
                                        loggedInUser,
                                        "Failed to add transaction class",
                                        "Parameters : " +
                                                editTransactionClassRequest
                                                        .getProductId());
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(
                                                false,
                                                "No Product found for product id :- "
                                                        +
                                                        editTransactionClassRequest
                                                                .getProductId()),
                                        HttpStatus.BAD_REQUEST);
                            }
                            decisionUiAudit.setIUserID(loggedInUser.getIuserID());
                            decisionUiAudit.setIorgId(loggedInUser.getIorgId());
                            decisionUiAudit.setIEntryUserID(loggedInUser.getIuserID());
                            decisionUiAudit.setIRecordStatus(0);
                            decisionUiAudit.setIsApproved(false);
                            decisionUiAudit.setVcDecisionDetail(
                                    editTransactionClassRequest.getAddNewDecision()
                                            .getVcDecisionDetail());
                            decisionUiAudit.setVcDecisionName(
                                    editTransactionClassRequest.getAddNewDecision()
                                            .getVcDecisionName());
                            decisionUiAudit.setIProductID(products);

                            decisionUiAudit.setVcAction("A");

                            decisionUiAudit.setVcRemark("New Added For Transaction Class");
                            try {

                                decisionUiAudit = decisionAuditService
                                        .saveDeicisonUiAudit(decisionUiAudit);
                            } catch (Exception e) {
                                LOGGER.error("Error : " + e + "\nParam : " +
                                        loggerEncoderUtil
                                                .encode(pr.toString()));
                                activityLogService.addActivity(loggedInUser,
                                        "failed to get user and permissions",
                                        e.toString());
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }

                            audit.setIDecisionIDAudit(
                                    decisionUiAudit.getIDecisionAuditID());

                        } else {
                            DecisionUiAudit decisionUiAudit = decisionAuditRepository
                                    .getReferenceById(audit.getIDecisionIDAudit());
                            decisionUiAudit.setVcDecisionName(
                                    editTransactionClassRequest.getAddNewDecision()
                                            .getVcDecisionName());
                            decisionUiAudit.setVcDecisionDetail(
                                    editTransactionClassRequest.getAddNewDecision()
                                            .getVcDecisionDetail());
                            decisionUiAudit.setIProductID(products);
                            try {

                                decisionUiAudit = decisionAuditService
                                        .saveDeicisonUiAudit(decisionUiAudit);
                            } catch (Exception e) {
                                LOGGER.error("Error : " + e + "\nParam : " +
                                        loggerEncoderUtil
                                                .encode(pr.toString()));
                                activityLogService.addActivity(loggedInUser,
                                        "failed to get user and permissions",
                                        e.toString());
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }

                            audit.setIDecisionIDAudit(
                                    decisionUiAudit.getIDecisionAuditID());
                        }
                    } else {
                        LOGGER.debug(
                                "Exiting editTransactionClass Method in " +
                                        CustomTransactionClassesImpl.class +
                                        " class with response  : with parameter edit transaction class");
                        activityLogService.addActivity(
                                loggedInUser, "Failed to edit transaction class",
                                "Parameters : " + editTransactionClassRequest
                                        .getProductId());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, "Invalid default decision"),
                                HttpStatus.BAD_REQUEST);
                    }

                    Products products = null;
                    if (editTransactionClassRequest.getProductId() == null) {
                        LOGGER.debug(
                                "Exiting editTransactionClass Method in " +
                                        CustomTransactionClassesImpl.class +
                                        " class with response  : with parameter edit transaction class");
                        activityLogService.addActivity(
                                loggedInUser, "Failed to edit transaction class",
                                "Parameters : " + editTransactionClassRequest
                                        .getProductId());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, "Product id cannot be blank"),
                                HttpStatus.BAD_REQUEST);
                    }
                    try {
                        products = productService.findByiProductID(
                                editTransactionClassRequest.getProductId());
                    } catch (Exception e) {
                        LOGGER.error(
                                loggerEncoderUtil.encode(
                                        "Error : " + e + "\nParam : " + pr));
                        activityLogService.addActivity(loggedInUser,
                                "failed to get user and permissions",
                                e.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                    if (products != null) {

                        audit.setIProductID(products);
                    } else {
                        LOGGER.debug(
                                "Exiting editTransactionClass Method in " +
                                        CustomTransactionClassesImpl.class +
                                        " class with response  : with parameter edit transaction class");
                        activityLogService.addActivity(
                                loggedInUser, "Failed to edit transaction class",
                                "Parameters : " + editTransactionClassRequest
                                        .getProductId());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "No Product found for product id :- " +
                                                editTransactionClassRequest
                                                        .getProductId()),
                                HttpStatus.BAD_REQUEST);
                    }

                    audit.setBPayeeMandatory(editTransactionClassRequest.getPayee());
                    audit.setBPayerMandatory(editTransactionClassRequest.getPayer());
                    audit.setIChannelID(editTransactionClassRequest.getChannelId());
                    ObjectMapper mapper = new ObjectMapper();
                    // try {

                    // JsonNode actualObj = mapper.readTree(
                    // editTransactionClassRequest.getVcDecisionParams());
                    // audit.setVcDecisionParams(actualObj);
                    // } catch (Exception e) {
                    // // TODO: handle exception
                    // LOGGER.error("Error " + e);
                    // }

                    audit.setVcDecisionParams(
                            editTransactionClassRequest.getDecisionParams());
                    audit.setVcRemark(editTransactionClassRequest.getMakerRemark());
                    audit.setIEntryUserID(loggedInUser.getIuserID());
                    audit.setIorgId(loggedInUser.getIorgId());
                    audit.setDtEntryStamp(ZonedDateTime.now());
                    audit.setBclosed(false);
                    audit.setAttribs(editTransactionClassRequest.getAttribs());
                    audit.setSkipProcessing(
                            editTransactionClassRequest.getSkipProcessing());
                    if (audit.getVcAction().equals("A")) {
                        audit.setItenantId(editTransactionClassRequest.getItenantId());
                    }
                    transactionClassessUiAuditService.saveAudit(audit);
                    LOGGER.debug(
                            "Exiting editTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter edit transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Transaction class edition sent for approval",
                            "Parameters : " + editTransactionClassRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(true,
                                    "Transaction class edition sent for approval"),
                            HttpStatus.OK);

                } else {
                    LOGGER.debug(
                            "Exiting editTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter edit transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to edit transaction class",
                            "Parameters : " + editTransactionClassRequest.getIclassId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "No Pending Entries Found for id :- " +
                                            editTransactionClassRequest
                                                    .getIclassId()),
                            HttpStatus.BAD_REQUEST);
                }
            } else {

                TransactionClassesUiAudit exist = null;
                exist = transactionClassessUiAuditService.findPendingEntriesByIClassId(
                        editTransactionClassRequest.getIclassId(),
                        editTransactionClassRequest.getItenantId());

                if (editTransactionClassRequest.getIclassId() == null) {
                    LOGGER.debug(
                            "Exiting editTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter edit transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to edit transaction class",
                            "Parameters : " + editTransactionClassRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Class id is null"),
                            HttpStatus.BAD_REQUEST);
                }

                if (editTransactionClassRequest.getDefaultDecisionId() == null &&
                        editTransactionClassRequest.getAddNewDecision() == null) {
                    LOGGER.debug(
                            "Exiting editTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter edit transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to edit transaction class",
                            "Parameters : " + editTransactionClassRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Default decision id cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }

                if (editTransactionClassRequest.getChannelId() == null) {
                    LOGGER.debug(
                            "Exiting editTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter edit transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to edit transaction class",
                            "Parameters : " + editTransactionClassRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Channel id is null"),
                            HttpStatus.BAD_REQUEST);
                }

                if (editTransactionClassRequest.getPayee() == null) {
                    LOGGER.debug(
                            "Exiting editTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter edit transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to edit transaction class",
                            "Parameters : " + editTransactionClassRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Payee mandatory is null"),
                            HttpStatus.BAD_REQUEST);
                }

                if (editTransactionClassRequest.getPayer() == null) {
                    LOGGER.debug(
                            "Exiting editTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter edit transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to edit transaction class",
                            "Parameters : " + editTransactionClassRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Payer mandatory is null"),
                            HttpStatus.BAD_REQUEST);
                }

                if (editTransactionClassRequest.getProductId() == null) {
                    LOGGER.debug(
                            "Exiting editTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter edit transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to edit transaction class",
                            "Parameters : " + editTransactionClassRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Product id cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }

                if (exist != null) {
                    LOGGER.debug(
                            "Exiting editTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter edit transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Transaction class failed edit",
                            "Parameters : " + editTransactionClassRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(true, "Entry is already pending for action"),
                            HttpStatus.OK);
                }

                TransactionClassesUI transactionClassesUI = null;
                try {
                    transactionClassesUI = transactionClassesUiService.findByiClassID(
                            editTransactionClassRequest.getIclassId(),
                            editTransactionClassRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e +
                            "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser,
                            "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (transactionClassesUI != null) {
                    TransactionClassesUiAudit audit = new TransactionClassesUiAudit();
                    audit = audit.parseToAudit(transactionClassesUI);

                    if (editTransactionClassRequest.getDefaultDecisionId() != null &&
                            editTransactionClassRequest.getAddNewDecision() == null) {

                        DecisionUiWorkflowAudit existAuditDec = null;
                        try {
                            existAuditDec = decisionWorkFlowAuditServiceImpl
                                    .findPendingDecisionByID(
                                            editTransactionClassRequest
                                                    .getDefaultDecisionId(),
                                            editTransactionClassRequest
                                                    .getItenantId());
                        } catch (Exception e) {
                            LOGGER.error(
                                    loggerEncoderUtil.encode("Error : " + e
                                            + "\nParam : " + pr));
                            activityLogService.addActivity(loggedInUser,
                                    "failed to get user and permissions",
                                    e.toString());
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }

                        if (existAuditDec != null) {
                            if (existAuditDec.getVcAction().equals("X")) {
                                LOGGER.debug(
                                        "Exiting addTransactionClass Method in "
                                                +
                                                CustomTransactionClassesImpl.class
                                                +
                                                " class with response  : with parameters type add transaction class");
                                activityLogService.addActivity(
                                        loggedInUser,
                                        "Failed to access decision details");
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                "Decision is pending delete approval"),
                                        HttpStatus.BAD_REQUEST);
                            }
                        }
                        if (audit.getIDecisionIDAudit() != null) {
                            try {

                                DecisionUiAudit decisionAudit = decisionAuditRepository
                                        .getReferenceById(audit
                                                .getIDecisionIDAudit());
                                decisionAudit.setBclosed(true);
                                decisionAudit.setIstatus(
                                        statusCodeService.findByIStatusId(5));
                                decisionAudit.setDtApproverStamp(ZonedDateTime.now());
                                decisionAudit.setIApproverUserID(
                                        loggedInUser.getIuserID());
                                decisionAudit.setIorgId(loggedInUser.getIorgId());
                                decisionAudit.setVcRemark("Rejected");
                                decisionAuditService.saveDeicisonUiAudit(decisionAudit);
                            } catch (Exception e) {
                                LOGGER.error("Error : " + e + "\nParam : " +
                                        loggerEncoderUtil
                                                .encode(pr.toString()));
                                activityLogService.addActivity(loggedInUser,
                                        "failed to get user and permissions",
                                        e.toString());
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }
                        }
                        audit.setIDecisionIDAudit(null);
                        DecisionUi defaultDecision = null;
                        try {
                            defaultDecision = decisionUiService.findByiDecisionID(
                                    editTransactionClassRequest
                                            .getDefaultDecisionId(),
                                    editTransactionClassRequest.getItenantId());
                        } catch (Exception e) {
                            LOGGER.error(
                                    loggerEncoderUtil.encode("Error : " + e
                                            + "\nParam : " + pr));
                            activityLogService.addActivity(loggedInUser,
                                    "failed to get user and permissions",
                                    e.toString());
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                        if (defaultDecision != null) {
                            audit.setIdecisionID(editTransactionClassRequest
                                    .getDefaultDecisionId());
                        } else {
                            LOGGER.debug(
                                    "Exiting editTransactionClass Method in " +
                                            CustomTransactionClassesImpl.class
                                            +
                                            " class with response  : with parameter edit transaction class");
                            activityLogService.addActivity(
                                    loggedInUser,
                                    "Failed to edit transaction class",
                                    "Parameters : " +
                                            editTransactionClassRequest
                                                    .getDefaultDecisionId());
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(
                                            false,
                                            "No Decision found for decision id :- "
                                                    +
                                                    editTransactionClassRequest
                                                            .getDefaultDecisionId()),
                                    HttpStatus.BAD_REQUEST);
                        }
                    } else if (editTransactionClassRequest.getAddNewDecision() != null &&
                            editTransactionClassRequest.getDefaultDecisionId() == null) {
                        List<DecisionUi> allDec = new ArrayList<>();
                        try {
                            allDec = decisionUiService.findAll();
                        } catch (Exception e1) {
                            // TODO Auto-generated catch block
                            LOGGER.error("Error " + e1);
                        }

                        if (allDec.size() != 0) {
                            for (int g = 0; g < allDec.size(); g++) {
                                if (allDec.get(g).getVcDecisionName().equals(
                                        editTransactionClassRequest
                                                .getAddNewDecision()
                                                .getVcDecisionName())) {
                                    activityLogService.addActivity(loggedInUser,
                                            "failed to save decision",
                                            editTransactionClassRequest
                                                    .getAddNewDecision()
                                                    .toString());
                                    return new ResponseEntity<ApiResponse>(
                                            new ApiResponse(false,
                                                    "Decision name already taken"),
                                            HttpStatus.CONFLICT);
                                }
                            }
                        }
                        audit.setIdecisionID(null);
                        if (editTransactionClassRequest.getAddNewDecision()
                                .getProductId() == null) {
                            LOGGER.debug(
                                    "Exiting addNewTransactionClass Method in " +
                                            CustomTransactionClassesImpl.class
                                            +
                                            " class with response  : with parameter add transaction class");
                            activityLogService.addActivity(loggedInUser,
                                    "Failed to add transaction class",
                                    "Parameters : product id is null");
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "Product id of new decison cannot be blank"),
                                    HttpStatus.BAD_REQUEST);
                        }

                        Products products = null;
                        try {
                            products = productService.findByiProductID(
                                    editTransactionClassRequest.getAddNewDecision()
                                            .getProductId());
                        } catch (Exception e) {
                            LOGGER.error(
                                    loggerEncoderUtil.encode("Error : " + e
                                            + "\nParam : " + pr));
                            activityLogService.addActivity(loggedInUser,
                                    "failed to get user and permissions",
                                    e.toString());
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            ResponseMessages.GenericErrorMessage),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }

                        if (editTransactionClassRequest.getAddNewDecision()
                                .getVcDecisionDetail() != null) {
                            if (editTransactionClassRequest.getAddNewDecision()
                                    .getVcDecisionDetail()
                                    .isEmpty() ||
                                    editTransactionClassRequest.getAddNewDecision()
                                            .getVcDecisionDetail()
                                            .isBlank()) {
                                LOGGER.debug(
                                        "Exiting addNewTransactionClass Method in "
                                                +
                                                CustomTransactionClassesImpl.class
                                                +
                                                " class with response  : with parameter add transaction class");
                                activityLogService.addActivity(
                                        loggedInUser,
                                        "Failed to add transaction class",
                                        "Parameters : product id is null");
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                "Decision detail cannot be blank"),
                                        HttpStatus.BAD_REQUEST);
                            }
                        } else {
                            LOGGER.debug(
                                    "Exiting addNewTransactionClass Method in " +
                                            CustomTransactionClassesImpl.class
                                            +
                                            " class with response  : with parameter add transaction class");
                            activityLogService.addActivity(loggedInUser,
                                    "Failed to add transaction class",
                                    "Parameters : product id is null");
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "Decision detail cannot be blank"),
                                    HttpStatus.BAD_REQUEST);
                        }

                        if (editTransactionClassRequest.getAddNewDecision()
                                .getVcDecisionName() == null) {
                            if (editTransactionClassRequest.getAddNewDecision()
                                    .getVcDecisionName()
                                    .isEmpty() ||
                                    editTransactionClassRequest.getAddNewDecision()
                                            .getVcDecisionName()
                                            .isBlank()) {
                                LOGGER.debug(
                                        "Exiting addNewTransactionClass Method in "
                                                +
                                                CustomTransactionClassesImpl.class
                                                +
                                                " class with response  : with parameter add transaction class");
                                activityLogService.addActivity(
                                        loggedInUser,
                                        "Failed to add transaction class",
                                        "Parameters : product id is null");
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                "Decision name cannot be blank"),
                                        HttpStatus.BAD_REQUEST);
                            }
                        }

                        if (audit.getIDecisionIDAudit() == null) {
                            DecisionUiAudit decisionUiAudit = new DecisionUiAudit();
                            decisionUiAudit.setBActive(
                                    editTransactionClassRequest.getAddNewDecision()
                                            .getActive());
                            decisionUiAudit.setDtEntryDatetime(ZonedDateTime.now());
                            decisionUiAudit.setBclosed(false);
                            decisionUiAudit.setDtEntryStamp(ZonedDateTime.now());
                            decisionUiAudit.setIRecordStatus(0);

                            if (products != null) {

                                decisionUiAudit.setIProductID(products);
                            } else {
                                LOGGER.debug(
                                        "Exiting addNewTransactionClass Method in "
                                                +
                                                CustomTransactionClassesImpl.class
                                                +
                                                " class with response  : with parameter add transaction class");
                                activityLogService.addActivity(
                                        loggedInUser,
                                        "Failed to add transaction class",
                                        "Parameters : " +
                                                editTransactionClassRequest
                                                        .getProductId());
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(
                                                false,
                                                "No Product found for product id :- "
                                                        +
                                                        editTransactionClassRequest
                                                                .getProductId()),
                                        HttpStatus.BAD_REQUEST);
                            }
                            decisionUiAudit.setIUserID(loggedInUser.getIuserID());
                            decisionUiAudit.setIorgId(loggedInUser.getIorgId());
                            decisionUiAudit.setIsApproved(false);
                            decisionUiAudit.setVcDecisionDetail(
                                    editTransactionClassRequest.getAddNewDecision()
                                            .getVcDecisionDetail());
                            decisionUiAudit.setVcDecisionName(
                                    editTransactionClassRequest.getAddNewDecision()
                                            .getVcDecisionName());
                            decisionUiAudit.setIProductID(products);

                            decisionUiAudit.setVcAction("A");

                            decisionUiAudit.setVcRemark("New Added For Transaction Class");
                            try {

                                decisionUiAudit = decisionAuditService
                                        .saveDeicisonUiAudit(decisionUiAudit);
                            } catch (Exception e) {
                                LOGGER.error("Error : " + e + "\nParam : " +
                                        loggerEncoderUtil
                                                .encode(pr.toString()));
                                activityLogService.addActivity(loggedInUser,
                                        "failed to get user and permissions",
                                        e.toString());
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }

                            audit.setIDecisionIDAudit(
                                    decisionUiAudit.getIDecisionAuditID());

                        } else {
                            DecisionUiAudit decisionUiAudit = decisionAuditRepository
                                    .getReferenceById(audit.getIDecisionIDAudit());
                            decisionUiAudit.setVcDecisionName(
                                    editTransactionClassRequest.getAddNewDecision()
                                            .getVcDecisionName());
                            decisionUiAudit.setVcDecisionDetail(
                                    editTransactionClassRequest.getAddNewDecision()
                                            .getVcDecisionDetail());
                            decisionUiAudit.setIProductID(products);
                            try {

                                decisionUiAudit = decisionAuditService
                                        .saveDeicisonUiAudit(decisionUiAudit);
                            } catch (Exception e) {
                                LOGGER.error("Error : " + e + "\nParam : " +
                                        loggerEncoderUtil
                                                .encode(pr.toString()));
                                activityLogService.addActivity(loggedInUser,
                                        "failed to get user and permissions",
                                        e.toString());
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }

                            audit.setIDecisionIDAudit(
                                    decisionUiAudit.getIDecisionAuditID());
                        }
                    } else {
                        LOGGER.debug(
                                "Exiting editTransactionClass Method in " +
                                        CustomTransactionClassesImpl.class +
                                        " class with response  : with parameter edit transaction class");
                        activityLogService.addActivity(
                                loggedInUser, "Failed to edit transaction class",
                                "Parameters : " + editTransactionClassRequest
                                        .getProductId());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, "Invalid default decision"),
                                HttpStatus.BAD_REQUEST);
                    }

                    Products products = null;
                    try {
                        products = productService.findByiProductID(
                                editTransactionClassRequest.getProductId());
                    } catch (Exception e) {
                        LOGGER.error(
                                loggerEncoderUtil.encode(
                                        "Error : " + e + "\nParam : " + pr));
                        activityLogService.addActivity(loggedInUser,
                                "failed to get user and permissions",
                                e.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                    if (products != null) {

                        audit.setIProductID(products);
                    } else {
                        LOGGER.debug(
                                "Exiting editTransactionClass Method in " +
                                        CustomTransactionClassesImpl.class +
                                        " class with response  : with parameter edit transaction class");
                        activityLogService.addActivity(
                                loggedInUser, "Failed to edit transaction class",
                                "Parameters : " + editTransactionClassRequest
                                        .getProductId());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "No Product found for product id :- " +
                                                editTransactionClassRequest
                                                        .getProductId()),
                                HttpStatus.BAD_REQUEST);
                    }
                    ObjectMapper mapper = new ObjectMapper();
                    // try {

                    // JsonNode actualObj = mapper.readTree(
                    // editTransactionClassRequest.getVcDecisionParams());

                    // audit.setVcDecisionParams(actualObj);
                    // } catch (Exception e) {
                    // // TODO: handle exception
                    // LOGGER.error("Error " + e);
                    // }
                    audit.setBPayeeMandatory(editTransactionClassRequest.getPayee());
                    audit.setBPayerMandatory(editTransactionClassRequest.getPayer());
                    audit.setIChannelID(editTransactionClassRequest.getChannelId());
                    audit.setVcDecisionParams(
                            editTransactionClassRequest.getDecisionParams());

                    audit.setVcRemark(editTransactionClassRequest.getMakerRemark());
                    audit.setIEntryUserID(loggedInUser.getIuserID());
                    audit.setIorgId(loggedInUser.getIorgId());
                    audit.setDtEntryStamp(ZonedDateTime.now());
                    audit.setBclosed(false);
                    audit.setAttribs(editTransactionClassRequest.getAttribs());
                    audit.setSkipProcessing(
                            editTransactionClassRequest.getSkipProcessing());

                    transactionClassessUiAuditService.saveAudit(audit);
                    LOGGER.debug(
                            "Exiting editTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter edit transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Transaction class edition sent for approval",
                            "Parameters : " + editTransactionClassRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(true,
                                    "Transaction class edition sent for approval"),
                            HttpStatus.OK);
                } else {
                    LOGGER.debug(
                            "Exiting editTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter edit transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to edit transaction class",
                            "Parameters : " + editTransactionClassRequest.getIclassId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "No transaction class Found for id :- " +
                                            editTransactionClassRequest
                                                    .getIclassId()),
                            HttpStatus.BAD_REQUEST);
                }
            }
        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to editTransactionClass ");
            LOGGER.debug(
                    "Exiting editTransactionClass Method in " +
                            CustomTransactionClassesImpl.class +
                            " class with response  : unauthorized to edit transaction class");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to edit transaction class"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> addNewTransactionClass(AddTransactionClassRequest addTransactionClassRequest,
                                                    Authentication pr) {
        // System.out.println(addTransactionClassRequest);
        LOGGER.debug("entered in class " + CustomTransactionClassesImpl.class +
                " in method addNewTransactionClass");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isAdd() && loggedUser.allowTenants(Arrays.asList(addTransactionClassRequest.getItenantId()))) {

            if (addTransactionClassRequest.getTransactionIdentifier() != null) {
                if (addTransactionClassRequest.getTransactionIdentifier().isBlank() ||
                        addTransactionClassRequest.getTransactionIdentifier().isEmpty()) {
                    LOGGER.debug(
                            "Exiting addTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter add transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to add transaction class",
                            "Parameters : " + addTransactionClassRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Class name cannot be empty"),
                            HttpStatus.BAD_REQUEST);
                }
            }

            TransactionClassesUI existName = null;
            TransactionClassesUiAudit auditExist = null;
            try {
                existName = transactionClassesUiService.findByClassName(
                        addTransactionClassRequest.getTransactionIdentifier(),
                        addTransactionClassRequest.getItenantId());

                auditExist = transactionClassessUiAuditService.findPendingEntriesTenantClass(
                        addTransactionClassRequest.getTransactionIdentifier(),
                        addTransactionClassRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e +
                        "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (addTransactionClassRequest.getMakerRemark() != null) {
                if (addTransactionClassRequest.getMakerRemark().isEmpty() ||
                        addTransactionClassRequest.getMakerRemark().isBlank()) {
                    LOGGER.debug(
                            "Exiting addTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter add transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to add transaction class",
                            "Parameters : " + addTransactionClassRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Maker remark cannot be empty"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                LOGGER.debug(
                        "Exiting addTransactionClass Method in " +
                                CustomTransactionClassesImpl.class +
                                " class with response  : with parameter add transaction class");
                activityLogService.addActivity(
                        loggedInUser, "Failed to add transaction class",
                        "Parameters : " + addTransactionClassRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Maker remark cannot be empty"),
                        HttpStatus.BAD_REQUEST);
            }

            if (existName != null || auditExist != null) {
                LOGGER.debug(
                        "Exiting addTransactionClass Method in " +
                                CustomTransactionClassesImpl.class +
                                " class with response  : with parameter add transaction class");
                activityLogService.addActivity(
                        loggedInUser, "Failed to add transaction class",
                        "Parameters : " + addTransactionClassRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Transaction class name already taken"),
                        HttpStatus.CONFLICT);
            }

            if (addTransactionClassRequest.getDefaultDecisionId() == null &&
                    addTransactionClassRequest.getAddNewDecision() == null) {
                LOGGER.debug(
                        "Exiting editTransactionClass Method in " +
                                CustomTransactionClassesImpl.class +
                                " class with response  : with parameter edit transaction class");
                activityLogService.addActivity(
                        loggedInUser, "Failed to edit transaction class",
                        "Parameters : " +
                                addTransactionClassRequest.getDefaultDecisionId());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Please add default decision"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addTransactionClassRequest.getPayee() == null) {
                LOGGER.debug(
                        "Exiting addTransactionClass Method in " +
                                CustomTransactionClassesImpl.class +
                                " class with response  : with parameter add transaction class");
                activityLogService.addActivity(
                        loggedInUser, "Failed to add transaction class",
                        "Parameters : " +
                                addTransactionClassRequest.getDefaultDecisionId());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Payee mandatory cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addTransactionClassRequest.getProductId() == null) {
                LOGGER.debug(
                        "Exiting addTransactionClass Method in " +
                                CustomTransactionClassesImpl.class +
                                " class with response  : with parameter add transaction class");
                activityLogService.addActivity(
                        loggedInUser, "Failed to add transaction class",
                        "Parameters : " +
                                addTransactionClassRequest.getDefaultDecisionId());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Product id cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (addTransactionClassRequest.getPayer() == null) {
                LOGGER.debug(
                        "Exiting addTransactionClass Method in " +
                                CustomTransactionClassesImpl.class +
                                " class with response  : with parameter add transaction class");
                activityLogService.addActivity(
                        loggedInUser, "Failed to add transaction class",
                        "Parameters : " +
                                addTransactionClassRequest.getDefaultDecisionId());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Payer mandatory cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            TransactionClassesUiAudit audit = new TransactionClassesUiAudit();
            audit.setVcClassName(
                    addTransactionClassRequest.getTransactionIdentifier());
            if (addTransactionClassRequest.getAddNewDecision() == null &&
                    addTransactionClassRequest.getDefaultDecisionId() != null) {

                DecisionUiWorkflowAudit exist = null;
                try {
                    exist = decisionWorkFlowAuditServiceImpl.findPendingDecisionByID(
                            addTransactionClassRequest.getDefaultDecisionId(),
                            addTransactionClassRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e +
                            "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser,
                            "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (exist != null) {
                    if (exist.getVcAction().equals("X")) {
                        LOGGER.debug(
                                "Exiting addTransactionClass Method in " +
                                        CustomTransactionClassesImpl.class +
                                        " class with response  : with parameters type add transaction class");
                        activityLogService.addActivity(loggedInUser,
                                "Failed to access decision details");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Decision is pending delete approval"),
                                HttpStatus.BAD_REQUEST);
                    }
                }
                DecisionUi defaultDecision = null;
                try {
                    defaultDecision = decisionUiService.findByiDecisionID(
                            addTransactionClassRequest.getDefaultDecisionId(),
                            addTransactionClassRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e +
                            "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser,
                            "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                if (defaultDecision != null) {
                    audit.setIdecisionID(addTransactionClassRequest.getDefaultDecisionId());
                    audit.setIDecisionIDAudit(null);
                } else {
                    LOGGER.debug(
                            "Exiting addTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter add transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to add transaction class",
                            "Parameters : " +
                                    addTransactionClassRequest
                                            .getDefaultDecisionId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(
                                    false, "No Decision found for decision id :- " +
                                    addTransactionClassRequest
                                            .getDefaultDecisionId()),
                            HttpStatus.BAD_REQUEST);
                }
            } else if (addTransactionClassRequest.getAddNewDecision() != null &&
                    addTransactionClassRequest.getDefaultDecisionId() == null) {
                audit.setIdecisionID(null);
                List<DecisionUi> allDec = new ArrayList<>();
                try {
                    allDec = decisionUiService.findAll();
                } catch (Exception e1) {
                    // TODO Auto-generated catch block
                    LOGGER.error("Error " + e1);
                }

                if (allDec.size() != 0) {
                    for (int g = 0; g < allDec.size(); g++) {
                        if (allDec.get(g).getVcDecisionName().equals(
                                addTransactionClassRequest.getAddNewDecision()
                                        .getVcDecisionName())) {
                            activityLogService.addActivity(loggedInUser,
                                    "failed to save decision",
                                    addTransactionClassRequest.getAddNewDecision()
                                            .toString());
                            return new ResponseEntity<ApiResponse>(
                                    new ApiResponse(false,
                                            "Decision name already taken"),
                                    HttpStatus.CONFLICT);
                        }
                    }
                }

                DecisionUiAudit decisionUiAudit = new DecisionUiAudit();
                decisionUiAudit.setBActive(
                        addTransactionClassRequest.getAddNewDecision().getActive());
                decisionUiAudit.setDtEntryDatetime(ZonedDateTime.now());
                decisionUiAudit.setBclosed(false);
                decisionUiAudit.setDtEntryStamp(ZonedDateTime.now());
                if (addTransactionClassRequest.getAddNewDecision().getProductId() == null) {
                    LOGGER.debug(
                            "Exiting addNewTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter add transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to add transaction class",
                            "Parameters : " + addTransactionClassRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Product id of new decison cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
                Products products = null;
                try {
                    products = productService.findByiProductID(
                            addTransactionClassRequest.getAddNewDecision().getProductId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e +
                            "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser,
                            "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                if (products != null) {

                    decisionUiAudit.setIProductID(products);
                } else {
                    LOGGER.debug(
                            "Exiting addNewTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter add transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to add transaction class",
                            "Parameters : " + addTransactionClassRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "No Product found for product id :- " +
                                            addTransactionClassRequest
                                                    .getProductId()),
                            HttpStatus.BAD_REQUEST);
                }
                decisionUiAudit.setIUserID(loggedInUser.getIuserID());
                decisionUiAudit.setIorgId(loggedInUser.getIorgId());
                decisionUiAudit.setIEntryUserID(loggedInUser.getIuserID());
                decisionUiAudit.setIsApproved(false);
                if (addTransactionClassRequest.getAddNewDecision()
                        .getVcDecisionDetail() != null) {
                    if (!addTransactionClassRequest.getAddNewDecision()
                            .getVcDecisionDetail()
                            .isEmpty() &&
                            !addTransactionClassRequest.getAddNewDecision()
                                    .getVcDecisionDetail()
                                    .isBlank()) {
                        decisionUiAudit.setVcDecisionDetail(
                                addTransactionClassRequest.getAddNewDecision()
                                        .getVcDecisionDetail());
                    } else {
                        LOGGER.debug(
                                "Exiting addNewTransactionClass Method in " +
                                        CustomTransactionClassesImpl.class +
                                        " class with response  : with parameter add transaction class");
                        activityLogService.addActivity(
                                loggedInUser, "Failed to add transaction class",
                                "Parameters : " + addTransactionClassRequest
                                        .getProductId());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(
                                        false,
                                        "Decision detail of new decison cannot be blank"),
                                HttpStatus.BAD_REQUEST);
                    }
                } else {
                    LOGGER.debug(
                            "Exiting addNewTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter add transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to add transaction class",
                            "Parameters : " + addTransactionClassRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Decision detail of new decison cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }

                decisionUiAudit.setVcAction("A");
                if (addTransactionClassRequest.getAddNewDecision()
                        .getVcDecisionName() != null) {
                    if (!addTransactionClassRequest.getAddNewDecision()
                            .getVcDecisionName()
                            .isEmpty() &&
                            !addTransactionClassRequest.getAddNewDecision()
                                    .getVcDecisionName()
                                    .isBlank()) {
                        decisionUiAudit.setVcDecisionName(
                                addTransactionClassRequest.getAddNewDecision()
                                        .getVcDecisionName());
                    } else {
                        LOGGER.debug(
                                "Exiting addNewTransactionClass Method in " +
                                        CustomTransactionClassesImpl.class +
                                        " class with response  : with parameter add transaction class");
                        activityLogService.addActivity(
                                loggedInUser, "Failed to add transaction class",
                                "Parameters : " + addTransactionClassRequest
                                        .getProductId());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Decision name of new decison cannot be blank"),
                                HttpStatus.BAD_REQUEST);
                    }
                } else {
                    LOGGER.debug(
                            "Exiting addNewTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter add transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to add transaction class",
                            "Parameters : " + addTransactionClassRequest.getProductId());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Decision name of new decison cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }

                decisionUiAudit.setVcRemark("New Added For Transaction Class");
                decisionUiAudit.setIRecordStatus(0);
                try {

                    decisionUiAudit = decisionAuditService.saveDeicisonUiAudit(decisionUiAudit);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e +
                            "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser,
                            "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                audit.setIDecisionIDAudit(decisionUiAudit.getIDecisionAuditID());

            } else {
                LOGGER.debug(
                        "Exiting addNewTransactionClass Method in " +
                                CustomTransactionClassesImpl.class +
                                " class with response  : with parameter add transaction class");
                activityLogService.addActivity(
                        loggedInUser, "Failed to add transaction class",
                        "Parameters : " + addTransactionClassRequest.getProductId());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Invalid default decision"),
                        HttpStatus.BAD_REQUEST);
            }

            Products products = null;
            try {
                products = productService.findByiProductID(
                        addTransactionClassRequest.getProductId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e +
                        "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            if (products != null) {

                audit.setIProductID(products);
            } else {
                LOGGER.debug(
                        "Exiting editTransactionClass Method in " +
                                CustomTransactionClassesImpl.class +
                                " class with response  : with parameter edit transaction class");
                activityLogService.addActivity(
                        loggedInUser, "Failed to edit transaction class",
                        "Parameters : " + addTransactionClassRequest.getProductId());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "No Product found for product id :- " +
                                        addTransactionClassRequest
                                                .getProductId()),
                        HttpStatus.BAD_REQUEST);
            }
            audit.setBActive(true);
            audit.setBclosed(false);
            audit.setDtEntryStamp(ZonedDateTime.now());
            audit.setDtEntryDateTime(ZonedDateTime.now());
            audit.setIEntryUserID(loggedInUser.getIuserID());
            audit.setIorgId(loggedInUser.getIorgId());
            audit.setBPayeeMandatory(addTransactionClassRequest.getPayee());
            audit.setBPayerMandatory(addTransactionClassRequest.getPayer());
            audit.setIChannelID(addTransactionClassRequest.getChannelId());
            audit.setIRecordStatus(0);
            audit.setVcRemark(addTransactionClassRequest.getMakerRemark());
            audit.setVcAction("A");
            audit.setAttribs(addTransactionClassRequest.getAttribs());
            audit.setVcDecisionParams(addTransactionClassRequest.getDecisionParams());
            audit.setSkipProcessing(addTransactionClassRequest.getSkipProcessing());
            audit.setItenantId(addTransactionClassRequest.getItenantId());
            transactionClassessUiAuditService.saveAudit(audit);
            LOGGER.debug(
                    "Exiting addTransactionClass Method in " +
                            CustomTransactionClassesImpl.class +
                            " class with response  : with parameter add transaction class");
            activityLogService.addActivity(
                    loggedInUser, "Transaction class addition sent for approval",
                    "Parameters : " + addTransactionClassRequest.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(true, "Transaction class addition sent for approval"),
                    HttpStatus.OK);

        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to addTransactionClass ");
            LOGGER.debug(
                    "Exiting addTransactionClass Method in " +
                            CustomTransactionClassesImpl.class +
                            " class with response  : unauthorized to add transaction class");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to add transaction class"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public ResponseEntity<?> approveTransactionClass(ApproveTransactionClass approveTransactionClass,
                                                     Authentication pr) {
        LOGGER.debug("entered in class " + CustomTransactionClassesImpl.class +
                " in method approveTransactionClass");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isApprove()) {
            TransactionClassesUiAudit audit = null;
            audit = transactionClassessUiAuditService.findTransactionDetail(
                    approveTransactionClass.getIclassAuditId(),
                    approveTransactionClass.getTenantId());

            if (audit.getIEntryUserID() == loggedInUser.getIuserID()) {
                LOGGER.debug(
                        "Exiting approveTransactionClass Method in " +
                                CustomTransactionClassesImpl.class +
                                " class with response  : with parameter approve transaction class");
                activityLogService.addActivity(
                        loggedInUser, "Failed to approve transaction class",
                        "Parameters : " + approveTransactionClass.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Maker cannot be checker"),
                        HttpStatus.BAD_REQUEST);
            }

            // if (audit.getIdecisionID() == null) {

            // DecisionUi saveNewUi = new DecisionUi();

            // saveNewUi.setBactive(audit.getIDecisionIDAudit().isBActive());
            // saveNewUi.setDtEntryDatetime(
            // audit.getIDecisionIDAudit().getDtEntryDatetime());
            // saveNewUi.setDtApproverStamp(new Date());
            // saveNewUi.setIApproverUserID(loggedInUser);
            // saveNewUi.setIstatus(
            // statusCodeService.findByIStatusId(2).getIStatusIDForMaster());
            // saveNewUi.setLastStatus("Approved");
            // saveNewUi.setLatestRemark("New Added");
            // saveNewUi.setIRecordStatus(0);
            // saveNewUi.setVcDecisionDetail(
            // audit.getIDecisionIDAudit().getVcDecisionDetail());
            // saveNewUi.setIProductID(audit.getIDecisionIDAudit().getIProductID());
            // saveNewUi.setVcDecisionName(
            // audit.getIDecisionIDAudit().getVcDecisionName());

            // try {
            // saveNewUi = decisionUiService.save(saveNewUi);
            // HttpResponse<String> res = decisionApiService.addDecision(saveNewUi);
            // if (res.statusCode() != 200) {
            // TransactionAspectSupport.currentTransactionStatus()
            // .setRollbackOnly();
            // activityLogService.addActivity("failed to save decision",
            // saveNewUi.toString());
            // return new ResponseEntity<ApiResponse>(
            // new ApiResponse(false, "something went wrong"),
            // HttpStatus.INTERNAL_SERVER_ERROR);
            // }
            // ObjectMapper mapper = new ObjectMapper();
            // JsonNode node = mapper.readTree(res.body());
            // saveNewUi.setMasterDecisionId(node.get("decisionId").asInt());
            // saveNewUi = decisionUiService.save(saveNewUi);

            // } catch (Exception e) {
            // TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            // LOGGER.error("Error : " + e +
            // "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            // activityLogService.addActivity("failed to get user and permissions",
            // e.toString());
            // return new ResponseEntity<ApiResponse>(
            // new ApiResponse(false, ResponseMessages.GenericErrorMessage),
            // HttpStatus.INTERNAL_SERVER_ERROR);
            // }

            // audit.setIdecisionID(saveNewUi);

            // try {

            // DecisionUiAudit decisionAudit = audit.getIDecisionIDAudit();
            // decisionAudit.setBclosed(true);
            // decisionAudit.setIstatus(statusCodeService.findByIStatusId(5));
            // decisionAudit.setDtApproverStamp(new Date());
            // decisionAudit.setIApproverUserID(loggedInUser);
            // decisionAudit.setVcRemark(
            // "{ " + audit.getIDecisionIDAudit().getVcRemark() + " }"
            // + "{ Approved }");
            // decisionAuditService.saveDeicisonUiAudit(decisionAudit);
            // } catch (Exception e) {
            // LOGGER.error("Error : " + e +
            // "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            // activityLogService.addActivity("failed to get user and permissions",
            // e.toString());
            // return new ResponseEntity<ApiResponse>(
            // new ApiResponse(false, ResponseMessages.GenericErrorMessage),
            // HttpStatus.INTERNAL_SERVER_ERROR);
            // }

            // // System.out.println(res.statusCode());
            // // System.out.println(res);
            // }

            if (approveTransactionClass.getCheckerRemark() != null) {
                if (approveTransactionClass.getCheckerRemark().isEmpty() ||
                        approveTransactionClass.getCheckerRemark().isBlank()) {
                    LOGGER.debug(
                            "Exiting approveTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter approve transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to approve transaction class",
                            "Parameters : " + approveTransactionClass.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Checker remarks cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                LOGGER.debug(
                        "Exiting approveTransactionClass Method in " +
                                CustomTransactionClassesImpl.class +
                                " class with response  : with parameter approve transaction class");
                activityLogService.addActivity(
                        loggedInUser, "Failed to approve transaction class",
                        "Parameters : " + approveTransactionClass.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Checker remarks cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            if (approveTransactionClass.getApprove()) {

                audit.setBclosed(true);
                audit.setDtApproverStamp(ZonedDateTime.now());
                audit.setIApproverUserID(loggedInUser.getIuserID());
                audit.setIorgId(loggedInUser.getIorgId());
                audit.setVcRemark("{ " + audit.getVcRemark() + " }"
                        + "{ " + approveTransactionClass.getCheckerRemark() +
                        " }");
                if (audit.getVcAction().equals("A")) {

                    audit.setIstatus(statusCodeService.findByIStatusId(2));
                } else if (audit.getVcAction().equals("M")) {
                    audit.setIstatus(statusCodeService.findByIStatusId(3));
                } else if (audit.getVcAction().equals("X")) {
                    audit.setIstatus(statusCodeService.findByIStatusId(4));
                }
                TransactionClassesUI transactionClassesUI = audit.parseAudit(audit);
                transactionClassesUI.setLastStatus("Approved");
                transactionClassesUI.setLatestRemark(
                        approveTransactionClass.getCheckerRemark());
                transactionClassesUI.setDtApproverStamp(ZonedDateTime.now());
                transactionClassesUI.setIstatus(
                        audit.getIstatus().getIStatusIDForMaster());
                if (audit.getVcAction().equals("X")) {
                    transactionClassesUI.setIRecordStatus(1);
                } else {
                    transactionClassesUI.setIRecordStatus(0);
                }
                transactionClassessUiAuditService.saveAudit(audit);
                // System.out.println("called 22");
                try {
                    transactionClassesUI = transactionClassesUiService.save(transactionClassesUI);
                } catch (Exception e) {
                    // e.printStackTrace();
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    LOGGER.error("Error : " + e +
                            "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser,
                            "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                DecisionUi decisions = null;
                try {
                    decisions = decisionUiService.findByiDecisionID(
                            transactionClassesUI.getIDecisionID(),
                            transactionClassesUI.getItenantId());
                } catch (Exception e) {
                    // e.printStackTrace();
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    LOGGER.error("Error : " + e +
                            "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get decision",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (decisions != null) {
                    // TransactionClasses transactionClasses = transactionClassesUI
                    // .parseToTransactionClass(transactionClassesUI);
                    // transactionClasses.setIDecisionID(decisions);
                    try {
                        // transactionClassesService.save(transactionClasses);
                        ResponseEntity<String> res = null;
                        if (audit.getIclassID() == null) {
                            System.out.println("add called");

                            res = transactionClassApiService.addTransactionClass(
                                    transactionClassesUI);
                            System.out.println("Add response status code " +
                                    res.getStatusCode());
                        } else {
                            if (audit.getVcAction().equals("X")) {
                                res = transactionClassApiService
                                        .deleteTransactionClass(
                                                tenantRepositoryService
                                                        .findAPIKeyTenant(
                                                                audit.getItenantId()),
                                                transactionClassesUI
                                                        .getVcClassName());
                            } else {
                                res = transactionClassApiService
                                        .editTransactionClass(
                                                transactionClassesUI);
                            }
                            // System.out.println("edit called");
                        }

                        // System.out.println(res.statusCode());
                        // System.out.println(res.body());

                        if (audit.getIclassID() == null) {
                            if (res.getStatusCode() != HttpStatus.CREATED) {
                                TransactionAspectSupport.currentTransactionStatus()
                                        .setRollbackOnly();
                                System.out.println("Response is " + res);
                                LOGGER.error("Error : Failed to save transaction class");
                                activityLogService.addActivity(loggedInUser,
                                        "failed to save transaction class",
                                        transactionClassesUI.toString());
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }
                        } else {
                            if (res.getStatusCode() != HttpStatus.OK) {
                                TransactionAspectSupport.currentTransactionStatus()
                                        .setRollbackOnly();
                                LOGGER.error("Error : Failed to save transaction class");
                                activityLogService.addActivity(loggedInUser,
                                        "failed to save transaction class",
                                        transactionClassesUI.toString());
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false,
                                                ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }
                        }

                    } catch (Exception e) {
                        // e.printStackTrace();
                        TransactionAspectSupport.currentTransactionStatus()
                                .setRollbackOnly();
                        LOGGER.error(
                                loggerEncoderUtil.encode(
                                        "Error : " + e + "\nParam : " + pr));
                        activityLogService.addActivity(loggedInUser,
                                "failed to save transaction class",
                                e.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                } else {
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    activityLogService.addActivity(loggedInUser,
                            "failed to get decision",
                            transactionClassesUI.getIDecisionID().toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                String msg = "";
                if (audit.getVcAction().equalsIgnoreCase("A")) {
                    msg = "Transaction class addition approved successfully";
                } else if (audit.getVcAction().equalsIgnoreCase("M")) {
                    msg = "Transaction class edition approved successfully";
                } else if (audit.getVcAction().equalsIgnoreCase("X")) {
                    msg = "Transaction class deletion approved successfully";
                }
                LOGGER.debug(
                        "Exiting approveTransactionClass Method in " +
                                CustomTransactionClassesImpl.class +
                                " class with response  : with parameter approve transaction class");
                activityLogService.addActivity(
                        loggedInUser, msg,
                        "Parameters : " + approveTransactionClass.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(true, msg),
                        HttpStatus.OK);

            } else {
                audit.setBclosed(true);
                audit.setDtApproverStamp(ZonedDateTime.now());
                audit.setIApproverUserID(loggedInUser.getIuserID());
                audit.setIorgId(loggedInUser.getIorgId());
                audit.setVcRemark("{" + audit.getVcRemark() + "}"
                        + "{ " + approveTransactionClass.getCheckerRemark() +
                        " }");
                audit.setIstatus(statusCodeService.findByIStatusId(5));
                transactionClassessUiAuditService.saveAudit(audit);

                TransactionClassesUI transUi = null;
                if (audit.getIclassID() != null) {

                    try {
                        transUi = transactionClassesUiService.findByiClassID(
                                audit.getIclassID(), audit.getItenantId());
                    } catch (Exception e) {
                        // e.printStackTrace();
                        TransactionAspectSupport.currentTransactionStatus()
                                .setRollbackOnly();
                        LOGGER.error(
                                loggerEncoderUtil.encode(
                                        "Error : " + e + "\nParam : " + pr));
                        activityLogService.addActivity(loggedInUser,
                                "failed to save transaction class",
                                e.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    transUi.setLastStatus("Rejected");
                    transUi.setLatestRemark(approveTransactionClass.getCheckerRemark());
                    transUi.setDtApproverStamp(ZonedDateTime.now());
                    try {
                        transactionClassesUiService.save(transUi);
                    } catch (Exception e) {
                        // e.printStackTrace();
                        TransactionAspectSupport.currentTransactionStatus()
                                .setRollbackOnly();
                        LOGGER.error(
                                loggerEncoderUtil.encode(
                                        "Error : " + e + "\nParam : " + pr));
                        activityLogService.addActivity(loggedInUser,
                                "failed to save transaction class",
                                e.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                }

                String msg = "";
                if (audit.getVcAction().equalsIgnoreCase("A")) {
                    msg = "Transaction class addition rejected successfully";
                } else if (audit.getVcAction().equalsIgnoreCase("M")) {
                    msg = "Transaction class edition rejected successfully";
                } else if (audit.getVcAction().equalsIgnoreCase("X")) {
                    msg = "Transaction class deletion rejected successfully";
                }
                LOGGER.debug(
                        "Exiting approveTransactionClass Method in " +
                                CustomTransactionClassesImpl.class +
                                " class with response  : with parameter approve transaction class");
                activityLogService.addActivity(
                        loggedInUser, msg,
                        "Parameters : " + approveTransactionClass.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(true, msg),
                        HttpStatus.OK);
            }

        } else {

            activityLogService.addActivity(
                    loggedInUser, "unauthorized to approveTransactionClass ");
            LOGGER.debug(
                    "Exiting approveTransactionClass Method in " +
                            CustomTransactionClassesImpl.class +
                            " class with response  : unauthorized to add transaction class");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false,
                            "unauthorized to approve/reject transaction class"),
                    HttpStatus.FORBIDDEN);
        }
    }

    @Override
    public ResponseEntity<?> deleteTransactionClass(
            DeleteTransactionClassRequest deleteTransactionClassRequest,
            Authentication pr) {
        LOGGER.debug("entered in class " + CustomTransactionClassesImpl.class +
                " in method deleteTransactionClass");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        System.out.println(deleteTransactionClassRequest);
        if (mp.isDelete()) {

            if (deleteTransactionClassRequest.getClassId() == null) {
                LOGGER.debug(
                        "Exiting deleteTransactionClass Method in " +
                                CustomTransactionClassesImpl.class +
                                " class with response  : with parameter delete transaction class");
                activityLogService.addActivity(
                        loggedInUser, "Failed to delete transaction class",
                        "Parameters : " + deleteTransactionClassRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Class id cannot null"),
                        HttpStatus.BAD_REQUEST);
            }

            if (deleteTransactionClassRequest.getMakerRemark() != null) {
                if (deleteTransactionClassRequest.getMakerRemark().isEmpty() ||
                        deleteTransactionClassRequest.getMakerRemark().isBlank()) {
                    LOGGER.debug(
                            "Exiting deleteTransactionClass Method in " +
                                    CustomTransactionClassesImpl.class +
                                    " class with response  : with parameter delete transaction class");
                    activityLogService.addActivity(
                            loggedInUser, "Failed to delete transaction class",
                            "Parameters : " + deleteTransactionClassRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Maker Remarks cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }

            } else {
                LOGGER.debug(
                        "Exiting deleteTransactionClass Method in " +
                                CustomTransactionClassesImpl.class +
                                " class with response  : with parameter delete transaction class");
                activityLogService.addActivity(
                        loggedInUser, "Failed to delete transaction class",
                        "Parameters : " + deleteTransactionClassRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Maker Remarks cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            TransactionClassesUiAudit exist = null;
            exist = transactionClassessUiAuditService.findPendingEntriesByIClassId(
                    deleteTransactionClassRequest.getClassId(),
                    deleteTransactionClassRequest.getItenantId());

            if (exist != null) {
                LOGGER.debug(
                        "Exiting deleteTransactionClass Method in " +
                                CustomTransactionClassesImpl.class +
                                " class with response  : with parameter delete transaction class");
                activityLogService.addActivity(
                        loggedInUser, "Failed to delete transaction class",
                        "Parameters : " + deleteTransactionClassRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Entry is already pending for action"),
                        HttpStatus.BAD_REQUEST);
            }

            TransactionClassesUI transactionClassesUI = null;
            try {
                transactionClassesUI = transactionClassesUiService.findByiClassID(
                        deleteTransactionClassRequest.getClassId(),
                        deleteTransactionClassRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e +
                        "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (transactionClassesUI != null) {
                TransactionClassesUiAudit audit = new TransactionClassesUiAudit();
                audit = audit.parseToAudit(transactionClassesUI);
                audit.setVcRemark(deleteTransactionClassRequest.getMakerRemark());
                audit.setIEntryUserID(loggedInUser.getIuserID());
                audit.setIorgId(loggedInUser.getIorgId());
                audit.setDtEntryDateTime(ZonedDateTime.now());
                audit.setIRecordStatus(1);
                audit.setVcAction("X");
                transactionClassessUiAuditService.saveAudit(audit);
                LOGGER.debug(
                        "Exiting deleteTransactionClass Method in " +
                                CustomTransactionClassesImpl.class +
                                " class with response  : with parameter delete transaction class");
                activityLogService.addActivity(
                        loggedInUser, "Transaction class deletion sent for approval",
                        "Parameters : " + deleteTransactionClassRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(true,
                                "Transaction class deletion sent for approval"),
                        HttpStatus.OK);

            } else {
                activityLogService.addActivity(loggedInUser,
                        "Failed to delete transaction class ");
                LOGGER.debug(
                        "Exiting deleteTransactionClass Method in " +
                                CustomTransactionClassesImpl.class +
                                " class with response  : failed to delete transaction class");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Failed to delete transaction class"),
                        HttpStatus.FORBIDDEN);
            }

        } else {

            activityLogService.addActivity(
                    loggedInUser, "unauthorized to delete transaction class ");
            LOGGER.debug(
                    "Exiting deleteTransactionClass Method in " +
                            CustomTransactionClassesImpl.class +
                            " class with response  : unauthorized to delete transaction class");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to delete transaction class"),
                    HttpStatus.FORBIDDEN);
        }
    }

    // @Override
    // public ResponseEntity<?> disableResultParam(Integer classID, Authentication
    // pr)
    // { LOGGER.debug( "entered in class " + CustomTransactionClassesImpl.class +
    // " disableResultParam"); UserAndPermissions userAndPermissions = null; try {
    // userAndPermissions = webUserService.getUserAndPermissions(pr.getName(),
    // MenuNames.Tasks);
    // } catch (Exception e) {
    // LOGGER.error("Error : " + e + "\nParam : " + pr);
    // activityLogService.addActivity("failed to get user and permissions",
    // e.toString());
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
    // ResponseMessages.GenericErrorMessage),
    // HttpStatus.INTERNAL_SERVER_ERROR);
    // }

    // WebUser user = userAndPermissions.getUser();
    // MenuPermissions mp = userAndPermissions.getPermissions();

    // if (mp.isEdit()) {
    // TransactionClasses editClass = null;
    // try {
    // // System.out.println(classID);
    // editClass = transactionClassesService.findByiClassID(classID);
    // // System.out.println(editClass);
    // } catch (Exception e) {
    // LOGGER.error("Error : " + e + "\nParam : " + pr);
    // activityLogService.addActivity("failed to edit transaction class",
    // e.toString());
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
    // ResponseMessages.GenericErrorMessage),
    // HttpStatus.INTERNAL_SERVER_ERROR);
    // }

    // // org.json.JSONObject param = new
    // org.json.JSONObject(editClass.getVcResultParams());
    // // JSONArray actionArr = param.optJSONArray("action");
    // // for (int i = 0; i < actionArr.length(); i++) {
    // // if (actionArr.optJSONObject(i).opt("bworkflow") != null) {
    // // actionArr.optJSONObject(i).put("bworkflow", false);
    // // }
    // // }

    // // param.put("action", actionArr);

    // try {
    // // editClass.setBActive(false);
    // // editClass.setVcResultParams(param.toString());

    // LOGGER.debug("Exiting disableResultParam Method in " +
    // CustomTransactionClassesImpl.class
    // + " class with response : with parameters type dropdown");
    // activityLogService.addActivity(user, "Default rule edited successfully");
    // return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Result Params
    // disabled Successfully"),
    // HttpStatus.OK);
    // } catch (Exception e) {
    // LOGGER.error("Error : " + e + "\nParam : " + pr);
    // activityLogService.addActivity("failed to disable result params",
    // e.toString());
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
    // ResponseMessages.GenericErrorMessage),
    // HttpStatus.INTERNAL_SERVER_ERROR);
    // }

    // } else {
    // activityLogService.addActivity(user, "unauthorized to result param of
    // transaction class ");
    // LOGGER.debug("Exiting disableResultParam Method in " +
    // CustomTransactionClassesImpl.class
    // + " class with response : unauthorized to save transaction class");
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized
    // to save transaction class"),
    // HttpStatus.FORBIDDEN);
    // }
    // }

    // @Override
    // public ResponseEntity<?> getWorkFlowName(Authentication pr) {
    // LOGGER.debug("entering class " + CustomTransactionClassesImpl.class + " and
    // method getWorkFlowName");

    // UserAndPermissions userAndPermissions = null;
    // try {
    // userAndPermissions = webUserService.getUserAndPermissions(pr.getName(),
    // MenuNames.Tasks);
    // } catch (Exception e) {
    // LOGGER.error("Error : " + e + "\nParam : " + pr);
    // activityLogService.addActivity("failed to get user and permissions",
    // e.toString());
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
    // ResponseMessages.GenericErrorMessage),
    // HttpStatus.INTERNAL_SERVER_ERROR);
    // }

    // WebUser loggedInUser = userAndPermissions.getUser();
    // MenuPermissions mp = userAndPermissions.getPermissions();

    // if (mp.isView()) {

    // ClientResponse clientResponse = null;
    // try {
    // clientResponse = camundaService.getWorkFlowName(loggedInUser);

    // } catch (Exception e) {
    // LOGGER.error("Error : " + e);
    // activityLogService.addActivity(loggedInUser, "failed to get workflow name",
    // "Error : " + e.toString());
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
    // ResponseMessages.GenericErrorMessage),
    // HttpStatus.INTERNAL_SERVER_ERROR);
    // }

    // String responses = clientResponse.bodyToMono(String.class).block();
    // if (clientResponse.statusCode() == HttpStatus.OK) {

    // JSONArray workflowNames = new JSONArray(responses);

    // List<DropdownWithObject> workFlowDropDown = new ArrayList<>();

    // try {
    // for (int i = 0; i < workflowNames.length(); i++) {
    // org.json.JSONObject objectInArray = workflowNames.getJSONObject(i);
    // if(!objectInArray.get("name").equals("Review Invoice") &&
    // !objectInArray.get("name").equals("Invoice Receipt") ){
    // workFlowDropDown.add(DropdownWithObject.builder().label(objectInArray.get("name"))
    // .value(objectInArray.get("name")).build());
    // }

    // }
    // } catch (Exception e) {
    // LOGGER.error("Error : " + e + "\nParam : " + responses);
    // activityLogService.addActivity(loggedInUser, "failed to get task history",
    // "Error : " + e.toString() + ", Parameters : " + responses);
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false,
    // ResponseMessages.GenericErrorMessage),
    // HttpStatus.INTERNAL_SERVER_ERROR);
    // }
    // LOGGER.debug("Exiting getWorkFlowName Method in " +
    // CustomTransactionClassesImpl.class
    // + " class with response : workflow names");
    // return ResponseEntity.ok(workFlowDropDown);
    // }else{
    // activityLogService.addActivity(loggedInUser, "failed to access workflow
    // names");
    // LOGGER.debug("Exiting getPayeeNames Method in " +
    // CustomTransactionClassesImpl.class + " class with response : "
    // + responses);
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false, responses),
    // clientResponse.statusCode());
    // }

    // } else {
    // activityLogService.addActivity(loggedInUser, "unauthorized to get workflow
    // names");
    // LOGGER.debug("Exiting getWorkFlowName Method in " +
    // CustomTransactionClassesImpl.class
    // + " class with response : unauthorized to get workflow names");
    // return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized
    // to get workflow names"),
    // HttpStatus.FORBIDDEN);
    // }
    // }
}
