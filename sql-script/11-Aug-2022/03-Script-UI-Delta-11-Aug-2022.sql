UPDATE ui.perspectivequery
SET  vcquery='SELECT  * from ui.getlivetrans_last(
:className,
	:score,
	:timeZone,
	50
)'
WHERE iperspectivequeryid=3;

UPDATE ui.perspectivequery
SET  vcquery='SELECT * from ui.getlivetrans_autorefresh(
:iLiveMessageID,
:className,
	:score,
	:timeZone
)'
WHERE iperspectivequeryid=16;

UPDATE ui.perspectivequery
SET  vcquery='SELECT * from ui.gettxnprofilebyclass_new(
:party,
	:vpaType,
	:txnType,
	:timeZone,
	:iLiveMsgID,
	:vpaAddress,
	:txnClass,
	20
)'
WHERE iperspectivequeryid=22;

UPDATE ui.perspectivequery
SET  vcquery='SELECT * from ui.gettxnprofile_new(
:party,
	:vpaType,
	:txnType,
	:timeZone,
	:iLiveMsgID,
	:vpaAddress,
	20
)'
WHERE iperspectivequeryid=23;


UPDATE ui.perspectivequery SET  vcquery='select
iLiveMessageID as "ID",
vcmsgid  as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
payervpa,
payername,
payeevpa,
payeename,
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
vcrulename as "Rule", vcpayeraccount,  vcpayeeaccount
from transactions.vw_livetrans_with_vpa_and_account_from_joins L where
 vcmsgid=:msgid'
WHERE iperspectivequeryid=24;


UPDATE ui.perspectivequery
SET  vcquery='SELECT * from ui.gettxnprofileselectedtxn_new(
:party,
	:vpaType,
	:timeZone,
	:msgid,
	:vpaAddress,
	:txnDate
)'
WHERE iperspectivequeryid=25;


UPDATE ui.perspectivequery
SET  vcquery='SELECT * from ui.gettxnprofileselectedtxnbyclass_new(
:party,
	:vpaType,
	:timeZone,
	:msgid,
	:vpaAddress,
	:txnClass,
	:txnDate
)'
WHERE iperspectivequeryid=26;


UPDATE ui.perspectivequeryparameters
SET  iposition=0
WHERE iperspectiveparameterid=20;

INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (59, 0, 'className', 'String', 3);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (60, 1, 'score', 'Integer', 3);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (61, 1, 'className', 'String', 16);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (62, 2, 'score', 'Integer', 16);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (63, 0, 'party', 'String', 22);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (64, 0, 'party', 'String', 23);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (65, 0, 'party', 'String', 24);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (66, 0, 'party', 'String', 25);
