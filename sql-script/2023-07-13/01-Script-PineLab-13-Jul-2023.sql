DELETE FROM ui.emailtemplate WHERE id=11 OR id=12 OR id =13;
INSERT INTO ui.emailtemplate (id, body, subject, associateid) VALUES (11, '<p>Dear <span th:text="${merchantName}">Merchant</span> ,</p>
<p>We have recently identified a transaction made through your platform that has raised concerns due to its potentially risky nature. In order to ensure the security and integrity of our operations, we are withholding the settlement of this transaction.</p> 
<h4>Transaction Details:</h4>
<ul>
    
<li>Transaction ID/Reference Number: <span th:text="${transactionId}"></span> </li>
<li>Date and time of the transaction: <span th:text="${timeStamp}"></span> </li>
<li>Amount of the transaction: <span th:text="${transactionAmount}"></span></li>
<li>Payment method used: <span th:text="${paymentMethod}"></span> </li>
<li>Shipping/billing address (if applicable): <span th:text="${billingAddress}"></span></li>
<li>Name and contact details of the customer: <span th:text="${customerDetails}"></span></li>
</ul>
<p>We kindly request your assistance in providing us with additional information regarding this specific transaction. Kindly provide following information/documents:</p>
<h4>Document List</h4>
<Document 1>
<Document 2>


<p>Please revert to this email without changing the subject line
Thank you for your cooperation in this urgent matter. We look forward to your prompt response.</p>


<p>Sincerely,</p>
<p>Pine Labs Team</p>
', '[(${ticketid})] | Hold on Identified Risky Transaction', 'RiskyMerchantSettlements');

INSERT INTO ui.emailtemplate (id, body, subject, associateid) VALUES (12, '<p>Dear <span th:text="${merchantName}">Merchant</span> ,</p>
<p>We have recently identified a transaction made through your platform that has raised concerns due to its potentially risky nature. In order to ensure the security and integrity of our operations, we request some more information about this transaction. </p>
<h4>Transaction Details:</h4>
<ul>
    
<li>Transaction ID/Reference Number: <span th:text="${transactionId}"></span> </li>
<li>Date and time of the transaction: <span th:text="${timeStamp}"></span> </li>
<li>Amount of the transaction: <span th:text="${transactionAmount}"></span></li>
<li>Payment method used: <span th:text="${paymentMethod}"></span> </li>
<li>Shipping/billing address (if applicable): <span th:text="${billingAddress}"></span></li>
<li>Name and contact details of the customer: <span th:text="${customerDetails}"></span></li>
</ul>
<p>
We kindly request your assistance in providing us with additional information regarding this specific transaction. Kindly provide following information/documents:</p>
<h4>Document List</h4>
<Document 1>
<Document 2>

<p>Please revert to this email without changing the subject line</p>
<p>Thank you for your cooperation in this urgent matter. We look forward to your prompt response.</p>


<p>Sincerely,</p>
<p>Pine Labs Team</p>
', 'Request for Information Regarding Identified Risky Transaction [(${ticketid})] 
', 'RiskyMerchantSettlements');

INSERT INTO ui.emailtemplate (id, body, subject, associateid) VALUES (13, '<p>Dear <span th:text="${merchantName}">Merchant</span> ,</p>
<p>Gentle Reminder!!</p>
<p>This is to kindly remind you about our previous email regarding a risky transaction that we identified on your platform. We understand that you may have been busy, and we genuinely appreciate your cooperation in providing us with the requested information.</p>
<p>As mentioned before, the transaction in question has raised concerns due to its potentially risky nature. To ensure the security and integrity of our operations, it is essential that we receive the requested details from you.</p>
<p>Your prompt attention to this matter is important, and we kindly request you to provide the requested information at your earliest convenience. Your cooperation in this regard will greatly assist us in conducting a thorough investigation and addressing any potential security issues.</p>
<p>Thank you for your attention to this reminder. We look forward to receiving your response soon.</p>


<p>Sincerely,</p>
<p>Pine Labs Team
', '[(${ticketid})]  | Transaction Settlement Processed
', 'RiskyMerchantSettlements');