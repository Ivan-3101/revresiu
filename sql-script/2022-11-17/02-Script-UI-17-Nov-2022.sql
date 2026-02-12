UPDATE ui.dashboardfilters
	SET vcdashboardfiltername='DateRange',  vcdashboardfiltertype='DateRangePicker', vcdashboardfilterdisplayname='Date Range'
	WHERE idashboardfilterid=24;

UPDATE ui.dashboardqueryparameters
	SET  vcparametername='DateRange', vcparametertype='DateRange'
	WHERE idashboardparameterid=30;

UPDATE
ui.dashboardquery
SET vcdashboardquery = 'select rp.tdate as "Date", d.vcdecisionname as "Decision", rp.vcclassname as "Class", rp.iruleid as "Rule ID", r.vcrulename as "Rule Name",
rp.score as "Score", rp.scoretxncount as "Rule Triggered Count", rp.totaltxncount as "Total Txn Count",
round( cast((cast(rp.scoretxncount as float)* 100)/rp.totaltxncount as numeric	),2	) as "Rule Efficiency (%)", rp.scoretxnvalue / rp.scoretxncount as "Avg Value (Rules Triggered)",
rp.totaltxnvalue / rp.totaltxncount as "Avg Value (Total Txns)"
from transactions.rule_performance rp
left join masters.rules r on r.iruleid = rp.iruleid
left join masters.decisions d on d.idecisionid = rp.idecisionid where tdate  between cast(:StartDate as date) and cast(:EndDate as date)-1 and score > 0 ;
', vcfilterparametersjson = '{"DateRange" : null}'
WHERE
idashboardqueryid = 31;


UPDATE
ui.dashboardquery
SET vcdashboardquery = 'SELECT (NOW() - interval ''1 day'');'
WHERE
idashboardqueryid = 32;