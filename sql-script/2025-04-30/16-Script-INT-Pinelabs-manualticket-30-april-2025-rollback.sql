UPDATE ui.workflowmasters SET
manual_attribs =  E' {
  "type": "realtime-multitrans",
  "display": [
    {
      "col": 3,
      "row": 0,
      "type": "select",
      "label": "Level",
      "options": [
        {
          "label": "Account",
          "value": "account"
        },
        {
          "label": "VPA",
          "value": "vpa"
        }
      ],
      "required": true,
      "valueKeyName": "level"
    },
    {
      "col": 3,
      "row": 0,
      "type": "text",
      "label": "Address",
      "regex": "^[a-zA-Z0-9 ,_@*#%''/\\\\\\\\&.-]*$",
      "disabled": false,
      "required": true,
      "apiKeyName": "",
      "valueKeyName": "address"
    },
    {
      "col": 3,
      "row": 1,
      "type": "text",
      "label": "Add Details To Task",
      "disabled": true,
      "required": true,
      "defaultValue": "Add Details To Task",
      "valueKeyName": "details"
    },
    {
      "col": 3,
      "row": 1,
      "type": "text",
      "label": "TXN ID",
      "regex": "^[a-zA-Z0-9.~+-]*$",
      "disabled": false,
      "required": true,
      "apiKeyName": "",
      "valueKeyName": "txnid"
    },
    {
      "col": 1,
      "row": 1,
      "icon": "search",
      "type": "icon",
      "label": "",
      "disabledIf": {
        "jsonLogic": {
          "or": [
            {
              "if": [
                {
                  "==": [
                    {
                      "var": "values.address"
                    },
                    null
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
                      "var": "values.address"
                    },
                    ""
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
                      "var": "values.level"
                    },
                    null
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
                      "var": "values.level"
                    },
                    ""
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
                      "var": "values.txnid"
                    },
                    null
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
                      "var": "values.txnid"
                    },
                    ""
                  ]
                },
                true,
                false
              ]
            }
          ]
        }
      },
      "onClickAction": [
        {
          "key": "callApi",
          "url": "/api/v1/case-management/tasks/workflows/manual-creation/get-realtime-trans/${address}/${level}/${txnid}/${workflow}/${tenant}",
          "headers": [
            {
              "name": "JWT"
            }
          ],
          "uiserver": true,
          "callApiIf": {
            "jsonLogic": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "values.address"
                        },
                        null
                      ]
                    },
                    true,
                    false
                  ]
                },
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "values.address"
                        },
                        ""
                      ]
                    },
                    true,
                    false
                  ]
                },
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "values.level"
                        },
                        null
                      ]
                    },
                    true,
                    false
                  ]
                },
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "values.level"
                        },
                        ""
                      ]
                    },
                    true,
                    false
                  ]
                },
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "values.txnid"
                        },
                        null
                      ]
                    },
                    true,
                    false
                  ]
                },
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "values.txnid"
                        },
                        ""
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "RequestType": "GET",
          "paramsValues": [
            {
              "key": "values.address"
            },
            {
              "key": "values.level"
            },
            {
              "key": "values.txnid"
            },
            {
              "key": "values.workflow"
            },
            {
              "key": "values.tenant"
            }
          ],
          "responseKeyName": "batchTransaction"
        }
      ]
    },
    {
      "col": 3,
      "row": 2,
      "type": "text",
      "label": "VPA Name",
      "disabled": true,
      "required": true,
      "defaultValue": {
        "keyName": "apiResponse.batchTransaction.Transaction.observations.payeeVPA.vpaName"
      },
      "valueKeyName": "vpaName",
      "renderCondition": {
        "jsonLogic": {
          "and": [
            {
              "if": [
                {
                  "==": [
                    {
                      "var": "values.level"
                    },
                    "vpa"
                  ]
                },
                true,
                false
              ]
            },
            {
              "if": [
                {
                  "!=": [
                    {
                      "var": "apiResponse.batchTransaction"
                    },
                    null
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
                      "var": "apiResponse.batchTransaction.side"
                    },
                    "payee"
                  ]
                },
                true,
                false
              ]
            }
          ]
        }
      }
    },
    {
      "col": 3,
      "row": 2,
      "type": "text",
      "label": "VPA Address",
      "disabled": true,
      "required": true,
      "defaultValue": {
        "keyName": "apiResponse.batchTransaction.Transaction.observations.payeeVPA.externalId"
      },
      "valueKeyName": "vpaAddress",
      "renderCondition": {
        "jsonLogic": {
          "and": [
            {
              "if": [
                {
                  "==": [
                    {
                      "var": "values.level"
                    },
                    "vpa"
                  ]
                },
                true,
                false
              ]
            },
            {
              "if": [
                {
                  "!=": [
                    {
                      "var": "apiResponse.batchTransaction"
                    },
                    null
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
                      "var": "apiResponse.batchTransaction.side"
                    },
                    "payee"
                  ]
                },
                true,
                false
              ]
            }
          ]
        }
      }
    },
    {
      "col": 3,
      "row": 2,
      "type": "text",
      "label": "VPA Name",
      "disabled": true,
      "required": true,
      "defaultValue": {
        "keyName": "apiResponse.batchTransaction.Transaction.observations.payerVPA.vpaName"
      },
      "valueKeyName": "vpaName",
      "renderCondition": {
        "jsonLogic": {
          "and": [
            {
              "if": [
                {
                  "==": [
                    {
                      "var": "values.level"
                    },
                    "vpa"
                  ]
                },
                true,
                false
              ]
            },
            {
              "if": [
                {
                  "!=": [
                    {
                      "var": "apiResponse.batchTransaction"
                    },
                    null
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
                      "var": "apiResponse.batchTransaction.side"
                    },
                    "payer"
                  ]
                },
                true,
                false
              ]
            }
          ]
        }
      }
    },
    {
      "col": 3,
      "row": 2,
      "type": "text",
      "label": "VPA Address",
      "disabled": true,
      "required": true,
      "defaultValue": {
        "keyName": "apiResponse.batchTransaction.Transaction.observations.payerVPA.externalId"
      },
      "valueKeyName": "vpaAddress",
      "renderCondition": {
        "jsonLogic": {
          "and": [
            {
              "if": [
                {
                  "==": [
                    {
                      "var": "values.level"
                    },
                    "vpa"
                  ]
                },
                true,
                false
              ]
            },
            {
              "if": [
                {
                  "!=": [
                    {
                      "var": "apiResponse.batchTransaction"
                    },
                    null
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
                      "var": "apiResponse.batchTransaction.side"
                    },
                    "payer"
                  ]
                },
                true,
                false
              ]
            }
          ]
        }
      }
    },
    {
      "col": 3,
      "row": 2,
      "type": "text",
      "label": "Customer Name",
      "disabled": true,
      "required": true,
      "defaultValue": {
        "keyName": "apiResponse.batchTransaction.Transaction.observations.payeeVPA.account.customer.customerName"
      },
      "valueKeyName": "customerName",
      "renderCondition": {
        "jsonLogic": {
          "and": [
            {
              "if": [
                {
                  "==": [
                    {
                      "var": "values.level"
                    },
                    "account"
                  ]
                },
                true,
                false
              ]
            },
            {
              "if": [
                {
                  "!=": [
                    {
                      "var": "apiResponse.batchTransaction"
                    },
                    null
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
                      "var": "apiResponse.batchTransaction.side"
                    },
                    "payee"
                  ]
                },
                true,
                false
              ]
            }
          ]
        }
      }
    },
    {
      "col": 3,
      "row": 2,
      "type": "text",
      "label": "Account Name",
      "disabled": true,
      "required": true,
      "defaultValue": {
        "keyName": "apiResponse.batchTransaction.Transaction.observations.payeeVPA.account.accountName"
      },
      "valueKeyName": "accountName",
      "renderCondition": {
        "jsonLogic": {
          "and": [
            {
              "if": [
                {
                  "==": [
                    {
                      "var": "values.level"
                    },
                    "account"
                  ]
                },
                true,
                false
              ]
            },
            {
              "if": [
                {
                  "!=": [
                    {
                      "var": "apiResponse.batchTransaction"
                    },
                    null
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
                      "var": "apiResponse.batchTransaction.side"
                    },
                    "payee"
                  ]
                },
                true,
                false
              ]
            }
          ]
        }
      }
    },
    {
      "col": 3,
      "row": 2,
      "type": "text",
      "label": "Account Address",
      "disabled": true,
      "required": true,
      "defaultValue": {
        "keyName": "apiResponse.batchTransaction.Transaction.observations.payeeVPA.account.externalId"
      },
      "valueKeyName": "accountAddress",
      "renderCondition": {
        "jsonLogic": {
          "and": [
            {
              "if": [
                {
                  "==": [
                    {
                      "var": "values.level"
                    },
                    "account"
                  ]
                },
                true,
                false
              ]
            },
            {
              "if": [
                {
                  "!=": [
                    {
                      "var": "apiResponse.batchTransaction"
                    },
                    null
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
                      "var": "apiResponse.batchTransaction.side"
                    },
                    "payee"
                  ]
                },
                true,
                false
              ]
            }
          ]
        }
      }
    },
    {
      "col": 3,
      "row": 2,
      "type": "text",
      "label": "Customer Name",
      "disabled": true,
      "required": true,
      "defaultValue": {
        "keyName": "apiResponse.batchTransaction.Transaction.observations.payerVPA.account.customer.customerName"
      },
      "valueKeyName": "customerName",
      "renderCondition": {
        "jsonLogic": {
          "and": [
            {
              "if": [
                {
                  "==": [
                    {
                      "var": "values.level"
                    },
                    "account"
                  ]
                },
                true,
                false
              ]
            },
            {
              "if": [
                {
                  "!=": [
                    {
                      "var": "apiResponse.batchTransaction"
                    },
                    null
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
                      "var": "apiResponse.batchTransaction.side"
                    },
                    "payer"
                  ]
                },
                true,
                false
              ]
            }
          ]
        }
      }
    },
    {
      "col": 3,
      "row": 2,
      "type": "text",
      "label": "Account Name",
      "disabled": true,
      "required": true,
      "defaultValue": {
        "keyName": "apiResponse.batchTransaction.Transaction.observations.payerVPA.account.accountName"
      },
      "valueKeyName": "accountName",
      "renderCondition": {
        "jsonLogic": {
          "and": [
            {
              "if": [
                {
                  "==": [
                    {
                      "var": "values.level"
                    },
                    "account"
                  ]
                },
                true,
                false
              ]
            },
            {
              "if": [
                {
                  "!=": [
                    {
                      "var": "apiResponse.batchTransaction"
                    },
                    null
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
                      "var": "apiResponse.batchTransaction.side"
                    },
                    "payer"
                  ]
                },
                true,
                false
              ]
            }
          ]
        }
      }
    },
    {
      "col": 3,
      "row": 2,
      "type": "text",
      "label": "Account Address",
      "disabled": true,
      "required": true,
      "defaultValue": {
        "keyName": "apiResponse.batchTransaction.Transaction.observations.payerVPA.account.externalId"
      },
      "valueKeyName": "accountAddress",
      "renderCondition": {
        "jsonLogic": {
          "and": [
            {
              "if": [
                {
                  "==": [
                    {
                      "var": "values.level"
                    },
                    "account"
                  ]
                },
                true,
                false
              ]
            },
            {
              "if": [
                {
                  "!=": [
                    {
                      "var": "apiResponse.batchTransaction"
                    },
                    null
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
                      "var": "apiResponse.batchTransaction.side"
                    },
                    "payer"
                  ]
                },
                true,
                false
              ]
            }
          ]
        }
      }
    },
    {
      "col": 9,
      "row": 3,
      "type": "select",
      "label": "Select Alert(s)",
      "isMulti": true,
      "required": true,
      "apiOptions": {
        "keyName": "rulesDropDown"
      },
      "valueKeyName": "alerts",
      "onChangeAction": [
        {
          "key": "changeValues",
          "keyToBeChanged": "score",
          "changeValuesLogic": {
            "jsonLogic": {
              "if": [
                {
                  "==": [
                    {
                      "var": "apiResponse.aggregateType"
                    },
                    "sum"
                  ]
                },
                {
                  "reduce": [
                    {
                      "var": "values.alerts"
                    },
                    {
                      "+": [
                        {
                          "var": "current.score"
                        },
                        {
                          "var": "accumulator"
                        }
                      ]
                    },
                    0
                  ]
                },
                {
                  "==": [
                    {
                      "var": "apiResponse.aggregateType"
                    },
                    "max"
                  ]
                },
                {
                  "custommax": [
                    {
                      "var": "values.alerts"
                    }
                  ]
                }
              ]
            }
          }
        }
      ],
      "renderCondition": {
        "jsonLogic": {
          "and": [
            {
              "if": [
                {
                  "!=": [
                    {
                      "var": "apiResponse.batchTransaction"
                    },
                    null
                  ]
                },
                true,
                false
              ]
            }
          ]
        }
      }
    },
    {
      "col": 3,
      "row": 3,
      "type": "number",
      "label": "Score",
      "disabled": false,
      "required": true,
      "valueKeyName": "score",
      "renderCondition": {
        "jsonLogic": {
          "and": [
            {
              "if": [
                {
                  "!=": [
                    {
                      "var": "apiResponse.batchTransaction"
                    },
                    null
                  ]
                },
                true,
                false
              ]
            }
          ]
        }
      }
    },
    {
      "type": "finalpostbody",
      "bodyStructure": {
        "Result": {
          "type": "json",
          "value": {
            "value": "apiResponse.batchTransaction.Result"
          }
        },
        "Transaction": {
          "type": "json",
          "value": {
            "value": "apiResponse.batchTransaction.Transaction"
          }
        },
        "manualScore": {
          "type": "long",
          "value": {
            "value": "values.score"
          }
        },
        "manualAlerts": {
          "type": "json",
          "value": {
            "value": "values.alerts"
          }
        },
        "isCreatedManually": {
          "type": "Boolean",
          "value": true
        }
      }
    }
  ]
}'::jsonb WHERE
workflowkey = 'RiskyMerchantSettlements' AND itenantid = 10;
