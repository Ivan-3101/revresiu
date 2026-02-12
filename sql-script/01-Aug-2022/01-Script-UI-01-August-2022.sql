UPDATE ui.perspectivequery
SET vcquery='select
iLiveMessageID as "ID",
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
cast(observations  ->  ''payer'' ->> ''addr''  as text) as "Payer VPA",
cast(observations  ->  ''payer'' -> ''attribs'' -> ''identity'' ->> ''verified_name''as text) as "Payer Name",
cast(observations  ->  ''payee'' ->> ''addr''  as text) as "Payee VPA",
cast(observations  ->  ''payee'' -> ''attribs'' -> ''identity'' ->> ''verified_name'' as text) as "Payee Name",
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
vcrulename as "Rule",
cast(observations  ->  ''observations'' -> ''payerVPA'' -> ''account'' ->> ''accountNumber''  as text) as "Payer Account",
cast(observations  ->  ''observations'' -> ''payeeVPA'' -> ''account'' ->> ''accountNumber'' as text) as "Payee Account"
from transactions.vw_LiveTrans order by dtTrxnTime desc
limit 50'
WHERE iperspectivequeryid=3;


UPDATE ui.perspectivequery
SET vcquery='select
iLiveMessageID as "ID",
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
cast(observations  ->  ''payer'' ->> ''addr''  as text) as "Payer VPA",
cast(observations  ->  ''payer'' -> ''attribs'' -> ''identity'' ->> ''verified_name''as text) as "Payer Name",
cast(observations  ->  ''payee'' ->> ''addr''  as text) as "Payee VPA",
cast(observations  ->  ''payee'' -> ''attribs'' -> ''identity'' ->> ''verified_name'' as text) as "Payee Name",
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
vcrulename as "Rule",
cast(observations  ->  ''observations'' -> ''payerVPA'' -> ''account'' ->> ''accountNumber''  as text) as "Payer Account",
cast(observations  ->  ''observations'' -> ''payeeVPA'' -> ''account'' ->> ''accountNumber'' as text) as "Payee Account"
from transactions.vw_LiveTrans order by dtTrxnTime desc
limit 50'
WHERE iperspectivequeryid=4;

UPDATE ui.perspectivequery
SET vcquery='select
iLiveMessageID as "ID",
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
cast(observations  ->  ''payer'' ->> ''addr''  as text) as "Payer VPA",
cast(observations  ->  ''payer'' -> ''attribs'' -> ''identity'' ->> ''verified_name''as text) as "Payer Name",
cast(observations  ->  ''payee'' ->> ''addr''  as text) as "Payee VPA",
cast(observations  ->  ''payee'' -> ''attribs'' -> ''identity'' ->> ''verified_name'' as text) as "Payee Name",
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
vcrulename as "Rule",
cast(observations  ->  ''observations'' -> ''payerVPA'' -> ''account'' ->> ''accountNumber''  as text) as "Payer Account",
cast(observations  ->  ''observations'' -> ''payeeVPA'' -> ''account'' ->> ''accountNumber'' as text) as "Payee Account"
from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where
Payer.iVPAID = L.iPayerVPAID   and Payee.iVPAID = L.iPayeeVPAID and iLiveMessageID > :iLiveMessageID order by dtTrxnTime desc;'
WHERE iperspectivequeryid=16;


UPDATE ui.perspectivequery
SET vcquery='select
iLiveMessageID as "ID",
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
cast(observations  ->  ''payer'' ->> ''addr''  as text) as "Payer VPA",
cast(observations  ->  ''payer'' -> ''attribs'' -> ''identity'' ->> ''verified_name''as text) as "Payer Name",
cast(observations  ->  ''payee'' ->> ''addr''  as text) as "Payee VPA",
cast(observations  ->  ''payee'' -> ''attribs'' -> ''identity'' ->> ''verified_name'' as text) as "Payee Name",
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
vcrulename as "Rule",
cast(observations  ->  ''observations'' -> ''payerVPA'' -> ''account'' ->> ''accountNumber''  as text) as "Payer Account",
cast(observations  ->  ''observations'' -> ''payeeVPA'' -> ''account'' ->> ''accountNumber'' as text) as "Payee Account"
from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where
Payer.iVPAID = L.iPayerVPAID   and Payee.iVPAID = L.iPayeeVPAID and txnclass = :className and iLiveMessageID > :iLiveMessageID order by dtTrxnTime desc;'
WHERE iperspectivequeryid=17;


UPDATE ui.perspectivequery
SET vcquery='select
    iLiveMessageID as "ID",
    vcmsgid  as "Unique ID",
    dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
    cast(L.observations  ->  ''payer'' ->> ''addr''  as character varying) as "Payer VPA",
    cast(L.observations  ->  ''payer'' -> ''attribs'' -> ''identity'' ->> ''verified_name''as character varying) as "Payer Name",
    cast(L.observations  ->  ''payee'' ->> ''addr''  as character varying) as "Payee VPA",
    cast(L.observations  ->  ''payee'' -> ''attribs'' -> ''identity'' ->> ''verified_name'' as character varying) as "Payee Name",
    dTransAmount as "Amount",
    bFRMPassed as "FRM Pass",
    score as "Score",
    vcrulename as "Rule",
    cast(observations  ->  ''observations'' -> ''payerVPA'' -> ''account'' ->> ''accountNumber''  as character varying) as "Payer Account",
    cast(observations  ->  ''observations'' -> ''payeeVPA'' -> ''account'' ->> ''accountNumber'' as character varying) as "Payee Account"
from transactions.vw_LiveTrans L
where ipayervpaid = (select ipayervpaid FROM transactions.vw_livetrans ORDER BY dttrxntime desc LIMIT 1)
  and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) limit 1000;'
WHERE iperspectivequeryid=18;


UPDATE ui.menustructuredesc
SET vcaction='PartyDashboard', vccontroller='PartyDashboard', vcmenuname='Party Dashboard', vcmini='PD', vcpath='/analytics/party-dashboard'	WHERE vcaction='VPADB';


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


INSERT INTO ui.perspectivequeryparameters(iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)VALUES (45, 1, 'party', 'String', 27);
INSERT INTO ui.perspectivequeryparameters(iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)VALUES (46, 2, 'userType', 'String', 27);
INSERT INTO ui.perspectivequeryparameters(iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)VALUES (47, 4, 'useraddress', 'String', 27);

INSERT INTO ui.perspectivequeryparameters(iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)VALUES (48, 1, 'party', 'String', 28);
INSERT INTO ui.perspectivequeryparameters(iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)VALUES (49, 2, 'userType', 'String', 28);
INSERT INTO ui.perspectivequeryparameters(iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)VALUES (50, 4, 'txnClass', 'String', 28);
INSERT INTO ui.perspectivequeryparameters(iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)VALUES (51, 5, 'useraddress', 'String', 28);

