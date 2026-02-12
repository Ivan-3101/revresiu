update ui.workflowmasters set is_manual_creation=true where workflowid=16;
UPDATE ui.workflowmasters SET
manual_attribs = '[
  {
    "label": "Level",
    "type": "select",
    "valueKeyName": "level",
    "required": true,
    "row": 0,
    "col": 3,
    "options": [
      {
        "label": "Account",
        "value": "account"
      },
      {
        "label": "VPA",
        "value": "vpa"
      }
    ]
  },

  {
    "label": "Address",
    "valueKeyName": "address",
    "type": "text",
    "disabled": false,
    "apiKeyName": "",
    "required": true,
    "row": 0,
    "col": 3
  },
  {
    "label": "Add Details To Task",
    "type": "text",
    "valueKeyName": "details",
    "required": true,
    "disabled": true,
    "defaultValue": "Add Details To Task",
    "row": 1,
    "col": 3
  },
  {
    "label": "TXN ID",
    "valueKeyName": "txnid",
    "type": "text",
    "disabled": false,
    "apiKeyName": "",
    "required": true,
    "row": 1,
    "col": 3
  },
  {
    "label": "",
    "type": "icon",
    "icon": "search",
    "row": 1,
    "col": 1,
    "onClickAction": [
      {
        "key": "callApi",
        "responseKeyName": "batchTransaction",
        "RequestType": "GET",
        "headers": [{ "name": "JWT" }],
        "url": "/api/v1/case-management/tasks/workflows/manual-creation/get-realtime-trans/${address}/${level}/${txnid}",
        "paramsValues": [{ "key": "values.address" }, { "key": "values.level" }, { "key": "values.txnid" }],
        "uiserver": true,
        "callApiIf": {
          "jsonLogic": {
            "and": [
              { "if": [{ "!=": [{ "var": "values.address" }, null] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.address" }, ""] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.level" }, null] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.level" }, ""] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.txnid" }, null] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.txnid" }, ""] }, true, false] }
            ]
          }
        }
      }
    ],
    "disabledIf": {
      "jsonLogic": {
        "or": [
          { "if": [{ "==": [{ "var": "values.address" }, null] }, true, false] },
          { "if": [{ "==": [{ "var": "values.address" }, ""] }, true, false] },
          { "if": [{ "==": [{ "var": "values.level" }, null] }, true, false] },
          { "if": [{ "==": [{ "var": "values.level" }, ""] }, true, false] },
          { "if": [{ "==": [{ "var": "values.txnid" }, null] }, true, false] },
          { "if": [{ "==": [{ "var": "values.txnid" }, ""] }, true, false] }
        ]
      }
    }
  },
  {
    "label": "VPA Name",
    "type": "text",
    "required": true,
    "valueKeyName": "vpaName",
    "disabled": true,
    "row": 2,
    "col": 3,

    "renderCondition": {
      "jsonLogic": {
        "and": [
          { "if": [{ "==": [{ "var": "values.level" }, "vpa"] }, true, false] },
          { "if": [{ "!=": [{ "var": "apiResponse.batchTransaction" }, null] }, true, false] },
          { "if": [{ "==": [{ "var": "apiResponse.batchTransaction.side" }, "payee"] }, true, false] }
        ]
      }
    },
    "defaultValue": {
      "keyName": "apiResponse.batchTransaction.Transaction.observations.payeeVPA.vpaName"
    }
  },

  {
    "label": "VPA Address",
    "type": "text",
    "required": true,
    "valueKeyName": "vpaAddress",
    "disabled": true,
    "row": 2,
    "col": 3,

    "renderCondition": {
      "jsonLogic": {
        "and": [
          { "if": [{ "==": [{ "var": "values.level" }, "vpa"] }, true, false] },
          { "if": [{ "!=": [{ "var": "apiResponse.batchTransaction" }, null] }, true, false] },
          { "if": [{ "==": [{ "var": "apiResponse.batchTransaction.side" }, "payee"] }, true, false] }
        ]
      }
    },
    "defaultValue": {
      "keyName": "apiResponse.batchTransaction.Transaction.observations.payeeVPA.externalId"
    }
  },

  {
    "label": "VPA Name",
    "type": "text",
    "required": true,
    "valueKeyName": "vpaName",
    "disabled": true,
    "row": 2,
    "col": 3,

    "renderCondition": {
      "jsonLogic": {
        "and": [
          { "if": [{ "==": [{ "var": "values.level" }, "vpa"] }, true, false] },
          { "if": [{ "!=": [{ "var": "apiResponse.batchTransaction" }, null] }, true, false] },
          { "if": [{ "==": [{ "var": "apiResponse.batchTransaction.side" }, "payer"] }, true, false] }
        ]
      }
    },
    "defaultValue": {
      "keyName": "apiResponse.batchTransaction.Transaction.observations.payerVPA.vpaName"
    }
  },

  {
    "label": "VPA Address",
    "type": "text",
    "required": true,
    "valueKeyName": "vpaAddress",
    "disabled": true,
    "row": 2,
    "col": 3,

    "renderCondition": {
      "jsonLogic": {
        "and": [
          { "if": [{ "==": [{ "var": "values.level" }, "vpa"] }, true, false] },
          { "if": [{ "!=": [{ "var": "apiResponse.batchTransaction" }, null] }, true, false] },
          { "if": [{ "==": [{ "var": "apiResponse.batchTransaction.side" }, "payer"] }, true, false] }
        ]
      }
    },
    "defaultValue": {
      "keyName": "apiResponse.batchTransaction.Transaction.observations.payerVPA.externalId"
    }
  },

  {
    "label": "Customer Name",
    "type": "text",
    "required": true,
    "valueKeyName": "customerName",
    "disabled": true,
    "row": 2,
    "col": 3,

    "renderCondition": {
      "jsonLogic": {
        "and": [
          { "if": [{ "==": [{ "var": "values.level" }, "account"] }, true, false] },
          { "if": [{ "!=": [{ "var": "apiResponse.batchTransaction" }, null] }, true, false] },
          { "if": [{ "==": [{ "var": "apiResponse.batchTransaction.side" }, "payee"] }, true, false] }
        ]
      }
    },
    "defaultValue": {
      "keyName": "apiResponse.batchTransaction.Transaction.observations.payeeVPA.account.customer.customerName"
    }
  },

  {
    "label": "Account Name",
    "type": "text",
    "required": true,
    "valueKeyName": "accountName",
    "disabled": true,
    "row": 2,
    "col": 3,

    "renderCondition": {
      "jsonLogic": {
        "and": [
          { "if": [{ "==": [{ "var": "values.level" }, "account"] }, true, false] },
          { "if": [{ "!=": [{ "var": "apiResponse.batchTransaction" }, null] }, true, false] },
          { "if": [{ "==": [{ "var": "apiResponse.batchTransaction.side" }, "payee"] }, true, false] }
        ]
      }
    },
    "defaultValue": {
      "keyName": "apiResponse.batchTransaction.Transaction.observations.payeeVPA.account.accountName"
    }
  },
  {
    "label": "Account Address",
    "type": "text",
    "required": true,
    "valueKeyName": "accountAddress",
    "disabled": true,
    "row": 2,
    "col": 3,

    "renderCondition": {
      "jsonLogic": {
        "and": [
          { "if": [{ "==": [{ "var": "values.level" }, "account"] }, true, false] },
          { "if": [{ "!=": [{ "var": "apiResponse.batchTransaction" }, null] }, true, false] },
          { "if": [{ "==": [{ "var": "apiResponse.batchTransaction.side" }, "payee"] }, true, false] }
        ]
      }
    },
    "defaultValue": {
      "keyName": "apiResponse.batchTransaction.Transaction.observations.payeeVPA.account.externalId"
    }
  },

  {
    "label": "Customer Name",
    "type": "text",
    "required": true,
    "valueKeyName": "customerName",
    "disabled": true,
    "row": 2,
    "col": 3,

    "renderCondition": {
      "jsonLogic": {
        "and": [
          { "if": [{ "==": [{ "var": "values.level" }, "account"] }, true, false] },
          { "if": [{ "!=": [{ "var": "apiResponse.batchTransaction" }, null] }, true, false] },
          { "if": [{ "==": [{ "var": "apiResponse.batchTransaction.side" }, "payer"] }, true, false] }
        ]
      }
    },
    "defaultValue": {
      "keyName": "apiResponse.batchTransaction.Transaction.observations.payerVPA.account.customer.customerName"
    }
  },

  {
    "label": "Account Name",
    "type": "text",
    "required": true,
    "valueKeyName": "accountName",
    "disabled": true,
    "row": 2,
    "col": 3,

    "renderCondition": {
      "jsonLogic": {
        "and": [
          { "if": [{ "==": [{ "var": "values.level" }, "account"] }, true, false] },
          { "if": [{ "!=": [{ "var": "apiResponse.batchTransaction" }, null] }, true, false] },
          { "if": [{ "==": [{ "var": "apiResponse.batchTransaction.side" }, "payer"] }, true, false] }
        ]
      }
    },
    "defaultValue": {
      "keyName": "apiResponse.batchTransaction.Transaction.observations.payerVPA.account.accountName"
    }
  },
  {
    "label": "Account Address",
    "type": "text",
    "required": true,
    "valueKeyName": "accountAddress",
    "disabled": true,
    "row": 2,
    "col": 3,

    "renderCondition": {
      "jsonLogic": {
        "and": [
          { "if": [{ "==": [{ "var": "values.level" }, "account"] }, true, false] },
          { "if": [{ "!=": [{ "var": "apiResponse.batchTransaction" }, null] }, true, false] },
          { "if": [{ "==": [{ "var": "apiResponse.batchTransaction.side" }, "payer"] }, true, false] }
        ]
      }
    },
    "defaultValue": {
      "keyName": "apiResponse.batchTransaction.Transaction.observations.payerVPA.account.externalId"
    }
  },
  {
    "label": "Select Alert(s)",
    "type": "select",
    "valueKeyName": "alerts",
    "isMulti": true,
    "required": true,
    "row": 3,
    "col": 9,
    "apiOptions": {
      "keyName": "rulesDropDown"
    },

    "onChangeAction": [
      {
        "key": "changeValues",
        "keyToBeChanged": "score",
        "changeValuesLogic": {
          "jsonLogic": {
            "if": [
              { "==": [{ "var": "apiResponse.aggregateType" }, "sum"] },
              {
                "reduce": [
                  { "var": "values.alerts" },
                  { "+": [{ "var": "current.score" }, { "var": "accumulator" }] },
                  0
                ]
              },
              { "==": [{ "var": "apiResponse.aggregateType" }, "max"] },
              {
                "custommax": [{ "var": "values.alerts" }]
              }
            ]
          }
        }
      }
    ],
    "renderCondition": {
      "jsonLogic": {
        "and": [{ "if": [{ "!=": [{ "var": "apiResponse.batchTransaction" }, null] }, true, false] }]
      }
    }
  },
  {
    "label": "Score",
    "type": "number",
    "required": true,
    "valueKeyName": "score",
    "disabled": true,
    "row": 3,
    "col": 3,
    "renderCondition": {
      "jsonLogic": {
        "and": [{ "if": [{ "!=": [{ "var": "apiResponse.batchTransaction" }, null] }, true, false] }]
      }
    }
  },
  {
    "type": "finalpostbody",
    "bodyStructure": {
      "Transaction": {
        "value": {
          "value": "apiResponse.batchTransaction.Transaction"
        },
        "type": "json"
      },
      "Result": {
        "value": {
          "value": "apiResponse.batchTransaction.Result"
        },
        "type": "json"
      },
      "isCreatedManually": {
        "value": true,
        "type": "Boolean"
      },
      "manualAlerts": {
        "value": { "value": "values.alerts" },
        "type": "json"
      },
      "manualScore": {
        "value": { "value": "values.score" },
        "type": "long"
      }
    }
  }
]'::jsonb WHERE
workflowid = 16;