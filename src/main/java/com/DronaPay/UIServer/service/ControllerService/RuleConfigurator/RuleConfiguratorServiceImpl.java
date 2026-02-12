package com.DronaPay.UIServer.service.ControllerService.RuleConfigurator;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.ResponseVO.DecisionClassDropDown;
import com.DronaPay.UIServer.ResponseVO.DropdownWithObject;
import com.DronaPay.UIServer.ResponseVO.RuleAvailable;
import com.DronaPay.UIServer.ResponseVO.UserAndPermissions;
import com.DronaPay.UIServer.VOMapper.DecisionVoMapper;
import com.DronaPay.UIServer.VOMapper.RulesAuditMapper;
import com.DronaPay.UIServer.VOMapper.RulesAvailableMapper;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.requests.ApproveRuleRequest;
import com.DronaPay.UIServer.requests.EditDefaultRuleRequest;
import com.DronaPay.UIServer.response.*;
import com.DronaPay.UIServer.service.ApiServices.RuleApiServices;
import com.DronaPay.UIServer.service.HelperServices.CheckerMakerHelperService;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.DronaPay.UIServer.util.RuleDifferenceUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.collect.BiMap;
import io.hypersistence.utils.common.StringUtils;
import io.trino.jdbc.$internal.guava.collect.HashBiMap;
import org.json.JSONObject;
import org.json.simple.JSONValue;
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

import java.net.http.HttpResponse;
import java.time.ZonedDateTime;
import java.util.*;

import java.util.function.Function;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Service
public class RuleConfiguratorServiceImpl implements RuleConfiguratorService {

    private static final Logger LOGGER = LoggerFactory.getLogger(RuleConfiguratorServiceImpl.class);
    final String menu_name = MenuNames.defaultRules;
    @Value("${max.rule.ui.create}")
    private Integer maxRule;
    @Autowired
    private ActivityLogService activityLogService;
    @Autowired
    private DecisionUiServiceImpl decisionUiServiceImpl;

    @Autowired
    private RulesTempServiceImpl rulesTempService;

    @Autowired
    private DecisionAuditServiceImpl decisionAuditServiceImpl;
    @Autowired
    private RulesTempAuditServiceImpl rulesTempAuditServiceImpl;
    @Autowired
    private StatusCodeService statusCodeService;
    @Autowired
    private RuleApiServices ruleApiServices;
    @Autowired
    private DecisionUiWorkflowAuditServiceImpl decisionAuditServiceImplWorkFlow;
    @Autowired
    private CheckerMakerHelperService<DecisionAuditServiceImpl, DecisionUiAudit, DecisionUiServiceImpl, DecisionUi> checkerMakerHelperDecisionService;
    @Autowired
    private CheckerMakerHelperService<RulesTempAuditServiceImpl, RulesAudit, RulesTempServiceImpl, Rules> checkerMakerHelperRulesService;

    @Autowired
    private ObservationsUiService observationsUiService;
    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;
    @Autowired
    private MetadataUiService metadataUiService;

    @Autowired
    private RulesAvailableService rulesAvailableService;


    @Autowired
    private TenantRepositoryService tenantRepositoryService;

    @Autowired
    private RulesAvailableUiService rulesAvailableUiService;

    @Override
    public ResponseEntity<?> getAllDecision(Authentication pr) {
        LOGGER.debug("entered in class " + RuleConfiguratorServiceImpl.class + " in method getAllDecisions");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        DecisionListView decisionListView = new DecisionListView();

        decisionListView.setAdd(mp.isAdd());
        decisionListView.setApprove(mp.isApprove());
        decisionListView.setDelete(mp.isDelete());
        decisionListView.setEdit(mp.isEdit());
        decisionListView.setView(mp.isView());
        decisionListView.setPublish(mp.isPublish());

        if (mp.isView()) {
            List<DecisionUi> decisionList = new ArrayList<>();
            List<DecisionClassDropDown> responses = new ArrayList<>();
            List<DecisionUiAudit> decisionUiAudits = new ArrayList<>();
            // List<DecisionUiWorkflowAudit> decisionUiAuditsWorkFlow = new ArrayList<>();

            try {
                List<Integer> tenantids = loggedUser.getUserTenant();
                decisionList = decisionUiServiceImpl.findAllNonDeletedTenants(tenantids);
                decisionList = decisionList.stream().filter(c -> c.getIRecordStatus() == 0)
                        .collect(Collectors.toList());
                decisionUiAudits = decisionAuditServiceImpl.findPendingEntriesTenant(tenantids);
                // decisionUiAuditsWorkFlow =
                // decisionAuditServiceImplWorkFlow.findPendingEntries();
                decisionList.stream()
                        .map(d -> responses.add(DecisionClassDropDown.builder().label(d.getVcDecisionName())
                                .value(d.getIDecisionID()).prooductId(d.getIProductID().getIProductID())
                                .vcResultParam(d.getVcResultParams()).lastUpdate(d.getDtApproverStamp())
                                .itenantId(d.getItenantId()).tenantName(tenantRepositoryService.findByItenantId(d.getItenantId()).getTenantName())
                                .latestRemark(d.getLatestRemark()).lastStatus(d.getLastStatus()).auditEntry(false)
                                .auditExist(false).makerChecker("").build()))
                        .collect(Collectors.toList());

                decisionUiAudits = decisionUiAudits.stream()
                        .filter(c -> c.getIsApproved() == true && c.getIdecisionUiId() != null)
                        .collect(Collectors.toList());
                for (int i = 0; i < responses.size(); i++) {
                    for (int k = 0; k < decisionUiAudits.size(); k++) {
                        if (responses.get(i).getValue()
                                .equals(decisionUiAudits.get(k).getIdecisionUiId())) {
                            responses.get(i).setAuditExist(true);
                        }
                    }
                }

                // for (int i = 0; i < responses.size(); i++) {
                // for (int k = 0; k < decisionUiAuditsWorkFlow.size(); k++) {
                // if (responses.get(i).getValue()
                // .equals(decisionUiAuditsWorkFlow.get(k).getIdecisionUiId().getIDecisionID()))
                // {
                // responses.get(i).setAuditExist(true);
                // }
                // }
                // }
                decisionUiAudits.stream()
                        .map(d -> responses.add(DecisionClassDropDown.builder().label(d.getVcDecisionName())
                                .value(d.getIdecisionUiId())
                                .prooductId(d.getIProductID().getIProductID())
                                .vcResultParam(d.getVcResultParams())
                                .lastUpdate(d.getDtEntryStamp())
                                .latestRemark(d.getVcRemark())
                                .lastStatus("Pending")
                                .itenantId(d.getItenantId())
                                .tenantName(tenantRepositoryService.findByItenantId(d.getItenantId()).getTenantName())
                                .auditEntry(true)
                                .auditExist(false)
                                .makerChecker(d.getIEntryUserID() != loggedInUser.getIuserID() ? "C" : "M")
                                .build()))
                        .collect(Collectors.toList());
                decisionListView.setDecisionList(responses);

                LOGGER.debug("Exiting getTransactionClassesAndDecision Method in " + RuleConfiguratorServiceImpl.class
                        + " class with response  : with parameters type dropdown");
                activityLogService.addActivity(loggedInUser, "Decision Dropdown  accessed");
                return ResponseEntity.ok(decisionListView);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get decision details", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access decision dropdown for Transaction to decision");
            LOGGER.debug("Exiting getAllUploadChargeBacks Method in " + RuleConfiguratorServiceImpl.class
                    + " class with response  : unauthorized to access list of lists");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to access list of lists"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> getRulesAvailableByIDecisionId(Integer iDecisionId, Boolean audit, Authentication pr) {
        List<RuleAvailable> res = null;

        try {
            //this api is not used hence passing commenting out
            // List<Rules> rules = rulesTempService.findAllDefaultByIDecisionID(iDecisionId, 0);
            // RulesAvailableMapper RulesAvailableMapper = new RulesAvailableMapper();
            // res = RulesAvailableMapper
            //         .parse(rulesAvailableService.findAllByIDecisionIDActiveAndNotDeletedAndRuleType(), rules);

        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(String.valueOf(iDecisionId)));
            // activityLogService.addActivity(loggedInUser, "failed to get  available Rules", e.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.BAD_REQUEST);
        }
        return ResponseEntity.ok(res);
    }

