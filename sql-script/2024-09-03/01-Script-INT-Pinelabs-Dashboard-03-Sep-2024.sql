INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid, bdynamic) VALUES (
'69'::integer, true::boolean, false::boolean, 'Settlement Status Report'::character varying, '69'::integer, '1'::integer, '536'::integer, '10'::integer, true::boolean)
 returning idashboardid,itenantid;


INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid) VALUES (
'139'::integer, false::boolean, 'WITH settlementStatusCode AS (
    SELECT
        holdStatusCodeVar.proc_inst_id_ AS process_instance_id,
        holdStatusCodeVar.text_ AS status_code
    FROM camunda.act_hi_varinst holdStatusCodeVar
    WHERE (holdStatusCodeVar.name_ = ''holdStatusCode'' OR holdStatusCodeVar.name_ = ''releaseStatusCode'')
      AND holdStatusCodeVar.tenant_id_ = ''10''
    AND holdStatusCodeVar.create_time_ BETWEEN cast((current_date - 1) as timestamp) AND cast(current_date as timestamp)
),
callbackbyte AS (
    SELECT 
        callBackResponse.proc_inst_id_ AS process_instance_id,
        CONCAT(''Call Back '',convert_from(callBackResponsebyte.bytes_, ''UTF8'')::jsonb->>''status'') AS status_code
    FROM camunda.act_hi_varinst callBackResponse
    LEFT JOIN camunda.act_ge_bytearray callBackResponsebyte 
        ON callBackResponsebyte.id_ = callBackResponse.bytearray_id_
    WHERE callBackResponse.name_ = ''callBackResponse''
      AND callBackResponse.var_type_ = ''json''
      AND callBackResponse.create_time_ BETWEEN cast((current_date - 1) as timestamp) AND cast(current_date as timestamp)
      AND callBackResponse.tenant_id_ = ''10''
),
combined_statuses AS (
    SELECT status_code FROM settlementStatusCode
    UNION ALL
    SELECT status_code FROM callbackbyte
),
status_summary AS (
    SELECT
        status_code AS "Status",
        COUNT(*) AS "Count"
    FROM combined_statuses
    GROUP BY status_code
),
status_difference AS (
    SELECT
        ''Response not received'' AS "Status",
        COALESCE(
            SUM(CASE WHEN status_code = ''200 OK'' THEN 1 ELSE 0 END) - 
            SUM(CASE WHEN status_code LIKE ''Call Back%'' THEN 1 ELSE 0 END), 0
        ) AS "Count"
    FROM combined_statuses
)
SELECT
    "Status",
    "Count"
FROM status_summary

UNION ALL

SELECT
     "Status",
     "Count"
FROM status_difference
	'::text, false::boolean, false::boolean, false::boolean, '536'::integer, '10'::integer)
 returning idashboardqueryid,itenantid;



INSERT INTO ui.dashboardresultset(
	idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno, dtlastupdatedtimestamp, iuserid, imenustructuredesc, itenantid, iorgid)
	VALUES (228,null ,null, '{
    "sizes": [
        1
    ],
    "detail": {
        "main": {
            "type": "tab-area",
            "widgets": [
                "PERSPECTIVE_GENERATED_ID_1"
            ],
            "currentIndex": 0
        }
    },
    "mode": "globalFilters",
    "viewers": {
        "PERSPECTIVE_GENERATED_ID_1": {
            "plugin": "Datagrid",
            "plugin_config": {
                "columns": {},
                "editable": false,
                "scroll_lock": false
            },
            "settings": false,
            "theme": "Pro Dark",
            "title": "Settlement Status Report",
            "group_by": [],
            "split_by": [],
            "columns": [],
            "filter": [],
            "sort": [],
            "expressions": [],
            "aggregates": {},
            "master": false,
            "table": "settlementStatusReport",
            "linked": false
        }
    }
}', 
	'settlementStatusReport',139 ,69,
	'{
    "Status" : "string",
    "Count" : "integer"
}', 
	null, 1, null, null ,536, 10, 7);


UPDATE ui.workflowmasters
	SET  manual_attribs='{
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
}'
	WHERE itenantid=10 AND manualworkflowid=16;