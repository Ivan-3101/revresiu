UPDATE ui.dashboardquery
SET  vcdashboardquery='select cast(dtcreateddatetime as date) as "Date", r.vcrulename as "Rule Name", sum(l.iruleid) "Rule Count", dscore as "Score" from
transactions.livedecisiondetails l
left join masters.rules r on l.iruleid = r.iruleid
 where cast(dtcreateddatetime as date)=:Date and bpassed is false group by l.iruleid, cast(dtcreateddatetime as date), r.vcrulename,dscore
 order by l.iruleid'
WHERE idashboardqueryid=12;