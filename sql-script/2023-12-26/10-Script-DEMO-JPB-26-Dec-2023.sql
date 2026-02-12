INSERT INTO ui.workflowmasters (
workflowid, workflowname, workflowkey, is_manual_creation, is_filter_display, itenantid) VALUES (
'21'::integer, 'Risk Notification JPB'::character varying, 'JPB_RiskNotification'::character varying, false::boolean, true::boolean, '13'::integer)
 returning workflowid;

INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 2, 1, 21, 8, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 0, 2, 21, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 2, 2, 21, 8, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 0, 3, 21, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 2, 3, 21, 8, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 0, 4, 21, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 0, 1, 21, 6, '{"tag": "span", "path": "this.created", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 1, 2, 21, 12, '{"tag": "h4", "path": "this.name", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 1, 4, 21, 8, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 0, 1, 21, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (2, 0, 2, 21, 2, '{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 0, 2, 21, 6, '{"tag": "span", "path": "this.created", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 0, 4, 21, 6, '{"tag": "span", "path": "this.created", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 1, 1, 21, 12, '{"tag": "h4", "path": "this.name", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (2, 0, 3, 21, 2, '{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 1, 3, 21, 12, '{"tag": "h4", "path": "this.name", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 2, 1, 21, 4, '{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount", "className": "d-inline pull-right"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (2, 0, 1, 21, 2, '{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (2, 0, 4, 21, 2, '{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 0, 3, 21, 6, '{"tag": "span", "path": "this.startTime", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 2, 2, 21, 4, '{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount", "className": "d-inline pull-right"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 2, 3, 21, 4, '{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount", "className": "d-inline pull-right"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 1, 4, 21, 4, '{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount", "className": "d-inline pull-right"}');

INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2062'::integer, 'riskanalyst'::character varying, 'Risk Analyst'::character varying, 'WORKFLOW'::character varying, '1'::integer, '13'::integer)
 returning igroupid;

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2062, 21);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2062, 21);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2062, 21);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2062, 21);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2062, 21);


INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2063'::integer, 'risksupervisor'::character varying, 'Risk Supervisor'::character varying, 'WORKFLOW'::character varying, '1'::integer, '13'::integer)
 returning igroupid;
 
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2063, 21);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2063, 21);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2063, 21);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2063, 21);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2063, 21);