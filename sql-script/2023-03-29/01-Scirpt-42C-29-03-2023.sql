delete from ui.panelaccessmap where workflowid != 3;
delete from camunda.allocationusers where workflowid != 3;
DELETE FROM ui.workflowmasters WHERE workflowid != 3;
UPDATE ui.workflowmasters SET workflowkey='RiskNotification' WHERE workflowname='Risk Notification';
