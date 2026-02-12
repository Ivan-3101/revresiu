INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (15, 'select 
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
ipayervpaid = (SELECT ipayervpaid FROM transactions.vw_livetrans ORDER BY dttrxntime  LIMIT 1)  and Payee.iVPAID = L.iPayeeVPAID and Payer.iVPAID = ipayervpaid', 'vpaTransactionProfileInitial');

CREATE SEQUENCE ui.rulesaudit_iruleidaudit_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE  ui.rulesaudit_iruleidaudit_seq OWNED BY ui.rulesaudit.iruleidaudit;
ALTER TABLE ui.rulesaudit ALTER COLUMN iruleidaudit SET DEFAULT nextval('ui.rulesaudit_iruleidaudit_seq');
