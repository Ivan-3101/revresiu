INSERT INTO ui.workflowmasters (
workflowid, workflowname, workflowkey, is_manual_creation, is_filter_display, itenantid) VALUES (
'19'::integer, 'Risk Notification JPB'::character varying, 'JPB_RiskNotification'::character varying, false::boolean, true::boolean, '4'::integer)
 returning workflowid;

INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 2, 1, 19, 8, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 0, 2, 19, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 2, 2, 19, 8, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 0, 3, 19, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 2, 3, 19, 8, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 0, 4, 19, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 0, 1, 19, 6, '{"tag": "span", "path": "this.created", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 1, 2, 19, 12, '{"tag": "h4", "path": "this.name", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 1, 4, 19, 8, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 0, 1, 19, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (2, 0, 2, 19, 2, '{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 0, 2, 19, 6, '{"tag": "span", "path": "this.created", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 0, 4, 19, 6, '{"tag": "span", "path": "this.created", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 1, 1, 19, 12, '{"tag": "h4", "path": "this.name", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (2, 0, 3, 19, 2, '{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 1, 3, 19, 12, '{"tag": "h4", "path": "this.name", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 2, 1, 19, 4, '{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount", "className": "d-inline pull-right"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (2, 0, 1, 19, 2, '{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (2, 0, 4, 19, 2, '{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 0, 3, 19, 6, '{"tag": "span", "path": "this.startTime", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 2, 2, 19, 4, '{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount", "className": "d-inline pull-right"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 2, 3, 19, 4, '{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount", "className": "d-inline pull-right"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 1, 4, 19, 4, '{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount", "className": "d-inline pull-right"}');

INSERT INTO ui.emailtemplate (
id, body, subject, associateid) VALUES (
'30'::integer, '<p>Dear Sir/Ma''am,</p>

<p>Name :- <span th:text="${payername}"></span> Acc. number :- <span th:text="${payerAccount}"></span>
<p>During the transaction monitoring process for safeguarding our customers interest, we have noticed transaction(s) on your JPB acc Number <span th:text="${payerAccount}"></span></p>
<p>The details of the transaction(s) are as mentioned below:</p>

<table border = "1">
<tr>
<th>TRANSACTION DATE AND TIME</th>
<th>MERCHANT NAME</th>
<th>TRANSACTION AMOUNT(INR)</th>
<th>TRANSACTION AMOUNT (Currency)</th>
<th>TRANSACTION STATUS</th>
</tr>
<tr>
<td th:text="${ts}"></td>
<td th:text="${payeeVpa}"></td>
<td th:text="${amount}"></td>
<td th:text="${currency}"></td>
<td>A</td>
</tr>
</table>

<p>Request you to confirm the transaction (initiated by you/not initiated by you) by responding to us immediately by e-mail (). </p>
<p>In an event of disputed/un-authorized transaction(s) we request you to change your PIN/PASSWORD immediately or contact us.</p>
<p>Case Ref. #<span th:text="${ticketId}"></span></p>

<p>Regards,</p>
<p>JPB Team</p>'::text, 'Urgent - Transaction Confirmation - EMAIL FROM JIO BANK'::text, 'jpb_risknotification'::character varying)
 returning id;

 INSERT INTO ui.emailtemplate (
id, body, subject, associateid) VALUES (
'31'::integer, '<p> You have received new alert(s).  Please access Drona Pay Case Manager to check them. </p>
 <a th:href="${dronauiurl}"> UI URL </a>
<br>
<p> Please do not respond to this email. This is an automated Notification. </p>'::text, 'Real Time [(${type})]: [(${alert})] (Account#:[(${accountid})]. Transaction Amount:[(${amount})] - [(${type}  == ''Alert'' ? ''Approved'':''Declined'')])'::text, 'jpb_risknotification'::character varying)
 returning id;