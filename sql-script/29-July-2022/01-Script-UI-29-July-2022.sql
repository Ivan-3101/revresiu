UPDATE ui.perspectivequery SET vcquery='select
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
Payer.vcAddress as "Payer VPA",
Payee.vcAddress as "Payee VPA",
dTransAmount as "Amount",
ld.vcremark as "Remark",
ld.dscore as  "Rule Score"
from transactions.vw_livetrans L, masters.VPA Payer, masters.VPA Payee, transactions.LiveDecisionDetails ld where
Payer.iVPAID = L.iPayerVPAID   and Payee.iVPAID = L.iPayeeVPAID and ld.ilivemessageid= L.ilivemessageid and score=:score
and ld.dscore > 0 and dtTrxnTime between now() - cast(:lastTime as interval)  AND now()
order by dtTrxnTime desc' WHERE iperspectivequeryid=20;


UPDATE ui.perspectivequery SET vcquery='select
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
Payer.vcAddress as "Payer VPA",
Payee.vcAddress as "Payee VPA",
dTransAmount as "Amount",
ld.vcremark as "Remark",
ld.dscore as  "Rule Score"
from transactions.vw_livetrans L, masters.VPA Payer, masters.VPA Payee, transactions.LiveDecisionDetails ld where
Payer.iVPAID = L.iPayerVPAID   and Payee.iVPAID = L.iPayeeVPAID and ld.ilivemessageid= L.ilivemessageid and score=:score
and ld.dscore > 0 and txnclass = :className and dtTrxnTime between now() - cast(:lastTime as interval) and now()
order by dtTrxnTime  desc' WHERE iperspectivequeryid=21;

INSERT INTO ui.perspectivequeryparameters(iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (43, 3, 'lastTime', 'String', 20);
INSERT INTO ui.perspectivequeryparameters(iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (44, 4, 'lastTime', 'String', 21);