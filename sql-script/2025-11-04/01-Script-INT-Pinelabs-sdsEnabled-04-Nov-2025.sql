-- ui.tasklhsmap

UPDATE ui.tasklhsmap SET
icolumn = '10'::integer WHERE
iorder = 0 AND irow = 1 AND idropdownoptionid in (1,2,3) AND iworkflowid = 16 AND itenantid = 10;

UPDATE ui.tasklhsmap SET
irow = '2'::integer WHERE
iorder = 0 AND irow = 1 AND idropdownoptionid = 4 AND iworkflowid = 16 AND itenantid = 10;

UPDATE ui.tasklhsmap SET
irow = '2'::integer WHERE
iorder = 1 AND irow = 1 AND idropdownoptionid = 4 AND iworkflowid = 16 AND itenantid = 10;

INSERT INTO ui.tasklhsmap (
iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (
'2'::integer, '1'::integer, '1'::integer, '16'::integer, '2'::integer, '{
  "tag": "span",
  "path": "this.variables.sdsEnabled",
  "type": "default",
  "className": "d-inline pull-right"
}'::jsonb, '10'::integer)
 returning iorder,irow,idropdownoptionid,iworkflowid,itenantid;

 INSERT INTO ui.tasklhsmap (
iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (
'2'::integer, '1'::integer, '2'::integer, '16'::integer, '2'::integer, '{
  "tag": "span",
  "path": "this.variables.sdsEnabled",
  "type": "default",
  "className": "d-inline pull-right"
}'::jsonb, '10'::integer)
 returning iorder,irow,idropdownoptionid,iworkflowid,itenantid;

 INSERT INTO ui.tasklhsmap (
iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (
'2'::integer, '1'::integer, '3'::integer, '16'::integer, '2'::integer, '{
  "tag": "span",
  "path": "this.variables.sdsEnabled",
  "type": "default",
  "className": "d-inline pull-right"
}'::jsonb, '10'::integer)
 returning iorder,irow,idropdownoptionid,iworkflowid,itenantid;

 INSERT INTO ui.tasklhsmap (
iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (
'0'::integer, '1'::integer, '4'::integer, '16'::integer, '12'::integer, '{
  "tag": "span",
  "path": "this.variables.sdsEnabled",
  "type": "default",
  "className": "d-inline pull-right"
}'::jsonb, '10'::integer)
 returning iorder,irow,idropdownoptionid,iworkflowid,itenantid;

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
  },
  {
    "name": "sdsEnabled",
    "data_type": "string",
    "value_config": {
      "value": "/observations/payeeVPA/account/customer/attribs/sdsEnabled",
      "extract_from": "trans_json"
    }
  }
]'::jsonb WHERE
workflowid = 16 AND itenantid = 10;

-- ui.taskvariables

UPDATE ui.taskvariables SET
variables = '["WorkflowName","TicketID","failedRules","TransactionAmount","fieldDropDowns","RiskScore","AvgRiskScore","triggeredtype","payeeAccount","failedRuleIDs", "payeeName", "current_final_status", "txndate", "payeepayerAccount", "sdsEnabled"]'::text WHERE
id = 1;