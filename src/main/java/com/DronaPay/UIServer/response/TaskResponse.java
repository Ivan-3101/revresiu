package com.DronaPay.UIServer.response;

import lombok.Data;

@Data
public class TaskResponse {
    
    private Object processInstanceId;
    private Object id;
    private Object TicketID;
    private Object WorkflowName;
    private Object taskName;
    private Object created;
    private Object alert;
    private Object payee;
    private Object payerAccount;
    private Object payeeAccount;
    private Object payer;
    private Object TransactionAmount;
    private Object state;
    private Object taskId;
    private Object name;
    private Object defKey;
    private Object assignee;
    private Object RiskScore;
    private Object failedRules;
}
