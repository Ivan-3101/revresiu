UPDATE ui.workflowmasters
	SET filterparams='[
  {
    "name": "TransactionClass",
    "data_type": "string",
    "value_config": {
      "value": "/txn/class",
      "extract_from": "trans_json"
    }
  }
]', displayconfig='[
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
                "type": "long",
                "variable": "RiskScore"
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
                "type": "double",
                "variable": "TransactionAmount"
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
        "body": {
          "key": "data.formData.TenantId"
        },
        "route": "/api/v1/admin/app-users/get-all-workflows/${menuName}",
        "paramValues": [
          {
            "value": "Tasks"
          }
        ],
        "requestType": "POST",
        "onApiSuccess": [
          {
            "key": "setIndexHttpData",
            "keyToSet": "workFlowNamesDrop"
          }
        ],
        "beforeCallAction": [
          {
            "key": "resetFormData"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "filteroptions"
          }
        ]
      },
      {
        "key": "callApi",
        "route": "/api/v1/task/filter/config/${paramOne}/${paramTwo}",
        "paramValues": [
          {
            "key": "data.formData.TenantId[0]"
          },
          {
            "key": "data.formData.CaseType[0]"
          }
        ],
        "requestType": "GET",
        "onApiSuccess": [
          {
            "key": "setIndexHttpData",
            "keyToSet": "filter.inputjson"
          }
        ],
        "beforeCallAction": [
          {
            "key": "resetFormData"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "filteroptions"
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
        "paramValues": [
          {
            "key": "data.formData.TenantId[0]"
          },
          {
            "key": "data.formData.CaseType[0]"
          }
        ],
        "requestType": "GET",
        "onApiSuccess": [
          {
            "key": "setIndexHttpData",
            "keyToSet": "filter.inputjson"
          }
        ],
        "beforeCallAction": [
          {
            "key": "resetFormData"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "filteroptions"
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
      "value": "parameters.taskDefinitionKeyIn[]",
      "lodashKey": "data.formData.Status"
    },
    "name": "Status",
    "type": "select",
    "label": "Status",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.statusFilterDropDowns"
      }
    },
    "isClearable": true
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
    "type": "text",
    "label": "Address"
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
          "type": "object"
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
          "type": "object"
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
          "type": "object"
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
          "type": "object"
        }
      }
    },
    "name": "Rule",
    "type": "select",
    "label": "Rule",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.ruleDropDownOption"
      }
    }
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
        "var": "data.indexHttpData.classDropDownOption"
      }
    }
  }
]'
	WHERE itenantid=8 AND  workflowid=4;

      UPDATE ui.workflowmasters
	SET filterparams='[
  {
    "name": "TransactionClass",
    "data_type": "string",
    "value_config": {
      "value": "/txn/class",
      "extract_from": "trans_json"
    }
  }
]', displayconfig='[
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
                "type": "long",
                "variable": "RiskScore"
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
                "type": "double",
                "variable": "TransactionAmount"
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
        "body": {
          "key": "data.formData.TenantId"
        },
        "route": "/api/v1/admin/app-users/get-all-workflows/${menuName}",
        "paramValues": [
          {
            "value": "Tasks"
          }
        ],
        "requestType": "POST",
        "onApiSuccess": [
          {
            "key": "setIndexHttpData",
            "keyToSet": "workFlowNamesDrop"
          }
        ],
        "beforeCallAction": [
          {
            "key": "resetFormData"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "filteroptions"
          }
        ]
      },
      {
        "key": "callApi",
        "route": "/api/v1/task/filter/config/${paramOne}/${paramTwo}",
        "paramValues": [
          {
            "key": "data.formData.TenantId[0]"
          },
          {
            "key": "data.formData.CaseType[0]"
          }
        ],
        "requestType": "GET",
        "onApiSuccess": [
          {
            "key": "setIndexHttpData",
            "keyToSet": "filter.inputjson"
          }
        ],
        "beforeCallAction": [
          {
            "key": "resetFormData"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "filteroptions"
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
        "paramValues": [
          {
            "key": "data.formData.TenantId[0]"
          },
          {
            "key": "data.formData.CaseType[0]"
          }
        ],
        "requestType": "GET",
        "onApiSuccess": [
          {
            "key": "setIndexHttpData",
            "keyToSet": "filter.inputjson"
          }
        ],
        "beforeCallAction": [
          {
            "key": "resetFormData"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "filteroptions"
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
      "value": "parameters.taskDefinitionKeyIn[]",
      "lodashKey": "data.formData.Status"
    },
    "name": "Status",
    "type": "select",
    "label": "Status",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.statusFilterDropDowns"
      }
    },
    "isClearable": true
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
    "type": "text",
    "label": "Address"
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
          "type": "object"
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
          "type": "object"
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
          "type": "object"
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
          "type": "object"
        }
      }
    },
    "name": "Rule",
    "type": "select",
    "label": "Rule",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.ruleDropDownOption"
      }
    }
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
        "var": "data.indexHttpData.classDropDownOption"
      }
    }
  }
]'
	WHERE itenantid=8 AND  workflowid=5;



