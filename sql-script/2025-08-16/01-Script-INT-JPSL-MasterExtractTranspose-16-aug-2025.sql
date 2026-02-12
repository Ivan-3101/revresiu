UPDATE ui.dashboardfilters SET
validation = '{
  "autoSelectTransposeOnChange": {
    "value": true,
    "inputs": [
      "vcexternalcustid",
      "vcexternalaccountid",
      "vcexternaladdressid"
    ]
  }
}'::jsonb WHERE
 itenantid=14 and idashboardid=16 and vcdashboardfiltername='Transpose'
