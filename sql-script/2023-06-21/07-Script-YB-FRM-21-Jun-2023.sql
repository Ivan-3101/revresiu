INSERT INTO ui.emailtemplate (id, body, subject, associateid) VALUES (9, '<p>Hii <span th:text="${merchantName}"></span>,</p>
<br>
<p>We are happy to inform you that we have analysed your documents and we are refunding the transaction that was blocked.</p>
<br>
<p>Transaction Details are:</p>
<br>
<p>TransactionId - <span th:text="${transactionId}"></span></p>
<p>Amount - <span th:text="${amount}"></span></p>
<p>Customer - <span th:text="${customer}"></span></p>
<p>Date - <span th:text="${date}"></span></p>
<p>Time - <span th:text="${time}"> </span></p>
<p>Status - <span th:text="${status}"></span></p>
<br>
<p>Thank you for your cooperation</p>
<br>
<p>Regards,</p>
<p>Yes Bank Team</p>', 'Refund Transaction', 'ybfrmblocksettlements');
INSERT INTO ui.emailtemplate (id, body, subject, associateid) VALUES (7, '<p>Hii <span th:text="${merchantName}"></span>,</p>
<br>
<p>Sorry! we have identified a potential high risk transaction on your account. Your Risk status has been updated. Settlement for this transaction</p>
<p>is currently witheld.Our Risk Team needs your help to analyze this transaction and take necessary actions.</p>
<br>
<p>Transaction Details are:</p>
<br>
<p>TransactionId - <span th:text="${transactionId}"></span></p>
<p>Amount - <span th:text="${amount}"></span></p>
<p>Customer - <span th:text="${customer}"></span></p>
<p>Date - <span th:text="${date}"></span></p>
<p>Time - <span th:text="${time}"> </span></p>
<p>Status - <span th:text="${status}"></span> </p>
<br>
<p th:if="${note} != null">Email Note :</p>
<p th:if="${note} != null" th:text="${note}"></p>
<br th:if="${note} != null">
<p th:if="${doc} != null">Kindly provide below documents as attachments</p>
<p th:if="${doc} != null" th:text="${doc}"></p>
<br th:if="${doc} != null">
<p>Regards,</p>
<p>Yes Bank Team</p>', 'Transaction Blocked!!', 'ybfrmblocksettlements');
INSERT INTO ui.emailtemplate (id, body, subject, associateid) VALUES (6, '<p>Hii <span th:text="${merchantName}"></span>,</p> <br> <p>We have identified following errors in the document you shared</p> <p th:text="${errorMsg}"></p> <br> <p>Transaction Details are:</p> <br> <p>TransactionId - <span th:text="${transactionId}"></span></p> <p>Amount - <span th:text="${amount}"></span></p> <p>Customer - <span th:text="${customer}"></span></p> <p>Date - <span th:text="${date}"></span></p> <p>Time - <span th:text="${time}"> </span></p> <p>Status - <span th:text="${status}"></span> </p> <br> <p>Email Note :</p> <br> <p th:text="${note}"></p> <br> <p>Kindly provide below documents as attachments </p> <br> <p th:text="${doc}"></p> <br> <p>Regards,</p> <p>Yes Bank Team</p>', 'Reupload document', 'ybfrmblocksettlements');
INSERT INTO ui.emailtemplate (id, body, subject, associateid) VALUES (8, '<p>Hii <span th:text="${merchantName}"></span>,</p>
<br>
<p>We are happy to inform you that we have analysed your documents and we are releasing the transaction that was blocked.</p>
<br>
<p>Transaction Details are:</p>
<br>
<p>TransactionId - <span th:text="${transactionId}"></span></p>
<p>Amount - <span th:text="${amount}"></span></p>
<p>Customer - <span th:text="${customer}"></span></p>
<p>Date - <span th:text="${date}"></span></p>
<p>Time - <span th:text="${time}"> </span></p>
<p>Status - <span th:text="${status}"></span></p>
<br>
<p>Thank you for your cooperation</p>
<br>
<p>Regards,</p>
<p>Yes Bank Team</p>', 'Release Hold', 'ybfrmblocksettlements');