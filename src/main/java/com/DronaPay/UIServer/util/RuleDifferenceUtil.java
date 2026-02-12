package com.DronaPay.UIServer.util;

import com.DronaPay.UIServer.ResponseVO.RuleAvailable;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.Objects;

public class RuleDifferenceUtil {

    public static Boolean validate(RuleAvailable source, RuleAvailable input) throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        if (
                Objects.equals(source.getAvailableRuleID(), input.getAvailableRuleID()) &&
                        Objects.equals(source.getRuleID(), input.getRuleID()) &&
                        Objects.equals(source.getDecisionID(), input.getDecisionID()) &&
                        Objects.equals(source.getRuleName(), input.getRuleName()) &&
                        Objects.equals(source.getRuleDescription(), input.getRuleDescription()) &&
                        Objects.equals(source.getActive(), input.getActive()) &&
                        Objects.equals(source.getRuleParam(), input.getRuleParam()) &&

                        Objects.equals(source.getLabel(), input.getLabel()) &&
                        Objects.equals(source.getRuleType(), input.getRuleType()) &&
                        Objects.equals(source.getRuleDimension(), input.getRuleDimension()) &&
                        Objects.equals(source.getRuleState(), input.getRuleState()) &&
                        Objects.equals(source.getRuleDetails(), input.getRuleDetails()) &&
                        Objects.deepEquals(mapper.readTree(source.getRuleDetails() == null ? "{}" : source.getRuleDetails()), mapper.readTree(input.getRuleDetails() == null ? "{}" : input.getRuleDetails())) &&
                        Objects.equals(source.getInstance(), input.getInstance()) &&
                        Objects.equals(source.getCustom(), input.getCustom()) &&
                        Objects.equals(
                                mapper.readTree(source.getVcruleorder() == null ? "{}" : source.getVcruleorder()),
                                mapper.readTree(input.getVcruleorder() == null ? "{}" : input.getVcruleorder())
                        )
//                        Objects.equals(source.getRuleAuditID(), input.getRuleAuditID()) &&
//                        Objects.equals(source.getAction(), input.getAction())
        ) {
            return true;
        } else {
            return false;
        }
    }
}
