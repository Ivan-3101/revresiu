UPDATE ui.taskvariables SET
variables = '["WorkflowName","TicketID","failedRules","TransactionAmount","fieldDropDowns","RiskScore","AvgRiskScore","triggeredtype","payeeAccount","failedRuleIDs", "payeeName", "current_final_status", "txndate", "payeepayerAccount", "sdsEnabled","odsEnabled"] '::text WHERE
id = 1;
