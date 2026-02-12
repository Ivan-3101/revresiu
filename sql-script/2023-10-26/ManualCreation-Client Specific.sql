UPDATE ui.workflowmasters SET
is_manual_creation = false::boolean, is_filter_display = true::boolean, manual_display_name = 'Risk Alert'::character varying WHERE
workflowid = 1;
UPDATE ui.workflowmasters SET
is_manual_creation = false::boolean, is_filter_display = true::boolean, manual_display_name = 'Decline Transaction'::character varying WHERE
workflowid = 2;
UPDATE ui.workflowmasters SET
is_manual_creation = false::boolean, is_filter_display = true::boolean, manual_display_name = 'AML Cases'::character varying WHERE
workflowid = 4;
UPDATE ui.workflowmasters SET
is_manual_creation = false::boolean, is_filter_display = true::boolean, manual_display_name = 'QC'::character varying WHERE
workflowid = 5;
UPDATE ui.workflowmasters SET
is_manual_creation = false::boolean, is_filter_display = true::boolean, manual_display_name = 'Blocked Settlements'::character varying WHERE
workflowid = 6;
UPDATE ui.workflowmasters SET
is_manual_creation = false::boolean, is_filter_display = true::boolean, manual_display_name = 'Risk Alert'::character varying WHERE
workflowid = 12;
UPDATE ui.workflowmasters SET
is_manual_creation = false::boolean, is_filter_display = true::boolean, manual_display_name = 'CUB-Risk Notification'::character varying WHERE
workflowid = 13;
UPDATE ui.workflowmasters SET
is_manual_creation = false::boolean, is_filter_display = true::boolean, manual_display_name = 'USFB-Risk Notification'::character varying WHERE
workflowid = 14;
UPDATE ui.workflowmasters SET
is_manual_creation = false::boolean, is_filter_display = true::boolean, manual_display_name = 'Sanctions'::character varying WHERE
workflowid = 15;
UPDATE ui.workflowmasters SET
is_manual_creation = false::boolean, is_filter_display = true::boolean, manual_display_name = 'Risky Merchant Settlements'::character varying WHERE
workflowid = 16;

