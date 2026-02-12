UPDATE ui.dashboardresultset SET
vcdashboardresultsetschema = '{
"Txn Date Time" : "datetime",
"Txn ID" : "string" ,
"Payer Customer ID" : "string",
"Payer Account ID" : "string",
"Payer VPA ID" : "string",
"Customer ID" : "string",
"Account ID" : "string",
"VPA ID" : "string",
"Payee Customer ID" : "string",
"Payee Account ID" : "string",
"Payee VPA ID" : "string",
"Txn Class" : "string",
"Txn Amount" : "float",
"Decision Name" : "string",
"Rule ID" : "integer",
"Rule Name" : "string" ,
"Score" : "integer",
"Side": "string"
}'::text WHERE
idashboardresultsetid = 13;
