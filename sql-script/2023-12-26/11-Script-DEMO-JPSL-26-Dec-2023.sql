INSERT INTO ui.workflowmasters (workflowid, workflowname,workflowkey,is_manual_creation,is_filter_display,itenantid) VALUES (23, 'JPSL AML','JPSL_AML',false,true,15);
INSERT INTO ui.workflowmasters (workflowid, workflowname,workflowkey,is_manual_creation,is_filter_display,itenantid) VALUES (22, 'JPSL Risky Merchant Settlement','JPSLRMS',false,true,15);

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


INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2064'::integer, 'riskanalyst'::character varying, 'Risk Analyst'::character varying, 'WORKFLOW'::character varying, '1'::integer, '15'::integer)
 returning igroupid;

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2064, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2064, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2064, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2064, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2064, 22);

 
 
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2065'::integer, 'risksupervisor'::character varying, 'Risk Supervisor'::character varying, 'WORKFLOW'::character varying, '1'::integer, '15'::integer)
 returning igroupid;
 
 
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2065, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2065, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2065, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2065, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2065, 22);

INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2066'::integer, 'level1'::character varying, 'L1'::character varying, 'WORKFLOW'::character varying, '1'::integer, '15'::integer)
 returning igroupid;

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2066, 23);
-- insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2066, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2066, 23);
-- insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2066, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2066, 23);

INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2067'::integer, 'level2'::character varying, 'L2'::character varying, 'WORKFLOW'::character varying, '1'::integer, '15'::integer)
 returning igroupid;

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2067, 23);
-- insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2067, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2067, 23);
-- insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2067, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2067, 23);

INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2068'::integer, 'level3'::character varying, 'L3'::character varying, 'WORKFLOW'::character varying, '1'::integer, '15'::integer)
 returning igroupid;

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2068, 23);
-- insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2068, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2068, 23);
-- insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2068, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2068, 23);
 


 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 1, igroupid, 1
 FROM
 ui.groupdesc where igroupid >= 2062 and igroupid <= 2068;


 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 2, igroupid, 2
 FROM
 ui.groupdesc where igroupid >= 2062 and igroupid <= 2068;


 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 3, igroupid, 3
 FROM
 ui.groupdesc where igroupid >= 2062 and igroupid <= 2068;


 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 4, igroupid, 4
 FROM ui.groupdesc where igroupid >= 2062 and igroupid <= 2068;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 5, igroupid, 5
 FROM ui.groupdesc where igroupid >= 2062 and igroupid <= 2068;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 6, igroupid, 6
 FROM ui.groupdesc where igroupid >= 2062 and igroupid <= 2068;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 7, igroupid, 7
 FROM ui.groupdesc where igroupid >= 2062 and igroupid <= 2068;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 8, igroupid, 8
 FROM ui.groupdesc where igroupid >= 2062 and igroupid <= 2068;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 9, igroupid,9
 FROM ui.groupdesc where igroupid >= 2062 and igroupid <= 2068;