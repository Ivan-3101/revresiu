INSERT INTO ui.workflowmasters (workflowid, workflowname,workflowkey,is_manual_creation,is_filter_display,itenantid) VALUES (20, 'JPSL AML','JPSL_AML',false,true,1);



INSERT INTO ui.workflowmasters (workflowid, workflowname,workflowkey,is_manual_creation,is_filter_display,itenantid) VALUES (18, 'JPSL Risky Merchant Settlement','JPSLRiskyMerchantSettlement',false,true,1);

insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES 
(0,0, 1,18,4,'{"tag":"span", "path":"this.variables.TicketID", "type":"ticketid"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 0, 1, 18, 6, '{"tag":"span", "path":"this.created","type":"timestamp"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(2, 0, 1, 18, 2, '{"tag":"span","path":"this.variables.RiskScore","type":"score"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 1, 1, 18, 12, '{"tag":"span","path":"this.name", "type":"default"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 2, 1, 18, 4, '{"tag":"span","path":"this.variables.TransactionAmount", "type":"amount", "className":"d-inline pull-left"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 2, 1, 18, 8, '{"tag":"span","path":"this.variables.WorkflowName", "type":"default", "className":"d-inline pull-right"}');



insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES 
(0,0, 2,18,4,'{"tag":"span", "path":"this.variables.TicketID", "type":"ticketid"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 0, 2, 18, 6, '{"tag":"span", "path":"this.created","type":"timestamp"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(2, 0, 2, 18, 2, '{"tag":"span","path":"this.variables.RiskScore","type":"score"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 1, 2, 18, 12, '{"tag":"span","path":"this.name", "type":"default"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 2, 2, 18, 4, '{"tag":"span","path":"this.variables.TransactionAmount", "type":"amount", "className":"d-inline pull-left"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 2, 2, 18, 8, '{"tag":"span","path":"this.variables.WorkflowName", "type":"default", "className":"d-inline pull-right"}');



insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES 
(0,0,3,18,4,'{"tag":"span", "path":"this.variables.TicketID", "type":"ticketid"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 0, 3, 18, 6, '{"tag":"span", "path":"this.startTime","type":"timestamp"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(2, 0, 3, 18, 2, '{"tag":"span","path":"this.variables.RiskScore","type":"score"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 1, 3, 18, 12, '{"tag":"span","path":"this.name", "type":"default"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 2, 3, 18, 4, '{"tag":"span","path":"this.variables.TransactionAmount", "type":"amount", "className":"d-inline pull-left"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 2, 3, 18, 8, '{"tag":"span","path":"this.variables.WorkflowName", "type":"default", "className":"d-inline pull-right"}');


insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES 
(0,0,4,18,4,'{"tag":"span", "path":"this.variables.TicketID", "type":"ticketid"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 0, 4, 18, 6, '{"tag":"span", "path":"this.created","type":"timestamp"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(2, 0, 4, 18, 2, '{"tag":"span","path":"this.variables.RiskScore","type":"score"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 1, 4, 18, 4, '{"tag":"span","path":"this.variables.TransactionAmount", "type":"amount", "className":"d-inline pull-left"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 1, 4, 18, 8, '{"tag":"span","path":"this.variables.WorkflowName", "type":"default", "className":"d-inline pull-right"}');




INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 2, 1, 20, 8, '{"tag": "span", "path": "this.name", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 0, 2, 20, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 0, 1, 20, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 2, 2, 20, 8, '{"tag": "span", "path": "this.name", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 0, 3, 20, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 0, 1, 20, 6, '{"tag": "span", "path": "this.created", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 0, 2, 20, 6, '{"tag": "span", "path": "this.created", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 2, 2, 20, 4, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default", "className": "d-block text-right normal-span-text"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 2, 1, 20, 4, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default", "className": "d-block text-right normal-span-text"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (2, 0, 1, 20, 2, '{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 1, 1, 20, 12, '{"tag": "h4", "path": "this.variables.payeeName", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (2, 0, 2, 20, 2, '{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (2, 0, 3, 20, 2, '{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 2, 3, 20, 8, '{"tag": "span", "path": "this.name", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 1, 2, 20, 12, '{"tag": "h4", "path": "this.variables.payeeName", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (0, 1, 3, 20, 12, '{"tag": "h4", "path": "this.variables.payeeName", "type": "default"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 2, 3, 20, 4, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default", "className": "d-block text-right normal-span-text"}');
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES (1, 0, 3, 20, 6, '{"tag": "span", "path": "this.startTime", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,0,4,20,4,'{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (1,0,4,20,6,'{"tag": "span", "path": "this.created", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,1,4,20,8,'{"tag": "h4", "path": "this.variables.payeeName", "type": "default"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (2,0,4,20,2,'{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (1,1,4,20,4,'{"tag": "span", "path": "this.variables.WorkflowName", "type": "default", "className": "d-block text-right normal-span-text"}');

INSERT INTO ui.emailtemplate (id, body, subject, associateid, response, camunda_message_name) VALUES (26, '<p>Dear Merchant Partner,</p> 
<p>Greetings from JPSL.</p> 
<p>We have received your documents and are delighted to inform you that your payment will be released in two working days.  The payment will be credited to your registered bank account with us.</p>
<p>We appreciate your patience in the interim.</p> 
<p>Please contact us at 0120-4033600 or write to <span th:text="${emailid}"></span> for any further assistance.</p>
<p>Thank you,</p> 
<p>Team JPSL</p>', 'TransactionId#:[(${transactionId})] | Transaction Settlement Processed', 'JPSLRiskyMerchantSettlement', NULL, NULL);
INSERT INTO ui.emailtemplate (id, body, subject, associateid, response, camunda_message_name) VALUES (29, '<p>Dear <span th:text="${merchantName}">Merchant</span> ,</p>
<p>Gentle Reminder!!</p>
<p>This is to kindly remind you about our previous email regarding a risky transaction that we identified on your platform. We understand that you may have been busy, and we genuinely appreciate your cooperation in providing us with the requested information.</p>
<p>As mentioned before, the transaction in question has raised concerns due to its potentially risky nature. To ensure the security and integrity of our operations, it is essential that we receive the requested details from you.</p>
<p>Your prompt attention to this matter is important, and we kindly request you to provide the requested information at your earliest convenience. Your cooperation in this regard will greatly assist us in conducting a thorough investigation and addressing any potential security issues.</p>
<p>Thank you for your attention to this reminder. We look forward to receiving your response soon.</p>
<p>Sincerely,</p>
<p>JPSL Team
', 'TransactionId#:[(${transactionId})] | Hold on Identified Risky Transaction', 'JPSLRiskyMerchantSettlement', NULL, 'response_from_merchant');
INSERT INTO ui.emailtemplate (id, body, subject, associateid, response, camunda_message_name) VALUES (25, '<p>Dear Merchant Partner,</p> 
<p>Greetings from JPSL.</p> 
<p>We are delighted to inform you that your payment will be released in 4-5 working days.  The payment will be credited to your registered bank account with us. In case, any change in bank account, kindly inform us for the same within 3 working days.</p>
<p>We appreciate your patience in the interim.</p> 
<p>Please contact us at 0120-4033600 or write to <span th:text="${emailid}"></span> for any further assistance.</p>
<p>Thank you,</p>
<p>Team JPSL</p> ', 'TransactionId#:[(${transactionId})] | Transaction Settlement Processed', 'JPSLRiskyMerchantSettlement', NULL, NULL);
INSERT INTO ui.emailtemplate (id, body, subject, associateid, response, camunda_message_name) VALUES (22, '<p>Dear Merchant Partner, </p>
<p>Greetings from JPSL.</p>
<p>We wish to inform you that we have received your documents. The concerned team will review them and get back to you within next 1 working days. </p>
<p>We appreciate your patience in the interim.</p>
<p>Please contact us at 0120-4033600 or write to <span th:text="${emailid}"></span> for any further assistance.</p>
<p>Thank you, </p>
<p>Team JPSL</p> ', 'TransactionId#:[(${transactionId})] | Documents Received', 'JPSLRiskyMerchantSettlement', NULL, NULL);
INSERT INTO ui.emailtemplate (id, body, subject, associateid, response, camunda_message_name) VALUES (24, '<p>Dear Merchant Partner, </p>
Greetings from JPSL. 
JPSL has always worked to maintain a trusted environment and safeguard merchant partners from fraudulent transactions. We wish to inform you that as per the JPSL'' Transaction Monitoring System, the following transactions were found to be inconsistent. These transactions are being put on hold till further review. 

<h4>Transaction Details:</h4>
<table border="1">
<tr>
<th>Transaction ID/Reference Number</th>
<th>Date and time of the transaction</th>
<th>Amount of the transaction</th>
<th>Payment method used</th>
<th>Name of Customer</th>
<th>Customer_vpa</th>
</tr>
<tr th:each="trans: ${allTransInfo}">
    <td th:text="${trans.id}" />
    <td th:text="${trans.ts}" />
    <td th:text="${trans.amount}"/>
    <td th:text="${trans.type}"/>
    <td th:text="${trans.name}"/>
    <td th:text="${trans.addr}"/>
</tr>
</table>
<p>Request you to share the additional documents below within 2 working days: </p>
<ul>
<li>Store''s Invoice/ bill/ cash memo copy, including product\service details and Charge slip/ merchant copy of PoS transaction (s) </li>
<p>Any transaction above 50 K, please provide below - </p>
<li>A copy of the cardholder''s valid photo ID (PAN card/ Aadhar card/ Driving License/Passport/Voter ID)</li>
</ul>
<p>Please note that the JPSL team will review the documents, and the payment will be released once the documents are deemed valid.</p>
<p>We regret the inconvenience caused and appreciate your cooperation in this regard.</p>
<p>Please contact us at 0120-4033600 or write to <span th:text="${emailid}"></span> for any further assistance.</p>
<p>Thank you,<p>
<p>Team JPSL</p> ', 'TransactionId#:[(${transactionId})] | Hold on Identified Risky Transaction', 'JPSLRiskyMerchantSettlement', NULL, 'response_from_merchant');
INSERT INTO ui.emailtemplate (id, body, subject, associateid, response, camunda_message_name) VALUES (28, '<p>Dear Merchant Partner, </p> 
<p>Greetings from JPSL.</p>
<p>We wish to inform you that our team is unable to ascertain the validity of the transaction basis the documents shared by you earlier. Request you to kindly share the revised below mentioned documents at the earliest to release your payment. </p>
<ol>
<li th:each="doc:${docList}" th:text="${doc}"></li>
</ol>
<p>-------------------------------------</p>
<p>We appreciate your prompt response in this regard.</p>
<p>Please contact us at 0120-4033600 or write to <span th:text="${emailid}"></span> for any further assistance.</p>
<p>Thank you,</p>
<p>Team JPSL</p> ', 'TransactionId#:[(${transactionId})] | Request for Information Regarding Identified Risky Transaction', 'JPSLRiskyMerchantSettlement', NULL, 'response_from_merchant');
INSERT INTO ui.emailtemplate (id, body, subject, associateid, response, camunda_message_name) VALUES (27, '<p>Dear Merchant Partner, </p>
<p>Greetings from JPSL.</p> 
<p>JPSL has always worked to maintain a trusted environment and safeguard merchant partners from fraudulent transactions. We wish to inform you that as per the JPSL'' Transaction Monitoring System, the following transactions were found to be inconsistent. These transactions are being further review.</p> 

<h4>Transaction Details:</h4>
<table border="1">
<tr>
<th>Transaction ID/Reference Number</th>
<th>Date and time of the transaction</th>
<th>Amount of the transaction</th>
<th>Payment method used</th>
<th>Name of Customer</th>
<th>Customer_vpa</th>
</tr>
<tr th:each="trans: ${allTransInfo}">
    <td th:text="${trans.id}" />
    <td th:text="${trans.ts}" />
    <td th:text="${trans.amount}"/>
    <td th:text="${trans.type}"/>
    <td th:text="${trans.name}"/>
    <td th:text="${trans.addr}"/>
</tr>
</table>
<p>Request you to share the additional documents below within 2 working days: </p>
<ul>
<li>Store''s Invoice/ bill/ cash memo copy, including product\service details</li>
<p>OR</p>
<li>Charge slip/ merchant copy of PoS transaction (s) </li>
<p>OR</p>
<li>A copy of the cardholder''s valid photo ID (PAN card/ Aadhar card/ Driving License/Passport/Voter ID)</li>
</ul>
<p>We regret the inconvenience caused and appreciate your cooperation in this regard.</p>
<p>Please contact us at 0120-4033600 or write to <span th:text="${emailid}"></span> for any further assistance.</p>
<p>Thank you,<p>
<p>Team JPSL</p> ', 'TransactionId#:[(${transactionId})] | Request for Information Regarding Identified Risky Transaction', 'JPSLRiskyMerchantSettlement', NULL, 'response_from_merchant');
INSERT INTO ui.emailtemplate (id, body, subject, associateid, response, camunda_message_name) VALUES (23, '<p>Dear Merchant Partner, </p>
Greetings from JPSL. 
We have received your documents and are delighted to inform you that your payment for below transactions will be released in two working days. The payment will be credited to your registered bank account with us. 

<h4>Transaction Details:</h4>
<table border="1">
<tr>
<th>Transaction ID/Reference Number</th>
<th>Date and time of the transaction</th>
<th>Amount of the transaction</th>
<th>Payment method used</th>
<th>Name of Customer</th>
<th>Customer_vpa</th>
</tr>
<tr th:each="trans: ${allTransInfo}">
    <td th:text="${trans.id}" />
    <td th:text="${trans.ts}" />
    <td th:text="${trans.amount}"/>
    <td th:text="${trans.type}"/>
    <td th:text="${trans.name}"/>
    <td th:text="${trans.addr}"/>
</tr>
</table>
<p>We appreciate your patience in the interim.</p>
<p>Please contact us at 0120-4033600 or write to <span th:text="${emailid}"></span> for any further assistance.</p>
<p>Thank you,<p>
<p>Team JPSL</p> ', 'TransactionId#:[(${transactionId})] | Transaction Settlement Processed', 'JPSLRiskyMerchantSettlement', NULL, NULL);




