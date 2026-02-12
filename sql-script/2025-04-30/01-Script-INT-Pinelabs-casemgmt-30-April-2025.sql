UPDATE ui.workflowmasters SET
manual_attribs =  E'{
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
      "regex": "^[a-zA-Z0-9.~+_-]*$",
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
}'::jsonb, displayconfig =  E'[
  {
    "type": "sortingOptions",
    "render": false,
    "options": [
      {
        "key": "parameters.sorting[]",
        "value": "Created Date",
        "bodyValue": {
          "my": {
            "key": "sortBy",
            "value": "starttime"
          },
          "open": {
            "key": "sortBy",
            "value": "starttime"
          },
          "closed": {
            "key": "sortBy",
            "value": "starttime"
          },
          "myclosed": {
            "key": "sortBy",
            "value": "starttime"
          }
        },
        "compareValue": {
          "value": {
            "jsonLogic": {
              "var": "data.leftPanelLogic.sortBy.value"
            }
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
        "key": "parameters.sorting[]",
        "value": "Risk Score",
        "bodyValue": {
          "key": "sortBy",
          "value": "riskscore"
        },
        "compareValue": {
          "value": {
            "jsonLogic": {
              "var": "data.leftPanelLogic.sortBy.value"
            }
          }
        },
        "finalbodyvalue": {
          "keysToSet": [
            {
              "name": "sortBy",
              "value": "processVariable",
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
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
                        "!=": [
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
              },
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
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
                        "!=": [
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
              "name": "parameters",
              "value": {
                "type": "long",
                "variable": "RiskScore"
              },
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
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
                        "!=": [
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
            }
          ]
        }
      },
      {
        "key": "parameters.sorting[]",
        "value": "Transaction Amount",
        "bodyValue": {
          "key": "sortBy",
          "value": "amount"
        },
        "compareValue": {
          "value": {
            "jsonLogic": {
              "var": "data.leftPanelLogic.sortBy.value"
            }
          }
        },
        "finalbodyvalue": {
          "keysToSet": [
            {
              "name": "sortBy",
              "value": "processVariable",
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
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
                        "!=": [
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
              },
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
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
                        "!=": [
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
              "name": "parameters",
              "value": {
                "type": "double",
                "variable": "TransactionAmount"
              },
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
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
                        "!=": [
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
            }
          ]
        }
      }
    ],
    "compareValue": true
  },
  {
    "key": "parameters.tenantIdIn",
    "name": "TenantId",
    "type": "multiSelect",
    "label": "Tenant",
    "value": {
      "jsonLogic": {
        "var": "data.formData.TenantId"
      }
    },
    "keyType": "array",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.tenantOptions"
      }
    },
    "defaultValue": {
      "setDefaultValueIf": [
        {
          "key": "data.formData.TenantId",
          "TRUE": {
            "key": "data.formData.TenantId",
            "type": "array"
          },
          "gteq": 1,
          "FALSE": {
            "key": "data.indexHttpData.tenantOptions",
            "map": "itenantId",
            "type": "array"
          },
          "action": "checkLength"
        }
      ]
    },
    "keyToExtract": "itenantId",
    "maxSelectable": 1,
    "onChangeAction": [
      {
        "key": "callApi",
        "body": [
          {
            "PARSEINT": true,
            "lodashKey": "data.formData.TenantId",
            "bodyKeyName": "tenants"
          }
        ],
        "route": "/api/v1/admin/app-users/get-all-workflows/${menuName}",
        "RequestType": "POST",
        "paramValues": [
          {
            "value": "Tasks"
          }
        ],
        "onApiSuccess": [
          {
            "key": "setIndexHttpData",
            "keyToSet": "workFlowNamesDrop"
          }
        ],
        "beforeCallAction": [
          {
            "key": "resetFormDataAll"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "filter.inputJson"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "apiOptions"
          }
        ]
      }
    ]
  },
  {
    "key": {
      "value": "parameters.processDefinitionKeyIn",
      "closed": {
        "key": "parameters.orQueries",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "WorkflowName"
              },
              {
                "key": "value",
                "value": {
                  "key": "value",
                  "keyToExtract": "label"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "arrayofobjects",
          "value": {
            "jsonLogic": {
              "var": "data.indexHttpData.workFlowNamesDrop"
            },
            "keyToCheck": "workflowKey",
            "compareWith": "data.newValue",
            "keyToExtract": "label"
          }
        }
      },
      "myclosed": {
        "key": "parameters.orQueries[].processVariables",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "WorkflowName"
              },
              {
                "key": "value",
                "value": {
                  "key": "value",
                  "keyToExtract": "label"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "arrayofobjects",
          "value": {
            "jsonLogic": {
              "var": "data.indexHttpData.workFlowNamesDrop"
            },
            "keyToCheck": "workflowKey",
            "compareWith": "data.newValue",
            "keyToExtract": "label"
          }
        }
      }
    },
    "name": "CaseType",
    "type": "multiSelect",
    "label": "Case Type",
    "value": {
      "jsonLogic": {
        "var": "data.formData.CaseType"
      }
    },
    "keyType": "array",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.workFlowNamesDrop"
      }
    },
    "bodyValue": {
      "key": "defKey",
      "jsonLogic": {
        "var": "data.formData.CaseType"
      }
    },
    "defaultValue": {
      "setDefaultValueIf": [
        {
          "key": "data.formData.CaseType",
          "TRUE": {
            "key": "data.formData.CaseType",
            "type": "array"
          },
          "gteq": 1,
          "FALSE": {
            "key": "data.indexHttpData.workFlowNamesDrop",
            "map": "workflowKey",
            "type": "array"
          },
          "action": "checkLength"
        }
      ]
    },
    "keyToExtract": "workflowKey",
    "maxSelectable": 1,
    "onChangeAction": [
      {
        "key": "callApi",
        "route": "/api/v1/task/filter/config/${paramOne}/${paramTwo}",
        "RequestType": "GET",
        "paramValues": [
          {
            "key": "data.formData.TenantId[0]"
          },
          {
            "key": "data.formData.CaseType[0]",
            "paramValueHardCode": "workflowid"
          }
        ],
        "onApiSuccess": [
          {
            "key": "setIndexHttpData",
            "keyToSet": "filter.inputJson"
          }
        ],
        "beforeCallAction": [
          {
            "key": "resetFormDataWorkflow"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "filter.inputJson"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "apiOptions"
          }
        ]
      }
    ]
  },
  {
    "key": {
      "my": {
        "key": "parameters.createdAfter,parameters.createdBefore",
        "lodashKey": "data.formData.startDate,data.formData.endDate"
      },
      "open": {
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
    "name": "startDate,endDate,startedAfter,finsihedBefore",
    "type": "dateRange",
    "label": "Date Range",
    "valueKey": "dataRangeValueKey",
    "bodyValue": {
      "key": "startDate,endDate,startedAfter,finsihedBefore",
      "lodashKey": "data.formData.startDate,data.formData.endDate,data.formData.startDate,data.formData.endDate"
    },
    "multipleKeyName": "[0],[1],[0],[1]"
  },
  {
    "key": {
      "value": "parameters.taskDefinitionKeyIn",
      "lodashKey": "data.formData.Status"
    },
    "name": "Status",
    "type": "multiSelect",
    "label": "Status",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.apiOptions.statusOptions"
      }
    },
    "apiOptions": {
      "url": "/api/v1/case-management/tasks/get-status/tenant-id/${tenantid}/workflow-key/${workflowKey}",
      "body": {
        "keys": [
          {
            "key": "maxResult",
            "valueKey": "indexLogic.maximumResult.value"
          },
          {
            "key": "parameters",
            "valueKey": "indexLogic?.taskSelect?.value"
          }
        ]
      },
      "RequestType": "POST",
      "paramValues": [
        {
          "key": "data.formData.TenantId[0]"
        },
        {
          "key": "data.formData.CaseType[0]"
        }
      ],
      "responseKey": "statusOptions"
    },
    "isClearable": true,
    "keyToExtract": "value"
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionAmount",
        "outputFormat": {
          "keys": {
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
            ],
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
            }
          },
          "type": "object"
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionAmount",
        "outputFormat": {
          "keys": {
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
            ],
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
            }
          },
          "type": "object"
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.TransactionAmount",
        "outputFormat": {
          "keys": {
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
            ],
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
            }
          },
          "type": "object"
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionAmount",
        "outputFormat": {
          "keys": {
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
            ],
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
            }
          },
          "type": "object"
        }
      }
    },
    "min": 0,
    "name": "TransactionAmount",
    "type": "number",
    "label": "Transaction Amount",
    "compareOperator": {
      "name": "TransactionAmountCompareOperator",
      "type": "select",
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
    }
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.LevelType",
        "outputFormat": {
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
            ],
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
            }
          },
          "type": "object",
          "keys2": {
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
            ],
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
            }
          }
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.LevelType",
        "outputFormat": {
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
            ],
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
            }
          },
          "type": "object",
          "keys2": {
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
            ],
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
            }
          }
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.LevelType",
        "outputFormat": {
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
          "type": "object",
          "keys2": {
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
            ],
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
            }
          },
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
          }
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.LevelType",
        "outputFormat": {
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
            ],
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
            }
          },
          "type": "object",
          "keys2": {
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
            ],
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
            }
          }
        }
      }
    },
    "name": "LevelType",
    "type": "object",
    "fields": [
      {
        "name": "levelSelectMain",
        "type": "select",
        "label": "Level",
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
        "type": "select",
        "label": "Type",
        "options": [
          {
            "label": "Payer",
            "value": "Payer"
          },
          {
            "label": "Payee",
            "value": "Payee"
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
    "type": "text",
    "label": "Address",
    "regex": "^[a-zA-Z0-9 ,_@*#%''/\\\\\\\\&.-]*$"
  },
  {
    "name": "NoOfCases",
    "type": "select",
    "label": "No Of Cases",
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
      "key": "maxResult",
      "lodashKey": "data.formData.NoOfCases"
    }
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.RiskScore",
        "outputFormat": {
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
          },
          "type": "object"
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.RiskScore",
        "outputFormat": {
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
          },
          "type": "object"
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.RiskScore",
        "outputFormat": {
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
          },
          "type": "object"
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.RiskScore",
        "outputFormat": {
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
          },
          "type": "object"
        }
      }
    },
    "max": 100,
    "min": 0,
    "name": "RiskScore",
    "type": "number",
    "label": "Risk Score ( >= )"
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.Rule",
        "outputFormat": {
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
          },
          "type": "object",
          "arrayKey": true
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.Rule",
        "outputFormat": {
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
          },
          "type": "arrayofobjects",
          "arrayKey": true
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.Rule",
        "outputFormat": {
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
          },
          "type": "object",
          "arrayKey": true
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.Rule",
        "outputFormat": {
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
          },
          "type": "object",
          "arrayKey": true
        }
      }
    },
    "name": "Rule",
    "type": "multiSelect",
    "label": "Rule",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.apiOptions.ruleOptions"
      }
    },
    "apiOptions": {
      "url": "/api/v1/case-management/tasks/get-rules-dropdown/Tasks/tenant-id/${tenantId}",
      "body": {
        "keys": [
          {
            "key": "maxResult",
            "valueKey": "indexLogic.maximumResult.value"
          },
          {
            "key": "parameters",
            "valueKey": "indexLogic?.taskSelect?.value"
          }
        ]
      },
      "RequestType": "GET",
      "paramValues": [
        {
          "key": "data.formData.TenantId[0]"
        }
      ],
      "responseKey": "ruleOptions"
    },
    "keyToExtract": "value"
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionClass",
        "outputFormat": {
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
          },
          "type": "object"
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionClass",
        "outputFormat": {
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
          },
          "type": "object"
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.TransactionClass",
        "outputFormat": {
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
          },
          "type": "object"
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionClass",
        "outputFormat": {
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
          },
          "type": "object"
        }
      }
    },
    "name": "TransactionClass",
    "type": "select",
    "label": "Transaction Class",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.apiOptions.classDropDownOption.dropDownOptions"
      }
    },
    "apiOptions": {
      "url": "/api/v1/generic-dashboard/get-transaction-classes/Tasks/tenant-id/${tenant}",
      "RequestType": "GET",
      "paramValues": [
        {
          "key": "data.formData.TenantId[0]"
        }
      ],
      "responseKey": "classDropDownOption"
    },
    "isClearable": true
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.OfflineOnline",
        "outputFormat": {
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
          },
          "type": "object"
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.OfflineOnline",
        "outputFormat": {
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
          },
          "type": "object"
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.OfflineOnline",
        "outputFormat": {
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
          },
          "type": "object"
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.OfflineOnline",
        "outputFormat": {
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
          },
          "type": "object"
        }
      }
    },
    "name": "OfflineOnline",
    "type": "select",
    "label": "Offline / Online",
    "options": [
      {
        "label": "Online",
        "value": "Online"
      },
      {
        "label": "Offline",
        "value": "Offline"
      }
    ],
    "isClearable": true
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.is_domestic",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "is_domestic"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.is_domestic"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.is_domestic",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "is_domestic"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.is_domestic"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.is_domestic",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "is_domestic"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.is_domestic"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.is_domestic",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "is_domestic"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.is_domestic"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      }
    },
    "name": "is_domestic",
    "type": "select",
    "label": "Domestic / International",
    "options": [
      {
        "label": "Domestic",
        "value": 0
      },
      {
        "label": "International",
        "value": 1
      },
      {
        "label": "Unknown",
        "value": -1
      }
    ],
    "isClearable": true
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.hasMerchantResponded",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "hasMerchantResponded"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.hasMerchantResponded"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.hasMerchantResponded",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "hasMerchantResponded"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.hasMerchantResponded"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.hasMerchantResponded",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "hasMerchantResponded"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.hasMerchantResponded"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.hasMerchantResponded",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "hasMerchantResponded"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.hasMerchantResponded"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      }
    },
    "name": "hasMerchantResponded",
    "type": "select",
    "label": "Response received",
    "options": [
      {
        "label": "True",
        "value": true
      },
      {
        "label": "False",
        "value": false
      }
    ],
    "isClearable": true
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.is_dcc",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "is_dcc"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.is_dcc"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.is_dcc",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "is_dcc"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.is_dcc"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.is_dcc",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "is_dcc"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.is_dcc"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.is_dcc",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "is_dcc"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.is_dcc"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      }
    },
    "name": "is_dcc",
    "type": "select",
    "label": "Is DCC",
    "options": [
      {
        "label": "Yes",
        "value": true
      },
      {
        "label": "No",
        "value": false
      }
    ],
    "isClearable": true
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.isBlacklist",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "isBlacklist"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.isBlacklist"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.isBlacklist",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "isBlacklist"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.isBlacklist"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.isBlacklist",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "isBlacklist"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.isBlacklist"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.isBlacklist",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "isBlacklist"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.isBlacklist"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      }
    },
    "name": "isBlacklist",
    "type": "select",
    "label": "Settlement requested",
    "options": [
      {
        "label": "Auto Hold",
        "value": true
      },
      {
        "label": "Manual hold",
        "value": {
          "config": {
            "my": [
              "_arrayofobjects,Action2,like,parameters.processVariables[],%hold_%",
              "_arrayofobjects,isBlacklist,eq,parameters.processVariables[],boolean_false"
            ],
            "open": [
              "_arrayofobjects,Action2,like,parameters.processVariables[],%hold_%",
              "_arrayofobjects,isBlacklist,eq,parameters.processVariables[],boolean_false"
            ],
            "closed": [
              "_arrayofobjects,Action2,like,parameters.variables[],%hold_%",
              "_arrayofobjects,isBlacklist,eq,parameters.variables[],boolean_false"
            ],
            "myclosed": [
              "_arrayofobjects,Action2,like,parameters.processVariables[],%hold_%",
              "_arrayofobjects,isBlacklist,eq,parameters.processVariables[],boolean_false"
            ]
          },
          "arrayofobjects": true
        }
      },
      {
        "label": "Release",
        "value": {
          "config": {
            "my": [
              "_arrayofobjects,Action2,like,parameters.processVariables[],%release%"
            ],
            "open": [
              "_arrayofobjects,Action2,like,parameters.processVariables[],%release%"
            ],
            "closed": [
              "_arrayofobjects,Action2,like,parameters.variables[],release%"
            ],
            "myclosed": [
              "_arrayofobjects,Action2,like,parameters.processVariables[],%release%"
            ]
          },
          "arrayofobjects": true
        }
      }
    ],
    "isClearable": true
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.transaction_id",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "transaction_id"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.transaction_id"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.transaction_id",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "transaction_id"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.transaction_id"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.transaction_id",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "transaction_id"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.transaction_id"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.transaction_id",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "transaction_id"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.transaction_id"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      }
    },
    "name": "transaction_id",
    "type": "text",
    "label": "Transaction id",
    "regex": "^[0-9.~+_-]*$"
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.rrn",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "rrn"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.rrn"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.rrn",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "rrn"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.rrn"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.rrn",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "rrn"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.rrn"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.rrn",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "rrn"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.rrn"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      }
    },
    "name": "rrn",
    "type": "text",
    "label": "RRN",
    "regex": "^[0-9.+-]*$"
  }
]'::jsonb WHERE
workflowid = 16 AND itenantid = 10;

