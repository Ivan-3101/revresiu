UPDATE ui.dashboardresultset SET
vcdashboardresultsetschema = '{
"Date":"date",
"Decision":"string",
"Class":"string",
"Rule ID":"integer",
"Rule Name":"string",
"Score":"integer",
"Rule Triggered Count":"integer",
"Total Txn Count":"integer",
"Rule Efficiency (%)":"float",
"Avg Value (Rules Triggered)":"float",
"Avg Value (Total Txns)":"float",
"False Alert %":"float",
"Unique Accounts Triggered":"integer",
"Unique VPAs Affected":"integer"
}'::text WHERE
idashboardresultsetid = 12;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'select rp.tdate as "Date", d.vcdecisionname as "Decision", rp.vcclassname as "Class", rp.iruleid as "Rule ID", r.vcrulename as "Rule Name",
rp.score as "Score", rp.scoretxncount as "Rule Triggered Count", rp.totaltxncount as "Total Txn Count",
round( cast((cast(rp.scoretxncount as float)* 100)/rp.totaltxncount as numeric	),2	) as "Rule Efficiency (%)",
round( cast((cast(rp.override_txncount as float)* 100)/rp.scoretxncount as numeric	),2	) as "False Alert %",
rp.scoretxnvalue / rp.scoretxncount as "Avg Value (Rules Triggered)",
rp.totaltxnvalue / rp.totaltxncount as "Avg Value (Total Txns)",
rp.accounts_affected as "Unique Accounts Triggered",
rp.vpas_affected as "Unique VPAs Affected"
from transactions.rule_performance rp
left join masters.rules r on r.iruleid = rp.iruleid
left join masters.decisions d on d.idecisionid = rp.idecisionid where tdate  between cast(:StartDate as date) and cast(:EndDate as date)-1 and score > 0 ;
'::text WHERE
idashboardqueryid = 31;
