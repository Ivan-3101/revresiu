package com.DronaPay.UIServer.requests;

import lombok.Data;
import lombok.Getter;

@Getter
public class EditDecisionRuleOfTransaction {
    
    private String transactionIdentifier;
    private Integer decisionId;
    private String vcDecisionParams;
}