INSERT INTO ui.workflowmasters (
workflowid, workflowname, workflowkey, manual_display_name, is_manual_creation, is_filter_display) VALUES (
'17'::integer, 'Orchestration'::character varying, 'Orchestrator'::character varying, 'AML Cases'::character varying, true::boolean, false::boolean)
 returning workflowid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '578'::integer, '1'::integer)
 returning irolemenumapid;

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
    ],
    "onChangeAction": [
      {
        "key": "callApi",
        "responseKeyName": "dateOptions",
        "RequestType": "GET",
        "headers": [{ "name": "JWT" }],
        "url": "/api/v1/case-management/tasks/workflows/manual-creation/profile-dates/${address}/${level}/${frequency}",
        "paramsValues": [{ "key": "values.address" }, { "key": "values.level" }, { "key": "values.frequency" }],
        "uiserver": true,
        "callApiIf": {
          "jsonLogic": {
            "and": [
              { "if": [{ "!=": [{ "var": "values.address" }, null] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.address" }, ""] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.level" }, null] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.level" }, ""] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.frequency" }, null] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.frequency" }, ""] }, true, false] }
            ]
          }
        }
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
    "col": 3,
    "onBlurAction": [
      {
        "key": "callApi",
        "responseKeyName": "dateOptions",
        "RequestType": "GET",
        "headers": [{ "name": "JWT" }],
        "url": "/api/v1/case-management/tasks/workflows/manual-creation/profile-dates/${address}/${level}/${frequency}",
        "paramsValues": [{ "key": "values.address" }, { "key": "values.level" }, { "key": "values.frequency" }],
        "uiserver": true,
        "callApiIf": {
          "jsonLogic": {
            "and": [
              { "if": [{ "!=": [{ "var": "values.address" }, null] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.address" }, ""] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.level" }, null] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.level" }, ""] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.frequency" }, null] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.frequency" }, ""] }, true, false] }
            ]
          }
        }
      }
    ]
  },
  {
    "label": "Add Details about alert",
    "type": "text",
    "valueKeyName": "details",
    "required": true,
    "disabled": true,
    "defaultValue": "Add Profile",
    "row": 1,
    "col": 3
  },
  {
    "label": "Frequency",
    "type": "select",
    "valueKeyName": "frequency",
    "required": true,
    "row": 1,
    "col": 3,
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
    "onChangeAction": [
      {
        "key": "callApi",
        "responseKeyName": "dateOptions",
        "RequestType": "GET",
        "headers": [{ "name": "JWT" }],
        "url": "/api/v1/case-management/tasks/workflows/manual-creation/profile-dates/${address}/${level}/${frequency}",
        "paramsValues": [{ "key": "values.address" }, { "key": "values.level" }, { "key": "values.frequency" }],
        "uiserver": true,
        "callApiIf": {
          "jsonLogic": {
            "and": [
              { "if": [{ "!=": [{ "var": "values.address" }, null] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.address" }, ""] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.level" }, null] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.level" }, ""] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.frequency" }, null] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.frequency" }, ""] }, true, false] }
            ]
          }
        }
      }
    ]
  },
  {
    "label": "Date",
    "type": "select",
    "valueKeyName": "date",
    "required": true,
    "row": 1,
    "col": 3,
    "apiOptions": {
      "keyName": "dateOptions"
    },
    "renderCondition": {
      "jsonLogic": {
        "and": [{ "if": [{ "!=": [{ "var": "apiResponse.dateOptions" }, null] }, true, false] }]
      }
    }
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
        "url": "/api/v1/case-management/tasks/workflows/manual-creation/get-batch-trans/${address}/${level}/${frequency}/${date}",
        "paramsValues": [
          { "key": "values.address" },
          { "key": "values.level" },
          { "key": "values.frequency" },
          { "key": "values.date" }
        ],
        "uiserver": true,
        "callApiIf": {
          "jsonLogic": {
            "and": [
              { "if": [{ "!=": [{ "var": "values.address" }, null] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.address" }, ""] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.level" }, null] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.level" }, ""] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.frequency" }, null] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.frequency" }, ""] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.date" }, null] }, true, false] },
              { "if": [{ "!=": [{ "var": "values.date" }, ""] }, true, false] }
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
          { "if": [{ "==": [{ "var": "values.frequency" }, null] }, true, false] },
          { "if": [{ "==": [{ "var": "values.frequency" }, ""] }, true, false] },
          { "if": [{ "==": [{ "var": "values.date" }, null] }, true, false] },
          { "if": [{ "==": [{ "var": "values.date" }, ""] }, true, false] }
        ]
      }
    }
  },
  {
    "label": "Merchant ID",
    "type": "text",
    "required": true,
    "valueKeyName": "merchantId",
    "disabled": true,
    "row": 2,
    "col": 3,

    "renderCondition": {
      "jsonLogic": {
        "and": [
          { "if": [{ "==": [{ "var": "values.level" }, "account"] }, true, false] },
          { "if": [{ "!=": [{ "var": "apiResponse.batchTransaction" }, null] }, true, false] }
        ]
      }
    },
    "defaultValue": {
      "keyName": "apiResponse.batchTransaction.Transaction.observations.customer.vcattribs.yb_raw.id"
    }
  },
  {
    "label": "Merchant Name",
    "type": "text",
    "required": true,
    "valueKeyName": "merchantName",
    "disabled": true,
    "row": 2,
    "col": 3,
    "renderCondition": {
      "jsonLogic": {
        "and": [
          { "if": [{ "==": [{ "var": "values.level" }, "account"] }, true, false] },
          { "if": [{ "!=": [{ "var": "apiResponse.batchTransaction" }, null] }, true, false] }
        ]
      }
    },
    "defaultValue": {
      "keyName": "apiResponse.batchTransaction.Transaction.observations.customer.vcattribs.yb_raw.businessName"
    }
  },
  {
    "label": "Verified Name",
    "type": "text",
    "required": true,
    "valueKeyName": "verifiedName",
    "disabled": true,
    "row": 2,
    "col": 3,
    "renderCondition": {
      "jsonLogic": {
        "and": [
          { "if": [{ "==": [{ "var": "values.level" }, "account"] }, true, false] },
          { "if": [{ "!=": [{ "var": "apiResponse.batchTransaction" }, null] }, true, false] }
        ]
      }
    },
    "defaultValue": {
      "keyName": "apiResponse.batchTransaction.Transaction.observations.customer.vcattribs.yb_raw.sellerVerifiedAccountName"
    }
  },
  {
    "label": "Partner Name",
    "type": "text",
    "required": true,
    "valueKeyName": "partnerName",
    "disabled": true,
    "row": 2,
    "col": 3,
    "renderCondition": {
      "jsonLogic": {
        "and": [
          { "if": [{ "==": [{ "var": "values.level" }, "account"] }, true, false] },
          { "if": [{ "!=": [{ "var": "apiResponse.batchTransaction" }, null] }, true, false] }
        ]
      }
    },
    "defaultValue": {
      "keyName": "apiResponse.batchTransaction.Transaction.observations.customer.vcattribs.yb_raw.partnerName"
    }
  },
  {
    "label": "Customer VPA",
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
          { "if": [{ "!=": [{ "var": "apiResponse.batchTransaction" }, null] }, true, false] }
        ]
      }
    },
    "defaultValue": {
      "keyName": "apiResponse.batchTransaction.Transaction.observations.vpa.vcexternaladdressid"
    }
  },
  {
    "label": "Customer Name",
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
          { "if": [{ "!=": [{ "var": "apiResponse.batchTransaction" }, null] }, true, false] }
        ]
      }
    },
    "defaultValue": {
      "keyName": "apiResponse.batchTransaction.Transaction.observations.vpa.vcvpaname"
    }
  },
  {
    "label": "Select Alert(s)",
    "type": "select",
    "valueKeyName": "alerts",
    "isMulti": true,
    "required": true,
    "row": 3,
    "col": 3,
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
      "TransactionType": {
        "value": "Batch",
        "type": "String"
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
]
'::jsonb WHERE
workflowid = 17;