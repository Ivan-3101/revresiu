INSERT INTO ui.workflowmasters (workflowid, workflowname,workflowkey,is_manual_creation,is_filter_display,itenantid) VALUES (23, 'JPSL AML','JPSL_AML',false,true,2);
INSERT INTO ui.workflowmasters (workflowid, workflowname,workflowkey,is_manual_creation,is_filter_display,itenantid) VALUES (22, 'JPSL Risky Merchant Settlement','JPSLRMS',false,true,2);

insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES 
(0,0, 1,22,4,'{"tag":"span", "path":"this.variables.TicketID", "type":"ticketid"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 0, 1, 22, 6, '{"tag":"span", "path":"this.created","type":"timestamp"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(2, 0, 1, 22, 2, '{"tag":"span","path":"this.variables.RiskScore","type":"score"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 1, 1, 22, 12, '{"tag":"span","path":"this.name", "type":"default"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 2, 1, 22, 4, '{"tag":"span","path":"this.variables.TransactionAmount", "type":"amount", "className":"d-inline pull-left"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 2, 1, 22, 8, '{"tag":"span","path":"this.variables.WorkflowName", "type":"default", "className":"d-inline pull-right"}');



insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES 
(0,0, 2,22,4,'{"tag":"span", "path":"this.variables.TicketID", "type":"ticketid"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 0, 2, 22, 6, '{"tag":"span", "path":"this.created","type":"timestamp"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(2, 0, 2, 22, 2, '{"tag":"span","path":"this.variables.RiskScore","type":"score"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 1, 2, 22, 12, '{"tag":"span","path":"this.name", "type":"default"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 2, 2, 22, 4, '{"tag":"span","path":"this.variables.TransactionAmount", "type":"amount", "className":"d-inline pull-left"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 2, 2, 22, 8, '{"tag":"span","path":"this.variables.WorkflowName", "type":"default", "className":"d-inline pull-right"}');



insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES 
(0,0,3,22,4,'{"tag":"span", "path":"this.variables.TicketID", "type":"ticketid"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 0, 3, 22, 6, '{"tag":"span", "path":"this.startTime","type":"timestamp"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(2, 0, 3, 22, 2, '{"tag":"span","path":"this.variables.RiskScore","type":"score"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 1, 3, 22, 12, '{"tag":"span","path":"this.name", "type":"default"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 2, 3, 22, 4, '{"tag":"span","path":"this.variables.TransactionAmount", "type":"amount", "className":"d-inline pull-left"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 2, 3, 22, 8, '{"tag":"span","path":"this.variables.WorkflowName", "type":"default", "className":"d-inline pull-right"}');


insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES 
(0,0,4,22,4,'{"tag":"span", "path":"this.variables.TicketID", "type":"ticketid"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 0, 4, 22, 6, '{"tag":"span", "path":"this.created","type":"timestamp"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(2, 0, 4, 22, 2, '{"tag":"span","path":"this.variables.RiskScore","type":"score"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 1, 4, 22, 4, '{"tag":"span","path":"this.variables.TransactionAmount", "type":"amount", "className":"d-inline pull-left"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 1, 4, 22, 8, '{"tag":"span","path":"this.variables.WorkflowName", "type":"default", "className":"d-inline pull-right"}');




INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 2, 1, 23, 8, '{"tag": "span", "path": "this.name", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 0, 2, 23, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 0, 1, 23, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 2, 2, 23, 8, '{"tag": "span", "path": "this.name", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 0, 3, 23, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 0, 1, 23, 6, '{"tag": "span", "path": "this.created", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 0, 2, 23, 6, '{"tag": "span", "path": "this.created", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 2, 2, 23, 4, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default", "className": "d-block text-right normal-span-text"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 2, 1, 23, 4, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default", "className": "d-block text-right normal-span-text"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (2, 0, 1, 23, 2, '{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 1, 1, 23, 12, '{"tag": "h4", "path": "this.variables.payeeName", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (2, 0, 2, 23, 2, '{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (2, 0, 3, 23, 2, '{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 2, 3, 23, 8, '{"tag": "span", "path": "this.name", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 1, 2, 23, 12, '{"tag": "h4", "path": "this.variables.payeeName", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 1, 3, 23, 12, '{"tag": "h4", "path": "this.variables.payeeName", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 2, 3, 23, 4, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default", "className": "d-block text-right normal-span-text"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 0, 3, 23, 6, '{"tag": "span", "path": "this.startTime", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,0,4,23,4,'{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (1,0,4,23,6,'{"tag": "span", "path": "this.created", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,1,4,23,8,'{"tag": "h4", "path": "this.variables.payeeName", "type": "default"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (2,0,4,23,2,'{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (1,1,4,23,4,'{"tag": "span", "path": "this.variables.WorkflowName", "type": "default", "className": "d-block text-right normal-span-text"}');

INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 1020, 22);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 1020, 22);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 1020, 22);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 1020, 22);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 1020, 22);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 1021, 22);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 1021, 22);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 1021, 22);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 1021, 22);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 1021, 22);

INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 1022, 23);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 1022, 23);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 1022, 23);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 1023, 23);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 1023, 23);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 1023, 23);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 1024, 23);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 1024, 23);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 1024, 23);