UPDATE ui.perspectivequery
SET vcquery='select
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
row_number() OVER (ORDER BY dtTrxnTime asc) AS "Serial Number"
from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where
ipayervpaid = (SELECT ipayervpaid FROM transactions.vw_livetrans ORDER BY dttrxntime  desc LIMIT 1)  and Payee.iVPAID = L.iPayeeVPAID and Payer.iVPAID = ipayervpaid' WHERE iperspectivequeryid = 15;