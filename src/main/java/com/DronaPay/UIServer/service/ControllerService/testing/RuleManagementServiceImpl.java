package com.DronaPay.UIServer.service.ControllerService.testing;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.ResponseVO.*;
import com.DronaPay.UIServer.VOMapper.ParameterTypeVOMapper;
import com.DronaPay.UIServer.VOMapper.RuleVOMapper;
import com.DronaPay.UIServer.VOMapper.ViewParameterVOMapper;
import com.DronaPay.UIServer.model.DecisionUi;
import com.DronaPay.UIServer.model.Rules;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.requests.AddRuleRequest;
import com.DronaPay.UIServer.requests.ParameterRequset;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.response.RuleManagementResponse;
import com.DronaPay.UIServer.service.ControllerService.ListManagement.ListManagementServiceImpl;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.time.ZonedDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class RuleManagementServiceImpl implements RuleManagementService {

    private static final Logger LOGGER = LoggerFactory.getLogger(RuleManagementServiceImpl.class);
    final String menu_name = MenuNames.listManagement;
    @Autowired
    private ActivityLogService activityLogService;
    @Autowired
    private WebUserService webUserService;
    @Autowired
    private UserRoleMenuAccessService userRoleMenuAccessService;
    @Autowired
    private TransactionClassesService transactionClassesService;
    @Autowired
    private RulesTempServiceImpl rulesService;
    @Autowired
    private DecisionUiServiceImpl decisionService;
    @Autowired
    private ParameterService parameterService;

    //	@Autowired
//	private RulesAuditService rulesAuditService;
    @Autowired
    private ProductService productService;
    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Override
    public ResponseEntity<?> getRuleManagement(Authentication pr) {
        LOGGER.debug("entered in class " + RuleManagementServiceImpl.class + " in method getRuleManagement");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);
        // WebUser user = webUserService.loadUserByUsername(pr.getName());
        if (mp.isView()) {
            List<RuleManagementVO> voList = new ArrayList<>();

            // List<TransactionClasses> classesList = null;
            List<DecisionUi> decisionList = null;

            try {
                // classesList = transactionClassesService.findAll();
                // decisionList = decisionService.findAllActive();
                // System.out.println(decisionList);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get decision list", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            for (DecisionUi t : decisionList) {
                List<Rules> rules = null;
                // try {
                //     rules = rulesService.findAllByIDecisionID(t.getIDecisionID());
                // } catch (Exception e) {
                //     LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(String.valueOf(t.getIDecisionID())));
                //     activityLogService.addActivity("failed to get rules", e.toString());
                //     return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                //             HttpStatus.INTERNAL_SERVER_ERROR);
                // }
                for (Rules r : rules) {
                    try {
                        // voList.add(RuleManagementVOMapper.convert(r, t, mp, RuleVOMapper
                        //         .parse(rulesService.getSequenceByiDecisionID(t.getIDecisionID()), r)));
                        // voList.add(RuleManagementVO.convert(r, t, mp, RulesVO
                        // .parse(rulesService.getSequenceByiDecisionID(t.getIDecisionID().getIDecisionID()),
                        // r)));
                    } catch (Exception e) {
                        LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(String.valueOf(t.getIDecisionID())));
                        activityLogService.addActivity(loggedInUser, "failed to parse rule list", e.toString());
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                }
            }

            RuleManagementResponse response = new RuleManagementResponse();
            response.setAdd(mp.isAdd());
            response.setView(mp.isView());

            response.setRuleManagementVO(voList);
            LOGGER.debug("Exiting getRuleManagement Method in " + RuleManagementServiceImpl.class
                    + " class with response  : with parameters type list");
            activityLogService.addActivity(loggedInUser, "Rule List accessed");
            return ResponseEntity.ok(response);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access parameter types ");
            LOGGER.debug("Exiting getRuleManagement Method in " + RuleManagementServiceImpl.class
                    + " class with response  : unauthorized to access parameter types");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to access parameter types"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> getTransactionClassesAndDecision(Authentication pr) {

        LOGGER.debug(
                "entered in class " + RuleManagementServiceImpl.class + " in method getTransactionClassesAndDecision");
        // WebUser user = webUserService.loadUserByUsername(pr.getName());
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            List<DecisionUi> decisionList = new ArrayList<>();
            List<DecisionClassDropDown> responses = new ArrayList<>();
            try {
                // responses = ClassAndDecisionVO.parse(transactionClassesService.findAll());
                // responses =
                // ClassAndDecisionVOMapper.parse(transactionClassesService.findAll());
                // responses =
                // ClassAndDecisionVOMapper.parse(transactionClassesService.findAllActiveClasses());
                // decisionList = decisionService.findAllActive();
                decisionList.stream()
                        .map(d -> responses.add(DecisionClassDropDown.builder().label(d.getVcDecisionName())
                                .value(d.getIDecisionID()).prooductId(d.getIProductID().getIProductID()).build()))
                        .collect(Collectors.toList());
                LOGGER.debug("Exiting getTransactionClassesAndDecision Method in " + RuleManagementServiceImpl.class
                        + " class with response  : with parameters type dropdown");
                activityLogService.addActivity(loggedInUser, "Decision Dropdown  accessed");
                return ResponseEntity.ok(responses);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access parameter types ");
            LOGGER.debug("Exiting getTransactionClassesAndDecision Method in " + RuleManagementServiceImpl.class
                    + " class with response  : unauthorized to access parameter types");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to access parameter types"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> getParameterType(int iProductID, Authentication pr) {

        LOGGER.debug(
                "entered in class " + RuleManagementServiceImpl.class + " in method getParameterType");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            HashMap<String, List<ViewParameterVO>> temp = new HashMap<>();
            List<String> parameterTypes = parameterService.getAllParameterType(iProductID);

            for (String parameterType : parameterTypes) {
                temp.put(parameterType, ViewParameterVOMapper
                        .parse(parameterService.findAllByIProductIDAndvAndVcParameterType(iProductID, parameterType)));
                // temp.put(parameterType, ViewParameterVO
                // .parse(parameterService.findAllByIProductIDAndvAndVcParameterType(iProductID,
                // parameterType)));
            }
            // List<ParameterTypeVO> responses = ParameterTypeVO.parse(temp);
            List<ParameterTypeVO> responses = ParameterTypeVOMapper.parse(temp);
            LOGGER.debug("Exiting getParameterType Method in " + RuleManagementServiceImpl.class
                    + " class with response  : with parameters type");
            activityLogService.addActivity(loggedInUser, "Parameter types accessed", "Parameters : " + iProductID);
            return ResponseEntity.ok(responses);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access parameter types ");
            LOGGER.debug("Exiting getParameterType Method in " + RuleManagementServiceImpl.class
                    + " class with response  : unauthorized to access parameter types");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to access parameter types"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> getSequenceByiDecisionID(int iDecisionID, Authentication pr) {

        LOGGER.debug(
                "entered in class " + RuleManagementServiceImpl.class + " in method getSequenceByiDecisionID");
        // WebUser user = webUserService.loadUserByUsername(pr.getName());
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            Deque<Rules> row = new LinkedList<>();
            // try {
            //     row = rulesService.getSequenceByiDecisionID(iDecisionID);
            // } catch (Exception e) {
            //     LOGGER.error("Error : " + e + "\nParam : " + String.valueOf(iDecisionID));
            //     activityLogService.addActivity("failed to get rules sequence", e.toString());
            //     return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
            //             HttpStatus.INTERNAL_SERVER_ERROR);
            // }

            Rules tempLast = new Rules();
            tempLast.setVcRuleName("");
            tempLast.setVcRuleOrder("");
            tempLast.setBactive(false);
            // tempLast.setIRuleID(0);
            row.addLast(tempLast);
            List<RulesVO> response = RuleVOMapper.parse(row);
            LOGGER.debug("Exiting getSequenceByiDecisionID Method in " + RuleManagementServiceImpl.class
                    + " class with response  : with parameters type");
            activityLogService.addActivity(loggedInUser, "Rules sequence accessed", "Parameters : " + iDecisionID);
            return ResponseEntity.ok(response);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access parameter types ");
            LOGGER.debug("Exiting getSequenceByiDecisionID Method in " + RuleManagementServiceImpl.class
                    + " class with response  : unauthorized to access parameter types");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to access parameter types"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> getParameterType(ParameterRequset parameterRequset, Authentication pr) {

        LOGGER.debug(
                "entered in class " + RuleManagementServiceImpl.class + " in method getParameterType");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            List<ViewParameterVO> responses = ViewParameterVOMapper
                    .parse(parameterService.findAllByIProductIDAndvAndVcParameterType(parameterRequset.getIProductID(),
                            parameterRequset.getVcParameterType()));
            // List<ViewParameterVO> responses = ViewParameterVO
            // .parse(parameterService.findAllByIProductIDAndvAndVcParameterType(parameterRequset.getIProductID(),
            // parameterRequset.getVcParameterType()));
            LOGGER.debug("Exiting getParameterType Method in " + RuleManagementServiceImpl.class
                    + " class with response  : with parameters type");
            activityLogService.addActivity(loggedInUser, "Parameter types accessed", "Parameters : " + parameterRequset);
            return ResponseEntity.ok(responses);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access parameter types ");
            LOGGER.debug("Exiting getParameterType Method in " + RuleManagementServiceImpl.class
                    + " class with response  : unauthorized to access parameter types");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to access parameter types"),
                    HttpStatus.FORBIDDEN);
        }

    }

    @Override
    public ResponseEntity<?> addRule(AddRuleRequest addRuleRequest, Authentication pr) {

        LOGGER.debug(
                "entered in class " + RuleManagementServiceImpl.class + " in method addRule");
        // WebUser user = webUserService.loadUserByUsername(pr.getName());
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isAdd()) {
            Rules add = new Rules();
            add.setBcustom(true);
            add.setVcRuleDescription(addRuleRequest.getRuledescription());
            add.setVcRuleOrder("{\"FailedRule\": -1,\"SuccessRule\":-1}");
            add.setDtStartDate(addRuleRequest.getStartdate());
            add.setIVersion(0);
            add.setVcRuleParams(addRuleRequest.getParams());

            // duplicate rule name check
            try {
                List<Rules> rulelist = rulesService.findAll();
                String rname = addRuleRequest.getRulename();
                for (int i = 0; i < rulelist.size(); i++) {
                    // System.out.println(rulelist.get(i).getVcRuleName()+"=="
                    // +addRuleRequest.getRulename());
                    if (rulelist.get(i).getVcRuleName().equalsIgnoreCase(rname)) {
                        activityLogService.addActivity(loggedInUser, "Rule name is already taken ");
                        LOGGER.debug("Exiting addRule Method in " + RuleManagementServiceImpl.class
                                + " class with response  : failed to add rule");
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Rule name already exist"),
                                HttpStatus.CONFLICT);
                    }
                }
            } catch (Exception e1) {
                LOGGER.error("Error : " + e1);
                activityLogService.addActivity(loggedInUser, "failed to get rules", e1.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (addRuleRequest.getRulename() != null) {
                if (!addRuleRequest.getRulename().isEmpty()) {
                    add.setVcRuleName(addRuleRequest.getRulename());
                } else {
                    activityLogService.addActivity(loggedInUser, "failed to add rule because rule name is not provided ",
                            " Parameters :" + addRuleRequest.toString());
                    LOGGER.debug("Exiting addRule Method in " + RuleManagementServiceImpl.class
                            + " class with response  : failed to add rule");
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please Enter Rule Name"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                activityLogService.addActivity(loggedInUser, "failed to add rule because rule name is not provided ",
                        " Parameters :" + addRuleRequest.toString());
                LOGGER.debug("Exiting addRule Method in " + RuleManagementServiceImpl.class
                        + " class with response  : failed to add rule");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please Enter Rule Name"),
                        HttpStatus.BAD_REQUEST);
            }

            add.setDtEntryDatetime(ZonedDateTime.now());
            add.setBactive(addRuleRequest.getActive());
            add.setIUserID(loggedInUser.getIuserID());
            add.setIorgId(loggedInUser.getIorgId());
            if (addRuleRequest.getRuledetail() != null) {
                if (!addRuleRequest.getRuledetail().isEmpty()) {
                    add.setVcRuleDetail(addRuleRequest.getRuledetail());
                } else {
                    activityLogService.addActivity(loggedInUser, "failed to add rule because rule is not correct ",
                            " Parameters :" + addRuleRequest.toString());
                    LOGGER.debug("Exiting addRule Method in " + RuleManagementServiceImpl.class
                            + " class with response  : Bad Request");
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please enter correct rule"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                activityLogService.addActivity(loggedInUser, "failed to add rule because rule is not correct ",
                        " Parameters :" + addRuleRequest.toString());
                LOGGER.debug("Exiting addRule Method in " + RuleManagementServiceImpl.class
                        + " class with response  : Bad Request");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please enter rule"),
                        HttpStatus.BAD_REQUEST);
            }

            // try {
            // add.setIProductID(productService.findByiProductID(addRuleRequest.getProductid()));
            // } catch (Exception e) {
            // e.printStackTrace();
            // LOGGER.error("Error : " + e.toString() + ", Parameters : " + addRuleRequest);
            // activityLogService.addActivity(user, "failed to add rule ",
            // "Error : " + e.toString() + ", Parameters : " + addRuleRequest.toString());
            // return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went
            // wrong"),
            // HttpStatus.INTERNAL_SERVER_ERROR);
            // }
            try {
                add.setIdecisionID(addRuleRequest.getDecisionid());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(String.valueOf(addRuleRequest.getDecisionid())));
                activityLogService.addActivity(loggedInUser, "failed to set idecisionID", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            Rules saved = new Rules();

            try {
                saved = rulesService.saveAndGetSavedObject(add);
                // System.out.println(saved);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(add.toString()));
                activityLogService.addActivity(loggedInUser, "failed to set idecisionID", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (addRuleRequest.getSequence().size() > 1) {
                List<RulesVO> unfilteredSequence = addRuleRequest.getSequence();

                List<RulesVO> sequence = new ArrayList<>();
                for (RulesVO iteration : unfilteredSequence) {

                    sequence.add(iteration);

                }

                int i = 0;
                for (RulesVO iteration : sequence) {
                    if (iteration.getId() == 0) {
                        RulesVO next = null;
                        try {
                            next = sequence.get(i + 1);
                        } catch (IndexOutOfBoundsException e) {
                            // LOGGER.error("Error : " + e + "\nParam : " + i);
                            // activityLogService.addActivity("failed to set idecisionID", e.toString());
                            // return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went
                            // wrong"),
                            // HttpStatus.INTERNAL_SERVER_ERROR);
                        }

                        if (next != null) {

                            saved.setVcRuleOrder("{\"FailedRule\": -1,\"SuccessRule\":" + next.getId() + "}");
                            try {
                                rulesService.save(saved);
                            } catch (Exception e) {
                                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(saved.toString()));
                                activityLogService.addActivity(loggedInUser, "failed to save rule", e.toString());
                                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }
                        } else {
                            saved.setVcRuleOrder("{\"FailedRule\": -1,\"SuccessRule\":-1}");
                            try {
                                rulesService.save(saved);
                            } catch (Exception e) {
                                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(saved.toString()));
                                activityLogService.addActivity(loggedInUser, "failed to save rule", e.toString());
                                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                            }
                        }
                    } else {
                        Rules rule = null;
                        try {
                            rule = rulesService.findByiRuleID(iteration.getId(), addRuleRequest.getItenantId());
                        } catch (Exception e) {
                            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(String.valueOf(iteration.getId())));
                            activityLogService.addActivity(loggedInUser, "failed to get rule", e.toString());
                            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }

                        if (rule != null) {
                            RulesVO next = null;
                            try {
                                next = sequence.get(i + 1);
                            } catch (IndexOutOfBoundsException e) {
                                // LOGGER.error("Error : " + e + "\nParam : " + i);
                                // activityLogService.addActivity("failed to set idecisionID", e.toString());
                                // return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went
                                // wrong"),
                                // HttpStatus.INTERNAL_SERVER_ERROR);
                            }

                            if (next != null) {

                                // System.out.println(next);
                                Object obj = JSONValue.parse(iteration.getOrder());
                                JSONObject jsonObject = (JSONObject) obj;
                                jsonObject.replace("SuccessRule",
                                        (next.getId() == 0 ? saved.getIRuleID() : next.getId()));
                                // System.out.println(jsonObject.toJSONString());
                                rule.setVcRuleOrder(jsonObject.toJSONString());
                                try {

                                    rulesService.save(rule);
                                } catch (Exception e) {
                                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(rule.toString()));
                                    activityLogService.addActivity(loggedInUser, "failed to save rule", e.toString());
                                    return new ResponseEntity<ApiResponse>(
                                            new ApiResponse(false, "something went wrong"),
                                            HttpStatus.INTERNAL_SERVER_ERROR);
                                }
                            } else {
                                rule.setVcRuleOrder("{\"FailedRule\": -1,\"SuccessRule\":-1}");
                                try {
                                    // System.out.println(rule.getVcRuleOrder() +rule.getIRuleID());
                                    rulesService.save(rule);
                                } catch (Exception e) {
                                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(rule.toString()));
                                    activityLogService.addActivity(loggedInUser, "failed to save rule", e.toString());
                                    return new ResponseEntity<ApiResponse>(
                                            new ApiResponse(false, "something went wrong"),
                                            HttpStatus.INTERNAL_SERVER_ERROR);
                                }
                            }
                        } else {
                            LOGGER.debug("Exiting addRule Method in " + RuleManagementServiceImpl.class
                                    + " class with response  : failed to add rule");
                            activityLogService.addActivity(loggedInUser, "failed to add rule because rule does not exist ",
                                    "Parameters : " + addRuleRequest.toString());
                            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Rule does not exist"),
                                    HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                    }

                    i++;
                    // System.out.println(i);
                }

            }
            LOGGER.debug("Exiting getParameterType Method in " + ListManagementServiceImpl.class
                    + " class with response  : with parameters type dropdown");

            activityLogService.addActivity(loggedInUser, "rule added successfully ",
                    "Parameters : " + addRuleRequest.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Rule added successfully"), HttpStatus.OK);
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access parameter types ");
            LOGGER.debug("Exiting addRule Method in " + RuleManagementServiceImpl.class
                    + " class with response  : unauthorized to access parameter types");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to access parameter types"),
                    HttpStatus.FORBIDDEN);
        }

    }

