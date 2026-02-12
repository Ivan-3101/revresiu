UPDATE
ui.dashboardresultset
SET
vcdashboardresultsetschema = '{
"Date":"date",
"Decision":"string",
"Class":"string",
"Rule ID":"integer",
"Rule Name":"string",
"Score":"integer",
"Scored Txn Count":"integer",
"Total Txn Count":"integer",
"Rule Efficiency":"integer",
"Scored Txn Avg Value":"float",
"Avg Txn Value":"float"
}'
WHERE
idashboardresultsetid = 12;