    @Override
    public ResponseEntity<?> getModeDropDowns(Authentication pr) {
        LOGGER.debug("entered in class " + RuleConfiguratorServiceImpl.class + " in method getModeDropDowns");

        LoggedUser temp = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = temp.getWebUser();
        MenuPermissions mp = temp.getPermissions().get(menu_name);

        if (mp.isView()) {
            List<String> response = null;
            try {
                response = rulesAvailableService.findRuleTypes();
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get rule types", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            List<DropdownWithObject> dropDowns = new ArrayList<>();

            response.stream().map(c -> dropDowns.add(DropdownWithObject.builder().label(c).value(c).build()))
                    .collect(Collectors.toList());

            return ResponseEntity.ok(dropDowns);
        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access decision dropdown for types modes");
            LOGGER.debug("Exiting getModeDropDowns Method in " + RuleConfiguratorServiceImpl.class
                    + " class with response  : unauthorized to access list of lists");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access list of lists mode dropdowns"),
                    HttpStatus.FORBIDDEN);
        }

    }

    public ResponseEntity<?> getSequenceByiDecisionID(int iDecisionID, Boolean audit, Authentication pr) {

        LOGGER.debug(
                "entered in class " + RuleConfiguratorServiceImpl.class + " in method getSequenceByiDecisionID");
        // WebUser user = webUserService.loadUserByUsername(pr.getName());
        LoggedUser temp = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = temp.getWebUser();
        MenuPermissions mp = temp.getPermissions().get(menu_name);

        if (mp.isView()) {
            LinkedList<RuleAvailable> response = null;
            try {
                //commenting out since api not in use
                // if (!audit) {
                //     Deque<Rules> row = new LinkedList<>();
                //     row = rulesTempService.getSequenceByiDecisionID(iDecisionID);
                //     response = RulesAvailableMapper.parse(row);
                // } else {
                //     Deque<RulesAudit> rowAudit = new LinkedList<>();
                //     rowAudit = rulesTempAuditServiceImpl.getSequenceByiDecisionID(iDecisionID);
                //     response = RulesAvailableMapper.parseToRulesTempAudit(rowAudit);
                // }
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(String.valueOf(iDecisionID)));
                activityLogService.addActivity(loggedInUser, "failed to get rules sequence", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            LOGGER.debug("Exiting getSequenceByiDecisionID Method in " + RuleConfiguratorServiceImpl.class
                    + " class with response  : with parameters type");
            activityLogService.addActivity(loggedInUser, "Rules sequence accessed", "Parameters : " + iDecisionID);
            return ResponseEntity.ok(response);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access parameter types ");
            LOGGER.debug("Exiting getSequenceByiDecisionID Method in " + RuleConfiguratorServiceImpl.class
                    + " class with response  : unauthorized to access parameter types");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to access parameter types"),
                    HttpStatus.FORBIDDEN);
        }

    }

    public ResponseEntity<?> getRules(int iDecisionID) {

        LinkedList<RuleAvailable> response = null;
        try {

            // Deque<Rules> row = new LinkedList<>();
            // row = rulesTempService.getSequenceByiDecisionID(iDecisionID);
            // response = RulesAvailableMapper.parse(row);

        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(String.valueOf(iDecisionID)));
            // activityLogService.addActivity(loggedInUser, "failed to get rules sequence", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
        LOGGER.debug("Exiting getSequenceByiDecisionID Method in " + RuleConfiguratorServiceImpl.class
                + " class with response  : with parameters type");
        // activityLogService.addActivity("Rules sequence accessed", "Parameters : " + iDecisionID);
        return ResponseEntity.ok(response);

    }

    @Override
    public ResponseEntity<?> getCustomRulesByDecisionId(int iDecisionID, Boolean audit, Authentication pr) {
        LOGGER.debug(
                "entered in class " + RuleConfiguratorServiceImpl.class + " in method getCustomRulesByDecisionId");
        // WebUser user = webUserService.loadUserByUsername(pr.getName());
        LoggedUser temp = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = temp.getWebUser();
        MenuPermissions mp = temp.getPermissions().get(menu_name);

        List<Rules> res = null;
        List<RulesAudit> resAudits = null;
        List<RuleAvailable> finalRes = new ArrayList<>();
        if (mp.isView()) {
            try {
                // if (!audit) {
                //     res = rulesTempService.findAllByIDecisionID(iDecisionID);
                // } else {
                //     resAudits = rulesTempAuditServiceImpl.findAllByIDecisionID(iDecisionID);
                // }
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            if (!audit) {

                finalRes = RulesAvailableMapper.parseToList(res);
            } else {
                finalRes = RulesAvailableMapper.parseAuditToList(resAudits);
            }

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access parameter types ");
            LOGGER.debug("Exiting getCustomRulesByDecisionId Method in " + RuleConfiguratorServiceImpl.class
                    + " class with response  : unauthorized to access parameter types");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to access parameter types"),
                    HttpStatus.FORBIDDEN);
        }
        return ResponseEntity.ok(finalRes);
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public ResponseEntity<?> editNewDefaultRule(EditDefaultRuleRequest editDefaultRuleRequest, Authentication pr) throws JsonProcessingException {
        LOGGER.info("Edit rule request received");
        LOGGER.info(editDefaultRuleRequest.toString());
        // activityLogService.addActivity(loggedInUser, "rule sequence edit", editDefaultRuleRequest.toString());

        LOGGER.debug(
                "entered in class " + RuleConfiguratorServiceImpl.class + " in method editNewDefaultRule");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();

        Map<Integer, Integer> temp_id_saved = new HashMap<>();
        if (maxRule < editDefaultRuleRequest.getEditRule().size()) {
            LOGGER.info("\nParam : " + editDefaultRuleRequest);
            activityLogService.addActivity(loggedInUser, "failed to perform operation", editDefaultRuleRequest.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "No of rules should not exceed " + maxRule),
                    HttpStatus.BAD_REQUEST);
        }

        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        DecisionUi decisions = null;
        DecisionUiAudit decisionUiAudit = null;

        List<Integer> audit_rule_ids = editDefaultRuleRequest
                .getEditRule()
                .stream()
                .filter(a -> a.getRuleAuditID() != null)
                .map(a->a.getRuleAuditID())
                .toList();

        if(editDefaultRuleRequest.getAudit()) {
            boolean rules_exist = rulesTempAuditServiceImpl.findAuditEntryExist(editDefaultRuleRequest.getDecisionId(), editDefaultRuleRequest.getItenantId(), audit_rule_ids);
            if (!rules_exist) {
                LOGGER.info("\nParam : tenantid = ? , decidionid = ?" , editDefaultRuleRequest.getItenantId() , editDefaultRuleRequest.getDecisionId());
                activityLogService.addActivity(loggedInUser, "rules does not exist", editDefaultRuleRequest.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Audit entry already closed modification not allowed."),
                        HttpStatus.BAD_REQUEST);
            }
        }

        List<Rules> allActive = null;
        List<RulesAudit> allAudit = null;

        // finding all active by default decision id
        try {
            allActive = rulesTempService.findAllDefaultByIDecisionID(editDefaultRuleRequest.getDecisionId(), editDefaultRuleRequest.getItenantId());
            if (editDefaultRuleRequest.getAudit()) {
                allAudit = rulesTempAuditServiceImpl.findAllPending(editDefaultRuleRequest.getDecisionId(), editDefaultRuleRequest.getItenantId());
            }
        } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to add rule", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        Map<Integer, RuleAvailable> masterSequence = RulesAvailableMapper.parseToMap(allActive);
        Map<Integer, Boolean> auditEdit = new HashMap<>();
        Boolean add = false;
        Boolean edit = false;
        Boolean delete = false;

        for (int b = 0; b < editDefaultRuleRequest.getEditRule().size(); b++) {
            Integer auditid = editDefaultRuleRequest.getEditRule().get(b).getRuleAuditID();
            if (editDefaultRuleRequest.getEditRule().get(b).getRuleAuditID() != -1)
                temp_id_saved.put(auditid, auditid);
            if (editDefaultRuleRequest.getEditRule().get(b).getRuleID() != null) {
                RuleAvailable masterExist = masterSequence.get(editDefaultRuleRequest.getEditRule().get(b).getRuleID());

                if (masterExist != null) {

                    try {

                        if (!RuleDifferenceUtil.validate(masterExist, editDefaultRuleRequest.getEditRule().get(b))) {
                            edit = true;
                            auditEdit.put(editDefaultRuleRequest.getEditRule().get(b).getRuleID(), true);
                        }
                    } catch (Exception e) {
                        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                        LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to add rule", e.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                    masterSequence.remove(editDefaultRuleRequest.getEditRule().get(b).getRuleID());
                }
            } else {
                add = true;
            }
        }
        if (masterSequence.size() > 0) {
            delete = true;
        }

        if (add != mp.isAdd() && add) {
            activityLogService.addActivity(loggedInUser, "unauthorized to add default rules");
            LOGGER.debug("Exiting editNewDefaultRule Method in " + RuleConfiguratorServiceImpl.class
                    + " class with response  : unauthorized to add default rules");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to add default rules"),
                    HttpStatus.FORBIDDEN);
        }

        if (edit != mp.isEdit() && edit) {
            activityLogService.addActivity(loggedInUser, "unauthorized to edit default rules");
            LOGGER.debug("Exiting editNewDefaultRule Method in " + RuleConfiguratorServiceImpl.class
                    + " class with response  : unauthorized to edit default rules");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to edit default rules"),
                    HttpStatus.FORBIDDEN);
        }

