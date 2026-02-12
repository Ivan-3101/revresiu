ALTER TABLE ui.listmaster
ADD COLUMN iconfigjson JSONB DEFAULT NULL;


UPDATE ui.listmaster SET
iconfigjson = '{
  "options": [
    {
      "label": "monthly_txn_limit",
      "value": "monthly_txn_limit",
      "renderCondition": "fieldselect?.value===\"default_mcc_monthly\""
    },
    {
      "label": "single_day_txn_limit",
      "value": "single_day_txn_limit",
      "renderCondition": "fieldselect?.value===\"default_mcc\""
    }
  ],
  "renderCondition": "fieldselect?.value===\"default_mcc\"||fieldselect?.value===\"default_mcc_monthly\""
}
'::jsonb WHERE
ilistmasterid = 3 AND itenantid = 14;
