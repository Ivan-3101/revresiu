UPDATE ui.workflowmasters SET
manual_attribs = '{
  "type": "batch",
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
      "valueKeyName": "level",
      "onChangeAction": [
        {
          "key": "callApi",
          "url": "/api/v1/case-management/tasks/workflows/manual-creation/profile-dates/${address}/${level}/${frequency}/${workflow}/${tenant}",
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
                          "var": "values.frequency"
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
                          "var": "values.frequency"
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
              "key": "values.frequency"
            },
            {
              "key": "values.workflow"
            },
            {
              "key": "values.tenant"
            }
          ],
          "responseKeyName": "dateOptions"
        }
      ]
    },
    {
      "col": 3,
      "row": 0,
      "type": "text",
      "label": "Address",
      "disabled": false,
      "required": true,
      "apiKeyName": "",
      "onBlurAction": [
        {
          "key": "callApi",
          "url": "/api/v1/case-management/tasks/workflows/manual-creation/profile-dates/${address}/${level}/${frequency}/${workflow}/${tenant}",
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
                          "var": "values.frequency"
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
                          "var": "values.frequency"
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
              "key": "values.frequency"
            },
            {
              "key": "values.workflow"
            },
            {
              "key": "values.tenant"
            }
          ],
          "responseKeyName": "dateOptions"
        }
      ],
      "valueKeyName": "address"
    },
    {
      "col": 3,
      "row": 1,
      "type": "text",
      "label": "Add Details about alert",
      "disabled": true,
      "required": true,
      "defaultValue": "Add Profile",
      "valueKeyName": "details"
    },
    {
      "col": 3,
      "row": 1,
      "type": "select",
      "label": "Frequency",
      "options": [
        {
          "label": "End of Day",
          "value": "daily"
        },
        {
          "label": "End of Month",
          "value": "monthly"
        },
        {
          "label": "End of Week",
          "value": "weekly"
        }
      ],
      "required": true,
      "valueKeyName": "frequency",
      "onChangeAction": [
        {
          "key": "callApi",
          "url": "/api/v1/case-management/tasks/workflows/manual-creation/profile-dates/${address}/${level}/${frequency}/${workflow}/${tenant}",
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
                          "var": "values.frequency"
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
                          "var": "values.frequency"
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
              "key": "values.frequency"
            },
            {
              "key": "values.workflow"
            },
            {
              "key": "values.tenant"
            }
          ],
          "responseKeyName": "dateOptions"
        }
      ]
    },
    {
      "col": 3,
      "row": 1,
      "type": "select",
      "label": "Date",
      "required": true,
      "apiOptions": {
        "keyName": "dateOptions"
      },
      "valueKeyName": "date",
      "renderCondition": {
        "jsonLogic": {
          "and": [
            {
              "if": [
                {
                  "!=": [
                    {
                      "var": "apiResponse.dateOptions"
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
                      "var": "values.frequency"
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
                      "var": "values.frequency"
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
                      "var": "values.date"
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
                      "var": "values.date"
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
          "url": "/api/v1/case-management/tasks/workflows/manual-creation/get-batch-trans/${address}/${level}/${frequency}/${date}/${workflow}/${tenant}",
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
                          "var": "values.frequency"
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
                          "var": "values.frequency"
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
                          "var": "values.date"
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
                          "var": "values.date"
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
              "key": "values.frequency"
            },
            {
              "key": "values.date"
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
      "label": "Merchant ID",
      "disabled": true,
      "required": true,
      "defaultValue": {
        "keyName": "apiResponse.batchTransaction.Transaction.observations.customer.vcattribs.yb_raw.id"
      },
      "valueKeyName": "merchantId",
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
            }
          ]
        }
      }
    },
    {
      "col": 3,
      "row": 2,
      "type": "text",
      "label": "Merchant Name",
      "disabled": true,
      "required": true,
      "defaultValue": {
        "keyName": "apiResponse.batchTransaction.Transaction.observations.customer.vcattribs.yb_raw.businessName"
      },
      "valueKeyName": "merchantName",
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
            }
          ]
        }
      }
    },
    {
      "col": 3,
      "row": 2,
      "type": "text",
      "label": "Verified Name",
      "disabled": true,
      "required": true,
      "defaultValue": {
        "keyName": "apiResponse.batchTransaction.Transaction.observations.customer.vcattribs.yb_raw.sellerVerifiedAccountName"
      },
      "valueKeyName": "verifiedName",
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
            }
          ]
        }
      }
    },
    {
      "col": 3,
      "row": 2,
      "type": "text",
      "label": "Partner Name",
      "disabled": true,
      "required": true,
      "defaultValue": {
        "keyName": "apiResponse.batchTransaction.Transaction.observations.customer.vcattribs.yb_raw.partnerName"
      },
      "valueKeyName": "partnerName",
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
            }
          ]
        }
      }
    },
    {
      "col": 3,
      "row": 2,
      "type": "text",
      "label": "Customer VPA",
      "disabled": true,
      "required": true,
      "defaultValue": {
        "keyName": "apiResponse.batchTransaction.Transaction.observations.vpa.vcexternaladdressid"
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
        "keyName": "apiResponse.batchTransaction.Transaction.observations.vpa.vcvpaname"
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
      "disabled": true,
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
        "TransactionType": {
          "type": "String",
          "value": "Batch"
        },
        "isCreatedManually": {
          "type": "Boolean",
          "value": true
        }
      }
    }
  ]
}'::jsonb WHERE
workflowid = 4;