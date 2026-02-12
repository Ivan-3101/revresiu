package com.DronaPay.UIServer.requests;

import lombok.Getter;

import java.util.Date;

@Getter
public class RuleAvailableGt {

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
    private Date approvedDateTimeStamp;
}
