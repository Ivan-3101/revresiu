UPDATE ui.dashboardquery
SET  vcdashboardquery='select cast(dtcreateddatetime as date) as dtdate, r.vcrulename, sum(l.iruleid) cntrule, dscore from
transactions.livedecisiondetails l
left join masters.rules r on l.iruleid = r.iruleid
 where cast(dtcreateddatetime as date)=:Date and bpassed is false group by l.iruleid, cast(dtcreateddatetime as date), r.vcrulename,dscore
 order by l.iruleid'
WHERE idashboardqueryid=12;