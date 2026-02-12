UPDATE ui.dashboardquery SET
vcdashboardquery = 'select dtTrxnTime as "startdate", dtTrxnTime as "enddate" from transactions.vw_LiveTrans where dtTrxnTime is not null order by dtTrxnTime desc limit 1'::text WHERE
idashboardqueryid = 16;