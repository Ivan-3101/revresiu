

DELETE FROM ui.emailtemplate
WHERE id IN (1, 2)
  AND itenantid = 24;

INSERT INTO ui.emailtemplate (id, body, subject, associateid, response, itenantid, camunda_message_name) VALUES (2, '<p> You have received new alert(s).  Please access Drona Pay Case Manager to check them. </p>
 <a th:href="${dronauiurl}"> UI URL </a>
<br>
<p> Please do not respond to this email. This is an automated Notification. </p>', '[(${client})] Real Time [(${type})]: [(${alert})] (Account#:[(${accountid})]. Last 4 Digits of Card:[(${lastfourdigit})] Transaction Amount:[(${amount})] - [(${type}  == ''Alert'' ? ''Approved'':''Declined'')])', '42c-workflow', NULL, 24, NULL);
INSERT INTO ui.emailtemplate (id, body, subject, associateid, response, itenantid, camunda_message_name) VALUES (1, '<p>Hii <span th:text="${name}"> Bob </span>,</p><br><p>We have identified a potential high risk transaction on your account. Your Risk status has been updated. Our Risk Team needs your help</p> <p>to analyze this transaction and take necessary actions.</p> <br> <p>Transaction Details are:</p> <br> <p>TransactionId - <span th:text="${transactionId}">Tranaction ID</span></p> <p>Amount - <span th:text="${amount}">Amount</span></p> <p>Date - <span th:text="${date}">Date</span></p> <p>Time - <span th:text="${time}">Time </span></p> <p>Status - BLOCKED </p> <br> <p>Kindly revert within 2 Hrs. in one of the following formats:</p> <br> <p>A. If transaction is not done by you, and to report Fraud </p> <br> <p>Kindly Refund the Transaction ID - <span th:text="${transactionId}">Tranaction ID</span> to the customer</p> <br> <p>B. If you have done the transaction</p> <br> <p>The transaction is Correct, I executed it</p> <br> <p>Thank you for your cooperation.</p> <br> <p>Regards,</p> <p>Risk Team</p>', '[(${client})] Risky Transaction Alert', '42c-workflow', NULL, 24, NULL);


DELETE FROM ui.emailtemplate
WHERE id IN (1, 2)
  AND itenantid = 20;

INSERT INTO ui.emailtemplate (id, body, subject, associateid, response, itenantid, camunda_message_name) VALUES (2, '<p> You have received new alert(s).  Please access Drona Pay Case Manager to check them. </p>
 <a th:href="${dronauiurl}"> UI URL </a>
<br>
<p> Please do not respond to this email. This is an automated Notification. </p>', '[(${client})] Real Time [(${type})]: [(${alert})] (Account#:[(${accountid})]. Last 4 Digits of Card:[(${lastfourdigit})] Transaction Amount:[(${amount})] - [(${type}  == ''Alert'' ? ''Approved'':''Declined'')])', '42c-workflow', NULL, 20, NULL);
INSERT INTO ui.emailtemplate (id, body, subject, associateid, response, itenantid, camunda_message_name) VALUES (1, '<p>Hii <span th:text="${name}"> Bob </span>,</p><br><p>We have identified a potential high risk transaction on your account. Your Risk status has been updated. Our Risk Team needs your help</p> <p>to analyze this transaction and take necessary actions.</p> <br> <p>Transaction Details are:</p> <br> <p>TransactionId - <span th:text="${transactionId}">Tranaction ID</span></p> <p>Amount - <span th:text="${amount}">Amount</span></p> <p>Date - <span th:text="${date}">Date</span></p> <p>Time - <span th:text="${time}">Time </span></p> <p>Status - BLOCKED </p> <br> <p>Kindly revert within 2 Hrs. in one of the following formats:</p> <br> <p>A. If transaction is not done by you, and to report Fraud </p> <br> <p>Kindly Refund the Transaction ID - <span th:text="${transactionId}">Tranaction ID</span> to the customer</p> <br> <p>B. If you have done the transaction</p> <br> <p>The transaction is Correct, I executed it</p> <br> <p>Thank you for your cooperation.</p> <br> <p>Regards,</p> <p>Risk Team</p>', '[(${client})] Risky Transaction Alert', '42c-workflow', NULL, 20, NULL);
