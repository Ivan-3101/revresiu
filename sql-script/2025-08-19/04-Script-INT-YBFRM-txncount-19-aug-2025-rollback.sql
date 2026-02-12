UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT "Date",
"Class",
SUM ("Txns Failed to Process") AS "Txns Failed to Process",
SUM("Txns Processed Successfully") AS "Txns Processed Successfully" ,
SUM("Txns Failed to Process") + SUM("Txns Processed Successfully") AS "Txn Requests Received"
FROM
(select
date(sr.dtentrydatetime) as "Date",
cast(vcrequestdata as json)->''txn''->>''class'' as "Class",
case when sr.vcrequestid is null then 0 else 1 end  as "Txns Failed to Process",
case when sr.vcrequestid is null then 1 else 0 end  as "Txns Processed Successfully"
from
analytics.scorerequests sr
WHERE sr.dtentrydatetime between :StartDate and :EndDate and sr.itenantid = :tenantid
UNION ALL
select
date(tx.dttrxntime) as "Date",
tx.vcclassname as "Class",
case when tx.vcmsgid is null then 1 else 0 end  as "Txns Failed to Process",
case when tx.vcmsgid is null then 0 else 1 end  as "Txns Processed Successfully"
from
analytics.trans tx
WHERE tx.dttrxntime between :StartDate and :EndDate and tx.itenantid = :tenantid
 ) T GROUP BY "Date",
"Class" limit 10000;'::text WHERE
idashboardqueryid = 80 AND itenantid = 9;