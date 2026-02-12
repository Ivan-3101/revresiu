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
"Rule Triggered Count":"integer",
"Total Txn Count":"integer",
"Rule Efficiency":"integer",
"Avg Value (Rules Triggered)":"float",
"Avg Value (Total Txns)":"float"
}'
WHERE
idashboardresultsetid = 12;

UPDATE
ui.dashboardresultset
SET
vcdashboardresultsetlayout = '{
   "sizes":[
      1
   ],
   "master":{
      "widgets":[
         "PERSPECTIVE_GENERATED_ID_1"
      ]
   },
   "viewers":{
      "PERSPECTIVE_GENERATED_ID_1":{
         "settings":true,
         "selectable":false,
         "plugin":"datagrid",
         "columns":[
            "Date",
            "Decision",
            "Class",
            "Rule ID",
            "Rule Name",
            "Score",
            "Rule Triggered Count",
            "Total Txn Count",
            "Rule Efficiency",
            "Avg Value (Rules Triggered)",
            "Avg Value (Total Txns)"
         ],
         "master":true,
         "name":"Rule Efficiency Report",
         "table":"ruleefficiencyreport",
         "linked":false
      }
   }
}'
WHERE
idashboardresultsetid = 12;

UPDATE
ui.dashboardquery
SET
vcdashboardquery = 'select rp.tdate as "Date", d.vcdecisionname as "Decision", rp.vcclassname as "Class", rp.iruleid as "Rule ID", r.vcrulename as "Rule Name",
rp.score as "Score", rp.scoretxncount as "Rule Triggered Count", rp.totaltxncount as "Total Txn Count",
(rp.scoretxncount* 100)/rp.totaltxncount as "Rule Efficiency", rp.scoretxnvalue / rp.scoretxncount as "Avg Value (Rules Triggered)",
rp.totaltxnvalue / rp.totaltxncount as "Avg Value (Total Txns)"
from transactions.rule_performance rp
left join masters.rules r on r.iruleid = rp.iruleid
left join masters.decisions d on d.idecisionid = rp.idecisionid where tdate = :Date ;
'
WHERE
idashboardqueryid = 31;