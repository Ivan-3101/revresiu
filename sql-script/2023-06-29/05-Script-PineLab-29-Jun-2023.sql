INSERT INTO ui.emailtemplate (id, body, subject, associateid) VALUES (11, '<p>Hii <span th:text="${name}"> Bob </span>,</p><br><p>We have identified a potential high risk transaction on your account. Your Risk status has been updated. Our Risk Team needs your help</p> <p>to analyze this transaction and take necessary actions.</p> <br> <p>Transaction Details are:</p> <br> <p>TransactionId - <span th:text="${transactionId}">Tranaction ID</span></p> <p>Amount - <span th:text="${amount}">Amount</span></p> <p>Date - <span th:text="${date}">Date</span></p> <p>Time - <span th:text="${time}">Time </span></p> <p>Status - BLOCKED </p> <br> <p>Kindly revert within 2 Hrs. in one of the following formats:</p> <br> <p>A. If transaction is not done by you, and to report Fraud </p> <br> <p>Kindly Refund the Transaction ID - <span th:text="${transactionId}">Tranaction ID</span> to the customer</p> <br> <p>B. If you have done the transaction</p> <br> <p>The transaction is Correct, I executed it</p> <br> <p>Thank you for your cooperation.</p> <br> <p>Regards,</p> <p>Risk Team</p>', 'Risky Transaction Alert', 'RiskyMerchantSettlements');
INSERT INTO ui.emailtemplate (id, body, subject, associateid) VALUES (12, '<p>Hii <span th:text="${name}"> Bob </span>,</p><br><p>We have identified a potential high risk transaction on your account. Your Risk status has been updated. Our Risk Team needs your help</p> <p>to analyze this transaction and take necessary actions.</p> <br> <p>Transaction Details are:</p> <br> <p>TransactionId - <span th:text="${transactionId}">Tranaction ID</span></p> <p>Amount - <span th:text="${amount}">Amount</span></p> <p>Date - <span th:text="${date}">Date</span></p> <p>Time - <span th:text="${time}">Time </span></p> <p>Status - BLOCKED </p> <br> <p>Kindly revert within 2 Hrs. in one of the following formats:</p> <br> <p>A. If transaction is not done by you, and to report Fraud </p> <br> <p>Kindly Refund the Transaction ID - <span th:text="${transactionId}">Tranaction ID</span> to the customer</p> <br> <p>B. If you have done the transaction</p> <br> <p>The transaction is Correct, I executed it</p> <br> <p>Thank you for your cooperation.</p> <br> <p>Regards,</p> <p>Risk Team</p>', 'Risky Transaction Alert', 'RiskyMerchantSettlements');
INSERT INTO ui.emailtemplate (id, body, subject, associateid) VALUES (13, '<p>Hii <span th:text="${name}"> Bob </span>,</p><br><p>We have identified a potential high risk transaction on your account. Your Risk status has been updated. Our Risk Team needs your help</p> <p>to analyze this transaction and take necessary actions.</p> <br> <p>Transaction Details are:</p> <br> <p>TransactionId - <span th:text="${transactionId}">Tranaction ID</span></p> <p>Amount - <span th:text="${amount}">Amount</span></p> <p>Date - <span th:text="${date}">Date</span></p> <p>Time - <span th:text="${time}">Time </span></p> <p>Status - BLOCKED </p> <br> <p>Kindly revert within 2 Hrs. in one of the following formats:</p> <br> <p>A. If transaction is not done by you, and to report Fraud </p> <br> <p>Kindly Refund the Transaction ID - <span th:text="${transactionId}">Tranaction ID</span> to the customer</p> <br> <p>B. If you have done the transaction</p> <br> <p>The transaction is Correct, I executed it</p> <br> <p>Thank you for your cooperation.</p> <br> <p>Regards,</p> <p>Risk Team</p>', 'Risky Transaction Alert', 'RiskyMerchantSettlements');
INSERT INTO ui.emailtemplate (id, body, subject, associateid) VALUES (14, '<p>Hii <span th:text="${name}"> Bob </span>,</p><br><p>We have identified a potential high risk transaction on your account. Your Risk status has been updated. Our Risk Team needs your help</p> <p>to analyze this transaction and take necessary actions.</p> <br> <p>Transaction Details are:</p> <br> <p>TransactionId - <span th:text="${transactionId}">Tranaction ID</span></p> <p>Amount - <span th:text="${amount}">Amount</span></p> <p>Date - <span th:text="${date}">Date</span></p> <p>Time - <span th:text="${time}">Time </span></p> <p>Status - BLOCKED </p> <br> <p>Kindly revert within 2 Hrs. in one of the following formats:</p> <br> <p>A. If transaction is not done by you, and to report Fraud </p> <br> <p>Kindly Refund the Transaction ID - <span th:text="${transactionId}">Tranaction ID</span> to the customer</p> <br> <p>B. If you have done the transaction</p> <br> <p>The transaction is Correct, I executed it</p> <br> <p>Thank you for your cooperation.</p> <br> <p>Regards,</p> <p>Risk Team</p>', 'Risky Transaction Alert', 'RiskyMerchantSettlements');

INSERT INTO ui.templateresponse (templateid, activeflag, jsonresponse, responses, templatename) VALUES (15, 'Y', '{
    "messageName": "response_from_merchant",
    "businessKey": "1687152671",
    "processVariables": {
        "Document": {
            "value": "url",
            "type": "string"
        }
    }
}', 'Doc', 'RMS_ReqInfo');
INSERT INTO ui.templateresponse (templateid, activeflag, jsonresponse, responses, templatename) VALUES (13, 'Y', '{
  "messageName" : "response_from_settlement_1",
  "businessKey" : "1687236337"
  
}', 'Settlement', 'RMS_Settlement_1');
INSERT INTO ui.templateresponse (templateid, activeflag, jsonresponse, responses, templatename) VALUES (14, 'Y', '{
  "messageName" : "receive_response_settlement_2",
  "businessKey" : "1687236337"
  
}', 'Settlement', 'RMS_Settlement_2');

INSERT INTO ui.workflowmasters (workflowid, workflowname, workflowkey) VALUES (16, 'Risky Merchant Settlements', 'RiskyMerchantSettlements');

INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (144, 1, 1022, 16);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (145, 2, 1022, 16);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (146, 3, 1022, 16);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (147, 4, 1022, 16);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (148, 5, 1022, 16);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (149, 1, 1023, 16);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (150, 2, 1023, 16);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (151, 3, 1023, 16);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (152, 4, 1023, 16);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (153, 5, 1023, 16);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (154, 1, 1024, 16);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (155, 2, 1024, 16);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (156, 3, 1024, 16);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (157, 4, 1024, 16);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (158, 5, 1024, 16);
