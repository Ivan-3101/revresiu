package com.DronaPay.UIServer.util;

import com.DronaPay.UIServer.service.RepositoryService.ListReplicaServiceImpl;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.DronaPay.UIServer.model.DecisionUi;
import com.DronaPay.UIServer.model.Rules;
import com.DronaPay.UIServer.response.ApiResponse;
import org.springframework.http.ResponseEntity;
import com.fasterxml.jackson.databind.JsonNode;
import java.util.Map;
import java.util.HashMap;
import java.util.Arrays;
import java.util.ArrayList;
import org.springframework.security.core.Authentication;
import org.springframework.http.HttpStatus;
import org.springframework.beans.factory.annotation.Autowired;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

import java.time.ZonedDateTime;
import java.util.List;
import com.DronaPay.UIServer.service.RepositoryService.DecisionUiService;
import com.DronaPay.UIServer.service.RepositoryService.RulesTempServiceImpl;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.DronaPay.UIServer.service.RepositoryService.ActivityLogService;
import com.DronaPay.UIServer.model.WebUser;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@Getter
@Setter
@NoArgsConstructor
public class ListValidationUtil {

    private LoggerEncoderUtil loggerEncoderUtil;
    private ActivityLogService activityLogService;
    private DecisionUiService decisionService;
    private RulesTempServiceImpl rulesTempService;
    private ListReplicaServiceImpl listReplicaService;
    private String message;
    private Boolean success;
    final Logger LOGGER = LogManager.getLogger(ListValidationUtil.class);

    public ListValidationUtil(ListReplicaServiceImpl listReplicaService) {
        this.listReplicaService = listReplicaService;
    }

    public ListValidationUtil(ActivityLogService activityLogService, LoggerEncoderUtil loggerEncoderUtil, DecisionUiService decisionService, RulesTempServiceImpl rulesTempService) {
        this.activityLogService = activityLogService;
        this.loggerEncoderUtil = loggerEncoderUtil;
        this.decisionService = decisionService;
        this.rulesTempService = rulesTempService;
    }


    public void DoValdiations(String vcfield, String vcvalue, Integer ilistType, ZonedDateTime dtEffectiveFromOrg,
                              ZonedDateTime expireAt, Integer itenantid, String attrib, boolean ui) {
        this.message = null;
        this.success = true;

        // Add 1 day to dtEffectiveFrom
        ZonedDateTime dtEffectiveFrom = dtEffectiveFromOrg.plusDays(1);

        List<Integer> listTypes = new ArrayList<>();
        listTypes.add(ilistType);

        Integer existing =
                listReplicaService.findOverlappingEntriesWithoutAttribs(vcfield,
                        vcvalue, listTypes,
                        dtEffectiveFrom,
                        expireAt,
                        itenantid,
                        ui);
        if (existing > 0) {
            this.message = "Active list already present for other list type.";
            this.success = false;
        }
        if (!this.success) return;
        if (ilistType == 2) {
            List<Integer> action = new ArrayList<>();

            ObjectMapper obj2 = new ObjectMapper();
            JsonNode att;
            try {
                att = obj2.readTree(attrib);
                JsonNode act = att.get("action");
                if (act != null && act.isArray()) {
                    for (JsonNode node : act) {
                        if (node.isInt()) {
                            action.add(node.asInt());
                        }
                    }

                }
            } catch (JsonProcessingException e) {
                throw new RuntimeException(e);
            }
            List<JsonNode> attribslist =
                    listReplicaService.findOverLappingEntriesForWhitelistWithAttribs(vcfield,
                            vcvalue,
                            dtEffectiveFrom,
                            expireAt,
                            itenantid,
                            ui
                    );

            if (action.size() > 0) {
                Integer count =
                        attribslist.stream().filter(attribs -> attribs.get(
                                        "action").size() == 0)
                                .toList()
                                .size();

                existing = count;
            } else {

                Integer count =
                        attribslist.stream().filter(attribs -> attribs.get(
                                        "action").size() > 0)
                                .toList()
                                .size();

                existing = count;
            }
            if (existing > 0) {

                this.message = "Active list already exists for similar " +
                        "date range with different " +
                        "attributes. " +
                        "Pls deactivate older entry " +
                        "before " +
                        "entering this entry";
                this.success = false;
            }
        }
        if (!this.success) return;
        existing =
                listReplicaService.findEntriesWithEffectiveFromAfterExpiryAt(vcfield,
                        vcvalue,
                        ilistType,
                        dtEffectiveFrom,
                        itenantid, ui);
        if (existing > 0) {

            this.message = "Active list already exists for similar date " +
                    "range. Pls enter start date greater " +
                    "than  " +
                    "previous expiry or deactivate older " +
                    "entry";
            this.success = false;
        }
    }

    public ResponseEntity<?> getDecisionAndRules(Authentication pr,
                                                 Integer tenantid,WebUser loggedInUser,String menuName) {

        LOGGER.debug("entered in class " + ListValidationUtil.class +
                " in method getDecisionAndRules");


            Map<String, List<Map<String, Object>>> res = new HashMap<>();
            List<Map<String, Object>> resdecisionlist = new ArrayList<>();

            List<DecisionUi> decisionaActiveList;
            try {
                decisionaActiveList =
                        decisionService.findAllNonDeletedTenants(Arrays.asList(tenantid));
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get " +
                                "retrive list of active decision list",
                        e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false,
                        menuName),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            for (DecisionUi decision : decisionaActiveList) {
                Map<String, Object> adddecisiontores = new HashMap<>();
                adddecisiontores.put("label", decision.getVcDecisionName());
                adddecisiontores.put("value", decision.getIDecisionID());
                List<Rules> ruleslist = new ArrayList<>();
                try {
                    ruleslist =
                            rulesTempService.findAllByIDecisionID(decision.getIDecisionID(), tenantid);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser,
                            "failed to get retrieve list of active rules list" +
                                    " by decision id",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, menuName),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                List<Map<String, Object>> rulesreslist = new ArrayList<>();

                for (Rules rule : ruleslist) {
                    Map<String, Object> rulesres = new HashMap<>();
                    rulesres.put("label", rule.getVcRuleName());
                    rulesres.put("value", rule.getIRuleID());
                    rulesres.put("decisionId", decision.getIDecisionID());
                    rulesreslist.add(rulesres);
                }
                adddecisiontores.put("rules", rulesreslist);
                resdecisionlist.add(adddecisiontores);

            }
            res.put("decisionList", resdecisionlist);
            activityLogService.addActivity(loggedInUser,
                    " list get decisions and rules data accessed successfully");
            LOGGER.debug("Exiting getDecisionAndRules Method in " + ListValidationUtil.class
                    + " class with response  : with list of lists");
            return ResponseEntity.ok(res);

        } 
    }
