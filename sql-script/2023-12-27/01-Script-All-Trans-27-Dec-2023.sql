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
transactions.scorerequests sr
WHERE sr.dtentrydatetime between :StartDate and :EndDate
AND
vcrequestid not like ''pismo:%'' and vcrequestid not like ''unknown:%''
UNION ALL
select
date(tx.dttrxntime) as "Date",
tx.vcclassname as "Class",
case when tx.vcmsgid is null then 1 else 0 end  as "Txns Failed to Process",
case when tx.vcmsgid is null then 0 else 1 end  as "Txns Processed Successfully"
from
transactions.trans tx
WHERE tx.dttrxntime between :StartDate and :EndDate ) T
GROUP BY "Date",
"Class";'::text WHERE
idashboardqueryid = 80;