//	@Override
//	public ResponseEntity<?> editRule(EditRuleRequest editRuleRequest, Authentication pr) {
//
//		LOGGER.debug(
//				"entered in class " + RuleManagementServiceImpl.class + " in method editRule");
//		// WebUser user = webUserService.loadUserByUsername(pr.getName());
//		UserAndPermissions userAndPermissions = null;
//		try {
//			userAndPermissions = webUserService.getUserAndPermissions(pr.getName(), MenuNames.listManagement);
//		} catch (Exception e) {
//			LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
//			activityLogService.addActivity("failed to get user and permissions", e.toString());
//			return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
//					HttpStatus.INTERNAL_SERVER_ERROR);
//		}
//
//		WebUser user = userAndPermissions.getUser();
//		MenuPermissions mp = userAndPermissions.getPermissions();
//
//		if (mp.isEdit()) {
//			Rules edit = null;
//			try {
//				edit = rulesService.findByiRuleID(editRuleRequest.getId());
//				rulesAuditService.save(RulesAuditMapper.parse(edit));
//			} catch (Exception e) {
//				LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(editRuleRequest.toString()));
//				activityLogService.addActivity("failed to save rule", e.toString());
//				return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong 1"),
//						HttpStatus.INTERNAL_SERVER_ERROR);
//			}
//			edit.setBcustom(true);
//			edit.setVcRuleDescription(editRuleRequest.getRuledescription());
//			edit.setDtStartDate(editRuleRequest.getStartdate());
//			edit.setVcRuleParams(editRuleRequest.getParams());
//			if (editRuleRequest.getRulename() != null) {
//				if (!editRuleRequest.getRulename().isEmpty()) {
//					edit.setVcRuleName(editRuleRequest.getRulename());
//				} else {
//					LOGGER.debug("Exiting editRule Method in " + RuleManagementServiceImpl.class
//							+ " class with response  : failed to edit rule");
//					activityLogService.addActivity(user, "failed to edit rule because rule name not provided ",
//							" Parameters : " + editRuleRequest.toString());
//					return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Please Enter Rule Name"),
//							HttpStatus.BAD_REQUEST);
//				}
//
//			} else {
//				LOGGER.debug("Exiting editRule Method in " + RuleManagementServiceImpl.class
//						+ " class with response  : failed to edit rule");
//				activityLogService.addActivity(user, "failed to edit rule because rule name not provided ",
//						" Parameters : " + editRuleRequest.toString());
//				return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Please Enter Rule Name"),
//						HttpStatus.BAD_REQUEST);
//			}
//
//			edit.setDtEntryDatetime(ZonedDateTime.now());
//			edit.setBactive(editRuleRequest.getActive());
//			edit.setIUserID(user);
//			if (editRuleRequest.getRuledetail() != null) {
//				if (!editRuleRequest.getRuledetail().isEmpty()) {
//					edit.setVcRuleDetail(editRuleRequest.getRuledetail());
//				} else {
//					LOGGER.debug("Exiting editRule Method in " + RuleManagementServiceImpl.class
//							+ " class with response  : failed to edit rule");
//					activityLogService.addActivity(user, "failed to edit rule because rule is not correct ",
//							" Parameters : " + editRuleRequest.toString());
//					return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please enter correct rule"),
//							HttpStatus.BAD_REQUEST);
//				}
//			} else {
//				LOGGER.debug("Exiting editRule Method in " + RuleManagementServiceImpl.class
//						+ " class with response  : failed to edit rule");
//				activityLogService.addActivity(user, "failed to edit rule because rule not provided ",
//						" Parameters : " + editRuleRequest.toString());
//				return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please enter rule"),
//						HttpStatus.BAD_REQUEST);
//			}
//
//			try {
//				rulesService.saveAndGetSavedObject(edit);
//			} catch (Exception e) {
//				LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(edit.toString()));
//				activityLogService.addActivity("failed to save rule", e.toString());
//				return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong 2"),
//						HttpStatus.INTERNAL_SERVER_ERROR);
//			}
//
//			if (editRuleRequest.getSequence().size() > 1) {
//				List<RulesVO> unfilteredSequence = editRuleRequest.getSequence();
//
//				List<RulesVO> sequence = new ArrayList<>();
//				for (RulesVO iteration : unfilteredSequence) {
//					if (iteration.getActive()) {
//						sequence.add(iteration);
//					}
//				}
//
//				int i = 0;
//				for (RulesVO iteration : sequence) {
//
//					Rules rule = null;
//					try {
//						rule = rulesService.findByiRuleID(iteration.getId());
//						rulesAuditService.save(RulesAuditMapper.parse(rule));
//					} catch (Exception e) {
//						LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(String.valueOf(iteration.getId())));
//						activityLogService.addActivity(user, "failed to edit rule ",
//								"Error : " + e.toString() + ", Parameters : " + editRuleRequest.toString());
//						return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong 22"),
//								HttpStatus.INTERNAL_SERVER_ERROR);
//					}
//
//					if (rule != null) {
//						RulesVO next = null;
//						try {
//							next = sequence.get(i + 1);
//						} catch (IndexOutOfBoundsException e) {
//							// LOGGER.error("Error : " + e + "\nParam : " + i);
//							// activityLogService.addActivity(user, "failed to edit rule ",
//							// "Error : " + e.toString());
//							// return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went
//							// wrong"),
//							// HttpStatus.INTERNAL_SERVER_ERROR);
//
//						}
//						if (next != null) {
//							Object obj = JSONValue.parse(iteration.getOrder());
//							JSONObject jsonObject = (JSONObject) obj;
//							jsonObject.replace("SuccessRule", next.getId());
//							rule.setVcRuleOrder(jsonObject.toJSONString());
//							try {
//								rulesService.save(rule);
//							} catch (Exception e) {
//								LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(rule.toString()));
//								activityLogService.addActivity(user, "failed to edit rule ",
//										"Error : " + e.toString() + ", Parameters : " + rule.toString());
//								return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong 3"),
//										HttpStatus.INTERNAL_SERVER_ERROR);
//
//							}
//						} else {
//							rule.setVcRuleOrder("{\"FailedRule\": -1,\"SuccessRule\":-1}");
//							try {
//								rulesService.save(rule);
//							} catch (Exception e) {
//								LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(rule.toString()));
//								activityLogService.addActivity(user, "failed to edit rule ",
//										"Error : " + e.toString() + ", Parameters : " + rule.toString());
//								return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong 4"),
//										HttpStatus.INTERNAL_SERVER_ERROR);
//							}
//						}
//					} else {
//						LOGGER.debug("Exiting editRule Method in " + RuleManagementServiceImpl.class
//								+ " class with response  : failed to edit rule");
//						activityLogService.addActivity(user, "failed to edit rule ",
//								" Parameters : " + editRuleRequest.toString());
//						return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong 5"),
//								HttpStatus.INTERNAL_SERVER_ERROR);
//					}
//					i++;
//				}
//
//			}
//			LOGGER.debug("Exiting editRule Method in " + RuleManagementServiceImpl.class
//					+ " class with response  : rule edited successfully");
//			activityLogService.addActivity(user, "rule edited successfully ",
//					"Parameters : " + editRuleRequest.toString());
//			return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Rule edited successfully"), HttpStatus.OK);
//		} else {
//			activityLogService.addActivity(user, "unauthorized to access parameter types ");
//			LOGGER.debug("Exiting editRule Method in " + RuleManagementServiceImpl.class
//					+ " class with response  : unauthorized to access parameter types");
//			return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to access parameter types"),
//					HttpStatus.FORBIDDEN);
//		}
//		// WebUser user = webUserService.loadUserByUsername(pr.getName());
//
//	}

    @Override
    public ResponseEntity<?> deleteRule(Integer iRuleID, Authentication pr) {

        LOGGER.debug(
                "entered in class " + RuleManagementServiceImpl.class + " in method deleteRule");
        // WebUser user = webUserService.loadUserByUsername(pr.getName());
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isDelete()) {
            Rules deleteRule = null;
            // New try catch added 1 jan 2022
            try {
                ////not used anymore so passing dummy value for tenantid
                deleteRule = rulesService.findByiRuleID(iRuleID, 0);
            } catch (Exception e1) {
                LOGGER.error("Error : " + e1 + "\nParam : " + loggerEncoderUtil.encode(String.valueOf(iRuleID)));
                activityLogService.addActivity(loggedInUser, "failed to delete rule because rule does not exist",
                        " Parameters : {iRuleID :" + iRuleID + "}");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Selected rule does not exist please select valid one"),
                        HttpStatus.BAD_REQUEST);
            }
            if (deleteRule != null) {
                if (deleteRule.isBactive() == false) {
                    deleteRule.setBdelete(true);
                    try {
                        rulesService.save(deleteRule);
                        LOGGER.debug("Exiting deleteRule Method in " + RuleManagementServiceImpl.class
                                + " class with response  : rule deleted successfully");
                        activityLogService.addActivity(loggedInUser, "rule deleted successfully ",
                                "Parameters : {iRuleID :" + iRuleID + "}");
                        return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Rule Deleted Successfully"),
                                HttpStatus.OK);
                    } catch (Exception e) {
                        LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(deleteRule.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to delete rule ",
                                "Error : " + e.toString() + ", Parameters : {iRuleID :" + iRuleID + "}");
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                } else {
                    LOGGER.debug("Exiting deleteRule Method in " + RuleManagementServiceImpl.class
                            + " class with response  : failed to delete rule");
                    activityLogService.addActivity(loggedInUser, "failed to delete rule because rule is not deactivated",
                            " Parameters : {iRuleID :" + iRuleID + "}");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Selected rule is active please deactivate first"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                LOGGER.debug("Exiting deleteRule Method in " + RuleManagementServiceImpl.class
                        + " class with response  : failed to delete rule");
                activityLogService.addActivity(loggedInUser, "failed to delete rule because rule does not exist",
                        " Parameters : {iRuleID :" + iRuleID + "}");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Selected rule does not exist please select valid one"),
                        HttpStatus.BAD_REQUEST);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access parameter types ");
            LOGGER.debug("Exiting deleteRule Method in " + RuleManagementServiceImpl.class
                    + " class with response  : unauthorized to access parameter types");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to access parameter types"),
                    HttpStatus.FORBIDDEN);
        }
        // Rules deleteRule = null;

    }

    @Override
    public ResponseEntity<?> getParameterType(String rule, Authentication pr) {

        LOGGER.debug(
                "entered in class " + RuleManagementServiceImpl.class + " in method getParameterType");
        // WebUser user = webUserService.loadUserByUsername(pr.getName());
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            if (rule != null) {
                if (!rule.isEmpty()) {
                    LOGGER.debug("Exiting getParameterType Method in " + RuleManagementServiceImpl.class
                            + " class with response  : code executed successfully");
                    activityLogService.addActivity(loggedInUser, "python code executed successfully ",
                            " Parameters : {rule :" + rule + "}");
                    return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Code Executed"), HttpStatus.OK);
                } else {
                    LOGGER.debug("Exiting getParameterType Method in " + RuleManagementServiceImpl.class
                            + " class with response  : failed to execute code");
                    activityLogService.addActivity(loggedInUser, "failed to rule because rule is empty",
                            " Parameters : {rule :" + rule + "}");
                    return new ResponseEntity<ApiResponse>(new ApiResponse(false, "rule cannot be empty"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                LOGGER.debug("Exiting getParameterType Method in " + RuleManagementServiceImpl.class
                        + " class with response  : failed to execute code");
                activityLogService.addActivity(loggedInUser, "failed to rule because rule is null",
                        " Parameters : {rule :" + rule + "}");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Rule cannot be null"),
                        HttpStatus.BAD_REQUEST);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access parameter types ");
            LOGGER.debug("Exiting getParameterType Method in " + RuleManagementServiceImpl.class
                    + " class with response  : unauthorized to access parameter types");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to access parameter types"),
                    HttpStatus.FORBIDDEN);
        }

    }

    // Default Rule Method
    @Override
    public ResponseEntity<?> getRulesByIDecisionId(Integer iDecisionId, Authentication pr) {
        WebUser user = webUserService.loadUserByUsername(pr.getName());

        List<Rules> row = new ArrayList<Rules>();
        try {
            row = rulesService.findAllDefaultRulesByClass(iDecisionId);
        } catch (Exception e) {
            LOGGER.error(loggerEncoderUtil
                    .encode("Error : " + e.toString() + ", Parameters : {iProductID :" + iDecisionId + "}"));
            activityLogService.addActivity(user, "failed to get default rule list ",
                    "Error : " + e.toString() + ", Parameters : {iProductID :" + iDecisionId + "}");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return ResponseEntity.ok(row);

    }

    @Override
    public ResponseEntity<?> editDefaultRule(Integer iRuleId, String vcParam, Authentication pr) {
        WebUser user = webUserService.loadUserByUsername(pr.getName());

        Rules editJson = null;
        // New try catch added 1 jan 2022
        try {
            //not used anymore so adding dummy tenantid 0
            editJson = rulesService.findByiRuleID(iRuleId, 0);
        } catch (Exception e1) {
            activityLogService.addActivity(user, "failed to get default rule because rule does not exist",
                    " Parameters : {iRuleID :" + iRuleId + "}");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Selected rule does not exist please select valid one"),
                    HttpStatus.BAD_REQUEST);
        }

        try {
            editJson.setVcRuleParams(vcParam);
            activityLogService.addActivity(user, "Default rule editet successfully ",
                    "Parameters : {iRuleID :" + iRuleId + "}");
            return new ResponseEntity<ApiResponse>(new ApiResponse(true, "Parameters Edited Successfully"),
                    HttpStatus.OK);
        } catch (Exception e1) {
            activityLogService.addActivity(user, "failed to add default rule because rule does not exist",
                    " Parameters : {iRuleID :" + iRuleId + "}");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Selected rule does not exist please select valid one"),
                    HttpStatus.BAD_REQUEST);
        }

    }

}
