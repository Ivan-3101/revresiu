INSERT INTO ui.emailtemplate (
id, body, subject, associateid) VALUES (
'21'::integer, '<p>Dear Merchant Partner, </p>
Greetings from Pine Labs. 
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
<p>Team Pine Labs</p> '::text, 'TransactionId#:[(${transactionId})] | Transaction Settlement Processed'::text, 'RiskyMerchantSettlements'::character varying)
 returning id;