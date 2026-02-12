
INSERT INTO ui.emailtemplate (id, body, subject, associateid, camunda_message_name) VALUES (17, '<p>Dear <span th:text="${merchantName}">Merchant</span> ,</p>
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
<ol>
<li>Document 1</li>
<li>Document 2</li>
</ol>
<p>Please revert to this email without changing the subject line</p>
<p>Thank you for your cooperation in this urgent matter. We look forward to your prompt response.</p>


<p>Sincerely,</p>
<p>Pine Labs Team</p>
', 'TransactionId#:[(${transactionId})] | Request for Information Regarding Identified Risky Transaction',
'RiskyMerchantSettlements', 'response_from_merchant');