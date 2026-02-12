
truncate ui.perspectivequeryparameters cascade ;
truncate ui.perspectivequery cascade ;

INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (4, 'select
iLiveMessageID as "ID",
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
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
from transactions.vw_livetrans_with_vpa_and_account_from_joins where txnclass = :className order by dtTrxnTime desc
limit 50', 'livetransactionbyclass');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (3, 'select
iLiveMessageID as "ID",
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
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
from transactions.vw_livetrans_with_vpa_and_account_from_joins order by dtTrxnTime desc
limit 50', 'livetransaction');

INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (20, 'select
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
payervpa,
payeevpa,
dTransAmount as "Amount",
ld.vcremark as "Remark",
ld.dscore as  "Rule Score"
from transactions.vw_livetrans_with_vpa_and_account_from_joins L, transactions.LiveDecisionDetails ld where
ld.ilivemessageid = L.ilivemessageid and score=:score and ld.dscore > 0
and dtTrxnTime between now() - cast(:lastTime as interval)  AND now()
order by dtTrxnTime desc', 'alertTransactions');

INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (19, 'SELECT l.ilivemessageid, lt.vcmsgid, r.iruleid, r.vcrulename, l.bpassed, l.dscore, l.dinfo, l.vcremark, l.dtcreateddatetime
from transactions.LiveDecisionDetails l, masters.Rules r, transactions.livetrans lt
where  l.ilivemessageid = :iLiveMessageID and r.iRuleID=l.iRuleID and l.ilivemessageid = lt.ilivemessageid
order by dscore desc', 'decisiondetailsforlivetrans');

INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (16, 'select
iLiveMessageID as "ID",
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
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
from transactions.vw_livetrans_with_vpa_and_account_from_joins L where iLiveMessageID > :iLiveMessageID order by dtTrxnTime desc;', 'livetransactionAutoRefresh');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (2, 'SELECT * from ui.getdecisiondetails(
	 :vcMsgID
)', 'decisiondetails');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (21, 'select
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
payervpa,
payeevpa,
dTransAmount as "Amount",
ld.vcremark as "Remark",
ld.dscore as  "Rule Score"
from transactions.vw_livetrans_with_vpa_and_account_from_joins L, transactions.LiveDecisionDetails ld where
ld.ilivemessageid= L.ilivemessageid and score=:score
and ld.dscore > 0 and txnclass = :className and dtTrxnTime between now() - cast(:lastTime as interval) and now()
order by dtTrxnTime  desc', 'alertTransactionsByClass');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (26, 'SELECT * from ui.gettxnprofileselectedtxnbyclass(
	:vpaType,
	:timeZone,
	:msgid,
	:vpaAddress,
	:txnClass,
	:txnDate
)', 'selectedTransactionbyclass');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (17, 'select
iLiveMessageID as "ID",
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
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
from transactions.vw_livetrans_with_vpa_and_account_from_joins where
txnclass = :className and iLiveMessageID > :iLiveMessageID order by dtTrxnTime desc;', 'livetransactionbyclassAutoRefresh');

INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (27, 'SELECT * from ui.getpartydtxn(
	:party,
	:userType,
	:timeZone,
	:useraddress,
	1000
)', 'partyDashboard');

INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (28, 'SELECT * from  ui.getpartydtxnbyclass(
	:party,
	:userType,
	:timeZone,
	:txnClass,
	:useraddress,
	1000
)', 'partyDashboardByClass');

INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (15, 'select
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
vcrulename as "Rule"
from transactions.vw_livetrans_with_vpa_and_account_from_joins L ORDER BY dttrxntime  desc LIMIT 1', 'vpaTransactionProfileInitial');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (24, 'select
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
vcrulename as "Rule"
from transactions.vw_livetrans_with_vpa_and_account_from_joins L where
 vcmsgid=:msgid', 'selectedTransactionbymsgid');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (22, 'SELECT * from ui.gettxnprofilebyclass(
	:vpaType,
	:txnType,
	:timeZone,
	:iLiveMsgID,
	:vpaAddress,
	:txnClass,
	20
)', 'transactionProfileByClass');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (23, 'SELECT * from ui.gettxnprofile(
	:vpaType,
	:txnType,
	:timeZone,
	:iLiveMsgID,
	:vpaAddress,
	20
)', 'transactionProfile');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (25, 'SELECT * from ui.gettxnprofileselectedtxn(
	:vpaType,
	:timeZone,
	:msgid,
	:vpaAddress,
	:txnDate
)', 'selectedTransaction');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (18, 'select
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
    vcrulename as "Rule",
	vcpayeraccount,
	vcpayeeaccount
from transactions.vw_livetrans_with_vpa_and_account_from_joins L
where ipayervpaid = (select ipayervpaid FROM transactions.vw_livetrans_with_vpa_and_account_from_joins ORDER BY dttrxntime desc LIMIT 1)
  and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) limit 1000;', 'vpaDashboardInitial');



INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (2, 1, 'className', 'String', 4);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (20, 1, 'iLiveMessageID', 'Integer', 16);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (21, 1, 'className', 'String', 17);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (22, 2, 'iLiveMessageID', 'Integer', 17);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (1, 1, 'vcMsgID', 'String', 2);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (23, 1, 'iLiveMessageID', 'Integer', 19);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (24, 0, 'score', 'Integer', 20);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (25, 0, 'score', 'Integer', 21);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (26, 1, 'className', 'String', 21);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (5, 1, 'vpaType', 'String', 23);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (6, 2, 'txnType', 'String', 23);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (28, 6, 'vpaAddress', 'String', 23);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (29, 1, 'msgid', 'String', 24);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (30, 1, 'vpaType', 'String', 22);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (31, 2, 'txnType', 'String', 22);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (3, 6, 'vpaAddress', 'String', 22);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (4, 6, 'txnClass', 'String', 22);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (27, 4, 'iLiveMsgID', 'Integer', 23);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (33, 4, 'iLiveMsgID', 'Integer', 22);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (34, 1, 'vpaType', 'String', 25);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (35, 3, 'msgid', 'String', 25);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (36, 4, 'vpaAddress', 'String', 25);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (37, 5, 'txnDate', 'Date', 25);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (38, 1, 'vpaType', 'String', 26);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (39, 3, 'msgid', 'String', 26);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (40, 4, 'vpaAddress', 'String', 26);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (41, 5, 'txnClass', 'String', 26);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (42, 6, 'txnDate', 'Date', 26);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (43, 3, 'lastTime', 'String', 20);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (44, 4, 'lastTime', 'String', 21);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (45, 1, 'party', 'String', 27);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (46, 2, 'userType', 'String', 27);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (47, 4, 'useraddress', 'String', 27);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (48, 1, 'party', 'String', 28);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (49, 2, 'userType', 'String', 28);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (50, 4, 'txnClass', 'String', 28);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (51, 5, 'useraddress', 'String', 28);


