##work in progress
INSERT INTO ui.emailtemplate (
id, body, subject) VALUES (
'18'::integer, '<p>Dear <span th:text="${checkerName}"></span></p>
<p>A new release hold/refund request requires your attention and approval in the block settlement workflow.</p>
<p>CaseID:<span th:text="${ticketId}"></span></p>
<p>Thank you</p>'::text, 'Pending Approval: Release Hold/Refund Request'::text)
 returning id;

 INSERT INTO ui.emailtemplate (
id, body, subject, associateid) VALUES (
'20'::integer, '<p>Dear <span th:text="${checkerName}"></span>,</p>
<p>A new merchant address is being sent for approval. Kindly check.</p>
<p>CaseID:<span th:text="${ticketId}"></span></p>
<p>Thank you</p>'::text, 'Pending Approval: Whitelist Request'::text, 'ybfrmblocksettlements'::character varying)
 returning id;


UPDATE ui.emailtemplate SET
subject = 'TransactionId#:[(${transactionId})] Transaction Blocked!!'::text WHERE
id = 7;

UPDATE ui.emailtemplate SET
camunda_message_name = 'response_from_merchant'::character varying WHERE
id = 7;

INSERT INTO ui.emailtemplate (
id, body, subject, associateid, camunda_message_name) VALUES (
'19'::integer, '<p>Dear <span th:text="${merchantName}"></span>,</p>	
		
<p>We hope this email finds you well. We are writing to remind you about the information request related to txn id <span th:text="${transactionId}"></span>		
<p> Note: Subject should not be changed while replying	</p>	
		
<p>Thank you!</p>	
<p>Risk Team</p>'::text, 'TransactionId#:[(${transactionId})] Reminder: Request for Information'::text, 'ybfrmblocksettlements'::character varying, 'response_from_merchant'::character varying)
 returning id;


INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (6, 'Active Days_P30_Payee','account');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (6, 'Distinct Payer_P30_Payee','account');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (6, 'Rules Trig_P30_Payee','account');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (6, 'Total Value_P30_Payee','account');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (6, 'Total Value_P7_Payee','account');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (6, 'Active Days_P30_Payee','vpa');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (6, 'Distinct Payer_P30_Payee','vpa');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (6, 'Rules Trig_P30_Payee','vpa');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (6, 'Total Value_P30_Payee','vpa');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (6, 'Total Value_P7_Payee','vpa');

INSERT INTO ui.panelaccessmap (
panelaccessmap, panelid, groupid, workflowid) VALUES (
(select max(panelaccessmap)+1 from ui.panelaccessmap), '6'::integer, '1020'::integer, '6'::integer)
 returning panelaccessmap;

 INSERT INTO ui.panelaccessmap (
panelaccessmap, panelid, groupid, workflowid) VALUES (
(select max(panelaccessmap)+1 from ui.panelaccessmap), '6'::integer, '1021'::integer, '6'::integer)
 returning panelaccessmap;
 