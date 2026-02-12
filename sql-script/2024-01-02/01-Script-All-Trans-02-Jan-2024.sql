
UPDATE ui.dashboardquery SET
vcdashboardquery = '{
    "All": "select result->''score''->>''decisiondetails'' as \"decisiondetails\", ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\", dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where score >= :score and dttrxntime > cast(current_date as timestamp)  order by dttrxntime desc limit 1000;",
    "Other": "select result->''score''->>''decisiondetails'' as \"decisiondetails\", ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\", dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where score >= :score and dttrxntime > cast(current_date as timestamp)  and vcclassname  = :className order by dttrxntime desc limit 1000;"
}'::text WHERE
idashboardqueryid = 55;


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


UPDATE ui.dashboardquery SET
vcdashboardquery = 'select date(dtentrydatetime) as "Date", vcrequestid as "ReqID Failed to Process" from
transactions.scorerequests

WHERE dtentrydatetime between :StartDate and :EndDate '::text WHERE
idashboardqueryid = 93;