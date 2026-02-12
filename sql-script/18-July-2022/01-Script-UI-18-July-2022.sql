UPDATE ui.perspectivequery
SET  vcquery='select
iLiveMessageID as "ID",
vcmsgid  as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
Payer.vcAddress as "Payer VPA",
Payer.vcvpaname as "Payer Name",
Payee.vcAddress as "Payee VPA",
payee.vcvpaname as "Payee Name",
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
vcrulename as "Rule",
row_number() OVER (ORDER BY dtTrxnTime) AS "Serial Number"
from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where
ipayervpaid = (select ivpaid from masters.VPA where vcaddress = :payerID limit 1 )   and Payee.iVPAID = ipayeevpaid and Payer.iVPAID =  ipayervpaid
and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE)'
WHERE iperspectivequeryid=11;

UPDATE ui.perspectivequery
SET  vcquery='select
iLiveMessageID as "ID",
vcmsgid  as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
Payer.vcAddress as "Payer VPA",
Payer.vcvpaname as "Payer Name",
Payee.vcAddress as "Payee VPA",
payee.vcvpaname as "Payee Name",
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
vcrulename as "Rule",
row_number() OVER (ORDER BY dtTrxnTime) AS "Serial Number"
from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where
ipayervpaid = (select ivpaid from masters.VPA where vcaddress = :payerID limit 1)  and Payee.iVPAID = ipayeevpaid and Payer.iVPAID =  ipayervpaid and txnclass = :className
and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE)'
WHERE iperspectivequeryid=12;


UPDATE ui.perspectivequery
SET  vcquery='select
iLiveMessageID as "ID",
vcmsgid  as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
Payer.vcAddress as "Payer VPA",
Payer.vcvpaname as "Payer Name",
Payee.vcAddress as "Payee VPA",
payee.vcvpaname as "Payee Name",
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
vcrulename as "Rule",
row_number() OVER (ORDER BY dtTrxnTime) AS "Serial Number"
from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where
Payer.iVPAID =  L.iPayerVPAID   and ipayeevpaid = (select ivpaid from masters.VPA where vcaddress = :payeeID limit 1) and Payee.iVPAID = ipayeevpaid and txnclass =  :className
and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE)'
WHERE iperspectivequeryid=13;

UPDATE ui.perspectivequery
SET  vcquery='select
iLiveMessageID as "ID",
vcmsgid  as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
Payer.vcAddress as "Payer VPA",
Payer.vcvpaname as "Payer Name",
Payee.vcAddress as "Payee VPA",
payee.vcvpaname as "Payee Name",
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
vcrulename as "Rule",
row_number() OVER (ORDER BY dtTrxnTime) AS "Serial Number"
from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where
Payer.iVPAID =  L.iPayerVPAID   and ipayeevpaid = (select ivpaid from masters.VPA where vcaddress = :payeeID limit 1) and Payee.iVPAID = ipayeevpaid
and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE)'
WHERE iperspectivequeryid=14;