UPDATE ui.workflowmasters SET
autocloseconfig = '{
  "declare": [
    {
      "name": "systemComment",
      "type": "string",
      "value": "AutoClose - FAILED Txn arrived for case"
    },
    {
      "name": "transactionStatus",
      "type": "string",
      "value": "Failed"
    }
  ],
  "activity": "Event_0fnpq40",
  "identifier": {
    "duration": {
      "unit": "HOURS",
      "value": "2"
    },
    "variable": {
      "name": "transaction_id",
      "path": "/txn/id",
      "type": "string",
      "source": "trans_json"
    }
  }
} '::jsonb WHERE
 workflowkey = 'JPSLRMS' and itenantid = 14;