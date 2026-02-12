UPDATE ui.workflowmasters SET
displayconfig =  E'[
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
    "label": "Address",
    "regex": "^[a-zA-Z0-9 ,_@*#%''/\\\\\\\\&.\\\\-()\\\\+~!=:\\\\$`\\\\?\\"}]*$"
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
  }
]  '::jsonb WHERE
workflowid = 19 AND itenantid = 12;