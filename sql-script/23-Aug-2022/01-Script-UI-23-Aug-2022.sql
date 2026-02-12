UPDATE ui.dashboardresultset
	SET  vcdashboardresultsetlayout='{
                                       "sizes": [
                                         1
                                       ],
                                       "master": {
                                         "widgets": [
                                           "PERSPECTIVE_GENERATED_ID_1"
                                         ]
                                       },
                                       "viewers": {
                                         "PERSPECTIVE_GENERATED_ID_1": {
                                           "sort": [
                                             [
                                               "Live Message ID",
                                               "desc"
                                             ]
                                           ],
                                           "settings": true,
                                           "selectable": false,
                                           "columns": [
                                             "Transaction time",
                                             "Live Message ID",
                                             "Class",
                                             "Transaction Amount",
                                             "Settled Amount",
                                             "Failed Amount",
                                             "Score",
                                             "Status",
                                             "FRM Passed",
                                             "Payer VPA",
                                             "Payee VPA",
                                             "MCC",
                                             "Transaction ID",
                                             "Rule Name",
                                             "Decision Details",
                                             "Observations",
                                             "New Payer Flag",
                                             "Is New payee for Payer",
                                             "OS",
                                             "IP",
                                             "Device ID",
                                             "Location",
                                             "Device",
                                             "vcmsgid"
                                           ],
                                           "plugin": "datagrid",
                                           "master": true,
                                           "name": "Transaction",
                                           "table": "transaction",
                                           "linked": false
                                         }
                                       }
                                  }'
                                  ,  vcdashboardresultsetschema='{
                                  "Class":"string",
                                  "OS":"string",
                                  "Failed Amount": "float",
                                  "New Payer Flag": "boolean",
                                  "Decision Details": "string",
                                  "Live Message ID": "integer",
                                  "IP":"string",
                                  "Is New payee for Payer":"boolean",
                                  "Rule Name":"string",
                                  "Transaction Amount":"float",
                                  "MCC":"integer",
                                  "Device ID":"string",
                                  "Payee VPA":"string",
                                  "Settled Amount": "float",
                                  "Score":"integer",
                                  "FRM Passed": "boolean",
                                  "Observations":"string",
                                  "Payer VPA":"string",
                                  "Transaction time":"datetime",
                                  "Location":"string",
                                  "Device":"string",
                                  "Transaction ID":"string",
                                  "Status": "string",
                                  "vcmsgid": "string"
                                  }'
	WHERE idashboardresultsetid=1;


