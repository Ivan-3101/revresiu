UPDATE ui.dashboardquery
SET  vcdashboardquery='select iruleid, cast(dtcreateddatetime as date) as dtdate,sum(iruleid) cntrule from
transactions.livedecisiondetails
 where cast(dtcreateddatetime as date)=:Date and bpassed is false group by iruleid, cast(dtcreateddatetime as date)
 order by iruleid'
WHERE idashboardqueryid=12;


UPDATE ui.perspectivequeryparameters
SET iperspectivequeryid=26
WHERE  iperspectiveparameterid=65;