        if (delete != mp.isDelete() && delete) {
            activityLogService.addActivity(loggedInUser, "unauthorized to delete default rules");
            LOGGER.debug("Exiting editNewDefaultRule Method in " + RuleConfiguratorServiceImpl.class
                    + " class with response  : unauthorized to delete default rules");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to delete default rules"),
                    HttpStatus.FORBIDDEN);
        }

        // validated maker remark
        if (editDefaultRuleRequest.getMakerRemark() != null) {
            if (editDefaultRuleRequest.getMakerRemark().isEmpty()
                    || editDefaultRuleRequest.getMakerRemark().isBlank()) {
                activityLogService.addActivity(loggedInUser, "failed to edit decision", editDefaultRuleRequest.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Maker remark cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "failed to edit decision", editDefaultRuleRequest.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Maker remark cannot be blank"),
                    HttpStatus.BAD_REQUEST);
        }

        // find audit decision entry
        try {
            decisions = decisionUiServiceImpl.findByiDecisionID(editDefaultRuleRequest.getDecisionId(), editDefaultRuleRequest.getItenantId());
            if (editDefaultRuleRequest.getAudit()) {
                    decisionUiAudit = decisionAuditServiceImpl
                            .findPendingDecisionByID(editDefaultRuleRequest.getDecisionId(), editDefaultRuleRequest.getItenantId());
            } else {
                decisionUiAudit = decisionAuditServiceImpl
                        .findPendingDecisionByID(editDefaultRuleRequest.getDecisionId(), editDefaultRuleRequest.getItenantId());
                if (decisionUiAudit != null) {
                    activityLogService.addActivity(loggedInUser, "failed to edit decision", editDefaultRuleRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Decision is already pending for action"),
                            HttpStatus.BAD_REQUEST);
                }
            }
        } catch (Exception e2) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            LOGGER.error("Error : " + e2 + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to transaction class", e2.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        // finding all active by default decision id
        // try {
        // allActive =
        // rulesTempService.findAllDefaultByIDecisionID(editDefaultRuleRequest.getDecisionId());
        // if (editDefaultRuleRequest.getAudit()) {
        // allAudit =
        // rulesTempAuditServiceImpl.findAllPending(editDefaultRuleRequest.getDecisionId());
        // }
        // } catch (Exception e) {
        // e.printStackTrace();
        // TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
        // LOGGER.error("Error : " + e + "\nParam : " + pr);
        // activityLogService.addActivity("failed to add rule", e.toString());
        // return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went
        // wrong"),
        // HttpStatus.INTERNAL_SERVER_ERROR);
        // }

        Pattern pattern = Pattern.compile("^[a-zA-Z0-9 ,_'/\\\\&><=+().:%@#-]+$");

        // validate rule name and rule description
        for (int b = 0; b < editDefaultRuleRequest.getEditRule().size(); b++) {

            //validate rule name
            if (editDefaultRuleRequest.getEditRule().get(b).getRuleName() != null) {
                if (editDefaultRuleRequest.getEditRule().get(b).getRuleName().isBlank()
                        || editDefaultRuleRequest.getEditRule().get(b).getRuleName().isEmpty()) {
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    LOGGER.error("Error : Blank rule name" + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to transaction class", "Blank rule name");
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Rule name cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
                else{
                    Matcher matcher = pattern.matcher(editDefaultRuleRequest.getEditRule().get(b).getRuleName());
                    if (!matcher.matches()) {
                        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                        LOGGER.error("Error : Invalid rule name" + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to transaction class", "Invalid rule name");
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Rule name can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), empty space, " +
"single inverted commas ('), forward slash (/), backward slash (\\), ampersand (&), greater than (>), " +
"less than (<), equals (=), plus (+), brackets (), colon (:), percentage (%), at symbol (@), hash (#), and dot (.)"
),
                                HttpStatus.BAD_REQUEST);
                    }
                }
            } else {
                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                LOGGER.error("Error : Blank rule name" + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to transaction class", "Blank rule name");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Rule name cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }

            //validate rule description
            if (editDefaultRuleRequest.getEditRule().get(b).getRuleDescription() != null) {
                if (editDefaultRuleRequest.getEditRule().get(b).getRuleDescription().isBlank()
                        || editDefaultRuleRequest.getEditRule().get(b).getRuleDescription().isEmpty()) {
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    LOGGER.error("Error : Blank rule description" + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to transaction class", "Blank rule description");
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Rule description cannot be blank"),
                            HttpStatus.BAD_REQUEST);
                }
                else{
                    Matcher matcher = pattern.matcher(editDefaultRuleRequest.getEditRule().get(b).getRuleDescription());
                    if (!matcher.matches()) {
                        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                        LOGGER.error("Error : Invalid rule description" + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to transaction class", "Invalid rule description");
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Rule description can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), empty space, " +
"single inverted commas ('), forward slash (/), backward slash (\\), ampersand (&), greater than (>), " +
"less than (<), equals (=), plus (+), brackets (), colon (:), percentage (%), at symbol (@), hash (#), and dot (.)"
),
                                HttpStatus.BAD_REQUEST);
                    }
                }
            } else {
                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                LOGGER.error("Error : Blank rule description" + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to transaction class", "Blank rule description");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Rule description cannot be blank"),
                        HttpStatus.BAD_REQUEST);
            }
        }

        // verifiing if any rule got deleted from master entries
        for (int s = 0; s < editDefaultRuleRequest.getEditRule().size(); s++) {
            for (int i = 0; i < allActive.size(); i++) {
                if (allActive.get(i).getIRuleID().equals(editDefaultRuleRequest.getEditRule().get(s).getRuleID())) {
                    allActive.remove(i);
                }
            }

        }

        // verifiing if any rule got deleted from audit
        if (allAudit != null) {
            for (int s = 0; s < editDefaultRuleRequest.getEditRule().size(); s++) {
                for (int i = 0; i < allAudit.size(); i++) {
                    if (allAudit.get(i).getIRuleIDAudit() == editDefaultRuleRequest.getEditRule().get(s)
                            .getRuleAuditID()) {
                        allAudit.remove(i);
                    }
                }

            }
        }

        // modify entries of deleted rule
        if (!editDefaultRuleRequest.getAudit()) {
            List<RulesAudit> parsedAudit = RulesAuditMapper.parseRuleTemp(allActive, editDefaultRuleRequest.getItenantId());

            parsedAudit = parsedAudit.stream().map(c -> {
                c.setBdelete(true);
                c.setBactive(false);
                return c;
            }).collect(Collectors.toList());

            for (int j = 0; j < parsedAudit.size(); j++) {
                try {
                    // rulesTempService.save(allActive.get(j));
                    parsedAudit.get(j).setDtEntryDatetime(ZonedDateTime.now());
                    parsedAudit.get(j).setDtEntryStamp(ZonedDateTime.now());
                    parsedAudit.get(j).setIEntryUserID(loggedInUser.getIuserID());
                    parsedAudit.get(j).setIorgId(loggedInUser.getIorgId());
                    parsedAudit.get(j).setVcAction("X");
                    parsedAudit.get(j).setItenantId(editDefaultRuleRequest.getItenantId());
                    parsedAudit.get(j).setVcRemark(editDefaultRuleRequest.getMakerRemark());

                    rulesTempAuditServiceImpl.saveAudit(parsedAudit.get(j));
                } catch (Exception e) {
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to transaction class", e.toString());
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
            }
        }
        else {
            allAudit = allAudit.stream().map(c -> {
                c.setBdelete(true);
                c.setBactive(false);
                return c;
            }).collect(Collectors.toList());

            for (int j = 0; j < allAudit.size(); j++) {
                try {
                    // rulesTempService.save(allActive.get(j));
                    allAudit.get(j).setDtEntryDatetime(ZonedDateTime.now());
                    allAudit.get(j).setDtEntryStamp(ZonedDateTime.now());
                    allAudit.get(j).setIEntryUserID(loggedInUser.getIuserID());
                    allAudit.get(j).setIorgId(loggedInUser.getIorgId());
                    allAudit.get(j).setVcAction("X");
                    allAudit.get(j).setItenantId(editDefaultRuleRequest.getItenantId());
                    allAudit.get(j).setVcRemark(editDefaultRuleRequest.getMakerRemark());
                    rulesTempAuditServiceImpl.saveAudit(allAudit.get(j));
                } catch (Exception e) {
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to transaction class", e.toString());
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
            }
        }


        // add new rules that were not added
        for (int e = 0; e < editDefaultRuleRequest.getEditRule().size(); e++) {
            RulesAudit savedRule = null;
            RulesAudit temp = new RulesAudit();
            if (editDefaultRuleRequest.getEditRule().get(e).getRuleAuditID() == -1) {

                Rules saved = new Rules();
                try {
                    if (editDefaultRuleRequest.getEditRule().get(e).getRuleID() != null
                            && editDefaultRuleRequest.getEditRule().get(e).getRuleID() != -1) {
                        // saved = rulesTempService
                        //         .findByiRuleID(editDefaultRuleRequest.getEditRule().get(e).getRuleID(), editDefaultRuleRequest.getItenantId());
                        temp.setIRuleID(editDefaultRuleRequest.getEditRule().get(e).getRuleID());
                    } else {
                        temp.setIRuleID(null);
                    }
                } catch (Exception e3) {
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    LOGGER.error("Error : " + e3 + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e3.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (editDefaultRuleRequest.getEditRule().get(e).getRuleID() != -1) {
                    if (auditEdit.containsKey(editDefaultRuleRequest.getEditRule().get(e).getRuleID())) {
                        temp.setVcAction("M");
                    } else {
                        temp.setVcAction("N");
                    }
                } else {
                    temp.setVcAction("A");
                }
                temp.setBclosed(false);
                temp.setIstatus(null);
                temp.setIEntryUserID(loggedInUser.getIuserID());
                temp.setIorgId(loggedInUser.getIorgId());
                temp.setDtEntryStamp(ZonedDateTime.now());
                temp.setVcRemark(editDefaultRuleRequest.getMakerRemark());
                temp.setBdelete(false);
                temp.setIdecisionID(editDefaultRuleRequest.getDecisionId());
                temp.setBcustom(true);
                temp.setVcRuleName(editDefaultRuleRequest.getEditRule().get(e).getRuleName());
                temp.setVcRuleDescription(editDefaultRuleRequest.getEditRule().get(e).getRuleDescription());
                temp.setVcRuleDetail(editDefaultRuleRequest.getEditRule().get(e).getRuleDetails());

                temp.setBactive(editDefaultRuleRequest.getEditRule().get(e).getActive());
                temp.setDtEntryDatetime(ZonedDateTime.now());
                temp.setIUserID(loggedInUser.getIuserID());
                temp.setIorgId(loggedInUser.getIorgId());
                temp.setItenantId(editDefaultRuleRequest.getItenantId());
                temp.setVcRuleParams(editDefaultRuleRequest.getEditRule().get(e).getRuleParam());
                temp.setIruleAvailableID(editDefaultRuleRequest.getEditRule().get(e).getAvailableRuleID());
                // if (editDefaultRuleRequest.getEditRule().get(e).getAvailableRuleID() != null) {
                //     try {
                //         temp.setIruleAvailableID(rulesAvailableUiService
                //                 .findById(editDefaultRuleRequest.getEditRule().get(e).getAvailableRuleID()));
                //     } catch (Exception e2) {
                //         TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                //         LOGGER.error("Error : " + e2 + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                //         activityLogService.addActivity("failed to get user and permissions", e2.toString());
                //         return new ResponseEntity<ApiResponse>(
                //                 new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                //                 HttpStatus.INTERNAL_SERVER_ERROR);
                //     }
                // } else {
                //     temp.setIruleAvailableID(null);
                // }

                temp.setVcLabel(editDefaultRuleRequest.getEditRule().get(e).getLabel());
                temp.setVcRuleDimension(editDefaultRuleRequest.getEditRule().get(e).getRuleDimension());
                temp.setVcRuleState(editDefaultRuleRequest.getEditRule().get(e).getRuleState());
                temp.setVcRuleType(editDefaultRuleRequest.getEditRule().get(e).getRuleType());
                temp.setIInstance(editDefaultRuleRequest.getEditRule().get(e).getInstance());
                temp.setVcRuleOrder(editDefaultRuleRequest.getEditRule().get(e).getVcruleorder());
                temp.setIVersion(editDefaultRuleRequest.getEditRule().get(e).getVersionID());
                try {
                    savedRule = rulesTempAuditServiceImpl.saveAudit(temp);
                } catch (Exception e1) {
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    LOGGER.error("Error : " + e1 + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to transaction class", e1.toString());
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                if (savedRule != null) {
                    Integer tempid = editDefaultRuleRequest.getEditRule().get(e).getTempRuleID();
                    temp_id_saved.put(tempid != null ? tempid :
                            !editDefaultRuleRequest.getAudit() ?
                                    savedRule.getIRuleID() : savedRule.getIRuleIDAudit(), savedRule.getIRuleIDAudit());
                    editDefaultRuleRequest.getEditRule().get(e).setRuleAuditID(savedRule.getIRuleIDAudit());
                }
            }
        }


        System.out.println(temp_id_saved);

        List<String> predif = new ArrayList<>();
        predif.add("StartRule");
        predif.add("FailedRule");
        predif.add("SuccessRule");
        // modify existing audit entries and set sequence
        for (int k = 0; k < editDefaultRuleRequest.getEditRule().size(); k++) {
            if (editDefaultRuleRequest.getEditRule().get(k).getRuleAuditID() != -1) {
                RulesAudit existAudit = null;

                try {
                    existAudit = rulesTempAuditServiceImpl
                            .findById(editDefaultRuleRequest.getEditRule().get(k).getRuleAuditID(), editDefaultRuleRequest.getItenantId());
                } catch (Exception e) {
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to transaction class", e.toString());
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (existAudit == null) {
                    LOGGER.error("RulesAudit record not found for ID: " + editDefaultRuleRequest.toString());
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, "RulesAudit not found"), HttpStatus.NOT_FOUND);
                }

                existAudit.setVcRuleName(editDefaultRuleRequest.getEditRule().get(k).getRuleName());
                existAudit.setBactive(editDefaultRuleRequest.getEditRule().get(k).getActive());
                existAudit.setVcRuleDescription(editDefaultRuleRequest.getEditRule().get(k).getRuleDescription());
                existAudit.setVcRuleParams(editDefaultRuleRequest.getEditRule().get(k).getRuleParam());
                existAudit.setVcRuleDetail(editDefaultRuleRequest.getEditRule().get(k).getRuleDetails());
                existAudit.setVcRuleState(editDefaultRuleRequest.getEditRule().get(k).getRuleState());
                existAudit.setIInstance(editDefaultRuleRequest.getEditRule().get(k).getInstance());
                existAudit.setVcRemark(editDefaultRuleRequest.getMakerRemark());
                existAudit.setIVersion(editDefaultRuleRequest.getEditRule().get(k).getVersionID());

                JSONObject ruleorderJSON = new JSONObject(editDefaultRuleRequest.getEditRule().get(k).getVcruleorder());
                System.out.println(ruleorderJSON.toString());

                Set<String> labels = ruleorderJSON.keySet();
                JSONObject resultnode = new JSONObject();
                for (String label : labels) {
                    if (label.equalsIgnoreCase("StartRule")) {
                        resultnode.put(label, 1);
                    } else {
                        if (ruleorderJSON.optInt(label) != -1) {
                            resultnode.put(label, temp_id_saved.get(ruleorderJSON.get(label)));
                        } else {
                            resultnode.put(label, -1);
                        }
                    }
                    if(existAudit.getVcAction().equalsIgnoreCase("N") &&
                            temp_id_saved.get(ruleorderJSON.get(label))!= ruleorderJSON.get(label) && editDefaultRuleRequest.getAudit()
                    )
                    {
                        existAudit.setVcAction("M");
                    }
                }
                existAudit.setVcRuleOrder(resultnode.toString());

                boolean isMultiPath = labels.stream().filter(a -> !predif.contains(a)).collect(Collectors.toList()).size() > 0;

                if (isMultiPath) {
                    JSONObject ruleparam = new JSONObject(existAudit.getVcRuleParams());
                    JSONObject values = ruleparam.getJSONObject("values");
                    values.put("ruleorder", resultnode);
                    ruleparam.put("values", values);
                    existAudit.setVcRuleParams(ruleparam.toString());
                    System.out.println(ruleparam.toString());
                }

                try {
                    rulesTempAuditServiceImpl.saveAudit(existAudit);
                } catch (Exception e) {
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to transaction class", e.toString());
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
            }
        }


        try {
            DecisionUiAudit saveAudit = new DecisionUiAudit();
            if (editDefaultRuleRequest.getAudit()) {
                decisionUiAudit.setBclosed(false);
                decisionUiAudit.setIstatus(null);
                decisionUiAudit.setVcRemark(editDefaultRuleRequest.getMakerRemark());
                decisionUiAudit.setVcAction("M");
                decisionUiAudit.setDtEntryStamp(ZonedDateTime.now());
                decisionUiAudit.setIEntryUserID(loggedInUser.getIuserID());
                decisionUiAudit.setIorgId(loggedInUser.getIorgId());
                decisionUiAudit.setIsApproved(true);
                decisionUiAudit.setItenantId(editDefaultRuleRequest.getItenantId());
                decisionAuditServiceImpl.saveAudit(decisionUiAudit);

            } else {
                saveAudit = DecisionVoMapper.parseToAudit(decisions);
                saveAudit.setDtEntryDatetime(ZonedDateTime.now());
                saveAudit.setDtEntryStamp(ZonedDateTime.now());
                saveAudit.setIEntryUserID(loggedInUser.getIuserID());
                saveAudit.setIorgId(loggedInUser.getIorgId());
                saveAudit.setVcRemark(editDefaultRuleRequest.getMakerRemark());
                saveAudit.setIsApproved(true);
                saveAudit = decisionAuditServiceImpl.saveAudit(saveAudit);
            }
        } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to transaction class", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        LOGGER.debug(
                "Exiting editNewDefaultRule Method in " + RuleConfiguratorServiceImpl.class
                        + " class with response  : with parameters type dropdown");
        activityLogService.addActivity(loggedInUser, "Rules edition sent for approval",
                "Parameters : " + editDefaultRuleRequest.toString());
        return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Rules edition sent for approval"),
                HttpStatus.CREATED);

    }

//    Integer getNextAuditRule(LinkedList<RuleAvailable> input, int Index) {
//        Integer output = null;
//
//        for (int s = Index + 1; s < input.size(); s++) {
//            if (input.get(s).getActive()) {
//                output = input.get(s).getRuleAuditID();
//                break;
//            }
//        }
//        return output;
//    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public ResponseEntity<?> approveRule(ApproveRuleRequest approveRuleRequest, Authentication pr) throws JsonProcessingException {
        LOGGER.debug(
                "entered in class " + RuleConfiguratorServiceImpl.class + " in method approveRule");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();


        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (!mp.isApprove()) {
            activityLogService.addActivity(loggedInUser, "unauthorized to approve rules");
            LOGGER.debug("Exiting approveRule Method in " + RuleConfiguratorServiceImpl.class
                    + " class with response  : unauthorized to add default rules");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to approve rules"),
                    HttpStatus.FORBIDDEN);
        }


        if (Optional.ofNullable(approveRuleRequest.getCheckerRemark()).orElse("").isBlank()) {
            LOGGER.error("Error: Checker remark cannot be blank. Param: {}", loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "Checker remark cannot be blank", approveRuleRequest.toString());
            return new ResponseEntity<>(new ApiResponse(false, "Checker remark cannot be blank"), HttpStatus.BAD_REQUEST);
        }

        DecisionUiAudit decisionUiAudit = null;
        try {
            decisionUiAudit = decisionAuditServiceImpl
                    .findPendingDecisionByID(approveRuleRequest.getDecisionid(), approveRuleRequest.getItenantId());
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        if (decisionUiAudit == null) {
            activityLogService.addActivity(loggedInUser, "No pending entries found with decision id");
            LOGGER.debug("Exiting approveRule Method in " + RuleConfiguratorServiceImpl.class
                    + " class with response  : No pending entries found with decision id");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "No pending entries found with decision id"),
                    HttpStatus.BAD_REQUEST);
        }

        Integer itenantId = decisionUiAudit.getItenantId();

        if (decisionUiAudit.getIEntryUserID() == loggedInUser.getIuserID()) {
            LOGGER.error("Error :  Maker cannot be checker \nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to get user and permissions", decisionUiAudit.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Maker cannot be checker"),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        List<RulesAudit> rulesTempAudits = null;
        try {
            // finding all pending rules for decision id
            rulesTempAudits = rulesTempAuditServiceImpl
                    .findPendingEntriesByDecisionID(approveRuleRequest.getDecisionid(), approveRuleRequest.getItenantId());
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        String successMessage = "";
        if (approveRuleRequest.getApprove()) {
            ResponseEntity<?> res = approveRuleFlow(rulesTempAudits, loggedInUser, approveRuleRequest, itenantId, pr);
            if (res != null) {
                return res;
            }
            decisionUiAudit.setIstatus(statusCodeService.findByIStatusId(3));
            successMessage = "approved";
        } else {
            StatusCode reject_status = statusCodeService.findByIStatusId(5);
            rulesTempAudits.stream()
                    .forEach(delete ->
                    {
                        delete.setBclosed(true);
                        delete.setDtApproverStamp(ZonedDateTime.now());
                        delete.setIstatus(reject_status);
                        delete.setVcRemark("{" + delete.getVcRemark() + "}" + "{"
                                + approveRuleRequest.getCheckerRemark() + "}");
                        delete.setIApproverUserID(loggedInUser.getIuserID());
                        delete.setIorgId(loggedInUser.getIorgId());
                        rulesTempAuditServiceImpl.saveAudit(delete);
                    });
            successMessage = "rejected";

        }

        decisionUiAudit.setBclosed(true);
        decisionUiAudit.setDtApproverStamp(ZonedDateTime.now());
        decisionUiAudit.setVcRemark("{" + decisionUiAudit.getVcRemark() + "}" + "{"
                + approveRuleRequest.getCheckerRemark() + "}");
        decisionUiAudit.setIApproverUserID(loggedInUser.getIuserID());
        decisionUiAudit.setIorgId(loggedInUser.getIorgId());
        decisionAuditServiceImpl.saveAudit(decisionUiAudit);
        try {
            DecisionUi approve = decisionUiServiceImpl
                    .findByiDecisionID(approveRuleRequest.getDecisionid(), approveRuleRequest.getItenantId());
            approve.setLastStatus(approveRuleRequest.getApprove() ? "Approved" : "Rejected");
            approve.setLatestRemark(approveRuleRequest.getCheckerRemark());
            approve.setDtApproverStamp(ZonedDateTime.now());
            approve.setIApproverUserID(loggedInUser.getIuserID());
            approve.setIorgId(loggedInUser.getIorgId());
            decisionUiServiceImpl.save(approve);
        } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to update decision", e.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        LOGGER.debug(
                "Exiting approveRUle Method in " + RuleConfiguratorServiceImpl.class
                        + " class with response  : with " + successMessage + " successfsully");
        activityLogService.addActivity(loggedInUser, "Rules edition " + successMessage + " successfully",
                "Parameters : " + rulesTempAudits.toString());
        return new ResponseEntity<ApiResponse>(
                new ApiResponse(true, "Rules edition " + successMessage + " successfully"),
                HttpStatus.ACCEPTED);


    }

    Integer getNextRule(LinkedList<Rules> input, int Index) {
        Integer output = null;
        if (Index + 1 == input.size())
            return null;

        for (int s = Index + 1; s < input.size(); s++) {
            if (input.get(s).isBactive()) {
                output = input.get(s).getIRuleID();
                break;
            }
        }
        return output;
    }

    @Override
    public ResponseEntity<?> getRuleLabels(Authentication pr) {
        LOGGER.debug(
                "entered in class " + RuleConfiguratorServiceImpl.class + " in method getRuleLabels");
        UserAndPermissions userAndPermissions = null;
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);


        if (mp.isView()) {

            List<String> res = null;
            List<DropdownWithObject> finalRes = new ArrayList<>();
            try {
                res = rulesAvailableService.findRuleLabels();
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            Set<Object> uniqueLabel = new HashSet<>();
            for (int i = 0; i < res.size(); i++) {
                org.json.JSONObject param = new org.json.JSONObject(res.get(i));
                List<Object> labellist = param.optJSONArray("label").toList();
                for (int g = 0; g < labellist.size(); g++) {
                    uniqueLabel.add(labellist.get(g));
                }
            }

            List<Object> uniqueLis = uniqueLabel.stream().collect(Collectors.toList());
            for (int v = 0; v < uniqueLis.size(); v++) {
                finalRes.add(DropdownWithObject.builder().label(uniqueLis.get(v)).value(uniqueLis.get(v)).build());
            }

            LOGGER.debug(
                    "Exiting getRuleLabels Method in " + RuleConfiguratorServiceImpl.class
                            + " class with response  : rule labels accessed successfully");
            activityLogService.addActivity(loggedInUser, "Rules labels accessed Successfully");
            return ResponseEntity.ok(finalRes);

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get labels");
            LOGGER.debug("Exiting getRuleLabels Method in " + RuleConfiguratorServiceImpl.class
                    + " class with response  : unauthorized to get labels");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get labels"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> getMetaDataAndObservations(Integer tenantid, String menuname, Authentication pr) {
        LOGGER.debug(
                "entered in class " + RuleConfiguratorServiceImpl.class + " in method getMetaDataAndObservations");
        UserAndPermissions userAndPermissions = null;

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menuname);


        if (mp.isView()) {

            List<MetadataUi> metaData = new ArrayList<>();
            List<ObservationsUi> observationsUi = new ArrayList<>();

            try {
                System.out.println("t1 " + System.currentTimeMillis());
                metaData = metadataUiService.findAllActiveMetadataTenants(Arrays.asList(tenantid));
                System.out.println("t2 " + System.currentTimeMillis());
                observationsUi = observationsUiService.findAllNonDeletedTenants(Arrays.asList(tenantid));
                System.out.println("t3 " + System.currentTimeMillis());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get list of metadata and observations", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            MetadataObservationsResponse responses = new MetadataObservationsResponse();

            List<MetadataResponse> list1 = new ArrayList<>();
            metaData.stream().map(md -> {
                ObjectMapper mapper = new ObjectMapper();
                JsonNode emptyPath = null;
                try {
                    emptyPath = mapper.readTree("[{\"Path\": \"\" }]");
                } catch (JsonProcessingException e) {
                    LOGGER.error("Error in parsing" + e);
                }
                list1.add(MetadataResponse.builder().vcpath(md.getVcpath())
                        .vcroot(md.getVcroot())
                        .path(md.getVcPrefix().equals(emptyPath) ? md.getVcpath()
                                : md.getVcroot() + "." + md.getVcpath())
                        .vcprefix(md.getVcPrefix())
                        .config(md.getConfig())
                        .description(md.getVcdescription())
                        .build());
                return null;
            }).collect(Collectors.toList());

            responses.setMetadata(list1);

            List<ObservationMeta> list2 = observationsUi.stream()
                    .map(obs -> {
                        ObservationMeta res = ObservationMeta.builder()
                                .name(obs.getOname())
                                .description(obs.getOdesc())
                                .build();
                        return res;
                    }).collect(Collectors.toList());
            responses.setObservations(list2);
            System.out.println("t4 " + System.currentTimeMillis());
            LOGGER.debug("Exiting getMetaDataAndObservations Method in "
                    + RuleConfiguratorServiceImpl.class
                    + " class with response  : with parameters list of metadata and observations");
            activityLogService.addActivity(loggedInUser, "List of metadata and observations accessed");

            return ResponseEntity.ok(responses);

        } else {

            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access metadata and observations list");
            LOGGER.debug("Exiting getMetaDataAndObservations Method in " + RuleConfiguratorServiceImpl.class
                    + " class with response  : unauthorized to access list of metadata and observations");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access list of metadata and observations"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> getAllRulesDataDecision(int iDecisionID, Boolean audit, Integer tenantid, Authentication pr) {
        LOGGER.debug("entered in class " + RuleConfiguratorServiceImpl.class + " in method getMetaDataAndObservations");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (!mp.isView()) {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access all rules data for a decision");
            LOGGER.debug("Exiting getAllRulesDataDecision Method in " + RuleConfiguratorServiceImpl.class
                    + " class with response  : unauthorized to access all rules data for a decision");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access rules data for a decision"),
                    HttpStatus.FORBIDDEN);
        }
        List<RuleAvailable> resAvailable = null;

        try {
            List<Rules> rules = rulesTempService.findAllDefaultByIDecisionID(iDecisionID, tenantid);
            RulesAvailableMapper RulesAvailableMapper = new RulesAvailableMapper();
            resAvailable = RulesAvailableMapper
                    .parse(rulesAvailableUiService.findAllActiveNonDeletedTenant(tenantid), rules);

        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(String.valueOf(iDecisionID)));
            activityLogService.addActivity(loggedInUser, "failed to get  available Rules", e.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.BAD_REQUEST);
        }

        LinkedList<RuleAvailable> resRuleSequence = null;
        try {
            if (!audit) {
                List<Rules> row = rulesTempService.getSequenceByiDecisionID(iDecisionID, tenantid);
                resRuleSequence = RulesAvailableMapper.parse(row);
            } else {
                List<RulesAudit> rowAudit = rulesTempAuditServiceImpl.getSequenceByiDecisionID(iDecisionID, tenantid);
                resRuleSequence = RulesAvailableMapper.parseToRulesTempAudit(rowAudit);
            }
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(String.valueOf(iDecisionID)));
            activityLogService.addActivity(loggedInUser, "failed to get rules sequence", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        List<String> response = null;
        try {
            response = rulesAvailableService.findRuleTypes();
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to get rule types", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
        List<DropdownWithObject> resModes = new ArrayList<>();

        response.stream().map(c -> resModes.add(DropdownWithObject.builder().label(c).value(c).build()))
                .collect(Collectors.toList());

        Map<String, Object> allResponse = new HashMap<>();
        allResponse.put("rulesAvailable", resAvailable);
        allResponse.put("ruleSequence", resRuleSequence);
        allResponse.put("modes", resModes);

        return ResponseEntity.ok(allResponse);
    }


    private ResponseEntity<?> approveRuleFlow(List<RulesAudit> rulesTempAudits, WebUser loggedInUser,
                                              ApproveRuleRequest approveRuleRequest, Integer itenantId,
                                              Authentication pr) {

        List<Rules> curently_active_rules = null;
        try {
            curently_active_rules = rulesTempService.findAllByIDecisionID(approveRuleRequest.getDecisionid(), approveRuleRequest.getItenantId());
        } catch (Exception e) {
            LOGGER.error("Error: {} \nParam: {}", e, loggerEncoderUtil.encode(approveRuleRequest.toString()));
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            activityLogService.addActivity(loggedInUser, "failed to fetch rules for decision", e.toString());
            return new ResponseEntity<>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        Map<Integer, Rules> rule_audit_id_to_rule_map = RulesAuditMapper.parseAudit(rulesTempAudits);

        Map<Integer, RulesAudit> rule_audit_id_to_audit_map = rulesTempAudits.stream()
                .collect(Collectors.toMap(RulesAudit::getIRuleIDAudit, Function.identity()));


        // save all audit rules
        for (RulesAudit audit : rulesTempAudits) {

            try {
                audit.setIApproverUserID(loggedInUser.getIuserID());
                audit.setIorgId(loggedInUser.getIorgId());
                audit.setBclosed(true);
                audit.setDtApproverStamp(ZonedDateTime.now());
                if (audit.getVcAction().equalsIgnoreCase("M")) {
                    audit.setIstatus(statusCodeService.findByIStatusId(3));
                } else if (audit.getVcAction().equalsIgnoreCase("A")) {
                    audit.setIstatus(statusCodeService.findByIStatusId(2));
                } else if (audit.getVcAction().equalsIgnoreCase("X")) {
                    audit.setIstatus(statusCodeService.findByIStatusId(5));
                }
                audit.setVcRemark("{" + audit.getVcRemark() + "}" + "{"
                        + approveRuleRequest.getCheckerRemark() + "}");
                rulesTempAuditServiceImpl.saveAudit(audit);
            } catch (Exception e) {
                LOGGER.error("Error: {} \nParam: {}", e, loggerEncoderUtil.encode(audit.toString()));
                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                activityLogService.addActivity(loggedInUser, "failed to save rule audit", e.toString());
                return new ResponseEntity<>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        }
        Map<Integer, String> rule_id_to_action_map = new HashMap<>();


        // saved newly added rules into ui schema and updated delete in ui schema
        for (Integer rule_audit_id : rule_audit_id_to_rule_map.keySet()) {
            Rules rule = rule_audit_id_to_rule_map.get(rule_audit_id);
            Rules saveTemp = null;
            RulesAudit rule_audit = rule_audit_id_to_audit_map.get(rule_audit_id);


            if (rule.getIRuleID() == null && !rule.isBdelete()) { // condition to add new rule
                try {
                    saveTemp = rulesTempService.saveAndGetSavedObject(rule);
                } catch (Exception e) {
                    LOGGER.error("Error: {} \nParam: {}", e, loggerEncoderUtil.encode(rule.toString()));
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    activityLogService.addActivity(loggedInUser, "failed to save rule", e.toString());
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (saveTemp != null) {
                    rule_id_to_action_map.put(saveTemp.getIRuleID(), rule_audit.getVcAction());
                    rule_audit_id_to_rule_map.put(rule_audit_id, saveTemp);
                }
            } else if (rule.isBdelete() && rule.getIRuleID() != null) // update deleted rule
            {
                rule.setDtApproverStamp(ZonedDateTime.now());
                rule.setIApproverUserID(loggedInUser.getIuserID());
                rule.setIorgId(loggedInUser.getIorgId());
                rule.setIstatus(statusCodeService.findByIStatusId(4).getIStatusIDForMaster());
                try {
                    saveTemp = rulesTempService.saveAndGetSavedObject(rule);
                } catch (Exception e) {
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    LOGGER.error("Error: {} \nParam: {}", e, loggerEncoderUtil.encode(rule.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                    return new ResponseEntity<>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                rule_audit_id_to_rule_map.put(rule_audit_id, saveTemp);
                rule_id_to_action_map.put(saveTemp.getIRuleID(), rule_audit.getVcAction());
            } else if (rule.getIRuleID() == null && rule.isBdelete()) {
                rule_audit_id_to_rule_map.remove(rule_audit_id);
            } else if (rule.getIRuleID() != null) {
                rule_id_to_action_map.put(rule.getIRuleID(), rule_audit.getVcAction());
            }

        }

        Map<Integer, Integer> rule_audit_id_to_rule_id_map = rule_audit_id_to_rule_map.entrySet().stream()
                .collect(Collectors.toMap(e -> e.getKey(), e -> e.getValue().getIRuleID()));

        List<String> predif = new ArrayList<>();
        predif.add("StartRule");
        predif.add("FailedRule");
        predif.add("SuccessRule");


//      modifying sequnce of rules to save in ui schema
        Map<Integer, Rules> rule_id_to_rule_map = new HashMap<>();
        System.out.println(rule_audit_id_to_rule_id_map);
        for (Integer rule_audit_id : rule_audit_id_to_rule_map.keySet()) {
            Rules rule = rule_audit_id_to_rule_map.get(rule_audit_id);
            rule_id_to_rule_map.put(rule.getIRuleID(), rule);
            if (!rule.isBdelete()) {


                JSONObject ruleorderJSON = new JSONObject(rule.getVcRuleOrder());
                System.out.println(ruleorderJSON.toString());
                Set<String> labels = ruleorderJSON.keySet();

                JSONObject resultnode = new JSONObject();
                for (String label : labels) {
                    if (label.equalsIgnoreCase("StartRule")) {
                        resultnode.put(label, 1);
                    } else {
                        if (ruleorderJSON.optInt(label) != -1) {
                            resultnode.put(label, rule_audit_id_to_rule_id_map.get(ruleorderJSON.get(label)));
                        } else {
                            resultnode.put(label, -1);
                        }
                    }
                }
                rule.setVcRuleOrder(resultnode.toString());
                System.out.println(resultnode.toString());
                boolean isMultiPath = labels.stream().anyMatch(a -> !predif.contains(a));

                if (isMultiPath) {
                    JSONObject ruleparam = new JSONObject(rule.getVcRuleParams());
                    JSONObject values = ruleparam.getJSONObject("values");
                    values.put("ruleorder", resultnode);
                    ruleparam.put("values", values);
                    rule.setVcRuleParams(ruleparam.toString());
                    System.out.println(ruleparam.toString());
                }

                rule.setIApproverUserID(loggedInUser.getIuserID());
                rule.setIorgId(loggedInUser.getIorgId());
                rule.setDtApproverStamp(ZonedDateTime.now());
                rule.setIstatus(statusCodeService.findByIStatusId(1).getIStatusIDForMaster());

                try {
                    rulesTempService.save(rule);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }
                rule_audit_id_to_rule_map.put(rule_audit_id, rule);
            }
        }

        List<Rules> add_rule_list = new ArrayList<>();
        List<Rules> edit_rule_list = new ArrayList<>();
        List<Rules> delete_rule_list = new ArrayList<>();

        Rules new_start_rule = null;
        Rules old_start_rule = null;

        // Rollback variables
        List<Rules> addedRulesRollback = new ArrayList<>();
        List<Rules> editedRulesRollback = new ArrayList<>();
        List<Rules> deletedRules = new ArrayList<>();

        ResponseEntity<String> res = null;
//        Map<Integer, Rules> currenlty_active_rule_id_to_rule_map = curently_active_rules
//                .stream()
//                .collect(Collectors.toMap(Rules::getIRuleID, rule -> rule));
        try {
            System.out.println("In new execution logic");

            for (Rules rule : curently_active_rules) {
                String old_rule_order = rule.getVcRuleOrder();
                JSONObject old_rule_order_json = new JSONObject(old_rule_order);
                if (old_rule_order_json.optInt("StartRule") == 1) {
                    old_start_rule = rule;
                    break;
                }
            }

            // First loop to process rules
            for (Rules rule_entry : rule_audit_id_to_rule_map.values()) {
                String rule_action = rule_id_to_action_map.get(rule_entry.getIRuleID());
                JSONObject updated_rule_order_json = new JSONObject(rule_entry.getVcRuleOrder());

                if (updated_rule_order_json.optInt("StartRule") == 1) {
                    String original_rule_order = rule_entry.getVcRuleOrder();
                    rule_entry.setVcRuleOrder("{\"StartRule\": 1, \"SuccessRule\": -1,\"FailedRule\": -1}");

                    switch (rule_action) {
                        case "A":
                            res = ruleApiServices.addRule(rule_entry, itenantId);
                            if (res.getStatusCode() != HttpStatus.OK) {
                                LOGGER.info("status code : {} \n response body : {} \n request body : {}", res.getStatusCode(), res.getBody(), rule_entry);
                                throw new Exception("Add StartRule failed");
                            }
                            break;
                        case "M":
                            res = ruleApiServices.editRule(rule_entry, itenantId);
                            if (res.getStatusCode() != HttpStatus.OK) {
                                LOGGER.info("status code : {} \n response body : {} \n request body : {}", res.getStatusCode(), res.getBody(), rule_entry);
                                throw new Exception("Edit StartRule failed");
                            }
                            break;
                        case "N":
                            res = ruleApiServices.editRule(rule_entry, itenantId);
                            if (res.getStatusCode() != HttpStatus.OK) {
                                LOGGER.info("status code : {} \n response body : {} \n request body : {}", res.getStatusCode(), res.getBody(), rule_entry);
                                throw new Exception("No change StartRule failed");
                            }
                            break;
                        case "X":
                            res = ruleApiServices.deleteRule(rule_entry, itenantId);
                            if (res.getStatusCode() != HttpStatus.OK) {
                                LOGGER.info("status code : {} \n response body : {} \n request body : {}", res.getStatusCode(), res.getBody(), rule_entry);
                                throw new Exception("Delete StartRule failed");
                            }
                            break;
                    }
                    rule_entry.setVcRuleOrder(original_rule_order);
                    new_start_rule = rule_entry;

                    if (old_start_rule != null) {
                        if (!Objects.equals(old_start_rule.getIRuleID(), rule_entry.getIRuleID())) {

                            String old_rule_action = rule_id_to_action_map.get(old_start_rule.getIRuleID());
                            Rules old_start_rule_updated_version = rule_id_to_rule_map.get(old_start_rule.getIRuleID());

                            switch (old_rule_action) {
                                case "M":
                                    res = ruleApiServices.editRule(old_start_rule_updated_version, itenantId);
                                    if (res.getStatusCode() != HttpStatus.OK) {
                                        LOGGER.info("status code : {} \n response body : {} \n request body : {}", res.getStatusCode(), res.getBody(), old_start_rule_updated_version);
                                        throw new Exception("Edit StartRule failed");
                                    }
                                    break;
                                case "X":
                                    res = ruleApiServices.deleteRule(old_start_rule_updated_version, itenantId);
                                    if (res.getStatusCode() != HttpStatus.OK) {
                                        LOGGER.info("status code : {} \n response body : {} \n request body : {}", res.getStatusCode(), res.getBody(), old_start_rule_updated_version);
                                        throw new Exception("Delete StartRule failed");
                                    }
                                    break;
                            }
                        }
                    }
                }
                else
                {
                    switch (rule_action) {
                        case "A":
                            add_rule_list.add(rule_entry);
                            break;
                        case "M":
                            edit_rule_list.add(rule_entry);
                            break;
                        case "X":
                            delete_rule_list.add(rule_entry);
                            break;
                    }
                }
            }

            for (Rules add : add_rule_list) {
                res = ruleApiServices.addRule(add, approveRuleRequest.getItenantId());
                if (res.getStatusCode() != HttpStatus.OK) {
                    LOGGER.info("status code : {} \n response body : {} \n request body : {}", res.getStatusCode(), res.getBody(), add);
                    throw new Exception("Add StartRule failed");
                }
                addedRulesRollback.add(add); // Track for API rollback
            }

            for (Rules edit : edit_rule_list) {
                res = ruleApiServices.editRule(edit, approveRuleRequest.getItenantId());
                if (res.getStatusCode() != HttpStatus.OK) {
                    LOGGER.info("status code : {} \n response body : {} \n request body : {}", res.getStatusCode(), res.getBody(), edit);
                    throw new Exception("Edit StartRule failed");
                }
                editedRulesRollback.add(edit); // Track for API rollback
            }

            for (Rules delete : delete_rule_list) {
                res = ruleApiServices.deleteRule(delete, approveRuleRequest.getItenantId());
                if (res.getStatusCode() != HttpStatus.OK) {
                    LOGGER.info("status code : {} \n response body : {} \n request body : {}", res.getStatusCode(), res.getBody(), delete);
                    throw new Exception("Edit StartRule failed");
                }
                deletedRules.add(delete); // Track for rollback
            }

            res = ruleApiServices.editRule(new_start_rule, itenantId);
            if (res.getStatusCode() != HttpStatus.OK) {
                LOGGER.info("status code : {} \n response body : {} \n request body : {}", res.getStatusCode(), res.getBody(), new_start_rule);
                throw new Exception("Edit StartRule failed");
            }
        } catch (Exception e) {

            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            LOGGER.error("Error: {} ", e);
            activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
            return new ResponseEntity<>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);

            // ROLLBACK LOGIC for API and DB
//            LOGGER.error("Error: " + e.getMessage());
//
//            try {
//                // Rollback added rules
//                for (Rules addedRule : addedRulesRollback) {
//                    try {
//                        ruleApiServices.deleteRule(addedRule, approveRuleRequest.getItenantId()); // Rollback added rule
//                    } catch (Exception rollbackException) {
//                        LOGGER.error("Error during rollback of added rule (ID: " + addedRule.getIRuleID() + "): " + rollbackException.getMessage());
//                    }
//                }
//                // Rollback modified rules to their original state
//                for (Rules modifiedRule : editedRulesRollback) {
//                    try {
//                        Rules originalRule = currenlty_active_rule_id_to_rule_map.get(modifiedRule.getIRuleID());
//                        ruleApiServices.editRule(originalRule, approveRuleRequest.getItenantId()); // Revert to previous state
//                    } catch (Exception rollbackException) {
//                        LOGGER.error("Error during rollback of modified rule (ID: " + modifiedRule.getIRuleID() + "): " + rollbackException.getMessage());
//                    }
//                }
//                // Rollback deleted rules to their original state
//                for (Rules deletedRule : deletedRules) {
//                    try {
//                        ruleApiServices.addRule(deletedRule, approveRuleRequest.getItenantId()); // Re-add deleted rule
//                    } catch (Exception rollbackException) {
//                        LOGGER.error("Error during rollback of deleted rule (ID: " + deletedRule.getIRuleID() + "): " + rollbackException.getMessage());
//                    }
//                }
//            } catch (Exception rollbackException) {
//                LOGGER.error("Error during API rollback: " + rollbackException.getMessage());
//            }
//            // Rethrow exception to trigger DB rollback via @Transactional
//            throw new RuntimeException("Failed to approve rules, rollback triggered", e);
        }
        return null;
    }

}
