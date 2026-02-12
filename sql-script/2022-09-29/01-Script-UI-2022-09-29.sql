UPDATE
ui.dashboardquery
SET
vcdashboardquery = 'select vcclassname as "label", vcclassname as "value" FROM masters.transactionclasses where bactive=true UNION SELECT ''All'' AS "label", ''All'' AS "value" ORDER BY label'
WHERE
idashboardqueryid = 34;




UPDATE
ui.dashboardquery
SET
vcdashboardquery = 'select vcdecisionname as "label", vcdecisionname as "value" FROM masters.decisions where bactive=true UNION SELECT ''All'' AS "label", ''All'' AS "value" ORDER BY label'
WHERE
idashboardqueryid = 35;




UPDATE
ui.dashboardquery
SET
vcdashboardquery = 'select vcrulename as "label", vcrulename as "value" FROM masters.rules where bactive=true UNION SELECT ''All'' AS "label", ''All'' AS "value" ORDER BY label'
WHERE
idashboardqueryid = 36;


UPDATE
ui.dashboardresultset
SET
vcdashboardresultsetschema = '{
"Txn Date Time" : "datetime",
"Txn ID" : "string" ,
"Payer Customer ID" : "string",
"Payer Account ID" : "string",
"Payer VPA ID" : "string",
"Payee Customer ID" : "string",
"Payee Account ID" : "string",
"Payee VPA ID" : "string",
"Txn Class" : "string",
"Txn Amount" : "float",
"Decision Name" : "string",
"Rule ID" : "integer",
"Rule Name" : "string" ,
"Score" : "integer"
}'
WHERE
idashboardresultsetid = 13;




UPDATE
ui.dashboardquery
SET
vcdashboardquery = 'select rp.tdate as "Date", d.vcdecisionname as "Decision", rp.vcclassname as "Class", rp.iruleid as "Rule ID", r.vcrulename as "Rule Name",
rp.score as "Score", rp.scoretxncount as "Scored Txn Count", rp.totaltxncount as "Total Txn Count",
(rp.scoretxncount* 100)/rp.totaltxncount as "Rule Efficiency", rp.scoretxnvalue / rp.scoretxncount as "Scored Txn Avg Value",
rp.totaltxnvalue / rp.totaltxncount as "Avg Txn Value"
from transactions.rule_performance rp
left join masters.rules r on r.iruleid = rp.iruleid
left join masters.decisions d on d.idecisionid = rp.idecisionid where tdate = :Date ;
'
WHERE
idashboardqueryid = 31;



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
"Rule Efficiency":"float",
"Scored Txn Avg Value":"float",
"Avg Txn Value":"float"
}'
WHERE
idashboardresultsetid = 12;