----------------------BAPA STR FORM Master----------------------
INSERT INTO ui.formmaster_8 (ifromid, formattingjson, inputjson, vcformname, actioaftercreation, vcdisplayname, itenantid) VALUES (3, NULL, '[{"section": {"fields": [{"key": "Tenant", "type": "select", "label": "Tenant", "apiOptions": {"route": "/api/v1/admin/app-users/get-all-tenants/${orgId}/${menuName}", "headers": [{"name": "JWT"}], "uiserver": true, "callApiIf": "apiResponse?.tenantOptions===undefined", "RequestType": "GET", "responseKey": "tenantOptions", "paramsValues": [{"key": "orgId"}, {"key": "menuName"}]}, "isDisabled": true, "validations": {"required": true}}]}}, {"column": 12}, {"section": {"fields": [{"key": "GroupName", "type": "text", "label": "Group Name", "validations": {"required": true}}, {"key": "Level", "type": "select", "label": "Level", "options": [{"label": "Transaction", "value": "Transaction"}, {"label": "Customer", "value": "Customer"}, {"label": "Account", "value": "Account"}, {"label": "VPA", "value": "VPA"}]}, {"key": "Address", "type": "text", "label": "Address", "validations": {"required": true}}, {"key": "DateRange", "type": "daterange", "label": "Date Range", "format": "YYYY-MM-DD", "validations": {"required": true}}, {"key": "Extracts", "type": "select", "label": "Extracts", "isMulti": true, "options": [{"label": "KC1", "value": "KC1"}, {"label": "KC2", "value": "KC2"}, {"label": "KCS1", "value": "KCS1"}, {"label": "KCS2", "value": "KCS2"}, {"label": "TS3", "value": "TS3"}, {"label": "TS6", "value": "TS6"}, {"label": "GS1", "value": "GS1"}, {"label": "CB1", "value": "CB1"}, {"label": "GT1", "value": "GT1"}, {"label": "Account Detail", "value": "Account Detail"}, {"label": "Account Person Detail", "value": "Account Person Detail"}], "sectionOnChangeAction": {"actions": [{"resetActiveTab": {"key": "tabOne", "tabOptions": [{"label": "KC1", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"KC1\")>-1"}, {"label": "KC2", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"KC2\")>-1"}, {"label": "KCS1", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"KCS1\")>-1"}, {"label": "KCS2", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"KCS2\")>-1"}, {"label": "TS3", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"TS3\")>-1"}, {"label": "TS6", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"TS6\")>-1"}, {"label": "GS1", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"GS1\")>-1"}, {"label": "CB1", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"CB1\")>-1"}, {"label": "GT1", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"GT1\")>-1"}, {"label": "Account Detail", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"Account Detail\")>-1"}, {"label": "Account Person Detail", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"Account Person Detail\")>-1"}]}}]}, "conditionalRenderOtherKeys": true}, {"icon": "search", "type": "button", "onClick": {"action": [{"callApi": {"url": "/api/v1/generic-dashboard/get-resultset/STR Extracts/tenant-id/${Tenant}", "headers": [{"name": "JWT"}], "uiserver": true, "callApiIf": "apiResponse?.queryID===undefined", "RequestType": "GET", "responseKey": "queryID", "paramsValues": [{"key": "values.Tenant"}]}}, {"callApi": {"url": "/api/v1/generic-dashboard/get-result-set-data/tenant-id/${Tenant}", "body": {"keys": [{"key": "parametersJson", "type": "jsonstring", "values": [{"key": "Group", "required": true, "lodashKey": "values.GroupName"}, {"key": "Address", "required": true, "lodashKey": "values.Address"}, {"key": "DateRange", "required": true, "lodashKey": "values.DateRange"}, {"key": "Level", "required": true, "lodashKey": "values.Level"}, {"key": "Extract", "eval": true, "required": true, "lodashKey": "loopOf[ctr]"}]}, {"key": "inputTimezone", "lodashKey": "userTimezone"}, {"key": "queryID", "lodashKey": "apiResponse.queryID"}]}, "loopOf": "values.Extracts", "headers": [{"name": "JWT"}], "runLoop": true, "uiserver": true, "callApiIf": "values?.[loopOf?.[ctr]]===\"\"", "loopOfKey": "Extract", "RequestType": "POST", "paramsValues": [{"key": "values.Tenant"}], "onResponseAction": {"action": [{"key": "setValues", "keysToset": [{"key": {"eval": true, "lodashKey": "loopOf[ctr]", "keyToSetFrom": "data"}}]}], "hidePerspective": true}}}]}}]}}, {"column": 12}, {"section": {"fields": [{"key": "refnum", "type": "text", "label": "Case ID / Reference Number", "disabled": true, "validations": {"required": true}}]}}, {"section": {"tabs": true, "fields": [{"key": "KC1", "type": "perspective", "perspectiveData": {"layout": {"mode": "globalFilters", "sizes": [1], "detail": {"main": {"type": "tab-area", "widgets": ["PERSPECTIVE_GENERATED_ID_1"], "currentIndex": 0}}, "viewers": {"PERSPECTIVE_GENERATED_ID_1": {"sort": [], "table": "KC1", "theme": "Pro Dark", "title": "KC1", "filter": [], "linked": false, "master": false, "plugin": "Datagrid", "columns": [], "group_by": [], "settings": false, "split_by": [], "aggregates": {}, "expressions": [], "plugin_config": {"columns": {}, "editable": true, "scroll_lock": false}}}}, "schema": {"NPR": "string", "PAN": "string", "UCIC": "string", "PEKRN": "string", "Gender": "string", "Email ID": "string", "Voter ID": "string", "Last Name": "string", "DIN / DPIN": "string", "First Name": "string", "NREGA Card": "string", "Occupation": "string", "CKYC Number": "string", "Customer ID": "string", "Middle Name": "string", "Nationality": "string", "Report Type": "string", "Customer Type": "string", "Date of Birth": "string", "Employer Name": "string", "Mobile Number": "string", "Name of Father": "string", "Name of Mother": "string", "Passport Number": "string", "Other Occupation": "string", "Telephone Number": "string", "Primary Address 1": "string", "Primary City Name": "string", "Employee City Name": "string", "Employer Address 1": "string", "Primary State Name": "string", "Annual Income (INR)": "string", "Customer Risk Level": "string", "Employee State Name": "string", "Other Customer Type": "string", "Secondary Address 1": "string", "Secondary City Name": "string", "Spouse/Partner Name": "string", "Primary Address City": "string", "Secondary State Name": "string", "Employer Address City": "string", "Primary Address State": "string", "Primary District Name": "string", "Drivers License Number": "string", "Employee District Name": "string", "Employer Address State": "string", "Secondary Address City": "string", "Alternate Mobile Number": "string", "Primary Address Country": "string", "Report Reference Number": "string", "Secondary Address State": "string", "Secondary District Name": "string", "Employer Address Country": "string", "Primary Address District": "string", "Primary Address Locality": "string", "Primary Address Pin Code": "string", "Date of Last KYC / re-KYC": "string", "Employer Address District": "string", "Employer Address Locality": "string", "Employer Address Pin Code": "string", "Secondary Address Country": "string", "Secondary Address District": "string", "Secondary Address Locality": "string", "Secondary Address Pin Code": "string", "Date of Customer On-boarding": "string", "Identity verified using Aadhaar ID": "string", "Declaration (If PAN is not available)": "string", "Declaration (If CKYC is not available)": "string", "Declaration (If Last name is not available)": "string"}}, "renderCondition": "activeTab?.tabOne===\"KC1\""}, {"key": "KC2", "type": "perspective", "perspectiveData": {"layout": {"mode": "globalFilters", "sizes": [1], "detail": {"main": {"type": "tab-area", "widgets": ["PERSPECTIVE_GENERATED_ID_1"], "currentIndex": 0}}, "viewers": {"PERSPECTIVE_GENERATED_ID_1": {"sort": [], "table": "KC2", "theme": "Pro Dark", "title": "KC2", "filter": [], "linked": false, "master": false, "plugin": "Datagrid", "columns": [], "group_by": [], "settings": false, "split_by": [], "aggregates": {}, "expressions": [], "plugin_config": {"columns": {}, "editable": true, "scroll_lock": false}}}}, "schema": {"PAN": "string", "GSTIN": "string", "PEKRN": "string", "State": "string", "Country": "string", "District": "string", "Locality": "string", "PIN Code": "string", "City Name": "string", "Full Name": "string", "State Name": "string", "Report Type": "string", "District Name": "string", "Mobile Number": "string", "Company ID Type": "string", "Company ID Number": "string", "Registered Address": "string", "Non-Indian PIN Code": "string", "Second Address State": "string", "City / Village / Town": "string", "Second Address Line 1": "string", "Second Address Country": "string", "Report Reference Number": "string", "Second Address District": "string", "Second Address Locality": "string", "Second Address PIN Code": "string", "CIN/ FCRN/ LLPIN/ FLLPIN": "string", "Second Address City Name": "string", "Second Address State Name": "string", "City / Village / Town Name": "string", "Second Address District Name": "string", "Second Address Non-Indian PIN Code": "string", "Second Address City / Village / Town": "string", "Declaration (If PAN is not available)": "string"}}, "renderCondition": "activeTab?.tabOne===\"KC2\""}, {"key": "KCS1", "type": "perspective", "perspectiveData": {"layout": {"mode": "globalFilters", "sizes": [1], "detail": {"main": {"type": "tab-area", "widgets": ["PERSPECTIVE_GENERATED_ID_1"], "currentIndex": 0}}, "viewers": {"PERSPECTIVE_GENERATED_ID_1": {"sort": [], "table": "KCS1", "theme": "Pro Dark", "title": "KCS1", "filter": [], "linked": false, "master": false, "plugin": "Datagrid", "columns": [], "group_by": [], "settings": false, "split_by": [], "aggregates": {}, "expressions": [], "plugin_config": {"columns": {}, "editable": true, "scroll_lock": false}}}}, "schema": {"NPR": "string", "PAN": "string", "PEKRN": "string", "State": "string", "Country": "string", "District": "string", "Locality": "string", "PIN Code": "string", "Voter ID": "string", "City Name": "string", "Last Name": "string", "DIN / DPIN": "string", "First Name": "string", "NREGA Card": "string", "State Name": "string", "CKYC number": "string", "Middle Name": "string", "Report Type": "string", "Date Of Birth": "string", "District Name": "string", "Mobile Number": "string", "Address Line 1": "string", "Passport Number": "string", "Non-Indian PIN Code": "string", "Second Address State": "string", "City / Village / Town": "string", "Second Address Line 1": "string", "Drivers License Number": "string", "Second Address Country": "string", "Report Reference Number": "string", "Second Address District": "string", "Second Address Locality": "string", "Second Address PIN Code": "string", "Second Address City Name": "string", "Second Address State Name": "string", "City / Village / Town Name": "string", "Second Address District Name": "string", "Send Address Non-Indian PIN Code": "string", "Identity verified using Aadhaar ID": "string", "Second Address City / Village / Town": "string", "Declaration (If PAN is not available)": "string", "Declaration (If CKYC is not available)": "string", "Declaration (If Last name is not available)": "string"}}, "renderCondition": "activeTab?.tabOne===\"KCS1\""}, {"key": "KCS2", "type": "perspective", "perspectiveData": {"layout": {"mode": "globalFilters", "sizes": [1], "detail": {"main": {"type": "tab-area", "widgets": ["PERSPECTIVE_GENERATED_ID_1"], "currentIndex": 0}}, "viewers": {"PERSPECTIVE_GENERATED_ID_1": {"sort": [], "table": "KCS2", "theme": "Pro Dark", "title": "KCS2", "filter": [], "linked": false, "master": false, "plugin": "Datagrid", "columns": [], "group_by": [], "settings": false, "split_by": [], "aggregates": {}, "expressions": [], "plugin_config": {"columns": {}, "editable": true, "scroll_lock": false}}}}, "schema": {"PAN": "string", "GSTIN": "string", "PEKRN": "string", "State": "string", "Country": "string", "District": "string", "Locality": "string", "PIN Code": "string", "City Name": "string", "Full Name": "string", "State Name": "string", "Report Type": "string", "District Name": "string", "Mobile Number": "string", "Company ID Type": "string", "Company ID Number": "string", "Registered Address": "string", "Non-Indian PIN Code": "string", "Second Address State": "string", "City / Village / Town": "string", "Second Address Line 1": "string", "Second Address Country": "string", "Report Reference Number": "string", "Second Address District": "string", "Second Address Locality": "string", "Second Address PIN Code": "string", "CIN/ FCRN/ LLPIN/ FLLPIN": "string", "Second Address City Name": "string", "Second Address State Name": "string", "City / Village / Town Name": "string", "Second Address District Name": "string", "Second Address Non-Indian PIN Code": "string", "Second Address City / Village / Town": "string", "Declaration (If PAN is not available)": "string"}}, "renderCondition": "activeTab?.tabOne===\"KCS2\""}, {"key": "TS3", "type": "perspective", "perspectiveData": {"layout": {"mode": "globalFilters", "sizes": [1], "detail": {"main": {"type": "tab-area", "widgets": ["PERSPECTIVE_GENERATED_ID_1"], "currentIndex": 0}}, "viewers": {"PERSPECTIVE_GENERATED_ID_1": {"sort": [], "table": "TS3", "theme": "Pro Dark", "title": "TS3", "filter": [], "linked": false, "master": false, "plugin": "Datagrid", "columns": [], "group_by": [], "settings": false, "split_by": [], "aggregates": {}, "expressions": [], "plugin_config": {"columns": {}, "editable": true, "scroll_lock": false}}}}, "schema": {"PAN": "string", "GSTIN": "string", "PEKRN": "string", "State": "string", "Country": "string", "District": "string", "Locality": "string", "PIN Code": "string", "City Name": "string", "Full Name": "string", "State Name": "string", "Report Type": "string", "District Name": "string", "Mobile Number": "string", "Company ID Type": "string", "Company ID Number": "string", "Registered Address": "string", "Non-Indian PIN Code": "string", "Second Address State": "string", "City / Village / Town": "string", "Second Address Line 1": "string", "Second Address Country": "string", "Report Reference Number": "string", "Second Address District": "string", "Second Address Locality": "string", "Second Address PIN Code": "string", "CIN/ FCRN/ LLPIN/ FLLPIN": "string", "Second Address City Name": "string", "Second Address State Name": "string", "City / Village / Town Name": "string", "Second Address District Name": "string", "Second Address Non-Indian PIN Code": "string", "Second Address City / Village / Town": "string", "Declaration (If PAN is not available)": "string"}}, "renderCondition": "activeTab?.tabOne===\"TS3\""}, {"key": "TS6", "type": "perspective", "perspectiveData": {"layout": {"mode": "globalFilters", "sizes": [1], "detail": {"main": {"type": "tab-area", "widgets": ["PERSPECTIVE_GENERATED_ID_1"], "currentIndex": 0}}, "viewers": {"PERSPECTIVE_GENERATED_ID_1": {"sort": [], "table": "TS6", "theme": "Pro Dark", "title": "TS6", "filter": [], "linked": false, "master": false, "plugin": "Datagrid", "columns": [], "group_by": [], "settings": false, "split_by": [], "aggregates": {}, "expressions": [], "plugin_config": {"columns": {}, "editable": true, "scroll_lock": false}}}}, "schema": {"Narration": "string", "Report Type": "string", "Sender Name": "string", "Transaction ID": "string", "Beneficiary Name": "string", "Transaction Date": "string", "Transaction Time": "string", "Transaction Amount": "string", "Sender Mobile Number": "string", "Report Reference Number": "string", "Beneficiary Mobile Number": "string"}}, "renderCondition": "activeTab?.tabOne===\"TS6\""}, {"key": "GS1", "type": "perspective", "perspectiveData": {"layout": {"mode": "globalFilters", "sizes": [1], "detail": {"main": {"type": "tab-area", "widgets": ["PERSPECTIVE_GENERATED_ID_1"], "currentIndex": 0}}, "viewers": {"PERSPECTIVE_GENERATED_ID_1": {"sort": [], "table": "GS1", "theme": "Pro Dark", "title": "GS1", "filter": [], "linked": false, "master": false, "plugin": "Datagrid", "columns": [], "group_by": [], "settings": false, "split_by": [], "aggregates": {}, "expressions": [], "plugin_config": {"columns": {}, "editable": true, "scroll_lock": false}}}}, "schema": {"Narration": "string", "Other Offence Type": "string", "KYC Source of Funds": "string", "Report Reference Number": "string", "KYC Destination of Funds": "string", "Other Red Flag Indicator": "string", "GoS Tag 2 - Source of Alert": "string", "GoS Tag 1 - Suspicion Due To": "string", "GoS Tag 3 - Red Flag Indicator": "string", "GoS Tag 4 - Type of Suspicion Suspected": "string"}}, "renderCondition": "activeTab?.tabOne===\"GS1\""}, {"key": "CB1", "type": "perspective", "perspectiveData": {"layout": {"mode": "globalFilters", "sizes": [1], "detail": {"main": {"type": "tab-area", "widgets": ["PERSPECTIVE_GENERATED_ID_1"], "currentIndex": 0}}, "viewers": {"PERSPECTIVE_GENERATED_ID_1": {"sort": [], "table": "CB1", "theme": "Pro Dark", "title": "CB1", "filter": [], "linked": false, "master": false, "plugin": "Datagrid", "columns": [], "group_by": [], "settings": false, "split_by": [], "aggregates": {}, "expressions": [], "plugin_config": {"columns": {}, "editable": true, "scroll_lock": false}}}}, "schema": {"ID": "string", "Name": "string", "State": "string", "Country": "string", "District": "string", "Locality": "string", "PIN Code": "string", "State Name": "string", "Report Type": "string", "Sender Name": "string", "Purpose Code": "string", "Sender State": "string", "Amount In INR": "string", "District Name": "string", "Address Line 1": "string", "Sender Country": "string", "Transaction ID": "string", "Sender Bank BIC": "string", "Sender District": "string", "Sender Locality": "string", "Sender PIN Code": "string", "Beneficiary Name": "string", "Sender Bank Name": "string", "Transaction Date": "string", "Transaction Time": "string", "Beneficiary State": "string", "Sender State Name": "string", "Swift Message Code": "string", "Swift Message Text": "string", "Beneficiary Country": "string", "Beneficiary Bank BIC": "string", "Beneficiary District": "string", "Beneficiary Locality": "string", "Beneficiary PIN Code": "string", "Sender District Name": "string", "Transaction Currency": "string", "Beneficiary Bank Name": "string", "City / Village / Town": "string", "Sender Account Number": "string", "Sender Address Line 1": "string", "Beneficiary Account No": "string", "Beneficiary State Name": "string", "Sender Identifier Type": "string", "Report Reference Number": "string", "Transaction Institution": "string", "Sender Identifier Number": "string", "Beneficiary District Name": "string", "Beneficiary Address Line 1": "string", "City / Village / Town Name": "string", "Transaction Origin Country": "string", "Beneficiary Identifier Type": "string", "Sender City / Village / Town": "string", "Sender Other Identifier Type": "string", "Beneficiary Identifier Number": "string", "Sender Correspondent Bank BIC": "string", "Amount In Transaction Currency": "string", "Sender Correspondent Bank Name": "string", "Intermediary Institute Bank BIC": "string", "Transaction Destination Country": "string", "Intermediary Institute Bank Name": "string", "Beneficiary City / Village / Town": "string", "Beneficiary Other Identifier Type": "string", "Sender City / Village / Town Name": "string", "Beneficiary Correspondent Bank BIC": "string", "Beneficiary Correspondent Bank Name": "string", "Beneficiary City / Village / Town Name": "string", "Third Reimbursement Institute Bank BIC": "string", "Third Reimbursement Institute Bank Name": "string"}}, "renderCondition": "activeTab?.tabOne===\"CB1\""}, {"key": "GT1", "type": "perspective", "perspectiveData": {"layout": {"mode": "globalFilters", "sizes": [1], "detail": {"main": {"type": "tab-area", "widgets": ["PERSPECTIVE_GENERATED_ID_1"], "currentIndex": 0}}, "viewers": {"PERSPECTIVE_GENERATED_ID_1": {"sort": [], "table": "GT1", "theme": "Pro Dark", "title": "GT1", "filter": [], "linked": false, "master": false, "plugin": "Datagrid", "columns": [], "group_by": [], "settings": false, "split_by": [], "aggregates": {}, "expressions": [], "plugin_config": {"columns": {}, "editable": true, "scroll_lock": false}}}}, "schema": {"FC Code": "string", "Amount FC": "string", "Amount INR": "string", "Report Type": "string", "Sender Name": "string", "Instrument ID": "string", "Account Number": "string", "Transaction ID": "string", "Instrument Type": "string", "Beneficiary Name": "string", "Transaction Date": "string", "Transaction Time": "string", "Relationship Flag": "string", "Sender Mobile Number": "string", "Sender Account Number": "string", "Purpose of Transaction": "string", "Report Reference Number": "string", "Beneficiary Mobile Number": "string", "Beneficiary Account Number": "string", "Sender IFSC/Branch ID/MICR": "string", "Beneficiary IFSC/Branch ID/MICR": "string", "Instrument Issuer Institute Name": "string", "Declaration (If Sender name is not available)": "string", "Declaration (If Beneficiary Name is not available)": "string", "Declaration (If Sender Account Number is not available)": "string", "Declaration (If Beneficiary Account Number is not available)": "string", "Declaration (If Sender IFSC/Branch ID/MICR is not available)": "string", "Declaration (If Beneficiary IFSC/Branch ID/MICR is not available)": "string"}}, "renderCondition": "activeTab?.tabOne===\"GT1\""}, {"key": "ACTD", "type": "perspective", "perspectiveData": {"layout": {"mode": "globalFilters", "sizes": [1], "detail": {"main": {"type": "tab-area", "widgets": ["PERSPECTIVE_GENERATED_ID_1"], "currentIndex": 0}}, "viewers": {"PERSPECTIVE_GENERATED_ID_1": {"sort": [], "table": "ACTD", "theme": "Pro Dark", "title": "Account Detail", "filter": [], "linked": false, "master": false, "plugin": "Datagrid", "columns": [], "group_by": [], "settings": false, "split_by": [], "aggregates": {}, "expressions": [], "plugin_config": {"columns": {}, "editable": true, "scroll_lock": false}}}}, "schema": {"Report Type": "string", "Account Type": "string", "Account Number": "string", "Account Status": "string", "Branch Code of Account": "string", "Date of Account Closing": "string", "Date of Account Opening": "string", "Report Reference Number": "string", "Reason for Account Freeze": "string", "No Of Debits (In last 12 months)": "string", "No Of Credits (In last 12 months)": "string", "Total Cash Deposit (In last 12 months)": "string", "Total Debit Amount (In last 12 months)": "string", "Total Credit Amount (In last 12 months)": "string", "No Of Cash Transaction (In last 12 months)": "string", "Total Cash Withdrawal (In last 12 months) Amount": "string"}}, "renderCondition": "activeTab?.tabOne===\"Account Detail\""}, {"key": "APD", "type": "perspective", "perspectiveData": {"layout": {"mode": "globalFilters", "sizes": [1], "detail": {"main": {"type": "tab-area", "widgets": ["PERSPECTIVE_GENERATED_ID_1"], "currentIndex": 0}}, "viewers": {"PERSPECTIVE_GENERATED_ID_1": {"sort": [], "table": "APD", "theme": "Pro Dark", "title": "Account Person Detail", "filter": [], "linked": false, "master": false, "plugin": "Datagrid", "columns": [], "group_by": [], "settings": false, "split_by": [], "aggregates": {}, "expressions": [], "plugin_config": {"columns": {}, "editable": true, "scroll_lock": false}}}}, "schema": {"Report Type": "string", "Account Number": "string", "Relationship Type": "string", "Name of Non-customer": "string", "Report Reference Number": "string", "Unique Reference Number": "string", "Individual / Non-individual": "string"}}, "renderCondition": "activeTab?.tabOne===\"Account Person Detail\""}], "tabKey": "tabOne", "tabOptions": [{"label": "KC1", "value": "KC1", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"KC1\")>-1"}, {"label": "KC2", "value": "KC2", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"KC2\")>-1"}, {"label": "KCS1", "value": "KCS1", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"KCS1\")>-1"}, {"label": "KCS2", "value": "KCS2", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"KCS2\")>-1"}, {"label": "TS3", "value": "TS3", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"TS3\")>-1"}, {"label": "TS6", "value": "TS6", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"TS6\")>-1"}, {"label": "GS1", "value": "GS1", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"GS1\")>-1"}, {"label": "CB1", "value": "CB1", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"CB1\")>-1"}, {"label": "GT1", "value": "GT1", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"GT1\")>-1"}, {"label": "Account Detail", "value": "ACTD", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"Account Detail\")>-1"}, {"label": "Account Person Detail", "value": "APD", "renderCondition": "finalvalues?.Extracts?.findIndex(e=>e===\"Account Person Detail\")>-1"}]}}]', 'STR Report', '{"PUT": [{"UpdateProcessHistory": [{"ProcessVariableName": "strHistoryUpdate", "ProcessVariableType": "string", "ProcessVariableValue": {"user": "", "value": "STR Report was Updated"}}]}], "POST": [{"UpdateProcessVariableCamunda": [{"ProcessVariableName": "str_report_id", "ProcessVariableType": "integer", "ProcessVariableValue": "this.FormValue.ivalueID"}]}, {"UpdateProcessHistory": [{"ProcessVariableName": "strHistoryUpdate", "ProcessVariableType": "string", "ProcessVariableValue": {"user": "", "value": "STR Report was Created"}}]}]}', 'STR Report', 8);

