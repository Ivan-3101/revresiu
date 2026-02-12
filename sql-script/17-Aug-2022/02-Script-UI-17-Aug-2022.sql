UPDATE ui.perspectivequery
SET  vcquery='select
iLiveMessageID as "ID",
vcmsgid  as "Unique ID",
dtTrxnTime at time zone ''Asia/Kolkata'' at time zone :timeZone as "Time",
payervpa,
payername,
payeevpa,
payeename,
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
vcrulename as "Rule",
vcpayeraccount,
vcpayeeaccount
from transactions.vw_livetrans_with_vpa_and_account_from_joins L ORDER BY dttrxntime  desc LIMIT 1'
WHERE iperspectivequeryid=15;