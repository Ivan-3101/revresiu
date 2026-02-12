
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (20, 'select
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
Payer.vcAddress as "Payer VPA",
Payee.vcAddress as "Payee VPA",
dTransAmount as "Amount",
ld.vcremark as "Remark",
ld.dscore as  "Rule Score"
from transactions.livetrans L, masters.VPA Payer, masters.VPA Payee, transactions.LiveDecisionDetails ld where
Payer.iVPAID = L.iPayerVPAID   and Payee.iVPAID = L.iPayeeVPAID and ld.ilivemessageid= L.ilivemessageid and score=:score
and ld.dscore!=0
order by dtTrxnTime desc
', 'alertTransactions');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (21, 'select
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
Payer.vcAddress as "Payer VPA",
Payee.vcAddress as "Payee VPA",
dTransAmount as "Amount",
ld.vcremark as "Remark",
ld.dscore as  "Rule Score"
from transactions.livetrans L, masters.VPA Payer, masters.VPA Payee, transactions.LiveDecisionDetails ld where
Payer.iVPAID = L.iPayerVPAID   and Payee.iVPAID = L.iPayeeVPAID and ld.ilivemessageid= L.ilivemessageid and score=:score
and ld.dscore!=0 and txnclass = :className
order by desc
', 'alertTransactionsByClass');

UPDATE ui.perspectivequery SET vcquery= 'select
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
and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) limit 1000' WHERE iperspectivequeryid=11;

UPDATE ui.perspectivequery SET vcquery= 'select
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
and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) limit 1000' WHERE iperspectivequeryid=18;


UPDATE ui.perspectivequery SET vcquery='select
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
and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) limit 1000'
WHERE iperspectivequeryid=12;

UPDATE ui.perspectivequery SET vcquery= 'select
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
and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) limit 1000' WHERE iperspectivequeryid=13;

UPDATE ui.perspectivequery SET vcquery='select
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
and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) limit 1000' WHERE iperspectivequeryid=14;

INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (23, 'SELECT * from ui.gettxnprofile(
	:vpaType,
	:txnType,
	:timeZone,
	:date,
	:msgid,
	:vpaAddress,
	20
)
', 'transactionProfile');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (24, 'select
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
vcrulename as "Rule"
from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where
 vcmsgid=:msgid
and Payee.iVPAID = L.iPayeeVPAID and Payer.iVPAID = ipayervpaid', 'selectedTransaction');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (22, 'SELECT * from ui.gettxnprofilebyclass(
	:vpaType,
	:txnType,
	:timeZone,
	:date,
	:msgid,
	:vpaAddress,
	:txnClass,
	20
)', 'transactionProfileByClass');


UPDATE ui.perspectivequery SET  vcquery= 'select
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
vcrulename as "Rule"
from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where
vcmsgid  = (SELECT vcmsgid  FROM transactions.vw_livetrans ORDER BY dttrxntime  desc LIMIT 1)  and Payee.iVPAID = L.iPayeeVPAID and Payer.iVPAID = ipayervpaid'
WHERE iperspectivequeryid=15;

INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (24, 0, 'score', 'Integer', 20);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (25, 0, 'score', 'Integer', 21);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (26, 1, 'className', 'String', 21);

INSERT INTO ui.perspectivequeryparameters(
    iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)
VALUES (36, 1, 'vpaType', 'String', 23);

INSERT INTO ui.perspectivequeryparameters(
    iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)
VALUES (37, 2, 'txnType', 'String', 23);

INSERT INTO ui.perspectivequeryparameters(
    iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)
VALUES (38, 4, 'date', 'Date', 23);

INSERT INTO ui.perspectivequeryparameters(
    iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)
VALUES (27, 5, 'msgid', 'String', 23);


INSERT INTO ui.perspectivequeryparameters(
    iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)
VALUES (28, 6, 'vpaAddress', 'String', 23);

INSERT INTO ui.perspectivequeryparameters(
    iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)
VALUES (29, 1, 'msgid', 'String', 24);

INSERT INTO ui.perspectivequeryparameters(
    iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)
VALUES (30, 1, 'vpaType', 'String', 22);

INSERT INTO ui.perspectivequeryparameters(
    iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)
VALUES (31, 2, 'txnType', 'String', 22);

INSERT INTO ui.perspectivequeryparameters(
    iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)
VALUES (32, 4, 'date', 'Date', 22);

INSERT INTO ui.perspectivequeryparameters(
    iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)
VALUES (33, 5, 'msgid', 'String', 22);

INSERT INTO ui.perspectivequeryparameters(
    iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)
VALUES (34, 6, 'vpaAddress', 'String', 22);

INSERT INTO ui.perspectivequeryparameters(
    iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)
VALUES (35, 6, 'txnClass', 'String', 22);