UPDATE ui.dashboardresultset SET
vcdashboardresultsetschema = '{
    "Txn Date Time" : "datetime",
    "Txn ID" : "string",
    "Merchant Name":"string",
    "Payer Customer ID" : "string",
    "Payer Account ID" : "string",
    "Payer VPA ID" : "string",
    "Payee Customer ID" : "string",
    "Payee Account ID" : "string",
    "Payee VPA ID" : "string",
    "Txn Class" : "string",
    "Txn Amount" : "float",
    "Decision Name" : "string",
    "Rule ID" : "integer",
    "Rule Name" : "string" ,
    "Score" : "integer",
    "Side": "string",
    "id": "integer",
    "Request ID": "string",
    "Timestamp": "datetime",
    "Remarks": "string",
    "Org": "string",
    "Status": "string",
    "Txn ID": "string",
    "Txn Timestamp": "datetime",
    "Note": "string",
    "Type": "string",
    "Class": "string",
    "Merchant addr": "string",
    "Payee Name": "string",
    "Payee VPA": "string",
    "Account Name": "string",
    "Default MCC": "integer",
    "MCC": "integer",
    "Payee email": "string",
    "Payer": "string",
    "Payer VPA": "string",
    "Payer Name": "string",
    "Payer IP": "string",
    "Txn Score": "string",
    "Txn Amount": "float",
    "Card Country Code": "string",
    "Original Txn ID": "string",
    "Acquirer Name": "string",
    "Currency": "string",
    "Workflow Type": "string",
    "Decision Name": "string",
    "Decision Detail": "string",
    "Is_New_Merchant": "string",
    "Is_New_Payer": "string",
    "Skip Processing": "integer",
    "ip_details.Country": "string",
    "ip_details.PostalCode": "integer",
    "ip_details.City": "string",
    "observations.same_ip_addr_unique_payer_d01_txn_count": "integer",
    "observations.payeeVPA.account.customer.attribs.city": "string",
    "observations.same_payer_payee_acc_d01_txn_count": "integer",
    "observations.same_payer_payee_acc_d01_txn_value": "integer",
    "observations.payer_unique_payee_acc_online_d01_txn_count": "integer",
    "observations.payee_online_intl_card_m30_txn_count": "integer",
    "observations.same_payee_same_amt_online_m15_txn_count": "integer",
    "observations.same_payee_online_m10_gteq250_txn_count": "integer",
    "observations.payee_account_d01_txn_value": "integer",
    "observations.same_payee_acc_PT48H_txn_value": "integer",
    "observations.payee_acc_decline_less5k_m30_txn_count": "integer",
    "observations.same_payee_online_PT24H_txn_value": "integer",
    "observations.same_payer_payee_online_PT5M_txnPay_count": "integer",
    "observations.payer_decline_m30_txn_count": "integer",
    "observations.same_payer_payee_online_d01_txn_count": "integer",
    "observations.same_payer_payee_online_d01_txn_value": "integer"
    }