--------------------BAPA Tenant STR Extracts---------------------------
--Dashboard insert
INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid, bdynamic) VALUES (
'58'::integer, false::boolean, false::boolean, 'STR Extracts'::character varying, '42'::integer, '1'::integer, '494'::integer, '8'::integer, false::boolean)
 returning idashboardid,itenantid;

--query
INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid) VALUES (
'118'::integer, true::boolean, '{"Group":null, "Level":"null, "Address":null, "DateRange":null, "Extract":null}'::text, '{
    "Customer":{
        "KC1":"select vcexternalcustid as \"UCIC\", vcexternalcustid as \"Customer ID\", vcattribs->''yb_raw''->>''pan'' as \"PAN\", ''NA'' as \"Declaration (If PAN is not available)\", ''NA'' as \"CKYC Number\", ''NA'' as \"Declaration (If CKYC is not available)\", ''NA'' as \"Passport Number\", ''NA'' as \"Voter ID\", ''NA'' as \"Other Occupation\", ''NA'' as \"Drivers License Number\", ''NA'' as \"NREGA Card number of the individual\", ''NA'' as \"DIN / DPIN\", vccustomername as \"First Name\", ''NA'' as \"Middle Name\", ''NA'' as \"Last Name\", ''NA'' as \"Declaration (If Last name is not available)\", ''NA'' as \"Name of Father\", ''NA'' as \"Name of Mother\", ''NA'' as \"Spouse/Partner Name\", vcgender as \"Gender\", vcattribs->''yb_raw''->>''dob'' as \"Date of Birth\", ''NA'' as \"Nationality\", vcattribs->''yb_raw''->>''mobileNumber'' as \"Mobile Number\", ''NA'' as \"Alternate Mobile Number\", ''NA'' as \"Telephone Number\", vcattribs->''yb_raw''->>''emailId'' as \"Email ID\", vcattribs->''yb_raw''->>''addressLine1'' as \"Primary Address 1\", vcattribs->''yb_raw''->>''country'' as \"Primary Address Country\", vcattribs->''yb_raw''->>''pinCode'' as \"Primary Address Pin Code\", ''NA'' as \"Primary Address Locality\", vcattribs->''yb_raw''->>''state'' as \"Primary Address State\", vcattribs->''yb_raw''->>''district'' as \"Primary Address District\", vcattribs->''yb_raw''->>''city'' as \"Primary Address City\", vcattribs->''yb_raw''->>''addressLine2'' as \"Secondary Address 1\", ''NA'' as \"Secondary Address Country\", ''NA'' as \"Secondary Address Pin Code\", ''NA'' as \"Secondary Address Locality\", ''NA'' as \"Secondary Address State\", ''NA'' as \"Secondary Address District\", ''NA'' as \"Secondary Address City\", vcattribs->''yb_raw''->>''udyogAadhaar'' as \"Identity verified using Aadhaar ID\", vcattribs->''yb_raw''->>''ownershipType'' as \"Customer Type\", ''NA'' as \"Annual Income (INR)\", ''NA'' as \"Occupation\", ''NA'' as \"Employer Name\",  ''NA'' as \"Employer Address 1\", ''NA'' as \"Employer Address Country\", ''NA'' as \"Employer Address Pin Code\", ''NA'' as \"Employer Address Locality\", ''NA'' as \"Employer Address State\", ''NA'' as \"Employer Address District\", ''NA'' as \"Employer Address City\", vcattribs->''yb_raw''->>''createdDate'' as \"Date of Customer On-boarding\", ''NA'' as \"Date of Last KYC / re-KYC\", ''NA'' as \"Customer Risk Level\", ''NA'' as \"NPR\", ''NA'' as \"PEKRN\", vcattribs->''yb_raw''->>''state'' as \"Primary State Name\", vcattribs->''yb_raw''->>''district'' as \"Primary District Name\", vcattribs->''yb_raw''->>''city'' as \"Primary City Name\", ''NA'' as \"Secondary State Name\", ''NA'' as \"Secondary District Name\", ''NA'' as \"Secondary City Name\", ''NA'' as \"Employee State Name\", ''NA'' as \"Employee District Name\", ''NA'' as \"Employee City Name\", vcattribs->''yb_raw''->>''merchantType'' as \"Other Customer Type\", :Group as \"Report Type\" from masters.customers where vcexternalcustid = :Address and itenantid = :tenantid",
        "KC2":"select vccustomername as \"Full Name\", vcattribs->''yb_raw''->>''cin'' as \"CIN/ FCRN/ LLPIN/ FLLPIN\", vcattribs->''yb_raw''->>''pan'' as \"PAN\", ''NA'' as \"Declaration (If PAN is not available)\", vcattribs->''yb_raw''->>''gstn'' as \"GSTIN\", vcattribs->''yb_raw''->>''mobileNumber'' as \"Mobile Number\", vcattribs->''yb_raw''->>''addressLine1'' as \"Registered Address\", vcattribs->''yb_raw''->>''country'' as \"Country\", vcattribs->''yb_raw''->>''pinCode'' as \"PIN Code\", ''NA'' as \"Locality\", vcattribs->''yb_raw''->>''state'' as \"State\", vcattribs->''yb_raw''->>''district'' as \"District\", vcattribs->''yb_raw''->>''city'' as \"City / Village / Town\", ''NA'' as \"PEKRN\", vcattribs->''yb_raw''->>''state'' as \"State Name\", vcattribs->''yb_raw''->>''district'' as \"District Name\", vcattribs->''yb_raw''->>''city'' as \"City / Village / Town Name\", vcattribs->''yb_raw''->>''city'' as \"City Name\", vcattribs->''yb_raw''->>''addressLine2'' as \"Second Address Line 1\", ''NA'' as \"Second Address Country\", ''NA'' as \"Second Address PIN Code\", ''NA'' as \"Second Address Locality\", ''NA'' as \"Second Address State\", ''NA'' as \"Second Address State Name\", ''NA'' as \"Second Address District\", ''NA'' as \"Second Address District Name\", ''NA'' as \"Second Address City / Village / Town\", ''NA'' as \"Second Address City Name\", ''NA'' as \"Non-Indian PIN Code\", ''NA'' as \"Second Address Non-Indian PIN Code\", vcattribs->''yb_raw''->>''cin'' as \"Company ID Type\", vcattribs->''yb_raw''->>''pan'' as \"Company ID Number\" from masters.customers where vcexternalcustid = :Address and itenantid = :tenantid",
        "Other":"select itenantid from ui.tenants where itenantid is null"
    },
    "Transaction":{
        "TS3":"select ''NA'' as \"Relationship Flag\", vcuniquetransid as \"Transaction ID\", observations->''txn''->>''type'' as \"Transaction Type\", cast(dttrxntime as date) as \"Transaction Date\", cast(dttrxntime as time) as \"Transaction Time\", dobservationamount as \"Transaction Amount\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Sender Name\", vcpayeraddr as \"Sender VPA\", ''NA'' as \"Declaration (If Sender VPA is not available)\", ''NA'' as \"Sender Mobile Number\", ''NA'' as \"Sender IFSC\", ''NA'' as \"Sender Account Number\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''customerName'' as \"Beneficiary Name\", vcpayeeaddr as \"Beneficiary VPA\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->''yb_raw''->>''mobileNumber'' as \"Beneficiary Mobile Number\", observations->''observations''->''payeeVPA''->''account''->>''accountNumber'' as \"Beneficiary Account Number\", :Group as \"Report Type\", observations->''observations''->''payeeVPA''->''account''->>''ifsc'' as \"Beneficiary IFSC\", ''NA'' as \"Beneficiary Account Branch Code\", ''NA'' as \"Narration\", ipayeemccid as \"Merchant Category Code\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->''yb_raw''->>''merchantType'' as \"Beneficiary Account Type\" from analytics.trans where dttrxntime between :StartDate and :EndDate and itenantid = :tenantid",
        "Other":"select itenantid from ui.tenants where itenantid is null"
    },
    "Account":{
        "Account Detail" :"select :Group as \"Report Type\", ac.iaccounttypeid as \"Account Type\", ac.vcaccount as \"Account Number\", ''NA'' as \"Branch Code of Account\", ac.dtonboardingdate as \"Date of Account Opening\", ''NA'' as \"Date of Account Closing\", ''NA'' as \"Account Status\", ''NA'' as \"Reason for Account Freeze\", ''NA'' as \"No Of Debits (In last 12 months)\", ''NA'' as \"Total Debit Amount (In last 12 months)\", prof.val->''totalCount''->''p12m''->>''payee'' as \"No Of Credits (In last 12 months)\", prof.val->''totalValue''->''p12m''->>''payee'' as \"Total Credit Amount (In last 12 months)\", ''NA'' as \"No Of Cash Transaction (In last 12 months)\", ''NA'' as \"Total Cash Deposit (In last 12 months)\", ''NA'' as \"Total Cash Withdrawal (In last 12 months) Amount\" from profiles.account_monthly as prof join masters.accounts ac on prof.iaccountid=ac.iaccountid where ac.vcexternalaccountid = :Address order by prof.tdate desc limit 1",
        "Account Person Detail" : "select :Group as \"Report Type\", vcaccount as \"Account Number\", ''NA'' as \"Relationship Type\", vcexternalaccountid as \"Unique Reference Number\", ''NA'' as \"Individual / Non-individual\", ''NA'' as \"Name of Non-customer\" from masters.accounts where itenantid = :tenantid and vcexternalaccountid = :Address",
        "Other":"select itenantid from ui.tenants where itenantid is null"
    },
    "Other": {
        "Other":"select itenantid from ui.tenants where itenantid is null"
    }
}'::text, false::boolean, false::boolean, false::boolean, '494'::integer, '8'::integer)
 returning idashboardqueryid,itenantid;

