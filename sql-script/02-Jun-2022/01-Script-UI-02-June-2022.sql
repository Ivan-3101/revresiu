
delete from ui.perspectivequery where iperspectivequeryid = 18;

INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (18, 'select
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
ipayervpaid = (select ipayervpaid FROM transactions.vw_livetrans ORDER BY dttrxntime desc LIMIT 1)   and Payee.iVPAID = ipayeevpaid and Payer.iVPAID =  ipayervpaid
and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE)', 'vpaDashboardInitial');