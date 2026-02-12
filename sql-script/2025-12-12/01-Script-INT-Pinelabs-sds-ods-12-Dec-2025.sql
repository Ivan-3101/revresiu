UPDATE ui.tasklhsmap SET
valueconfig = '{
  "tag": "span",
  "type": "default",
  "className": "d-inline pull-right",
  "jsonLogic": { "if": [ { "and": [ { "==": [{ "var": "values.computationJson.sdsEnabled" }, "true"] }, { "==": [{ "var": "values.computationJson.odsEnabled" }, "true"] } ] }, "sdsAndOdsEnabled", { "and": [ { "==": [{ "var": "values.computationJson.sdsEnabled" }, "true"] }, { "!=": [{ "var": "values.computationJson.odsEnabled" }, "true"] } ] }, "sdsEnabled", { "and": [ { "!=": [{ "var": "values.computationJson.sdsEnabled" }, "true"] }, { "==": [{ "var": "values.computationJson.odsEnabled" }, "true"] } ] }, "odsEnabled", { "and": [ { "!=": [{ "var": "values.computationJson.sdsEnabled" }, "true"] }, { "!=": [{ "var": "values.computationJson.odsEnabled" }, "true"] } ] }, "" ] }
,
  "computationJson":[{"variableName":"sdsEnabled","value":"","type":"boolean"},{"variableName":"odsEnabled","value":"","type":"boolean"}]
}'::jsonb WHERE
iorder = 0 AND irow = 1 AND idropdownoptionid = 4 AND iworkflowid = 16 AND itenantid = 10;

UPDATE ui.tasklhsmap SET
valueconfig = '{
  "tag": "span",
  "type": "default",
  "className": "d-inline pull-right",
  "jsonLogic": { "if": [ { "and": [ { "==": [{ "var": "values.computationJson.sdsEnabled" }, "true"] }, { "==": [{ "var": "values.computationJson.odsEnabled" }, "true"] } ] }, "sdsAndOdsEnabled", { "and": [ { "==": [{ "var": "values.computationJson.sdsEnabled" }, "true"] }, { "!=": [{ "var": "values.computationJson.odsEnabled" }, "true"] } ] }, "sdsEnabled", { "and": [ { "!=": [{ "var": "values.computationJson.sdsEnabled" }, "true"] }, { "==": [{ "var": "values.computationJson.odsEnabled" }, "true"] } ] }, "odsEnabled", { "and": [ { "!=": [{ "var": "values.computationJson.sdsEnabled" }, "true"] }, { "!=": [{ "var": "values.computationJson.odsEnabled" }, "true"] } ] }, "" ] }
,
  "computationJson":[{"variableName":"sdsEnabled","value":"","type":"boolean"},{"variableName":"odsEnabled","value":"","type":"boolean"}]

}'::jsonb WHERE
iorder = 2 AND irow = 1 AND idropdownoptionid = 3 AND iworkflowid = 16 AND itenantid = 10;


UPDATE ui.tasklhsmap SET
valueconfig = '{
  "tag": "span",
  "type": "default",
  "className": "d-inline pull-right",
  "jsonLogic": { "if": [ { "and": [ { "==": [{ "var": "values.computationJson.sdsEnabled" }, "true"] }, { "==": [{ "var": "values.computationJson.odsEnabled" }, "true"] } ] }, "sdsAndOdsEnabled", { "and": [ { "==": [{ "var": "values.computationJson.sdsEnabled" }, "true"] }, { "!=": [{ "var": "values.computationJson.odsEnabled" }, "true"] } ] }, "sdsEnabled", { "and": [ { "!=": [{ "var": "values.computationJson.sdsEnabled" }, "true"] }, { "==": [{ "var": "values.computationJson.odsEnabled" }, "true"] } ] }, "odsEnabled", { "and": [ { "!=": [{ "var": "values.computationJson.sdsEnabled" }, "true"] }, { "!=": [{ "var": "values.computationJson.odsEnabled" }, "true"] } ] }, "" ] }
,
  "computationJson":[{"variableName":"sdsEnabled","value":"","type":"boolean"},{"variableName":"odsEnabled","value":"","type":"boolean"}]

}'::jsonb WHERE
iorder = 2 AND irow = 1 AND idropdownoptionid = 2 AND iworkflowid = 16 AND itenantid = 10;


UPDATE ui.tasklhsmap SET
valueconfig = '{
  "tag": "span",
  "type": "default",
  "className": "d-inline pull-right",
   "jsonLogic": { "if": [ { "and": [ { "==": [{ "var": "values.computationJson.sdsEnabled" }, "true"] }, { "==": [{ "var": "values.computationJson.odsEnabled" }, "true"] } ] }, "sdsAndOdsEnabled", { "and": [ { "==": [{ "var": "values.computationJson.sdsEnabled" }, "true"] }, { "!=": [{ "var": "values.computationJson.odsEnabled" }, "true"] } ] }, "sdsEnabled", { "and": [ { "!=": [{ "var": "values.computationJson.sdsEnabled" }, "true"] }, { "==": [{ "var": "values.computationJson.odsEnabled" }, "true"] } ] }, "odsEnabled", { "and": [ { "!=": [{ "var": "values.computationJson.sdsEnabled" }, "true"] }, { "!=": [{ "var": "values.computationJson.odsEnabled" }, "true"] } ] }, "" ] }
,
  "computationJson":[{"variableName":"sdsEnabled","value":"","type":"boolean"},{"variableName":"odsEnabled","value":"","type":"boolean"}]

}'::jsonb WHERE
iorder = 2 AND irow = 1 AND idropdownoptionid = 1 AND iworkflowid = 16 AND itenantid = 10;


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
  },
  {
    "name": "odsEnabled",
    "data_type": "string",
    "value_config": {
      "value": "/observations/payeeVPA/account/customer/attribs/odsEnabled",
      "extract_from": "trans_json"
    }
  }
]'::jsonb WHERE
workflowid = 16 AND itenantid = 10;