--queryparameters
INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype,
idashboardqueryid, iorder, itenantid) VALUES (
 (select max(idashboardparameterid)+1 from
ui.dashboardqueryparameters), 'Group'::character varying,
'String'::character varying, '118'::integer, '0'::integer, '8'::integer)
  returning idashboardparameterid;

INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype,
idashboardqueryid, iorder, itenantid) VALUES (
 (select max(idashboardparameterid)+1 from
ui.dashboardqueryparameters), 'Address'::character varying,
'String'::character varying, '118'::integer, '1'::integer, '8'::integer)
  returning idashboardparameterid;


INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype,
idashboardqueryid, iorder, itenantid) VALUES (
 (select max(idashboardparameterid)+1 from
ui.dashboardqueryparameters), 'DateRange'::character varying,
'DateRange'::character varying, '118'::integer, '2'::integer, '8'::integer)
  returning idashboardparameterid;


INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype,
idashboardqueryid, iorder, itenantid) VALUES (
 (select max(idashboardparameterid)+1 from
ui.dashboardqueryparameters), 'Level'::character varying,
'JsonPath'::character varying, '118'::integer, '3'::integer, '8'::integer)
  returning idashboardparameterid;

INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype,
idashboardqueryid, iorder, itenantid) VALUES (
 (select max(idashboardparameterid)+1 from
ui.dashboardqueryparameters), 'Extract'::character varying,
'JsonPath'::character varying, '118'::integer, '4'::integer, '8'::integer)
  returning idashboardparameterid;

--resultset
INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout,
vcdashboardresultsetname, idashboardqueryid, idashboardid, irowno,
imenustructuredesc, itenantid) VALUES
((select max(idashboardresultsetid)+1 from ui.dashboardresultset),
'{}'::text,
'strextracts', '118'::integer, '58'::integer, '1'::integer, '494'::integer, '8'::integer);