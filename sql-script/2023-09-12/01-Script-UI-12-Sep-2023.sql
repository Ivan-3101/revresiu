




UPDATE ui.taskvariables SET
variables = '["WorkflowName","TicketID","failedRules","TransactionAmount","fieldDropDowns","RiskScore","AvgRiskScore","triggeredtype","payeeAccount","failedRuleIDs", "payeeName", "current_final_status", "txndate"]'::text WHERE
id = 1;


INSERT INTO ui.taskdropdownoptions (ioptionid, vclabel, vcvalue) VALUES (5, 'All Related', NULL);


