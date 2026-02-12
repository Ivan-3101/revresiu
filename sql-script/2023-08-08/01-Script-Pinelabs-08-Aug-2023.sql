UPDATE ui.emailtemplate SET
body =  E'<p>Dear Merchant Partner, </p>
Greetings from Pine Labs. 
Pine Labs has always worked to maintain a trusted environment and safeguard merchant partners from fraudulent transactions. We wish to inform you that as per the Pine Labs'' Transaction Monitoring System, the following transactions were found to be inconsistent. These transactions are being put on hold till further review. 

<h4>Transaction Details:</h4>
<ul>
<li>Transaction ID/Reference Number: <span th:text="${transactionId}"></span> </li>
<li>Date and time of the transaction: <span th:text="${timeStamp}"></span> </li>
<li>Amount of the transaction: <span th:text="${transactionAmount}"></span></li>
<li>Payment method used: <span th:text="${paymentMethod}"></span> </li>
<li>Shipping/billing address (if applicable): <span th:text="${billingAddress}"></span></li>
<li>Name and contact details of the customer: <span th:text="${customerDetails}"></span></li>
</ul>
<p>Request you to share the additional documents below within 2 working days: </p>
<ul>
<li>Store''s Invoice/ bill/ cash memo copy, including product\\service details and Charge slip/ merchant copy of PoS transaction (s) </li>
<p>Any transaction above 50 K, please provide below - </p>
<li>A copy of the cardholder''s valid photo ID (PAN card/ Aadhar card/ Driving License/Passport/Voter ID)</li>
</ul>
<p>Please note that the Pine Labs team will review the documents, and the payment will be released once the documents are deemed valid.</p>
<p>We regret the inconvenience caused and appreciate your cooperation in this regard.</p>
<p>Please contact us at 0120-4033600 or write to doc.review@pinelabs.com for any further assistance.</p>
<p>Thank you,<p>
<p>Team Pine Labs</p> '::text WHERE
id = 11;

UPDATE ui.emailtemplate SET
body = '<p>Dear Merchant Partner, </p> 
<p>Greetings from Pine Labs.</p>
<p>We wish to inform you that our team is unable to ascertain the validity of the transaction basis the documents shared by you earlier. Request you to kindly share the revised below mentioned documents at the earliest to release your payment. </p>
<ol>
<li th:each="doc:${docList}" th:text="${doc}"></li>
</ol>
<p>-------------------------------------</p>
<p>We appreciate your prompt response in this regard.</p>
<p>Please contact us at 0120-4033600 or write to doc.review@pinelabs.com for any further assistance.</p>
<p>Thank you,</p>
<p>Team Pine Labs</p> '::text WHERE
id = 12;

INSERT INTO ui.emailtemplate (
id, body, subject, associateid) VALUES (
'15'::integer, '<p>Dear Merchant Partner, </p>
<p>Greetings from Pine Labs.</p>
<p>We wish to inform you that we have received your documents. The concerned team will review them and get back to you within next 1 working days. </p>
<p>We appreciate your patience in the interim.</p>
<p>Please contact us at 0120-4033600 or write to doc.review@pinelabs.com for any further assistance.</p>
<p>Thank you, </p>
<p>Team Pine Labs</p> '::text, 'TransactionId#:[(${transactionId})] | Documents Received'::text, 'RiskyMerchantSettlements'::character varying)
 returning id;

UPDATE ui.emailtemplate SET
subject = 'TransactionId#:[(${transactionId})] | Hold on Identified Risky Transaction'::text WHERE
id = 13;

UPDATE ui.emailtemplate SET
subject = 'TransactionId#:[(${transactionId})] | Transaction Settlement Processed'::text, body = '<p>Dear Merchant Partner,</p> 
<p>Greetings from Pine Labs.</p> 
<p>We have received your documents and are delighted to inform you that your payment will be released in two working days.  The payment will be credited to your registered bank account with us.</p>
<p>We appreciate your patience in the interim.</p> 
<p>Please contact us at 0120-4033600 or write to doc.review@pinelabs.com for any further assistance.</p>
<p>Thank you,</p> 
<p>Team Pine Labs</p>'::text WHERE
id = 14;

INSERT INTO ui.emailtemplate (
id, body, subject, associateid) VALUES (
'16'::integer, '<p>Dear Merchant Partner,</p> 
<p>Greetings from Pine Labs.</p> 
<p>We are delighted to inform you that your payment will be released in 4-5 working days.  The payment will be credited to your registered bank account with us. In case, any change in bank account, kindly inform us for the same within 3 working days.</p>
<p>We appreciate your patience in the interim.</p> 
<p>Please contact us at 0120-4033600 or write to doc.review@pinelabs.com for any further assistance.</p>
<p>Thank you,</p>
<p>Team Pine Labs</p> '::text, 'TransactionId#:[(${transactionId})] | Transaction Settlement Processed'::text, 'RiskyMerchantSettlements'::character varying)
 returning id;