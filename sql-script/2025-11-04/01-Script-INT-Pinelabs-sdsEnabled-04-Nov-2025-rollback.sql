--ui.tasklhsmap

DELETE FROM ui.tasklhsmap
WHERE iorder = 2
  AND irow = 1
  AND iworkflowid = 16
  AND itenantid = 10
  AND idropdownoptionid IN (1, 2, 3);

UPDATE ui.tasklhsmap SET
icolumn = '12'::integer WHERE
iorder = 0 AND irow = 1 AND idropdownoptionid in (1,2,3) AND iworkflowid = 16 AND itenantid = 10;

DELETE FROM ui.tasklhsmap
WHERE iorder = 0
  AND irow = 1
  AND iworkflowid = 16
  AND itenantid = 10
  AND idropdownoptionid = 4;

UPDATE ui.tasklhsmap SET
irow = '1'::integer WHERE
iorder = 0 AND irow = 2 AND idropdownoptionid = 4 AND iworkflowid = 16 AND itenantid = 10;

UPDATE ui.tasklhsmap SET
irow = '1'::integer WHERE
iorder = 1 AND irow = 2 AND idropdownoptionid = 4 AND iworkflowid = 16 AND itenantid = 10;


-- ui.workflowmasters

 UPDATE ui.workflowmasters SET
filterparams = '[
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
  },
  {
    "name": "is_domestic",
    "data_type": "double",
    "value_config": {
      "value": "/txn/attribs/is_domestic",
      "extract_from": "trans_json"
    }
  },
  {
    "name": "is_dcc",
    "data_type": "boolean",
    "value_config": {
      "value": "/txn/attribs/is_dcc",
      "extract_from": "trans_json"
    }
  },
  {
    "name": "rrn",
    "data_type": "string",
    "value_config": {
      "value": "/txn/attribs/rrn",
      "extract_from": "trans_json"
    }
  }
]'::jsonb WHERE
workflowid = 16 AND itenantid = 10;

-- ui.taskvariables

UPDATE ui.taskvariables SET
variables = '["WorkflowName","TicketID","failedRules","TransactionAmount","fieldDropDowns","RiskScore","AvgRiskScore","triggeredtype","payeeAccount","failedRuleIDs", "payeeName", "current_final_status", "txndate", "payeepayerAccount"]'::text WHERE
id = 1;