'::text WHERE
idashboardqueryid=112  AND itenantid = 10;

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{   
    "All": {
       "Claimed":   "select finalstatus.text_ as \\"Settlement Action\\", case when finalselectedtxnbytes.id_ is null then finalselectedtxn.text_ else SUBSTRING( convert_from( finalselectedtxnbytes.bytes_, ''UTF8'' ) FROM 2 FOR LENGTH( convert_from( finalselectedtxnbytes.bytes_, ''UTF8'' ) ) -2 ) end as \\"Associated Transaction\\", array_length(string_to_array( CASE WHEN finalselectedtxnbytes.id_ IS NULL THEN finalselectedtxn.text_ ELSE SUBSTRING( convert_from(finalselectedtxnbytes.bytes_, ''UTF8'') FROM 2 FOR LENGTH(convert_from(finalselectedtxnbytes.bytes_, ''UTF8'')) - 2 ) END, '', ''), 1) AS \\"Txn Count\\", task.name_ as \\"Stage\\", cuser.vcemailid   as \\"Claimed By\\", hiproinst.start_time_ \\"Created Date\\", CASE WHEN task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \\"Ticket Status\\", pdef.name_ as \\"Case Type\\", CASE WHEN task.assignee_ is not null and oplog.timestamp_ is not null THEN oplog.timestamp_ WHEN task.assignee_ is not null and oplog.timestamp_ is null THEN task.create_time_ ELSE null END as \\"Claimed On\\", payer.text_ as \\"Payer\\", payee.text_ as \\"Payee\\", TransactionAmount.double_ / 100 as \\"Amount\\", TicketID.long_ as \\"Case ID\\", Alert.text_ as \\"Alert\\", null as \\"Closed Date\\", null as \\"Closed By\\" , txnid.text_ as \\"Txn ID\\", hstatus.text_ as \\"Hold Status\\", mername.text_ as \\"Merchant Name\\", tamt.double_ as \\"Total Amount\\", CASE WHEN isBlack.long_ = 1 and SettlementType.text_ =''HOLD'' THEN ''Auto Hold'' WHEN isBlack.long_ = 0 and SettlementType.text_ =''HOLD'' THEN ''Manual Hold'' WHEN SettlementType.text_ =''RELEASE'' THEN ''Release'' ELSE NULL END AS \\"Settlement Request\\", CASE WHEN releaseStatus.text_ = ''SUCCESS'' THEN releaseDetail.time_ ELSE NULL END AS \\"Released Date\\" from camunda.act_re_procdef pdef left join camunda.act_ru_task task on pdef.id_ = task.proc_def_id_ LEFT JOIN ui.webuser cuser ON cast(task.assignee_  as integer) = cuser.iuserid  left join camunda.act_hi_op_log oplog on oplog.id_ = ( select id_ from camunda.act_hi_op_log where task_id_ = task.id_ and property_ = ''assignee'' and new_value_ = task.assignee_ order by timestamp_ desc limit 1 ) left join camunda.act_ru_variable payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_ru_variable payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_ru_variable TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' right join camunda.act_ru_variable TicketID on TicketID.proc_inst_id_ = task.proc_inst_id_ and TicketID.name_ = ''TicketID'' left join camunda.act_ru_variable Alert on Alert.proc_inst_id_ = task.proc_inst_id_ and Alert.name_ = ''Alert'' left join camunda.act_ru_variable finalstatus on finalstatus.proc_inst_id_ = task.proc_inst_id_ and finalstatus.name_ = ''current_final_status'' left join camunda.act_ru_variable finalselectedtxn on finalselectedtxn.proc_inst_id_ = task.proc_inst_id_ and finalselectedtxn.name_ = ''current_final_selected_txn'' left join camunda.act_ge_bytearray finalselectedtxnbytes on finalselectedtxnbytes.id_ = finalselectedtxn.bytearray_id_ and finalselectedtxnbytes.name_ = ''current_final_selected_txn'' inner join camunda.act_hi_procinst hiproinst on hiproinst.proc_inst_id_ = task.proc_inst_id_ left join camunda.act_hi_varinst txnid on txnid.proc_inst_id_ = hiproinst.proc_inst_id_ and txnid.name_ = ''transaction_id'' left join camunda.act_hi_varinst isBlack on isBlack.proc_inst_id_ = hiproinst.proc_inst_id_ and isBlack.name_ = ''isBlacklist'' LEFT JOIN camunda.act_hi_varinst SettlementType ON SettlementType.act_inst_id_ = hiproinst.proc_inst_id_ AND SettlementType.name_ = ''settlementType''  LEFT JOIN camunda.act_hi_varinst releaseStatus ON releaseStatus.proc_inst_id_ = hiproinst.proc_inst_id_ AND releaseStatus.name_ = ''releasestatus'' LEFT JOIN camunda.act_hi_detail releaseDetail ON releaseDetail.proc_inst_id_ = hiproinst.proc_inst_id_ AND releaseDetail.name_ = ''releasestatus'' AND releaseDetail.text_ = ''SUCCESS'' LEFT JOIN camunda.act_hi_varinst hstatus ON hstatus.proc_inst_id_ = hiproinst.proc_inst_id_ AND hstatus.name_ = ''settlementStatus'' LEFT JOIN camunda.act_hi_varinst tamt ON tamt.proc_inst_id_ = hiproinst.proc_inst_id_ AND tamt.name_ = ''totalAmountHolded'' LEFT JOIN camunda.act_hi_varinst mername ON mername.proc_inst_id_ = hiproinst.proc_inst_id_ AND mername.name_ = ''merchantName'' where hiproinst.start_time_ between :StartDate AND  :EndDate and task.assignee_ is not null and hiproinst.proc_def_key_ not in ( ''invoice'', ''ReviewInvoice'', ''Orchestrator'', ''Sanctions'' ) and hiproinst.tenant_id_ = :tenantidstr  limit 10000",
       "Unclaimed": "select finalstatus.text_ as \\"Settlement Action\\", case when finalselectedtxnbytes.id_ is null then finalselectedtxn.text_ else SUBSTRING( convert_from( finalselectedtxnbytes.bytes_, ''UTF8'' ) FROM 2 FOR LENGTH( convert_from( finalselectedtxnbytes.bytes_, ''UTF8'' ) ) -2 ) end as \\"Associated Transaction\\", array_length(string_to_array( CASE WHEN finalselectedtxnbytes.id_ IS NULL THEN finalselectedtxn.text_ ELSE SUBSTRING( convert_from(finalselectedtxnbytes.bytes_, ''UTF8'') FROM 2 FOR LENGTH(convert_from(finalselectedtxnbytes.bytes_, ''UTF8'')) - 2 ) END, '', ''), 1) AS \\"Txn Count\\", task.name_ as \\"Stage\\", cuser.vcemailid   as \\"Claimed By\\", hiproinst.start_time_ \\"Created Date\\", CASE WHEN task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \\"Ticket Status\\", pdef.name_ as \\"Case Type\\", CASE WHEN task.assignee_ is not null and oplog.timestamp_ is not null THEN oplog.timestamp_ WHEN task.assignee_ is not null and oplog.timestamp_ is null THEN task.create_time_ ELSE null END as \\"Claimed On\\", payer.text_ as \\"Payer\\", payee.text_ as \\"Payee\\", TransactionAmount.double_ / 100 as \\"Amount\\", TicketID.long_ as \\"Case ID\\", Alert.text_ as \\"Alert\\", null as \\"Closed Date\\", null as \\"Closed By\\" , txnid.text_ as \\"Txn ID\\", hstatus.text_ as \\"Hold Status\\", mername.text_ as \\"Merchant Name\\", tamt.double_ as \\"Total Amount\\", CASE WHEN isBlack.long_ = 1 and SettlementType.text_ =''HOLD'' THEN ''Auto Hold'' WHEN isBlack.long_ = 0 and SettlementType.text_ =''HOLD'' THEN ''Manual Hold'' WHEN SettlementType.text_ =''RELEASE'' THEN ''Release'' ELSE NULL END AS \\"Settlement Request\\", CASE WHEN releaseStatus.text_ = ''SUCCESS'' THEN releaseDetail.time_ ELSE NULL END AS \\"Released Date\\" from camunda.act_re_procdef pdef left join camunda.act_ru_task task on pdef.id_ = task.proc_def_id_ LEFT JOIN ui.webuser cuser ON cast(task.assignee_  as integer) = cuser.iuserid  left join camunda.act_hi_op_log oplog on oplog.id_ = ( select id_ from camunda.act_hi_op_log where task_id_ = task.id_ and property_ = ''assignee'' and new_value_ = task.assignee_ order by timestamp_ desc limit 1 ) left join camunda.act_ru_variable payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_ru_variable payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_ru_variable TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' right join camunda.act_ru_variable TicketID on TicketID.proc_inst_id_ = task.proc_inst_id_ and TicketID.name_ = ''TicketID'' left join camunda.act_ru_variable Alert on Alert.proc_inst_id_ = task.proc_inst_id_ and Alert.name_ = ''Alert'' left join camunda.act_ru_variable finalstatus on finalstatus.proc_inst_id_ = task.proc_inst_id_ and finalstatus.name_ = ''current_final_status'' left join camunda.act_ru_variable finalselectedtxn on finalselectedtxn.proc_inst_id_ = task.proc_inst_id_ and finalselectedtxn.name_ = ''current_final_selected_txn'' left join camunda.act_ge_bytearray finalselectedtxnbytes on finalselectedtxnbytes.id_ = finalselectedtxn.bytearray_id_ and finalselectedtxnbytes.name_ = ''current_final_selected_txn'' inner join camunda.act_hi_procinst hiproinst on hiproinst.proc_inst_id_ = task.proc_inst_id_ left join camunda.act_hi_varinst txnid on txnid.proc_inst_id_ = hiproinst.proc_inst_id_ and txnid.name_ = ''transaction_id'' left join camunda.act_hi_varinst isBlack on isBlack.proc_inst_id_ = hiproinst.proc_inst_id_ and isBlack.name_ = ''isBlacklist'' LEFT JOIN camunda.act_hi_varinst SettlementType ON SettlementType.act_inst_id_ = hiproinst.proc_inst_id_ AND SettlementType.name_ = ''settlementType''  LEFT JOIN camunda.act_hi_varinst releaseStatus ON releaseStatus.proc_inst_id_ = hiproinst.proc_inst_id_ AND releaseStatus.name_ = ''releasestatus'' LEFT JOIN camunda.act_hi_detail releaseDetail ON releaseDetail.proc_inst_id_ = hiproinst.proc_inst_id_ AND releaseDetail.name_ = ''releasestatus'' AND releaseDetail.text_ = ''SUCCESS'' LEFT JOIN camunda.act_hi_varinst hstatus ON hstatus.proc_inst_id_ = hiproinst.proc_inst_id_ AND hstatus.name_ = ''settlementStatus'' LEFT JOIN camunda.act_hi_varinst tamt ON tamt.proc_inst_id_ = hiproinst.proc_inst_id_ AND tamt.name_ = ''totalAmountHolded'' LEFT JOIN camunda.act_hi_varinst mername ON mername.proc_inst_id_ = hiproinst.proc_inst_id_ AND mername.name_ = ''merchantName'' where hiproinst.start_time_ between :StartDate AND  :EndDate and task.assignee_ is null and hiproinst.proc_def_key_ not in ( ''invoice'', ''ReviewInvoice'', ''Orchestrator'', ''Sanctions'' ) and hiproinst.tenant_id_ = :tenantidstr  limit 10000",
       "All":    "select finalstatus.text_ as \\"Settlement Action\\", case when finalselectedtxnbytes.id_ is null then finalselectedtxn.text_ else SUBSTRING( convert_from( finalselectedtxnbytes.bytes_, ''UTF8'' ) FROM 2 FOR LENGTH( convert_from( finalselectedtxnbytes.bytes_, ''UTF8'' ) ) -2 ) end as \\"Associated Transaction\\", array_length(string_to_array( CASE WHEN finalselectedtxnbytes.id_ IS NULL THEN finalselectedtxn.text_ ELSE SUBSTRING( convert_from(finalselectedtxnbytes.bytes_, ''UTF8'') FROM 2 FOR LENGTH(convert_from(finalselectedtxnbytes.bytes_, ''UTF8'')) - 2 ) END, '', ''), 1) AS \\"Txn Count\\", CASE WHEN hiproinst.state_ != ''ACTIVE'' THEN CASE WHEN closedby.assignee_ is not null THEN clsuser.vcemailid ELSE ''Auto Closed'' END ELSE null END as \\"Closed By\\", hiproinst.end_time_ as \\"Closed Date\\", CASE WHEN hiproinst.state_ = ''ACTIVE'' THEN task.name_ ELSE ''Closed'' END as \\"Stage\\", cuser.vcemailid  as \\"Claimed By\\", hiproinst.start_time_ as \\"Created Date\\", CASE WHEN hiproinst.state_ != ''ACTIVE'' then ''Closed'' WHEN task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \\"Ticket Status\\", pdef.name_ as \\"Case Type\\", CASE WHEN task.assignee_ is not null and oplog.timestamp_ is not null THEN oplog.timestamp_ WHEN task.assignee_ is not null and oplog.timestamp_ is null THEN task.create_time_ ELSE null END as \\"Claimed On\\", payer.text_ as \\"Payer\\", payee.text_ as \\"Payee\\", TransactionAmount.double_ / 100 as \\"Amount\\", TicketID.long_ as \\"Case ID\\", Alert.text_ as \\"Alert\\" , txnid.text_ as \\"Txn ID\\", hstatus.text_ as \\"Hold Status\\", mername.text_ as \\"Merchant Name\\", tamt.double_ as \\"Total Amount\\", CASE WHEN isBlack.long_ = 1 and SettlementType.text_ =''HOLD'' THEN ''Auto Hold'' WHEN isBlack.long_ = 0 and SettlementType.text_ =''HOLD'' THEN ''Manual Hold'' WHEN SettlementType.text_ =''RELEASE'' THEN ''Release'' ELSE NULL END AS \\"Settlement Request\\", CASE WHEN releaseStatus.text_ = ''SUCCESS'' THEN releaseDetail.time_ ELSE NULL END AS \\"Released Date\\" from camunda.act_hi_procinst hiproinst join camunda.act_re_procdef pdef on pdef.id_ = hiproinst.proc_def_id_ left join camunda.act_ru_task task on task.proc_inst_id_ = hiproinst.proc_inst_id_ left join camunda.act_hi_op_log oplog on oplog.id_ = ( select id_ from camunda.act_hi_detail WHERE proc_inst_id_ = task.proc_inst_id_ AND name_ = ''userActivity'' ORDER BY time_ DESC LIMIT 1 ) left join camunda.act_hi_taskinst closedby on closedby.id_ = ( select id_ from camunda.act_hi_taskinst where proc_inst_id_ = hiproinst.proc_inst_id_ ORDER BY end_time_ DESC LIMIT 1 ) LEFT JOIN ui.webuser cuser ON cast(task.assignee_  as integer) = cuser.iuserid LEFT JOIN ui.webuser clsuser ON cast(closedby.assignee_ as integer) = clsuser.iuserid  left join camunda.act_hi_varinst payer on payer.proc_inst_id_ = hiproinst.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_varinst finalstatus on finalstatus.proc_inst_id_ = hiproinst.proc_inst_id_ and finalstatus.name_ = ''current_final_status'' left join camunda.act_hi_varinst finalselectedtxn on finalselectedtxn.proc_inst_id_ = hiproinst.proc_inst_id_ and finalselectedtxn.name_ = ''current_final_selected_txn'' left join camunda.act_ge_bytearray finalselectedtxnbytes on finalselectedtxnbytes.id_ = finalselectedtxn.bytearray_id_ and finalselectedtxnbytes.name_ = ''current_final_selected_txn'' left join camunda.act_hi_varinst payee on payee.proc_inst_id_ = hiproinst.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_varinst TransactionAmount on TransactionAmount.proc_inst_id_ = hiproinst.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' left join camunda.act_hi_varinst TicketID on TicketID.proc_inst_id_ = hiproinst.proc_inst_id_ and TicketID.name_ = ''TicketID'' left join camunda.act_hi_varinst Alert on Alert.proc_inst_id_ = hiproinst.proc_inst_id_ and Alert.name_ = ''Alert'' left join camunda.act_hi_varinst txnid on txnid.proc_inst_id_ = hiproinst.proc_inst_id_ and txnid.name_ = ''transaction_id'' left join camunda.act_hi_varinst isBlack on isBlack.proc_inst_id_ = hiproinst.proc_inst_id_ and isBlack.name_ = ''isBlacklist''   LEFT JOIN camunda.act_hi_varinst SettlementType ON SettlementType.act_inst_id_ = hiproinst.proc_inst_id_ AND SettlementType.name_ = ''settlementType''  LEFT JOIN camunda.act_hi_varinst releaseStatus ON releaseStatus.proc_inst_id_ = hiproinst.proc_inst_id_ AND releaseStatus.name_ = ''releasestatus'' LEFT JOIN camunda.act_hi_detail releaseDetail ON releaseDetail.proc_inst_id_ = hiproinst.proc_inst_id_ AND releaseDetail.name_ = ''releasestatus'' AND releaseDetail.text_ = ''SUCCESS'' LEFT JOIN camunda.act_hi_varinst hstatus ON hstatus.proc_inst_id_ = hiproinst.proc_inst_id_ AND hstatus.name_ = ''settlementStatus'' LEFT JOIN camunda.act_hi_varinst tamt ON tamt.proc_inst_id_ = hiproinst.proc_inst_id_ AND tamt.name_ = ''totalAmountHolded'' LEFT JOIN camunda.act_hi_varinst mername ON mername.proc_inst_id_ = hiproinst.proc_inst_id_ AND mername.name_ = ''merchantName'' where hiproinst.start_time_ between :StartDate AND  :EndDate and hiproinst.state_ != ''EXTERNALLY_TERMINATED'' and hiproinst.proc_def_key_ not in ( ''invoice'', ''ReviewInvoice'', ''Orchestrator'', ''Sanctions'' ) and hiproinst.tenant_id_ = :tenantidstr limit 10000",
       "Closed": "select finalstatus.text_ as \\"Settlement Action\\", case when finalselectedtxnbytes.id_ is null then finalselectedtxn.text_ else SUBSTRING( convert_from( finalselectedtxnbytes.bytes_, ''UTF8'' ) FROM 2 FOR LENGTH( convert_from( finalselectedtxnbytes.bytes_, ''UTF8'' ) ) -2 ) end as \\"Associated Transaction\\", array_length(string_to_array( CASE WHEN finalselectedtxnbytes.id_ IS NULL THEN finalselectedtxn.text_ ELSE SUBSTRING( convert_from(finalselectedtxnbytes.bytes_, ''UTF8'') FROM 2 FOR LENGTH(convert_from(finalselectedtxnbytes.bytes_, ''UTF8'')) - 2 ) END, '', ''), 1) AS \\"Txn Count\\", CASE WHEN hiproinst.state_ != ''ACTIVE'' THEN CASE WHEN closedby.assignee_ is not null THEN clsuser.vcemailid ELSE ''Auto Closed'' END ELSE null END as \\"Closed By\\", hiproinst.end_time_ as \\"Closed Date\\", CASE WHEN hiproinst.state_ = ''ACTIVE'' THEN task.name_ ELSE ''Closed'' END as \\"Stage\\", cuser.vcemailid  as \\"Claimed By\\", hiproinst.start_time_ as \\"Created Date\\", CASE WHEN hiproinst.state_ != ''ACTIVE'' then ''Closed'' WHEN task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \\"Ticket Status\\", pdef.name_ as \\"Case Type\\", CASE WHEN task.assignee_ is not null and oplog.timestamp_ is not null THEN oplog.timestamp_ WHEN task.assignee_ is not null and oplog.timestamp_ is null THEN task.create_time_ ELSE null END as \\"Claimed On\\", payer.text_ as \\"Payer\\", payee.text_ as \\"Payee\\", TransactionAmount.double_ / 100 as \\"Amount\\", TicketID.long_ as \\"Case ID\\", Alert.text_ as \\"Alert\\" , txnid.text_ as \\"Txn ID\\", hstatus.text_ as \\"Hold Status\\", mername.text_ as \\"Merchant Name\\", tamt.double_ as \\"Total Amount\\", CASE WHEN isBlack.long_ = 1 and SettlementType.text_ =''HOLD'' THEN ''Auto Hold'' WHEN isBlack.long_ = 0 and SettlementType.text_ =''HOLD'' THEN ''Manual Hold'' WHEN SettlementType.text_ =''RELEASE'' THEN ''Release'' ELSE NULL END AS \\"Settlement Request\\", CASE WHEN releaseStatus.text_ = ''SUCCESS'' THEN releaseDetail.time_ ELSE NULL END AS \\"Released Date\\" from camunda.act_hi_procinst hiproinst join camunda.act_re_procdef pdef on pdef.id_ = hiproinst.proc_def_id_ left join camunda.act_ru_task task on task.proc_inst_id_ = hiproinst.proc_inst_id_ left join camunda.act_hi_op_log oplog on oplog.id_ = ( select id_ from camunda.act_hi_detail WHERE proc_inst_id_ = task.proc_inst_id_ AND name_ = ''userActivity'' ORDER BY time_ DESC LIMIT 1 ) left join camunda.act_hi_taskinst closedby on closedby.id_ = ( select id_ from camunda.act_hi_taskinst where proc_inst_id_ = hiproinst.proc_inst_id_ ORDER BY end_time_ DESC LIMIT 1 ) LEFT JOIN ui.webuser cuser ON cast(task.assignee_  as integer) = cuser.iuserid  LEFT JOIN ui.webuser clsuser ON cast(closedby.assignee_ as integer) = clsuser.iuserid  left join camunda.act_hi_varinst payer on payer.proc_inst_id_ = hiproinst.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_varinst finalstatus on finalstatus.proc_inst_id_ = hiproinst.proc_inst_id_ and finalstatus.name_ = ''current_final_status'' left join camunda.act_hi_varinst finalselectedtxn on finalselectedtxn.proc_inst_id_ = hiproinst.proc_inst_id_ and finalselectedtxn.name_ = ''current_final_selected_txn'' left join camunda.act_ge_bytearray finalselectedtxnbytes on finalselectedtxnbytes.id_ = finalselectedtxn.bytearray_id_ and finalselectedtxnbytes.name_ = ''current_final_selected_txn'' left join camunda.act_hi_varinst payee on payee.proc_inst_id_ = hiproinst.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_varinst TransactionAmount on TransactionAmount.proc_inst_id_ = hiproinst.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' left join camunda.act_hi_varinst TicketID on TicketID.proc_inst_id_ = hiproinst.proc_inst_id_ and TicketID.name_ = ''TicketID''  left join camunda.act_hi_varinst Alert on Alert.proc_inst_id_ = hiproinst.proc_inst_id_ and Alert.name_ = ''Alert'' left join camunda.act_hi_varinst txnid on txnid.proc_inst_id_ = hiproinst.proc_inst_id_ and txnid.name_ = ''transaction_id'' left join camunda.act_hi_varinst isBlack on isBlack.proc_inst_id_ = hiproinst.proc_inst_id_ and isBlack.name_ = ''isBlacklist''   LEFT JOIN camunda.act_hi_varinst SettlementType ON SettlementType.act_inst_id_ = hiproinst.proc_inst_id_ AND SettlementType.name_ = ''settlementType''  LEFT JOIN camunda.act_hi_varinst releaseStatus ON releaseStatus.proc_inst_id_ = hiproinst.proc_inst_id_ AND releaseStatus.name_ = ''releasestatus'' LEFT JOIN camunda.act_hi_detail releaseDetail ON releaseDetail.proc_inst_id_ = hiproinst.proc_inst_id_ AND releaseDetail.name_ = ''releasestatus'' AND releaseDetail.text_ = ''SUCCESS'' LEFT JOIN camunda.act_hi_varinst hstatus ON hstatus.proc_inst_id_ = hiproinst.proc_inst_id_ AND hstatus.name_ = ''settlementStatus'' LEFT JOIN camunda.act_hi_varinst tamt ON tamt.proc_inst_id_ = hiproinst.proc_inst_id_ AND tamt.name_ = ''totalAmountHolded'' LEFT JOIN camunda.act_hi_varinst mername ON mername.proc_inst_id_ = hiproinst.proc_inst_id_ AND mername.name_ = ''merchantName'' where hiproinst.start_time_ between :StartDate AND  :EndDate and hiproinst.state_ = ''COMPLETED'' and hiproinst.proc_def_key_ not in ( ''invoice'', ''ReviewInvoice'', ''Orchestrator'', ''Sanctions'' ) and hiproinst.tenant_id_ = :tenantidstr limit 10000"  
    },
   "Other": {
       "Claimed":   "select finalstatus.text_ as \\"Settlement Action\\", case when finalselectedtxnbytes.id_ is null then finalselectedtxn.text_ else SUBSTRING( convert_from( finalselectedtxnbytes.bytes_, ''UTF8'' ) FROM 2 FOR LENGTH( convert_from( finalselectedtxnbytes.bytes_, ''UTF8'' ) ) -2 ) end as \\"Associated Transaction\\", array_length(string_to_array( CASE WHEN finalselectedtxnbytes.id_ IS NULL THEN finalselectedtxn.text_ ELSE SUBSTRING( convert_from(finalselectedtxnbytes.bytes_, ''UTF8'') FROM 2 FOR LENGTH(convert_from(finalselectedtxnbytes.bytes_, ''UTF8'')) - 2 ) END, '', ''), 1) AS \\"Txn Count\\", task.name_ as \\"Stage\\", cuser.vcemailid  as \\"Claimed By\\", hiproinst.start_time_ \\"Created Date\\", CASE WHEN task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \\"Ticket Status\\", pdef.name_ as \\"Case Type\\", CASE WHEN task.assignee_ is not null and oplog.timestamp_ is not null THEN oplog.timestamp_ WHEN task.assignee_ is not null and oplog.timestamp_ is null THEN task.create_time_ ELSE null END as \\"Claimed On\\", payer.text_ as \\"Payer\\", payee.text_ as \\"Payee\\", TransactionAmount.double_ / 100 as \\"Amount\\", TicketID.long_ as \\"Case ID\\", Alert.text_ as \\"Alert\\", null as \\"Closed Date\\", null as \\"Closed By\\" , txnid.text_ as \\"Txn ID\\", hstatus.text_ as \\"Hold Status\\", mername.text_ as \\"Merchant Name\\", tamt.double_ as \\"Total Amount\\", CASE WHEN isBlack.long_ = 1 and SettlementType.text_ =''HOLD'' THEN ''Auto Hold'' WHEN isBlack.long_ = 0 and SettlementType.text_ =''HOLD'' THEN ''Manual Hold'' WHEN SettlementType.text_ =''RELEASE'' THEN ''Release'' ELSE NULL END AS \\"Settlement Request\\", CASE WHEN releaseStatus.text_ = ''SUCCESS'' THEN releaseDetail.time_ ELSE NULL END AS \\"Released Date\\" from camunda.act_re_procdef pdef left join camunda.act_ru_task task on pdef.id_ = task.proc_def_id_ LEFT JOIN ui.webuser cuser ON cast(task.assignee_  as integer) = cuser.iuserid  left join camunda.act_hi_op_log oplog on oplog.id_ = ( select id_ from camunda.act_hi_op_log where task_id_ = task.id_ and property_ = ''assignee'' and new_value_ = task.assignee_ order by timestamp_ desc limit 1 ) left join camunda.act_ru_variable payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_ru_variable payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_ru_variable TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' right join camunda.act_ru_variable TicketID on TicketID.proc_inst_id_ = task.proc_inst_id_ and TicketID.name_ = ''TicketID'' left join camunda.act_ru_variable Alert on Alert.proc_inst_id_ = task.proc_inst_id_ and Alert.name_ = ''Alert'' left join camunda.act_ru_variable finalstatus on finalstatus.proc_inst_id_ = task.proc_inst_id_ and finalstatus.name_ = ''current_final_status'' left join camunda.act_ru_variable finalselectedtxn on finalselectedtxn.proc_inst_id_ = task.proc_inst_id_ and finalselectedtxn.name_ = ''current_final_selected_txn'' left join camunda.act_ge_bytearray finalselectedtxnbytes on finalselectedtxnbytes.id_ = finalselectedtxn.bytearray_id_ and finalselectedtxnbytes.name_ = ''current_final_selected_txn''  inner join camunda.act_hi_procinst hiproinst on hiproinst.proc_inst_id_ = task.proc_inst_id_ left join camunda.act_hi_varinst txnid on txnid.proc_inst_id_ = hiproinst.proc_inst_id_ and txnid.name_ = ''transaction_id'' left join camunda.act_hi_varinst isBlack on isBlack.proc_inst_id_ = hiproinst.proc_inst_id_ and isBlack.name_ = ''isBlacklist'' LEFT JOIN camunda.act_hi_varinst SettlementType ON SettlementType.act_inst_id_ = hiproinst.proc_inst_id_ AND SettlementType.name_ = ''settlementType''  LEFT JOIN camunda.act_hi_varinst releaseStatus ON releaseStatus.proc_inst_id_ = hiproinst.proc_inst_id_ AND releaseStatus.name_ = ''releasestatus'' LEFT JOIN camunda.act_hi_detail releaseDetail ON releaseDetail.proc_inst_id_ = hiproinst.proc_inst_id_ AND releaseDetail.name_ = ''releasestatus'' AND releaseDetail.text_ = ''SUCCESS'' LEFT JOIN camunda.act_hi_varinst hstatus ON hstatus.proc_inst_id_ = hiproinst.proc_inst_id_ AND hstatus.name_ = ''settlementStatus'' LEFT JOIN camunda.act_hi_varinst tamt ON tamt.proc_inst_id_ = hiproinst.proc_inst_id_ AND tamt.name_ = ''totalAmountHolded'' LEFT JOIN camunda.act_hi_varinst mername ON mername.proc_inst_id_ = hiproinst.proc_inst_id_ AND mername.name_ = ''merchantName'' where hiproinst.start_time_ between :StartDate AND  :EndDate and task.proc_def_id_ in (SELECT id_ FROM camunda.act_re_procdef where key_ = :CaseType ) and task.assignee_ is not null and hiproinst.proc_def_key_ not in ( ''invoice'', ''ReviewInvoice'', ''Orchestrator'', ''Sanctions'' ) and hiproinst.tenant_id_ = :tenantidstr  limit 10000",
       "Unclaimed": "select finalstatus.text_ as \\"Settlement Action\\", case when finalselectedtxnbytes.id_ is null then finalselectedtxn.text_ else SUBSTRING( convert_from( finalselectedtxnbytes.bytes_, ''UTF8'' ) FROM 2 FOR LENGTH( convert_from( finalselectedtxnbytes.bytes_, ''UTF8'' ) ) -2 ) end as \\"Associated Transaction\\", array_length(string_to_array( CASE WHEN finalselectedtxnbytes.id_ IS NULL THEN finalselectedtxn.text_ ELSE SUBSTRING( convert_from(finalselectedtxnbytes.bytes_, ''UTF8'') FROM 2 FOR LENGTH(convert_from(finalselectedtxnbytes.bytes_, ''UTF8'')) - 2 ) END, '', ''), 1) AS \\"Txn Count\\", task.name_ as \\"Stage\\", cuser.vcemailid  as \\"Claimed By\\", hiproinst.start_time_ \\"Created Date\\", CASE WHEN task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \\"Ticket Status\\", pdef.name_ as \\"Case Type\\", CASE WHEN task.assignee_ is not null and oplog.timestamp_ is not null THEN oplog.timestamp_ WHEN task.assignee_ is not null and oplog.timestamp_ is null THEN task.create_time_ ELSE null END as \\"Claimed On\\", payer.text_ as \\"Payer\\", payee.text_ as \\"Payee\\", TransactionAmount.double_ / 100 as \\"Amount\\", TicketID.long_ as \\"Case ID\\", Alert.text_ as \\"Alert\\", null as \\"Closed Date\\", null as \\"Closed By\\" , txnid.text_ as \\"Txn ID\\", hstatus.text_ as \\"Hold Status\\", mername.text_ as \\"Merchant Name\\", tamt.double_ as \\"Total Amount\\", CASE WHEN isBlack.long_ = 1 and SettlementType.text_ =''HOLD'' THEN ''Auto Hold'' WHEN isBlack.long_ = 0 and SettlementType.text_ =''HOLD'' THEN ''Manual Hold'' WHEN SettlementType.text_ =''RELEASE'' THEN ''Release'' ELSE NULL END AS \\"Settlement Request\\", CASE WHEN releaseStatus.text_ = ''SUCCESS'' THEN releaseDetail.time_ ELSE NULL END AS \\"Released Date\\" from camunda.act_re_procdef pdef left join camunda.act_ru_task task on pdef.id_ = task.proc_def_id_ LEFT JOIN ui.webuser cuser ON cast(task.assignee_  as integer) = cuser.iuserid  left join camunda.act_hi_op_log oplog on oplog.id_ = ( select id_ from camunda.act_hi_op_log where task_id_ = task.id_ and property_ = ''assignee'' and new_value_ = task.assignee_ order by timestamp_ desc limit 1 ) left join camunda.act_ru_variable payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_ru_variable payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_ru_variable TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' right join camunda.act_ru_variable TicketID on TicketID.proc_inst_id_ = task.proc_inst_id_ and TicketID.name_ = ''TicketID'' left join camunda.act_ru_variable Alert on Alert.proc_inst_id_ = task.proc_inst_id_ and Alert.name_ = ''Alert'' left join camunda.act_ru_variable finalstatus on finalstatus.proc_inst_id_ = task.proc_inst_id_ and finalstatus.name_ = ''current_final_status'' left join camunda.act_ru_variable finalselectedtxn on finalselectedtxn.proc_inst_id_ = task.proc_inst_id_ and finalselectedtxn.name_ = ''current_final_selected_txn'' left join camunda.act_ge_bytearray finalselectedtxnbytes on finalselectedtxnbytes.id_ = finalselectedtxn.bytearray_id_ and finalselectedtxnbytes.name_ = ''current_final_selected_txn''  inner join camunda.act_hi_procinst hiproinst on hiproinst.proc_inst_id_ = task.proc_inst_id_ left join camunda.act_hi_varinst txnid on txnid.proc_inst_id_ = hiproinst.proc_inst_id_ and txnid.name_ = ''transaction_id'' left join camunda.act_hi_varinst isBlack on isBlack.proc_inst_id_ = hiproinst.proc_inst_id_ and isBlack.name_ = ''isBlacklist'' LEFT JOIN camunda.act_hi_varinst SettlementType ON SettlementType.act_inst_id_ = hiproinst.proc_inst_id_ AND SettlementType.name_ = ''settlementType''  LEFT JOIN camunda.act_hi_varinst releaseStatus ON releaseStatus.proc_inst_id_ = hiproinst.proc_inst_id_ AND releaseStatus.name_ = ''releasestatus'' LEFT JOIN camunda.act_hi_detail releaseDetail ON releaseDetail.proc_inst_id_ = hiproinst.proc_inst_id_ AND releaseDetail.name_ = ''releasestatus'' AND releaseDetail.text_ = ''SUCCESS'' LEFT JOIN camunda.act_hi_varinst hstatus ON hstatus.proc_inst_id_ = hiproinst.proc_inst_id_ AND hstatus.name_ = ''settlementStatus'' LEFT JOIN camunda.act_hi_varinst tamt ON tamt.proc_inst_id_ = hiproinst.proc_inst_id_ AND tamt.name_ = ''totalAmountHolded'' LEFT JOIN camunda.act_hi_varinst mername ON mername.proc_inst_id_ = hiproinst.proc_inst_id_ AND mername.name_ = ''merchantName'' where hiproinst.start_time_ between :StartDate AND  :EndDate and task.proc_def_id_ in (SELECT id_ FROM camunda.act_re_procdef where key_ = :CaseType ) and task.assignee_ is null and hiproinst.proc_def_key_ not in ( ''invoice'', ''ReviewInvoice'', ''Orchestrator'', ''Sanctions'' ) and hiproinst.tenant_id_ = :tenantidstr  limit 10000",
       "All":    "select finalstatus.text_ as \\"Settlement Action\\", case when finalselectedtxnbytes.id_ is null then finalselectedtxn.text_ else SUBSTRING( convert_from( finalselectedtxnbytes.bytes_, ''UTF8'' ) FROM 2 FOR LENGTH( convert_from( finalselectedtxnbytes.bytes_, ''UTF8'' ) ) -2 ) end as \\"Associated Transaction\\", array_length(string_to_array( CASE WHEN finalselectedtxnbytes.id_ IS NULL THEN finalselectedtxn.text_ ELSE SUBSTRING( convert_from(finalselectedtxnbytes.bytes_, ''UTF8'') FROM 2 FOR LENGTH(convert_from(finalselectedtxnbytes.bytes_, ''UTF8'')) - 2 ) END, '', ''), 1) AS \\"Txn Count\\", CASE WHEN hiproinst.state_ != ''ACTIVE'' THEN CASE WHEN closedby.assignee_ is not null THEN clsuser.vcemailid ELSE ''Auto Closed'' END ELSE null END as \\"Closed By\\", hiproinst.end_time_ as \\"Closed Date\\", CASE WHEN hiproinst.state_ = ''ACTIVE'' THEN task.name_ ELSE ''Closed'' END as \\"Stage\\", cuser.vcemailid  as \\"Claimed By\\", hiproinst.start_time_ as \\"Created Date\\", CASE WHEN hiproinst.state_ != ''ACTIVE'' then ''Closed'' WHEN task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \\"Ticket Status\\", pdef.name_ as \\"Case Type\\", CASE WHEN task.assignee_ is not null and oplog.timestamp_ is not null THEN oplog.timestamp_ WHEN task.assignee_ is not null and oplog.timestamp_ is null THEN task.create_time_ ELSE null END as \\"Claimed On\\", payer.text_ as \\"Payer\\", payee.text_ as \\"Payee\\", TransactionAmount.double_ / 100 as \\"Amount\\", TicketID.long_ as \\"Case ID\\", Alert.text_ as \\"Alert\\" , txnid.text_ as \\"Txn ID\\", hstatus.text_ as \\"Hold Status\\", mername.text_ as \\"Merchant Name\\", tamt.double_ as \\"Total Amount\\", CASE WHEN isBlack.long_ = 1 and SettlementType.text_ =''HOLD'' THEN ''Auto Hold'' WHEN isBlack.long_ = 0 and SettlementType.text_ =''HOLD'' THEN ''Manual Hold'' WHEN SettlementType.text_ =''RELEASE'' THEN ''Release'' ELSE NULL END AS \\"Settlement Request\\", CASE WHEN releaseStatus.text_ = ''SUCCESS'' THEN releaseDetail.time_ ELSE NULL END AS \\"Released Date\\" from camunda.act_hi_procinst hiproinst join camunda.act_re_procdef pdef on pdef.id_ = hiproinst.proc_def_id_ left join camunda.act_ru_task task on task.proc_inst_id_ = hiproinst.proc_inst_id_ left join camunda.act_hi_op_log oplog on oplog.id_ = ( select id_ from camunda.act_hi_detail WHERE proc_inst_id_ = task.proc_inst_id_ AND name_ = ''userActivity'' ORDER BY time_ DESC LIMIT 1 ) left join camunda.act_hi_taskinst closedby on closedby.id_ = ( select id_ from camunda.act_hi_taskinst where proc_inst_id_ = hiproinst.proc_inst_id_ ORDER BY end_time_ DESC LIMIT 1 ) LEFT JOIN ui.webuser cuser ON cast(task.assignee_  as integer) = cuser.iuserid  LEFT JOIN ui.webuser clsuser ON cast(closedby.assignee_ as integer) = clsuser.iuserid  left join camunda.act_hi_varinst payer on payer.proc_inst_id_ = hiproinst.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_varinst finalstatus on finalstatus.proc_inst_id_ = hiproinst.proc_inst_id_ and finalstatus.name_ = ''current_final_status'' left join camunda.act_hi_varinst finalselectedtxn on finalselectedtxn.proc_inst_id_ = hiproinst.proc_inst_id_ and finalselectedtxn.name_ = ''current_final_selected_txn'' left join camunda.act_ge_bytearray finalselectedtxnbytes on finalselectedtxnbytes.id_ = finalselectedtxn.bytearray_id_ and finalselectedtxnbytes.name_ = ''current_final_selected_txn'' left join camunda.act_hi_varinst payee on payee.proc_inst_id_ = hiproinst.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_varinst TransactionAmount on TransactionAmount.proc_inst_id_ = hiproinst.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' left join camunda.act_hi_varinst TicketID on TicketID.proc_inst_id_ = hiproinst.proc_inst_id_ and TicketID.name_ = ''TicketID''  left join camunda.act_hi_varinst Alert on Alert.proc_inst_id_ = hiproinst.proc_inst_id_ and Alert.name_ = ''Alert'' left join camunda.act_hi_varinst txnid on txnid.proc_inst_id_ = hiproinst.proc_inst_id_ and txnid.name_ = ''transaction_id'' left join camunda.act_hi_varinst isBlack on isBlack.proc_inst_id_ = hiproinst.proc_inst_id_ and isBlack.name_ = ''isBlacklist''   LEFT JOIN camunda.act_hi_varinst SettlementType ON SettlementType.act_inst_id_ = hiproinst.proc_inst_id_ AND SettlementType.name_ = ''settlementType''  LEFT JOIN camunda.act_hi_varinst releaseStatus ON releaseStatus.proc_inst_id_ = hiproinst.proc_inst_id_ AND releaseStatus.name_ = ''releasestatus'' LEFT JOIN camunda.act_hi_detail releaseDetail ON releaseDetail.proc_inst_id_ = hiproinst.proc_inst_id_ AND releaseDetail.name_ = ''releasestatus'' AND releaseDetail.text_ = ''SUCCESS'' LEFT JOIN camunda.act_hi_varinst hstatus ON hstatus.proc_inst_id_ = hiproinst.proc_inst_id_ AND hstatus.name_ = ''settlementStatus'' LEFT JOIN camunda.act_hi_varinst tamt ON tamt.proc_inst_id_ = hiproinst.proc_inst_id_ AND tamt.name_ = ''totalAmountHolded'' LEFT JOIN camunda.act_hi_varinst mername ON mername.proc_inst_id_ = hiproinst.proc_inst_id_ AND mername.name_ = ''merchantName'' where hiproinst.start_time_ between :StartDate AND  :EndDate and hiproinst.state_ != ''EXTERNALLY_TERMINATED'' and hiproinst.proc_def_key_ = :CaseType and hiproinst.tenant_id_ = :tenantidstr limit 10000",       
       "Closed": "select finalstatus.text_ as \\"Settlement Action\\", case when finalselectedtxnbytes.id_ is null then finalselectedtxn.text_ else SUBSTRING( convert_from( finalselectedtxnbytes.bytes_, ''UTF8'' ) FROM 2 FOR LENGTH( convert_from( finalselectedtxnbytes.bytes_, ''UTF8'' ) ) -2 ) end as \\"Associated Transaction\\", array_length(string_to_array( CASE WHEN finalselectedtxnbytes.id_ IS NULL THEN finalselectedtxn.text_ ELSE SUBSTRING( convert_from(finalselectedtxnbytes.bytes_, ''UTF8'') FROM 2 FOR LENGTH(convert_from(finalselectedtxnbytes.bytes_, ''UTF8'')) - 2 ) END, '', ''), 1) AS \\"Txn Count\\", CASE WHEN hiproinst.state_ != ''ACTIVE'' THEN CASE WHEN closedby.assignee_ is not null THEN clsuser.vcemailid ELSE ''Auto Closed'' END ELSE null END as \\"Closed By\\", hiproinst.end_time_ as \\"Closed Date\\", CASE WHEN hiproinst.state_ = ''ACTIVE'' THEN task.name_ ELSE ''Closed'' END as \\"Stage\\", cuser.vcemailid  as \\"Claimed By\\", hiproinst.start_time_ as \\"Created Date\\", CASE WHEN hiproinst.state_ != ''ACTIVE'' then ''Closed'' WHEN task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \\"Ticket Status\\", pdef.name_ as \\"Case Type\\", CASE WHEN task.assignee_ is not null and oplog.timestamp_ is not null THEN oplog.timestamp_ WHEN task.assignee_ is not null and oplog.timestamp_ is null THEN task.create_time_ ELSE null END as \\"Claimed On\\", payer.text_ as \\"Payer\\", payee.text_ as \\"Payee\\", TransactionAmount.double_ / 100 as \\"Amount\\", TicketID.long_ as \\"Case ID\\", Alert.text_ as \\"Alert\\" , txnid.text_ as \\"Txn ID\\", hstatus.text_ as \\"Hold Status\\", mername.text_ as \\"Merchant Name\\", tamt.double_ as \\"Total Amount\\", CASE WHEN isBlack.long_ = 1 and SettlementType.text_ =''HOLD'' THEN ''Auto Hold'' WHEN isBlack.long_ = 0 and SettlementType.text_ =''HOLD'' THEN ''Manual Hold'' WHEN SettlementType.text_ =''RELEASE'' THEN ''Release'' ELSE NULL END AS \\"Settlement Request\\", CASE WHEN releaseStatus.text_ = ''SUCCESS'' THEN releaseDetail.time_ ELSE NULL END AS \\"Released Date\\" from camunda.act_hi_procinst hiproinst join camunda.act_re_procdef pdef on pdef.id_ = hiproinst.proc_def_id_ left join camunda.act_ru_task task on task.proc_inst_id_ = hiproinst.proc_inst_id_ left join camunda.act_hi_op_log oplog on oplog.id_ = ( select id_ from camunda.act_hi_detail WHERE proc_inst_id_ = task.proc_inst_id_ AND name_ = ''userActivity'' ORDER BY time_ DESC LIMIT 1 ) left join camunda.act_hi_taskinst closedby on closedby.id_ = ( select id_ from camunda.act_hi_taskinst where proc_inst_id_ = hiproinst.proc_inst_id_ ORDER BY end_time_ DESC LIMIT 1 ) LEFT JOIN ui.webuser cuser ON cast(task.assignee_  as integer) = cuser.iuserid  LEFT JOIN ui.webuser clsuser ON cast(closedby.assignee_ as integer) = clsuser.iuserid  left join camunda.act_hi_varinst payer on payer.proc_inst_id_ = hiproinst.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_varinst finalstatus on finalstatus.proc_inst_id_ = hiproinst.proc_inst_id_ and finalstatus.name_ = ''current_final_status'' left join camunda.act_hi_varinst finalselectedtxn on finalselectedtxn.proc_inst_id_ = hiproinst.proc_inst_id_ and finalselectedtxn.name_ = ''current_final_selected_txn'' left join camunda.act_ge_bytearray finalselectedtxnbytes on finalselectedtxnbytes.id_ = finalselectedtxn.bytearray_id_ and finalselectedtxnbytes.name_ = ''current_final_selected_txn'' left join camunda.act_hi_varinst payee on payee.proc_inst_id_ = hiproinst.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_varinst TransactionAmount on TransactionAmount.proc_inst_id_ = hiproinst.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' left join camunda.act_hi_varinst TicketID on TicketID.proc_inst_id_ = hiproinst.proc_inst_id_ and TicketID.name_ = ''TicketID''  left join camunda.act_hi_varinst Alert on Alert.proc_inst_id_ = hiproinst.proc_inst_id_ and Alert.name_ = ''Alert'' left join camunda.act_hi_varinst txnid on txnid.proc_inst_id_ = hiproinst.proc_inst_id_ and txnid.name_ = ''transaction_id'' left join camunda.act_hi_varinst isBlack on isBlack.proc_inst_id_ = hiproinst.proc_inst_id_ and isBlack.name_ = ''isBlacklist''   LEFT JOIN camunda.act_hi_varinst SettlementType ON SettlementType.act_inst_id_ = hiproinst.proc_inst_id_ AND SettlementType.name_ = ''settlementType''  LEFT JOIN camunda.act_hi_varinst releaseStatus ON releaseStatus.proc_inst_id_ = hiproinst.proc_inst_id_ AND releaseStatus.name_ = ''releasestatus'' LEFT JOIN camunda.act_hi_detail releaseDetail ON releaseDetail.proc_inst_id_ = hiproinst.proc_inst_id_ AND releaseDetail.name_ = ''releasestatus'' AND releaseDetail.text_ = ''SUCCESS'' LEFT JOIN camunda.act_hi_varinst hstatus ON hstatus.proc_inst_id_ = hiproinst.proc_inst_id_ AND hstatus.name_ = ''settlementStatus'' LEFT JOIN camunda.act_hi_varinst tamt ON tamt.proc_inst_id_ = hiproinst.proc_inst_id_ AND tamt.name_ = ''totalAmountHolded'' LEFT JOIN camunda.act_hi_varinst mername ON mername.proc_inst_id_ = hiproinst.proc_inst_id_ AND mername.name_ = ''merchantName'' where hiproinst.start_time_ between :StartDate AND  :EndDate and hiproinst.state_ = ''COMPLETED'' and hiproinst.proc_def_key_ = :CaseType and hiproinst.tenant_id_ = :tenantidstr limit 10000" 
     }
}'::text WHERE
idashboardqueryid = 62 AND itenantid = 10;