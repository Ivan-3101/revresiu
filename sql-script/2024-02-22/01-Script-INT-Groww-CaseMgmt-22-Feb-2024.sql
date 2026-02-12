------------------------------------------ui.emailtemplate

INSERT INTO ui.emailtemplate (id, body, subject, associateid, response, camunda_message_name, itenantid) VALUES (14, '<p>Dear Merchant Partner,</p> 
<p>Greetings from Groww.</p> 
<p>We have received your documents and are delighted to inform you that your payment will be released in two working days.  The payment will be credited to your registered bank account with us.</p>
<p>We appreciate your patience in the interim.</p> 
<p>Thank you,</p> 
<p>Team Groww</p>', 'TransactionId#:[(${transactionId})] | Transaction Settlement Processed', 'RiskyMerchantSettlements', NULL, NULL, 11);
INSERT INTO ui.emailtemplate (id, body, subject, associateid, response, camunda_message_name, itenantid) VALUES (13, '<p>Dear <span th:text="${merchantName}">Merchant</span> ,</p>
<p>Gentle Reminder!!</p>
<p>This is to kindly remind you about our previous email regarding a risky transaction that we identified on your platform. We understand that you may have been busy, and we genuinely appreciate your cooperation in providing us with the requested information.</p>
<p>As mentioned before, the transaction in question has raised concerns due to its potentially risky nature. To ensure the security and integrity of our operations, it is essential that we receive the requested details from you.</p>
<p>Your prompt attention to this matter is important, and we kindly request you to provide the requested information at your earliest convenience. Your cooperation in this regard will greatly assist us in conducting a thorough investigation and addressing any potential security issues.</p>
<p>Thank you for your attention to this reminder. We look forward to receiving your response soon.</p>
<p>Sincerely,</p>
<p>Groww Team
', 'TransactionId#:[(${transactionId})] | Hold on Identified Risky Transaction', 'RiskyMerchantSettlements', NULL, 'response_from_merchant', 11);
INSERT INTO ui.emailtemplate (id, body, subject, associateid, response, camunda_message_name, itenantid) VALUES (16, '<p>Dear Merchant Partner,</p> 
<p>Greetings from Groww.</p> 
<p>We are delighted to inform you that your payment will be released in 4-5 working days.  The payment will be credited to your registered bank account with us. In case, any change in bank account, kindly inform us for the same within 3 working days.</p>
<p>We appreciate your patience in the interim.</p> 
<p>Thank you,</p>
<p>Team Groww</p> ', 'TransactionId#:[(${transactionId})] | Transaction Settlement Processed', 'RiskyMerchantSettlements', NULL, NULL, 11);
INSERT INTO ui.emailtemplate (id, body, subject, associateid, response, camunda_message_name, itenantid) VALUES (15, '<p>Dear Merchant Partner, </p>
<p>Greetings from Groww.</p>
<p>We wish to inform you that we have received your documents. The concerned team will review them and get back to you within next 1 working days. </p>
<p>We appreciate your patience in the interim.</p>
<p>Thank you, </p>
<p>Team Groww</p> ', 'TransactionId#:[(${transactionId})] | Documents Received', 'RiskyMerchantSettlements', NULL, NULL, 11);
INSERT INTO ui.emailtemplate (id, body, subject, associateid, response, camunda_message_name, itenantid) VALUES (11, '<p>Dear Merchant Partner, </p>
Greetings from Groww. 
Groww has always worked to maintain a trusted environment and safeguard merchant partners from fraudulent transactions. We wish to inform you that as per the Groww'' Transaction Monitoring System, the following transactions were found to be inconsistent. These transactions are being put on hold till further review. 

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
<p>Please note that the Groww team will review the documents, and the payment will be released once the documents are deemed valid.</p>
<p>We regret the inconvenience caused and appreciate your cooperation in this regard.</p>
<p>Please contact us at 0120-4033600 or write to <span th:text="${emailid}"></span> for any further assistance.</p>
<p>Thank you,<p>
<p>Team Groww</p> ', 'TransactionId#:[(${transactionId})] | Hold on Identified Risky Transaction', 'RiskyMerchantSettlements', NULL, 'response_from_merchant', 11);
INSERT INTO ui.emailtemplate (id, body, subject, associateid, response, camunda_message_name, itenantid) VALUES (12, '<p>Dear Merchant Partner, </p> 
<p>Greetings from Groww.</p>
<p>We wish to inform you that our team is unable to ascertain the validity of the transaction basis the documents shared by you earlier. Request you to kindly share the revised below mentioned documents at the earliest to release your payment. </p>
<ol>
<li th:each="doc:${docList}" th:text="${doc}"></li>
</ol>
<p>-------------------------------------</p>
<p>We appreciate your prompt response in this regard.</p>
<p>Thank you,</p>
<p>Team Groww</p> ', 'TransactionId#:[(${transactionId})] | Request for Information Regarding Identified Risky Transaction', 'RiskyMerchantSettlements', NULL, 'response_from_merchant', 11);
INSERT INTO ui.emailtemplate (id, body, subject, associateid, response, camunda_message_name, itenantid) VALUES (17, '<p>Dear Merchant Partner, </p>
<p>Greetings from Groww.</p> 
<p>Groww has always worked to maintain a trusted environment and safeguard merchant partners from fraudulent transactions. We wish to inform you that as per the Groww'' Transaction Monitoring System, the following transactions were found to be inconsistent. These transactions are being further review.</p> 

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
<p>Thank you,<p>
<p>Team Groww</p> ', 'TransactionId#:[(${transactionId})] | Request for Information Regarding Identified Risky Transaction', 'RiskyMerchantSettlements', NULL, 'response_from_merchant', 11);
INSERT INTO ui.emailtemplate (id, body, subject, associateid, response, camunda_message_name, itenantid) VALUES (21, '<p>Dear Merchant Partner, </p>
Greetings from Groww. 
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
<p>Thank you,<p>
<p>Team Groww</p> ', 'TransactionId#:[(${transactionId})] | Transaction Settlement Processed', 'RiskyMerchantSettlements', NULL, NULL, 11);

-- ----------------------------------------ui.workflowmasters

INSERT INTO ui.workflowmasters (workflowid, workflowname, workflowkey, manual_display_name, is_manual_creation, is_filter_display, manual_attribs, idecisionid, itenantid, manualworkflowid, filterparams, displayConfig)
 VALUES (16, 'Risky Merchant Settlements - Groww', 'GrowwRMS', 'Risky Merchant Settlements - Groww', true, true,
  '{"type": "realtime-multitrans", "display": [{"col": 3, "row": 0, "type": "select", "label": "Level", "options": [{"label": "Account", "value": "account"}, {"label": "VPA", "value": "vpa"}], "required": true, "valueKeyName": "level"}, {"col": 3, "row": 0, "type": "text", "label": "Address", "disabled": false, "required": true, "apiKeyName": "", "valueKeyName": "address"}, {"col": 3, "row": 1, "type": "text", "label": "Add Details To Task", "disabled": true, "required": true, "defaultValue": "Add Details To Task", "valueKeyName": "details"}, {"col": 3, "row": 1, "type": "text", "label": "TXN ID", "disabled": false, "required": true, "apiKeyName": "", "valueKeyName": "txnid"}, {"col": 1, "row": 1, "icon": "search", "type": "icon", "label": "", "disabledIf": {"jsonLogic": {"or": [{"if": [{"==": [{"var": "values.address"}, null]}, true, false]}, {"if": [{"==": [{"var": "values.address"}, ""]}, true, false]}, {"if": [{"==": [{"var": "values.level"}, null]}, true, false]}, {"if": [{"==": [{"var": "values.level"}, ""]}, true, false]}, {"if": [{"==": [{"var": "values.txnid"}, null]}, true, false]}, {"if": [{"==": [{"var": "values.txnid"}, ""]}, true, false]}]}}, "onClickAction": [{"key": "callApi", "url": "/api/v1/case-management/tasks/workflows/manual-creation/get-realtime-trans/${address}/${level}/${txnid}/${workflow}/${tenant}", "headers": [{"name": "JWT"}], "uiserver": true, "callApiIf": {"jsonLogic": {"and": [{"if": [{"!=": [{"var": "values.address"}, null]}, true, false]}, {"if": [{"!=": [{"var": "values.address"}, ""]}, true, false]}, {"if": [{"!=": [{"var": "values.level"}, null]}, true, false]}, {"if": [{"!=": [{"var": "values.level"}, ""]}, true, false]}, {"if": [{"!=": [{"var": "values.txnid"}, null]}, true, false]}, {"if": [{"!=": [{"var": "values.txnid"}, ""]}, true, false]}]}}, "RequestType": "GET", "paramsValues": [{"key": "values.address"}, {"key": "values.level"}, {"key": "values.txnid"}, {"key": "values.workflow"}, {"key": "values.tenant"}], "responseKeyName": "batchTransaction"}]}, {"col": 3, "row": 2, "type": "text", "label": "VPA Name", "disabled": true, "required": true, "defaultValue": {"keyName": "apiResponse.batchTransaction.Transaction.observations.payeeVPA.vpaName"}, "valueKeyName": "vpaName", "renderCondition": {"jsonLogic": {"and": [{"if": [{"==": [{"var": "values.level"}, "vpa"]}, true, false]}, {"if": [{"!=": [{"var": "apiResponse.batchTransaction"}, null]}, true, false]}, {"if": [{"==": [{"var": "apiResponse.batchTransaction.side"}, "payee"]}, true, false]}]}}}, {"col": 3, "row": 2, "type": "text", "label": "VPA Address", "disabled": true, "required": true, "defaultValue": {"keyName": "apiResponse.batchTransaction.Transaction.observations.payeeVPA.externalId"}, "valueKeyName": "vpaAddress", "renderCondition": {"jsonLogic": {"and": [{"if": [{"==": [{"var": "values.level"}, "vpa"]}, true, false]}, {"if": [{"!=": [{"var": "apiResponse.batchTransaction"}, null]}, true, false]}, {"if": [{"==": [{"var": "apiResponse.batchTransaction.side"}, "payee"]}, true, false]}]}}}, {"col": 3, "row": 2, "type": "text", "label": "VPA Name", "disabled": true, "required": true, "defaultValue": {"keyName": "apiResponse.batchTransaction.Transaction.observations.payerVPA.vpaName"}, "valueKeyName": "vpaName", "renderCondition": {"jsonLogic": {"and": [{"if": [{"==": [{"var": "values.level"}, "vpa"]}, true, false]}, {"if": [{"!=": [{"var": "apiResponse.batchTransaction"}, null]}, true, false]}, {"if": [{"==": [{"var": "apiResponse.batchTransaction.side"}, "payer"]}, true, false]}]}}}, {"col": 3, "row": 2, "type": "text", "label": "VPA Address", "disabled": true, "required": true, "defaultValue": {"keyName": "apiResponse.batchTransaction.Transaction.observations.payerVPA.externalId"}, "valueKeyName": "vpaAddress", "renderCondition": {"jsonLogic": {"and": [{"if": [{"==": [{"var": "values.level"}, "vpa"]}, true, false]}, {"if": [{"!=": [{"var": "apiResponse.batchTransaction"}, null]}, true, false]}, {"if": [{"==": [{"var": "apiResponse.batchTransaction.side"}, "payer"]}, true, false]}]}}}, {"col": 3, "row": 2, "type": "text", "label": "Customer Name", "disabled": true, "required": true, "defaultValue": {"keyName": "apiResponse.batchTransaction.Transaction.observations.payeeVPA.account.customer.customerName"}, "valueKeyName": "customerName", "renderCondition": {"jsonLogic": {"and": [{"if": [{"==": [{"var": "values.level"}, "account"]}, true, false]}, {"if": [{"!=": [{"var": "apiResponse.batchTransaction"}, null]}, true, false]}, {"if": [{"==": [{"var": "apiResponse.batchTransaction.side"}, "payee"]}, true, false]}]}}}, {"col": 3, "row": 2, "type": "text", "label": "Account Name", "disabled": true, "required": true, "defaultValue": {"keyName": "apiResponse.batchTransaction.Transaction.observations.payeeVPA.account.accountName"}, "valueKeyName": "accountName", "renderCondition": {"jsonLogic": {"and": [{"if": [{"==": [{"var": "values.level"}, "account"]}, true, false]}, {"if": [{"!=": [{"var": "apiResponse.batchTransaction"}, null]}, true, false]}, {"if": [{"==": [{"var": "apiResponse.batchTransaction.side"}, "payee"]}, true, false]}]}}}, {"col": 3, "row": 2, "type": "text", "label": "Account Address", "disabled": true, "required": true, "defaultValue": {"keyName": "apiResponse.batchTransaction.Transaction.observations.payeeVPA.account.externalId"}, "valueKeyName": "accountAddress", "renderCondition": {"jsonLogic": {"and": [{"if": [{"==": [{"var": "values.level"}, "account"]}, true, false]}, {"if": [{"!=": [{"var": "apiResponse.batchTransaction"}, null]}, true, false]}, {"if": [{"==": [{"var": "apiResponse.batchTransaction.side"}, "payee"]}, true, false]}]}}}, {"col": 3, "row": 2, "type": "text", "label": "Customer Name", "disabled": true, "required": true, "defaultValue": {"keyName": "apiResponse.batchTransaction.Transaction.observations.payerVPA.account.customer.customerName"}, "valueKeyName": "customerName", "renderCondition": {"jsonLogic": {"and": [{"if": [{"==": [{"var": "values.level"}, "account"]}, true, false]}, {"if": [{"!=": [{"var": "apiResponse.batchTransaction"}, null]}, true, false]}, {"if": [{"==": [{"var": "apiResponse.batchTransaction.side"}, "payer"]}, true, false]}]}}}, {"col": 3, "row": 2, "type": "text", "label": "Account Name", "disabled": true, "required": true, "defaultValue": {"keyName": "apiResponse.batchTransaction.Transaction.observations.payerVPA.account.accountName"}, "valueKeyName": "accountName", "renderCondition": {"jsonLogic": {"and": [{"if": [{"==": [{"var": "values.level"}, "account"]}, true, false]}, {"if": [{"!=": [{"var": "apiResponse.batchTransaction"}, null]}, true, false]}, {"if": [{"==": [{"var": "apiResponse.batchTransaction.side"}, "payer"]}, true, false]}]}}}, {"col": 3, "row": 2, "type": "text", "label": "Account Address", "disabled": true, "required": true, "defaultValue": {"keyName": "apiResponse.batchTransaction.Transaction.observations.payerVPA.account.externalId"}, "valueKeyName": "accountAddress", "renderCondition": {"jsonLogic": {"and": [{"if": [{"==": [{"var": "values.level"}, "account"]}, true, false]}, {"if": [{"!=": [{"var": "apiResponse.batchTransaction"}, null]}, true, false]}, {"if": [{"==": [{"var": "apiResponse.batchTransaction.side"}, "payer"]}, true, false]}]}}}, {"col": 9, "row": 3, "type": "select", "label": "Select Alert(s)", "isMulti": true, "required": true, "apiOptions": {"keyName": "rulesDropDown"}, "valueKeyName": "alerts", "onChangeAction": [{"key": "changeValues", "keyToBeChanged": "score", "changeValuesLogic": {"jsonLogic": {"if": [{"==": [{"var": "apiResponse.aggregateType"}, "sum"]}, {"reduce": [{"var": "values.alerts"}, {"+": [{"var": "current.score"}, {"var": "accumulator"}]}, 0]}, {"==": [{"var": "apiResponse.aggregateType"}, "max"]}, {"custommax": [{"var": "values.alerts"}]}]}}}], "renderCondition": {"jsonLogic": {"and": [{"if": [{"!=": [{"var": "apiResponse.batchTransaction"}, null]}, true, false]}]}}}, {"col": 3, "row": 3, "type": "number", "label": "Score", "disabled": true, "required": true, "valueKeyName": "score", "renderCondition": {"jsonLogic": {"and": [{"if": [{"!=": [{"var": "apiResponse.batchTransaction"}, null]}, true, false]}]}}}, {"type": "finalpostbody", "bodyStructure": {"Result": {"type": "json", "value": {"value": "apiResponse.batchTransaction.Result"}}, "Transaction": {"type": "json", "value": {"value": "apiResponse.batchTransaction.Transaction"}}, "manualScore": {"type": "long", "value": {"value": "values.score"}}, "manualAlerts": {"type": "json", "value": {"value": "values.alerts"}}, "isCreatedManually": {"type": "Boolean", "value": true}}}]}', 1035, 11, 16,
  '[
  {
    "name": "TransactionClass",
    "data_type": "string",
    "value_config": {
      "value": "/txn/class",
      "extract_from": "trans_json"
    }
  },
  {
    "name": "OfflineOnline",
    "data_type": "string",
    "value_config": {
      "value": "/txn/attribs/txn_type",
      "extract_from": "trans_json"
    }
  }
]'
,'[
  {
    "type": "sortingOptions",
    "render": false,
    "compareValue": true,
    "options": [
      {
        "value": "Created Date",
        "compareValue": {
          "value": {
            "jsonLogic": {
              "var": "data.leftPanelLogic.sortBy.value"
            }
          }
        },
        "key": "parameters.sorting[]",
        "bodyValue": {
          "open": {
            "value": "starttime",
            "key": "sortBy"
          },
          "my": {
            "value": "starttime",
            "key": "sortBy"
          },
          "myclosed": {
            "value": "starttime",
            "key": "sortBy"
          },
          "closed": {
            "value": "starttime",
            "key": "sortBy"
          }
        },
        "finalbodyvalue": {
          "keysToSet": [
            {
              "name": "sortBy",
              "value": "created",
              "setKeyIf": {
                "or": [
                  {
                    "if": [
                      {
                        "==": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Open"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "==": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            },
            {
              "name": "sortBy",
              "value": "startTime",
              "setKeyIf": {
                "or": [
                  {
                    "if": [
                      {
                        "==": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "==": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            },
            {
              "name": "sortOrder",
              "value": {
                "jsonLogic": {
                  "var": "data.leftPanelLogic.filterSortDir"
                }
              }
            }
          ]
        }
      },
      {
        "value": "Risk Score",
        "compareValue": {
          "value": {
            "jsonLogic": {
              "var": "data.leftPanelLogic.sortBy.value"
            }
          }
        },
        "bodyValue": {
          "value": "riskscore",
          "key": "sortBy"
        },
        "key": "parameters.sorting[]",
        "finalbodyvalue": {
          "keysToSet": [
            {
              "name": "sortBy",
              "value": "processVariable"
            },
            {
              "name": "sortOrder",
              "value": {
                "jsonLogic": {
                  "var": "data.leftPanelLogic.filterSortDir"
                }
              }
            },
            {
              "name": "parameters",
              "value": {
                "variable": "RiskScore",
                "type": "long"
              }
            }
          ]
        }
      },
      {
        "compareValue": {
          "value": {
            "jsonLogic": {
              "var": "data.leftPanelLogic.sortBy.value"
            }
          }
        },
        "value": "Transaction Amount",
        "bodyValue": {
          "value": "amount",
          "key": "sortBy"
        },
        "key": "parameters.sorting[]",
        "finalbodyvalue": {
          "keysToSet": [
            {
              "name": "sortBy",
              "value": "processVariable"
            },
            {
              "name": "sortOrder",
              "value": {
                "jsonLogic": {
                  "var": "data.leftPanelLogic.filterSortDir"
                }
              }
            },
            {
              "name": "parameters",
              "value": {
                "variable": "TransactionAmount",
                "type": "double"
              }
            }
          ]
        }
      }
    ]
  },
  {
    "name": "TenantId",
    "label": "Tenant",
    "onChangeAction": [
      {
        "key": "callApi",
        "beforeCallAction": [
          {
            "key": "resetFormData"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "filteroptions"
          }
        ],
        "requestType": "POST",
        "route": "/api/v1/admin/app-users/get-all-workflows/${menuName}",
        "paramValues": [
          {
            "value": "Tasks"
          }
        ],
        "body": {
          "key": "data.formData.TenantId"
        },
        "onApiSuccess": [
          {
            "key": "setIndexHttpData",
            "keyToSet": "workFlowNamesDrop"
          }
        ]
      },
      {
        "key": "callApi",
        "beforeCallAction": [
          {
            "key": "resetFormData"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "filteroptions"
          }
        ],
        "requestType": "GET",
        "route": "/api/v1/task/filter/config/${paramOne}/${paramTwo}",
        "paramValues": [
          {
            "key": "data.formData.TenantId[0]"
          },
          {
            "key": "data.formData.CaseType[0]"
          }
        ],
        "onApiSuccess": [
          {
            "key": "setIndexHttpData",
            "keyToSet": "filter.inputjson"
          }
        ]
      }
    ],
    "type": "multiSelect",
    "maxSelectable": 1,
    "key": "parameters.tenantIdIn",
    "keyToExtract": "itenantId",
    "value": {
      "jsonLogic": {
        "var": "data.formData.TenantId"
      }
    },
    "defaultValue": {
      "setDefaultValueIf": [
        {
          "action": "checkLength",
          "key": "data.formData.TenantId",
          "gteq": 1,
          "FALSE": {
            "key": "data.indexHttpData.tenantOptions",
            "map": "itenantId",
            "type": "array"
          },
          "TRUE": {
            "key": "data.formData.TenantId",
            "type": "array"
          }
        }
      ]
    },
    "keyType": "array",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.tenantOptions"
      }
    }
  },
  {
    "name": "CaseType",
    "onChangeAction": [
      {
        "key": "callApi",
        "beforeCallAction": [
          {
            "key": "resetFormData"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "filteroptions"
          }
        ],
        "requestType": "GET",
        "route": "/api/v1/task/filter/config/${paramOne}/${paramTwo}",
        "paramValues": [
          {
            "key": "data.formData.TenantId[0]"
          },
          {
            "key": "data.formData.CaseType[0]"
          }
        ],
        "onApiSuccess": [
          {
            "key": "setIndexHttpData",
            "keyToSet": "filter.inputjson"
          }
        ]
      }
    ],
    "bodyValue": {
      "jsonLogic": {
        "var": "data.formData.CaseType"
      },
      "key": "defKey"
    },
    "label": "Case Type",
    "maxSelectable": 1,
    "type": "multiSelect",
    "key": {
      "value": "parameters.processDefinitionKeyIn",
      "closed": {
        "key": "parameters.orQueries",
        "outputFormat": {
          "type": "arrayofobjects",
          "value": {
            "jsonLogic": {
              "var": "data.indexHttpData.workFlowNamesDrop"
            },
            "keyToCheck": "workflowKey",
            "compareWith": "data.newValue",
            "keyToExtract": "label"
          },
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "WorkflowName"
              },
              {
                "key": "value",
                "value": {
                  "keyToExtract": "label",
                  "key": "value"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      },
      "myclosed": {
        "key": "parameters.orQueries[].processVariables",
        "outputFormat": {
          "type": "arrayofobjects",
          "value": {
            "jsonLogic": {
              "var": "data.indexHttpData.workFlowNamesDrop"
            },
            "keyToCheck": "workflowKey",
            "compareWith": "data.newValue",
            "keyToExtract": "label"
          },
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "WorkflowName"
              },
              {
                "key": "value",
                "value": {
                  "keyToExtract": "label",
                  "key": "value"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      }
    },
    "keyToExtract": "workflowKey",
    "value": {
      "jsonLogic": {
        "var": "data.formData.CaseType"
      }
    },
    "defaultValue": {
      "setDefaultValueIf": [
        {
          "action": "checkLength",
          "key": "data.formData.CaseType",
          "gteq": 1,
          "FALSE": {
            "key": "data.indexHttpData.workFlowNamesDrop",
            "map": "workflowKey",
            "type": "array"
          },
          "TRUE": {
            "key": "data.formData.CaseType",
            "type": "array"
          }
        }
      ]
    },
    "keyType": "array",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.workFlowNamesDrop"
      }
    }
  },
  {
    "name": "startDate,endDate,startedAfter,finsihedBefore",
    "bodyValue": {
      "lodashKey": "data.formData.startDate,data.formData.endDate,data.formData.startDate,data.formData.endDate",
      "key": "startDate,endDate,startedAfter,finsihedBefore"
    },
    "label": "Date Range",
    "type": "dateRange",
    "valueKey": "dataRangeValueKey",
    "key": {
      "open": {
        "key": "parameters.createdAfter,parameters.createdBefore",
        "lodashKey": "data.formData.startDate,data.formData.endDate"
      },
      "my": {
        "key": "parameters.createdAfter,parameters.createdBefore",
        "lodashKey": "data.formData.startDate,data.formData.endDate"
      },
      "closed": {
        "key": "parameters.startedAfter,parameters.finsihedBefore",
        "lodashKey": "data.formData.startDate,data.formData.endDate"
      },
      "myclosed": {
        "key": "parameters.startedAfter,parameters.finsihedBefore",
        "lodashKey": "data.formData.startDate,data.formData.endDate"
      }
    },
    "multipleKeyName": "[0],[1],[0],[1]"
  },
  {
    "name": "Status",
    "label": "Status",
    "type": "select",
    "isClearable": true,
    "key": {
      "value": "parameters.taskDefinitionKeyIn[]",
      "lodashKey": "data.formData.Status"
    },
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.statusFilterDropDowns"
      }
    }
  },
  {
    "compareOperator": {
      "type": "select",
      "name": "TransactionAmountCompareOperator",
      "options": [
        {
          "label": "=",
          "value": "eq"
        },
        {
          "label": "<",
          "value": "lt"
        },
        {
          "label": ">",
          "value": "gt"
        }
      ]
    },
    "name": "TransactionAmount",
    "label": "Transaction Amount",
    "type": "number",
    "min": 0,
    "key": {
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionAmount",
        "outputFormat": {
          "type": "object",
          "keys": {
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.TransactionAmountCompareOperator"
                        },
                        null
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            },
            "items": [
              {
                "key": "name",
                "value": "TransactionAmount"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionAmount",
                  "finalbodyMultiplier": 100
                }
              },
              {
                "key": "operator",
                "value": {
                  "key": "data.formData.TransactionAmountCompareOperator"
                }
              }
            ]
          }
        }
      },
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionAmount",
        "outputFormat": {
          "type": "object",
          "keys": {
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.TransactionAmountCompareOperator"
                        },
                        null
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            },
            "items": [
              {
                "key": "name",
                "value": "TransactionAmount"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionAmount",
                  "finalbodyMultiplier": 100
                }
              },
              {
                "key": "operator",
                "value": {
                  "key": "data.formData.TransactionAmountCompareOperator"
                }
              }
            ]
          }
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.TransactionAmount",
        "outputFormat": {
          "type": "object",
          "keys": {
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.TransactionAmountCompareOperator"
                        },
                        null
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            },
            "items": [
              {
                "key": "name",
                "value": "TransactionAmount"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionAmount",
                  "finalbodyMultiplier": 100
                }
              },
              {
                "key": "operator",
                "value": {
                  "key": "data.formData.TransactionAmountCompareOperator"
                }
              }
            ]
          }
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionAmount",
        "outputFormat": {
          "type": "object",
          "keys": {
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.TransactionAmountCompareOperator"
                        },
                        null
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            },
            "items": [
              {
                "key": "name",
                "value": "TransactionAmount"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionAmount",
                  "finalbodyMultiplier": 100
                }
              },
              {
                "key": "operator",
                "value": {
                  "key": "data.formData.TransactionAmountCompareOperator"
                }
              }
            ]
          }
        }
      }
    }
  },
  {
    "name": "LevelType",
    "type": "object",
    "key": {
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.LevelType",
        "outputFormat": {
          "type": "object",
          "keys": {
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        null
                      ]
                    },
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        ""
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            },
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.LevelType"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Address"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "keys2": {
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "==": [
                        {
                          "var": "data.formData.typeSelectMain"
                        },
                        "address"
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            },
            "items": [
              {
                "key": "name",
                "value": "basedon"
              },
              {
                "key": "value",
                "value": {
                  "jsonLogic": {
                    "if": [
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "Account"
                            ]
                          }
                        ]
                      },
                      "account",
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "VPA"
                            ]
                          }
                        ]
                      },
                      "vpa",
                      "Invalid input"
                    ]
                  }
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      },
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.LevelType",
        "outputFormat": {
          "type": "object",
          "keys": {
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        null
                      ]
                    },
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        ""
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            },
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.LevelType"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Address"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "keys2": {
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "==": [
                        {
                          "var": "data.formData.typeSelectMain"
                        },
                        "address"
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            },
            "items": [
              {
                "key": "name",
                "value": "basedon"
              },
              {
                "key": "value",
                "value": {
                  "jsonLogic": {
                    "if": [
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "Account"
                            ]
                          }
                        ]
                      },
                      "account",
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "VPA"
                            ]
                          }
                        ]
                      },
                      "vpa",
                      "Invalid input"
                    ]
                  }
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.LevelType",
        "outputFormat": {
          "setKeyIf": {
            "and": [
              {
                "if": [
                  {
                    "!=": [
                      {
                        "var": "data.formData.Address"
                      },
                      null
                    ]
                  },
                  {
                    "!=": [
                      {
                        "var": "data.formData.Address"
                      },
                      ""
                    ]
                  },
                  true,
                  false
                ]
              }
            ]
          },
          "type": "object",
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.LevelType"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Address"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "keys2": {
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "==": [
                        {
                          "var": "data.formData.typeSelectMain"
                        },
                        "address"
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            },
            "items": [
              {
                "key": "name",
                "value": "basedon"
              },
              {
                "key": "value",
                "value": {
                  "jsonLogic": {
                    "if": [
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "Account"
                            ]
                          }
                        ]
                      },
                      "account",
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "VPA"
                            ]
                          }
                        ]
                      },
                      "vpa",
                      "Invalid input"
                    ]
                  }
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.LevelType",
        "outputFormat": {
          "type": "object",
          "keys": {
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        null
                      ]
                    },
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        ""
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            },
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.LevelType"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Address"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "keys2": {
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "==": [
                        {
                          "var": "data.formData.typeSelectMain"
                        },
                        "address"
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            },
            "items": [
              {
                "key": "name",
                "value": "basedon"
              },
              {
                "key": "value",
                "value": {
                  "jsonLogic": {
                    "if": [
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "Account"
                            ]
                          }
                        ]
                      },
                      "account",
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "VPA"
                            ]
                          }
                        ]
                      },
                      "vpa",
                      "Invalid input"
                    ]
                  }
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      }
    },
    "fields": [
      {
        "name": "levelSelectMain",
        "label": "Level",
        "type": "select",
        "options": [
          {
            "label": "Account",
            "value": "Account"
          },
          {
            "label": "VPA",
            "value": "VPA"
          }
        ],
        "onChangeAction": [
          {
            "key": "setOtherKey",
            "keyToSet": "LevelType",
            "keyValue": {
              "jsonLogic": {
                "if": [
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "Account"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payer"
                        ]
                      }
                    ]
                  },
                  "payerAccount",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "Account"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payee"
                        ]
                      }
                    ]
                  },
                  "payeeAccount",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "VPA"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payer"
                        ]
                      }
                    ]
                  },
                  "payer",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "VPA"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payee"
                        ]
                      }
                    ]
                  },
                  "payee",
                  "address"
                ]
              }
            }
          }
        ]
      },
      {
        "name": "typeSelectMain",
        "label": "Type",
        "type": "select",
        "options": [
          {
            "label": "Payer",
            "value": "Payer"
          },
          {
            "label": "Payee",
            "value": "Payee"
          },
          {
            "label": "Profile",
            "value": "address"
          }
        ],
        "onChangeAction": [
          {
            "key": "setOtherKey",
            "keyToSet": "LevelType",
            "keyValue": {
              "jsonLogic": {
                "if": [
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "Account"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payer"
                        ]
                      }
                    ]
                  },
                  "payerAccount",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "Account"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payee"
                        ]
                      }
                    ]
                  },
                  "payeeAccount",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "VPA"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payer"
                        ]
                      }
                    ]
                  },
                  "payer",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "VPA"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payee"
                        ]
                      }
                    ]
                  },
                  "payee",
                  "address"
                ]
              }
            }
          }
        ]
      }
    ]
  },
  {
    "name": "Address",
    "label": "Address",
    "type": "text"
  },
  {
    "name": "NoOfCases",
    "label": "No Of Cases",
    "type": "select",
    "options": [
      {
        "label": "20",
        "value": 20
      },
      {
        "label": "30",
        "value": 30
      },
      {
        "label": "50",
        "value": 50
      }
    ],
    "bodyValue": {
      "lodashKey": "data.formData.NoOfCases",
      "key": "maxResult"
    }
  },
  {
    "name": "RiskScore",
    "label": "Risk Score ( >= )",
    "type": "number",
    "min": 0,
    "max": 100,
    "key": {
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.RiskScore",
        "outputFormat": {
          "type": "object",
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "RiskScore"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.RiskScore"
                }
              },
              {
                "key": "operator",
                "value": "gteq"
              }
            ]
          }
        }
      },
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.RiskScore",
        "outputFormat": {
          "type": "object",
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "RiskScore"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.RiskScore"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.RiskScore",
        "outputFormat": {
          "type": "object",
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "RiskScore"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.RiskScore"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.RiskScore",
        "outputFormat": {
          "type": "object",
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "RiskScore"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.RiskScore"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      }
    }
  },
  {
    "name": "Rule",
    "label": "Rule",
    "type": "select",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.ruleDropDownOption"
      }
    },
    "key": {
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.Rule",
        "outputFormat": {
          "type": "object",
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      },
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.Rule",
        "outputFormat": {
          "type": "object",
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.Rule",
        "outputFormat": {
          "type": "object",
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.Rule",
        "outputFormat": {
          "type": "object",
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      }
    }
  },
  {
    "name": "TransactionClass",
    "label": "Transaction Class",
    "type": "select",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.classDropDownOption"
      }
    },
    "key": {
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionClass",
        "outputFormat": {
          "type": "object",
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionClass"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionClass"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      },
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionClass",
        "outputFormat": {
          "type": "object",
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionClass"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionClass"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.TransactionClass",
        "outputFormat": {
          "type": "object",
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionClass"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionClass"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionClass",
        "outputFormat": {
          "type": "object",
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionClass"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionClass"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      }
    }
  },
  {
    "name": "OfflineOnline",
    "label": "Offline / Online",
    "type": "text",
    "key": {
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.OfflineOnline",
        "outputFormat": {
          "type": "object",
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "OfflineOnline"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.OfflineOnline"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      },
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.OfflineOnline",
        "outputFormat": {
          "type": "object",
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "OfflineOnline"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.OfflineOnline"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.OfflineOnline",
        "outputFormat": {
          "type": "object",
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "OfflineOnline"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.OfflineOnline"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.OfflineOnline",
        "outputFormat": {
          "type": "object",
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "OfflineOnline"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.OfflineOnline"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          }
        }
      }
    }
  }
]'
);

-- ----------------------------------------ui.tasklhsmap

INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 0, 5, 16, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (2, 0, 5, 16, 2, '{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 1, 5, 16, 12, '{"tag": "h4", "path": "this.State", "type": "default"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (1, 2, 5, 16, 4, '{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 2, 5, 16, 8, '{"tag": "span", "path": "this.variables.current_final_status", "type": "default"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (1, 0, 5, 16, 6, '{"tag": "span", "path": "this.variables.txndate", "type": "timestamp"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 0, 1, 16, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (1, 0, 1, 16, 6, '{"tag": "span", "path": "this.created", "type": "timestamp"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (2, 0, 1, 16, 2, '{"tag": "span", "path": "this.variables.RiskScore", "type": "score"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 1, 1, 16, 12, '{"tag": "span", "path": "this.name", "type": "default"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 2, 1, 16, 4, '{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount", "className": "d-inline pull-left"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (1, 2, 1, 16, 8, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default", "className": "d-inline pull-right"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 0, 2, 16, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (1, 0, 2, 16, 6, '{"tag": "span", "path": "this.created", "type": "timestamp"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (2, 0, 2, 16, 2, '{"tag": "span", "path": "this.variables.RiskScore", "type": "score"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 1, 2, 16, 12, '{"tag": "span", "path": "this.name", "type": "default"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 2, 2, 16, 4, '{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount", "className": "d-inline pull-left"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (1, 2, 2, 16, 8, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default", "className": "d-inline pull-right"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 0, 3, 16, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (1, 0, 3, 16, 6, '{"tag": "span", "path": "this.startTime", "type": "timestamp"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (2, 0, 3, 16, 2, '{"tag": "span", "path": "this.variables.RiskScore", "type": "score"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 1, 3, 16, 12, '{"tag": "span", "path": "this.name", "type": "default"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 2, 3, 16, 4, '{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount", "className": "d-inline pull-left"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (1, 2, 3, 16, 8, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default", "className": "d-inline pull-right"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 0, 4, 16, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (1, 0, 4, 16, 6, '{"tag": "span", "path": "this.created", "type": "timestamp"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (2, 0, 4, 16, 2, '{"tag": "span", "path": "this.variables.RiskScore", "type": "score"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 1, 4, 16, 4, '{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount", "className": "d-inline pull-left"}', 11);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (1, 1, 4, 16, 8, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default", "className": "d-inline pull-right"}', 11);

-- ----------------------------------------ui.groupdesc

INSERT INTO ui.groupdesc (igroupid, dtapproverstamp, dtentrystamp, vcgroupid, vcgroupname, vcgrouptype, iapproveruserid, ientryuserid, istatus, itenantid, iorgid) VALUES (2038, NULL, NULL, 'level1', 'L1', 'WORKFLOW', NULL, NULL, 1, 11, NULL);
INSERT INTO ui.groupdesc (igroupid, dtapproverstamp, dtentrystamp, vcgroupid, vcgroupname, vcgrouptype, iapproveruserid, ientryuserid, istatus, itenantid, iorgid) VALUES (2055, NULL, NULL, 'level2', 'L2', 'WORKFLOW', NULL, NULL, 1, 11, NULL);
INSERT INTO ui.groupdesc (igroupid, dtapproverstamp, dtentrystamp, vcgroupid, vcgroupname, vcgrouptype, iapproveruserid, ientryuserid, istatus, itenantid, iorgid) VALUES (2056, NULL, NULL, 'level3', 'L3', 'WORKFLOW', NULL, NULL, 1, 11, NULL);

-- ----------------------------------------ui.grouptotaskfiltermap

INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (593, 9, 2038, 9, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (575, 8, 2038, 8, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (557, 7, 2038, 7, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (539, 6, 2038, 6, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (521, 5, 2038, 5, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (503, 4, 2038, 4, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (485, 3, 2038, 3, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (467, 2, 2038, 2, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (449, 1, 2038, 1, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (594, 9, 2055, 9, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (576, 8, 2055, 8, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (558, 7, 2055, 7, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (540, 6, 2055, 6, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (522, 5, 2055, 5, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (504, 4, 2055, 4, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (486, 3, 2055, 3, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (468, 2, 2055, 2, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (450, 1, 2055, 1, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (595, 9, 2056, 9, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (577, 8, 2056, 8, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (559, 7, 2056, 7, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (541, 6, 2056, 6, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (523, 5, 2056, 5, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (505, 4, 2056, 4, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (487, 3, 2056, 3, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (469, 2, 2056, 2, 11);
INSERT INTO ui.grouptotaskfiltermap (igrouptotaskfilterid, iposition, igroupid, itaskfilterid, itenantid) VALUES (451, 1, 2056, 1, 11);

-- ----------------------------------------ui.panelaccessmap


INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid, itenantid) VALUES (297, 1, 2038, 16, 11);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid, itenantid) VALUES (298, 2, 2038, 16, 11);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid, itenantid) VALUES (299, 3, 2038, 16, 11);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid, itenantid) VALUES (300, 4, 2038, 16, 11);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid, itenantid) VALUES (301, 5, 2038, 16, 11);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid, itenantid) VALUES (302, 6, 2038, 16, 11);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid, itenantid) VALUES (303, 1, 2055, 16, 11);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid, itenantid) VALUES (304, 2, 2055, 16, 11);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid, itenantid) VALUES (305, 3, 2055, 16, 11);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid, itenantid) VALUES (306, 4, 2055, 16, 11);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid, itenantid) VALUES (307, 5, 2055, 16, 11);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid, itenantid) VALUES (308, 6, 2055, 16, 11);
