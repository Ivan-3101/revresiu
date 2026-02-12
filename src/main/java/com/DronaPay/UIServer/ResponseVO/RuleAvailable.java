package com.DronaPay.UIServer.ResponseVO;

import lombok.Data;

import java.time.ZonedDateTime;

@Data
public class RuleAvailable {

    private Integer availableRuleID;
    private Integer ruleID;
    private Integer decisionID;
    private String ruleName;
    private String ruleDescription;
    private Boolean active;
    private String ruleParam;
    private String label;
    private String ruleType;
    private String ruleDimension;
    private String ruleState;
    private String ruleDetails;
    private Integer instance;
    private Boolean custom;
    private Integer ruleAuditID;
    private String action;
    private Integer versionID;
    private ZonedDateTime approvedDateTimeStamp;
    private String vcruleorder;
    private Boolean newRuleAdded;
    private Integer tempRuleID;
}
