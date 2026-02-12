UPDATE ui.emailtemplate SET
body =  E'<p>Dear Merchant Partner, </p>
<p>Greetings from Pine Labs.</p> 
<p>Pine Labs has always worked to maintain a trusted environment and safeguard merchant partners from fraudulent transactions. We wish to inform you that as per the Pine Labs'' Transaction Monitoring System, the following transactions were found to be inconsistent. These transactions are being further review.</p> 

<h4>Transaction Details:</h4>
<table border="1">
<tr>
<th>Transaction ID/Reference Number</td>
<th>Date and time of the transaction</td>
<th>Amount of the transaction</td>
<th>Payment method used</td>
<th>Shipping/billing address (if applicable)</td>
<th>Name and contact details of the customer</td>
</tr>
<tr th:each="trans: ${allTransInfo}">
    <td th:text="${trans.id}" />
    <td th:text="${trans.ts}" />
    <td th:text="${trans.amount}"/>
    <td th:text="${trans.type}"/>
    <td th:text="${trans.addr}"/>
    <td th:text="${trans.name}"/>
</tr>
</table>
<p>Request you to share the additional documents below within 2 working days: </p>
<ul>
<li>Store''s Invoice/ bill/ cash memo copy, including product\\service details</li>
<p>OR</p>
<li>Charge slip/ merchant copy of PoS transaction (s) </li>
<p>OR</p>
<li>A copy of the cardholder''s valid photo ID (PAN card/ Aadhar card/ Driving License/Passport/Voter ID)</li>
</ul>
<p>We regret the inconvenience caused and appreciate your cooperation in this regard.</p>
<p>Please contact us at 0120-4033600 or write to doc.review@pinelabs.com for any further assistance.</p>
<p>Thank you,<p>
<p>Team Pine Labs</p> '::text WHERE
id = 17;