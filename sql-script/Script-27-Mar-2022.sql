DROP TABLE if exists ui.transactionclasses;
DROP TABLE if exists ui.rulesaudit;
DROP TABLE if exists ui.rules ;
DROP TABLE if exists ui.decision;
DROP TABLE if exists ui.product cascade;


DELETE FROM ui.perspectivequeryparameters;

DELETE FROM ui.perspectivequery;

INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (1, 'select 
L.iLiveMessageID as "ID",
vcmsgid as "Unique ID",
dtTrxnTime as "Time",
Payer.vcAddress as "Payer VPA",
Payer.vcvpaname as "Payer Name",
Payee.vcAddress as "Payee VPA",
payee.vcvpaname as "Payee Name",
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
L.vcrulename as "Rule",
r.iruleid as "Rule ID",
r.vcrulename as "Rule Name", 
ldd.bpassed as "Passed", 
ldd.dscore as "Scored", 
ldd.vcremark as "Remark", 
ldd.dtcreateddatetime as "Data Time"
from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee, transactions.LiveDecisionDetails ldd, masters.Rules r where 
Payer.iVPAID = L.iPayerVPAID and Payee.iVPAID = L.iPayeeVPAID  and r.iRuleID = ldd.iRuleID and L.iLiveMessageID = ldd.ilivemessageid  order by L.iLiveMessageID desc limit 200', 'livetransaction1');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (9, 'select 
iLiveMessageID as "ID",
vcmsgid  as "Unique ID",
dtTrxnTime as "Time",
Payer.vcAddress as "Payer VPA",
Payer.vcvpaname as "Payer Name",
Payee.vcAddress as "Payee VPA",
payee.vcvpaname as "Payee Name",
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
vcrulename as "Rule"
from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where 
Payer.iVPAID =  L.iPayerVPAID   and Payee.iVPAID = L.iPayeeVPAID and iLiveMessageID = :iLiveMessageID
', 'vpaTransactionProfileByvcMsgID');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (10, 'select 
iLiveMessageID as "ID",
vcmsgid  as "Unique ID",
dtTrxnTime as "Time",
Payer.vcAddress as "Payer VPA",
Payer.vcvpaname as "Payer Name",
Payee.vcAddress as "Payee VPA",
payee.vcvpaname as "Payee Name",
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
vcrulename as "Rule"
from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where 
Payer.iVPAID =  L.iPayerVPAID   and Payee.iVPAID = :payeeID and txnclass = :className and iLiveMessageID > :iLiveMessageID order by iLiveMessageID asc 
FETCH FIRST 5 ROWS ONLY;', 'proceedingTransactionsByPayee');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (4, 'select 
iLiveMessageID as "ID",
vcmsgid as "Unique ID",
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
Payer.iVPAID = L.iPayerVPAID   and Payee.iVPAID = L.iPayeeVPAID and txnclass = :className order by dtTrxnTime desc
limit 50', 'livetransactionbyclass');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (2, 'SELECT lt.vcmsgid, r.iruleid, r.vcrulename, l.bpassed, l.dscore, l.dinfo, l.vcremark, l.dtcreateddatetime 
from transactions.LiveDecisionDetails l, masters.Rules r, transactions.livetrans lt
where lt.vcmsgid = :vcMsgID and l.ilivemessageid = lt.iLiveMessageID  and r.iRuleID=l.iRuleID
order by dscore desc', 'decisiondetails');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (3, 'select 
iLiveMessageID as "ID",
vcmsgid as "Unique ID",
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
Payer.iVPAID = L.iPayerVPAID   and Payee.iVPAID = L.iPayeeVPAID   order by dtTrxnTime desc
limit 50', 'livetransaction');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (6, 'select 
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
Payer.iVPAID =  L.iPayerVPAID   and ipayeevpaid = (select ivpaid from masters.VPA where vcaddress = :payeeID ) and Payee.iVPAID = ipayeevpaid and txnclass =  :className and Payee.iVPAID = ipayeevpaid
', 'vpaTransactionProfilePayeeIDAndClass');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (7, 'select 
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
ipayervpaid = (select ivpaid from masters.VPA where vcaddress = :payerID )  and Payee.iVPAID = L.iPayeeVPAID and Payer.iVPAID = ipayervpaid', 'vpaTransactionProfilePayerID');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (8, 'select 
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
Payer.iVPAID =  L.iPayerVPAID   and ipayeevpaid = (select ivpaid from masters.VPA where vcaddress = :payeeID ) and Payee.iVPAID = ipayeevpaid', 'vpaTransactionProfilePayeeID');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (14, 'select 
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
Payer.iVPAID =  L.iPayerVPAID   and ipayeevpaid = (select ivpaid from masters.VPA where vcaddress = :payeeID ) and Payee.iVPAID = ipayeevpaid
and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE)', 'vpaDashboardPayeeID');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (11, 'select 
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
ipayervpaid = (select ivpaid from masters.VPA where vcaddress = :payerID )   and Payee.iVPAID = ipayeevpaid and Payer.iVPAID =  ipayervpaid 
and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE)', 'vpaDashboardPayerID');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (12, 'select 
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
ipayervpaid = (select ivpaid from masters.VPA where vcaddress = :payerID )  and Payee.iVPAID = ipayeevpaid and Payer.iVPAID =  ipayervpaid and txnclass = :className 
and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE)', 'vpaDashboardPayerIDAndClass');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (13, 'select 
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
Payer.iVPAID =  L.iPayerVPAID   and ipayeevpaid = (select ivpaid from masters.VPA where vcaddress = :payeeID ) and Payee.iVPAID = ipayeevpaid and txnclass =  :className 
and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE)', 'vpaDashboardPayeeIDAndClass');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (5, 'select 
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
ipayervpaid = (select ivpaid from masters.VPA where vcaddress = :payerID )   and Payee.iVPAID = L.iPayeeVPAID and Payer.iVPAID = ipayervpaid and txnclass = :className
', 'vpaTransactionProfilePayerIDAndClass');


INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (2, 1, 'className', 'String', 4);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (4, 2, 'className', 'String', 5);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (7, 2, 'className', 'String', 6);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (10, 1, 'iLiveMessageID', 'Integer', 9);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (11, 1, 'payeeID', 'Integer', 10);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (12, 2, 'className', 'String', 10);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (13, 3, 'iLiveMessageID', 'Integer', 10);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (1, 1, 'vcMsgID', 'String', 2);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (16, 2, 'className', 'String', 12);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (18, 2, 'className', 'String', 13);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (14, 1, 'payerID', 'String', 11);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (15, 1, 'payerID', 'String', 12);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (17, 1, 'payeeID', 'String', 13);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (19, 1, 'payeeID', 'String', 14);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (3, 1, 'payerID', 'String', 5);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (5, 1, 'payeeID', 'String', 6);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (8, 1, 'payerID', 'String', 7);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (9, 1, 'payeeID', 'String', 8);




CREATE TABLE ui.rulesaudit (
    iruleidaudit integer NOT NULL,
    bactive boolean,
    bcustom boolean,
    bdelete boolean,
    dtentrydatetime timestamp without time zone,
    dtstartdate timestamp without time zone,
    iversion integer,
    vcbpmnfilelocation character varying(255),
    vcruledescription character varying(1000),
    vcruledetail character varying(1000),
    vcrulemapinfo character varying(255),
    vcrulename character varying(20),
    vcruleorder character varying(255) NOT NULL,
    vcruleparams text,
    idecisionid integer,
    iproductid integer,
    iruleid integer,
    iuserid integer
);


ALTER TABLE ONLY ui.rulesaudit
    ADD CONSTRAINT rulesaudit_pkey PRIMARY KEY (iruleidaudit);

ALTER TABLE ONLY ui.rulesaudit
    ADD CONSTRAINT fkbomi5nh667entf5qtegucsb32 FOREIGN KEY (iruleid) REFERENCES masters.rules(iruleid);

ALTER TABLE ONLY ui.rulesaudit
    ADD CONSTRAINT fkh9pok3d7i675eo9xsvnj4io39 FOREIGN KEY (idecisionid) REFERENCES masters.decisions(idecisionid);

ALTER TABLE ONLY ui.rulesaudit
    ADD CONSTRAINT fkok3myvkr8ouuut65h15wgq7re FOREIGN KEY (iproductid) REFERENCES masters.products(iproductid);

ALTER TABLE ONLY ui.rulesaudit
    ADD CONSTRAINT fkpqla2sh7u7adke3fl25jt45s9 FOREIGN KEY (iuserid) REFERENCES ui.webuser(iuserid);

DELETE FROM masters.rules;
INSERT INTO masters.rules (iruleid, idecisionid, iproductid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete, idecisionsid) VALUES (1, 1, 1, 'DoubleDebit', NULL, 'DoubleDebit', 0, NULL, NULL, NULL, true, NULL, NULL, '{"type":0,"minutes":5,"successscore":0,"successremark":"","failremarks":"Double Debit","failscore":100}', '{"FailedRule": -1,"SuccessRule": 3}', false, false, 1);
INSERT INTO masters.rules (iruleid, idecisionid, iproductid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete, idecisionsid) VALUES (2, 1, 1, 'MCCLimits', NULL, 'MCCLimits', 0, NULL, NULL, NULL, true, NULL, NULL, '{"type":1,"successscore":0,"successremark":"","failremarks":"MCC Limits exceeded ","failscore":10}', '{"FailedRule": 1,"SuccessRule": 1,"StartRule":1}', false, false, 1);
INSERT INTO masters.rules (iruleid, idecisionid, iproductid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete, idecisionsid) VALUES (3, 1, 1, 'Chargeback', NULL, 'Chargeback', 0, NULL, NULL, NULL, true, NULL, NULL, '{"type":0,"successscore":0,"successremark":"","failremarks":"Chargeback block","failscore":100}', '{"FailedRule": -1,"SuccessRule": -1}', false, false, 1);
INSERT INTO masters.rules (iruleid, idecisionid, iproductid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete, idecisionsid) VALUES (14, 2, 5, 'Blacklist', NULL, 'Blacklist', 0, NULL, NULL, NULL, true, NULL, NULL, '{"type":0,"successscore":0,"successremark":"","failremarks":"in Blacklist ","failscore":100}', '{"FailedRule":-1 ,"SuccessRule": 15,"StartRule":1}', false, false, 2);
INSERT INTO masters.rules (iruleid, idecisionid, iproductid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete, idecisionsid) VALUES (15, 2, 5, 'Greylist', NULL, 'Greylist', 0, NULL, NULL, NULL, true, NULL, NULL, '{"type":1,"successscore":0,"successremark":"","failremarks":"in Greylist ","failscore":10}', '{"FailedRule":16 ,"SuccessRule": 16}', false, false, 2);
INSERT INTO masters.rules (iruleid, idecisionid, iproductid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete, idecisionsid) VALUES (16, 2, 5, 'FirstTransaction', NULL, 'FirstTransaction', 0, NULL, NULL, NULL, true, NULL, NULL, '{"type":1,"successscore":0,"successremark":"","failremarks":"First Transaction ","failscore":10}', '{"FailedRule":21,"SuccessRule":21 }', false, false, 2);
INSERT INTO masters.rules (iruleid, idecisionid, iproductid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete, idecisionsid) VALUES (17, 2, 5, 'LimitCheck', NULL, 'LimitCheck', 0, NULL, NULL, NULL, true, NULL, NULL, '{"type":1,"successscore":0,"successremark":"","failremarks":"Limit check failed ","failscore":10,"cash_per": 80, "credit_per": 40}', '{"FailedRule":18,"SuccessRule":18 }', false, false, 2);
INSERT INTO masters.rules (iruleid, idecisionid, iproductid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete, idecisionsid) VALUES (18, 2, 5, 'Dormant', NULL, 'Dormant', 0, NULL, NULL, NULL, true, NULL, NULL, '{"type":1,"successscore":0,"successremark":"","failremarks":"Dormant vpa ","failscore":10,"days": 60}', '{"FailedRule":19,"SuccessRule":19 }', false, false, 2);
INSERT INTO masters.rules (iruleid, idecisionid, iproductid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete, idecisionsid) VALUES (19, 2, 5, 'VelocityPayer', NULL, 'VelocityPayer', 0, NULL, NULL, NULL, true, NULL, NULL, '{"type":1,"successscore":0,"successremark":"","d01":{"count":3,"value":10000000,"failremarks":"d01 velocity failed","failscore":10},"d02":{"count":5,"value":15000000,"failremarks":"d01 veloctity failed","failscore":10},"m60":{"count":3,"value":8000000,"failremarks":"m60 veloctity failed","failscore":10},"m30":{"count":2,"value":500000,"failremarks":"m30 veloctity failed","failscore":10}}', '{"FailedRule":20 ,"SuccessRule":20 }', false, false, 2);
INSERT INTO masters.rules (iruleid, idecisionid, iproductid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete, idecisionsid) VALUES (20, 2, 5, 'VelocityPayee', NULL, 'VelocityPayee', 0, NULL, NULL, NULL, true, NULL, NULL, '{"type":1,"successscore":0,"successremark":"","d01":{"count":3,"value":10000000,"failremarks":"d01 velocity failed","failscore":10},"d02":{"count":5,"value":15000000,"failremarks":"d01 veloctity failed","failscore":10},"m60":{"count":3,"value":8000000,"failremarks":"m60 veloctity failed","failscore":10},"m30":{"count":2,"value":500000,"failremarks":"m30 veloctity failed","failscore":10}}', '{"FailedRule":-1 ,"SuccessRule":-1 }', false, false, 2);
INSERT INTO masters.rules (iruleid, idecisionid, iproductid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete, idecisionsid) VALUES (21, 2, 5, 'FirstIntTransaction', NULL, 'FirstIntTransaction', 0, NULL, NULL, NULL, true, NULL, NULL, '{"type":1,"successscore":0,"successremark":"","failremarks":"First Internation Transaction ","failscore":10}', '{"FailedRule":17 ,"SuccessRule":17 }', false, false, 2);
INSERT INTO masters.rules (iruleid, idecisionid, iproductid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete, idecisionsid) VALUES (4, 1, 1, 'VelocityCheck', NULL, 'VelocityCheck', 0, NULL, NULL, NULL, true, NULL, NULL, '{"noPayments":{"30min":5,"60min":7},"noNewPayees":{"30min":2,"60min":5}}', '{"FailedRule": -1,"SuccessRule": 5}', false, false, 1);
INSERT INTO masters.rules (iruleid, idecisionid, iproductid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete, idecisionsid) VALUES (5, 1, 1, 'LightCheck', NULL, 'LightCheck', 0, NULL, NULL, NULL, true, NULL, NULL, '{"dLightValue":500,"dLightVerifiedValue":1000}', '{"FailedRule": 11,"SuccessRule": -1}', false, false, 1);
INSERT INTO masters.rules (iruleid, idecisionid, iproductid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete, idecisionsid) VALUES (6, 1, 1, 'Transaction Score', NULL, 'UPITrxnScore', 0, NULL, NULL, NULL, true, NULL, NULL, '{"payer":{"value":{"maxscore":5,"trxn":{"score":2,"maxval":200000},"today":{"limit":80000,"score":2},"tillyest":{"limit":150000,"score":3}},"payee":{"maxscore":3,"verified":{"score":0},"historic":{"score":0},"vpaprovider":[{"id":4,"score":3},{"id":3,"score":2},{"id":2,"score":1},{"id":1,"score":1}]},"velocity":{"maxscore":6,"today":{"mintpd":3,"payees":2,"score":2},"tillyest":{"mintpd":4,"payees":2,"score":3}},"device":{"maxscore":4,"changedid":3,"newapp":1},"location":{"maxscore":3,"taluka":0,"district":1,"state":2,"else":3},"ip":{"maxscore":3,"4octect":0,"3octect":1,"2octect":2,"1octect":3},"payeemc":{"maxscore":2,"new":2,"old":0},"tod":{"maxscore":3,"per":[{"percent":7,"score":0},{"percent":5,"score":1},{"percent":2,"score":2},{"percent":-1,"score":3}]}},"newpayer":{"value":{"maxscore":3,"today":{"limit":50000,"score":2},"tillyest":{"limit":120000,"score":3}},"payee":{"maxscore":3,"today":{"cnt":3,"score":2},"tillyest":{"cnt":4,"score":3}},"velocity":{"maxscore":6,"todaytrxn":[{"cnt":4,"score":3},{"cnt":3,"score":2}],"tillyesttrxn":[{"cnt":6,"score":3},{"cnt":4,"score":2}]}},"payee":{"value":{"maxscore":3,"max":3,"stddev":2,"avg":1,"else":0},"history":{"maxscore":4,"firsttrxn":[{"score":0,"days":365},{"score":1,"days":90},{"score":2,"days":-1}],"monthlycnt":[{"cnt":10,"score":0},{"cnt":1,"score":1},{"cnt":-1,"score":2}]},"velocity":{"maxscore":6,"today":{"max":4,"score":3},"tillyest":{"max":3,"score":2}},"vpaprovider":{"maxscore":2,"provider":[{"id":4,"score":2},{"id":3,"score":1},{"id":2,"score":0},{"id":1,"score":0}]},"relation":{"maxscore":2,"old":{"score":0},"new":{"score":2}},"tod":{"maxscore":3,"per":[{"percent":7,"score":0},{"percent":5,"score":1},{"percent":2,"score":2},{"percent":-1,"score":3}]}},"newpayee":{"value":{"maxscore":3,"today":{"limit":50000,"score":2},"tillyest":{"limit":120000,"score":3}},"payer":{"maxscore":3,"today":{"cnt":3,"score":2},"tillyest":{"cnt":4,"score":3}},"velocity":{"maxscore":6,"todaytrxn":[{"cnt":4,"score":3},{"cnt":3,"score":2}],"tillyesttrxn":[{"cnt":6,"score":3},{"cnt":4,"score":2}]},"vpaprovider":{"maxscore":3,"provider":[{"id":4,"score":3},{"id":3,"score":2},{"id":2,"score":1},{"id":1,"score":1}]}}}', '{"FailedRule":7,"SuccessRule":-1,"NoData":7,"ScoreRange":[{"greaterthan":40,"rule":-1,"bPass":0,"bRun":1},{"greaterthan":20,"rule":7,"bPass":1,"bRun":1,"StepUp":1},{"greaterthan":-1,"rule":7,"bPass":1,"bRun":0}]}', false, false, 1);
INSERT INTO masters.rules (iruleid, idecisionid, iproductid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete, idecisionsid) VALUES (7, 1, 1, 'Uber Trxn Value', NULL, '
if (( observed.payee.addr) == uber@upi   and (Decimal(observed.observations[instructed_amount]) > 50000.)):  
  bRun = False;rule=2;bPass=False;score=0;remarks=  Fail
else:     
	   bRun = True;rule=2;bPass=True;score=1;remarks=   Success   ', 0, NULL, NULL, NULL, true, NULL, NULL, '{"score":1}', '{"FailedRule": -1,"SuccessRule": -1}', true, false, 1);
INSERT INTO masters.rules (iruleid, idecisionid, iproductid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete, idecisionsid) VALUES (9, 1, 1, 'Croma location', NULL, '
if (( observed.payee.addr) == croma@upi   and (observed.payer.attribs[device][location]==Nellore,Nellore,Andhra Pradesh)):  
  bRun = False;rule=5;bPass=False;score=0;remarks=  Fail
else:     
	   bRun = True;rule=5;bPass=True;score=1;remarks=   Success   ', 0, NULL, NULL, NULL, true, NULL, NULL, '{"score":1}', '{"FailedRule": -1,"SuccessRule": 7}', true, false, 1);
INSERT INTO masters.rules (iruleid, idecisionid, iproductid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete, idecisionsid) VALUES (10, 1, 1, 'PayerModel ML', NULL, 'PayerModelML', 0, NULL, NULL, NULL, true, NULL, NULL, '{"strength": 0.5}', '{"FailedRule": -1,"SuccessRule": -1}', false, false, 1);
INSERT INTO masters.rules (iruleid, idecisionid, iproductid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete, idecisionsid) VALUES (11, 1, 1, 'VPA spoof', NULL, 'VPASpoof', 0, NULL, NULL, NULL, true, NULL, NULL, '{"threshold":0.75,"peralpha":80}', '{"FailedRule":-1,"SuccessRule":6}', false, false, 1);
ALTER SEQUENCE masters.rules_seq Restart WITH 22;


DELETE FROM ui.rolemenuaccessmap; 
DELETE FROM ui.menustructuredesc; 


INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (477, true, NULL, NULL, 0, 'Dashboards', 'Dashboards', NULL, 'tim-icons icon-chart-pie-36', NULL, 'Dashboards', NULL, NULL, NULL, NULL, 'DashboardsCollapse', NULL, NULL, NULL, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (478, true, NULL, NULL, 1, 'Analytics', 'Analytics', NULL, 'tim-icons icon-chart-bar-32', NULL, 'Analytics', NULL, NULL, NULL, NULL, 'analyticsCollapse', NULL, NULL, NULL, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (479, true, NULL, NULL, 2, 'Case', 'CaseManagement', NULL, 'tim-icons icon-single-copy-04', NULL, 'Case Management', NULL, NULL, NULL, NULL, 'caseManagementCollapse', NULL, NULL, NULL, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (480, true, NULL, NULL, 3, 'try out', 'try out', NULL, 'tim-icons icon-mobile', NULL, 'Try Out', NULL, NULL, NULL, NULL, 'tryOutCollapse', NULL, NULL, NULL, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (481, true, NULL, NULL, 5, 'Masters', 'Masters', NULL, 'tim-icons icon-molecule-40', NULL, 'Masters', NULL, NULL, NULL, NULL, 'mastersCollapse', NULL, NULL, NULL, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (482, true, NULL, NULL, 4, 'Admin', 'Admin', NULL, 'tim-icons icon-single-02', NULL, 'Admin', NULL, NULL, NULL, NULL, 'adminCollapse', NULL, NULL, NULL, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (499, false, NULL, NULL, 0, 'ListManagement', 'ListManagement', NULL, NULL, '/user', 'List Management', 'LM', '/masters/list-management', NULL, NULL, NULL, NULL, NULL, 481, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (503, false, NULL, NULL, 2, 'ProcessBulkTickets', 'ProcessBulkTickets', NULL, NULL, '/user', 'Process Bulk Tickets', 'PB', '/case-management/process-bulk-tickets', NULL, NULL, NULL, NULL, NULL, 479, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (504, false, NULL, NULL, 2, 'DefaultRules', 'DefaultRules', NULL, NULL, '/user', 'Default Rules', 'DR', '/masters/default-rules', NULL, NULL, NULL, NULL, NULL, 481, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (500, false, NULL, NULL, 1, 'CustomRules', 'CustomRules', NULL, NULL, '/user', 'Custom Rules', 'RM', '/masters/custom-rules', NULL, NULL, NULL, NULL, NULL, 481, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (505, false, NULL, NULL, 3, 'CaseSummary', 'CaseSummary', NULL, NULL, '/user', 'Case Summary', 'CS', '/case-management/case-summary', NULL, NULL, NULL, NULL, NULL, 479, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (506, false, NULL, NULL, 4, 'UploadChargeBacks', 'UploadChargeBacks', NULL, NULL, '/user', 'Upload Chargeback', 'UC', '/case-management/upload-charge-backs', NULL, NULL, NULL, NULL, NULL, 479, 1);

INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (483, false, NULL, NULL, 0, 'LiveScoring', 'LiveScoring', NULL, NULL, '/user', 'Live Scoring', 'LS', '/dashboards/live-scoring', NULL, NULL, NULL, NULL, NULL, 477, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (484, false, NULL, NULL, 1, 'customer', 'customer', NULL, NULL, '/user', 'Customer', 'CU', '/dashboards/customer', NULL, NULL, NULL, NULL, NULL, 477, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (485, false, NULL, NULL, 2, 'Transaction', 'Transaction', NULL, NULL, '/user', 'Transaction', 'TR', '/dashboards/transaction', NULL, NULL, NULL, NULL, NULL, 477, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (486, false, NULL, NULL, 3, 'operations', 'operations', NULL, NULL, '/user', 'Operations', 'OP', '/dashboards/operations', NULL, NULL, NULL, NULL, NULL, 477, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (487, false, NULL, NULL, 4, 'ITInfra', 'ITInfra', NULL, NULL, '/user', 'IT Infra', 'IT', '/dashboards/it-infra', NULL, NULL, NULL, NULL, NULL, 477, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (488, false, NULL, NULL, 0, 'Transaction', 'transaction', NULL, NULL, '/user', 'Transaction', 'TR', '/analytics/transaction', NULL, NULL, NULL, NULL, NULL, 478, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (489, false, NULL, NULL, 1, 'case', 'case', NULL, NULL, '/user', 'Case', 'CA', '/analytics/case', NULL, NULL, NULL, NULL, NULL, 478, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (490, false, NULL, NULL, 2, 'relationship', 'relationship', NULL, NULL, '/user', 'Relationship', 'RE', '/analytics/relationship', NULL, NULL, NULL, NULL, NULL, 478, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (491, false, NULL, NULL, 3, 'trend', 'trend', NULL, NULL, '/user', 'Trend', 'TR', '/analytics/trend', NULL, NULL, NULL, NULL, NULL, 478, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (492, false, NULL, NULL, 4, 'map', 'map', NULL, NULL, '/user', 'map', 'MA', '/analytics/map', NULL, NULL, NULL, NULL, NULL, 478, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (493, false, NULL, NULL, 0, 'dashboards', 'dashboards', NULL, NULL, '/user', 'Dashboards', 'DA', '/case-management/dashboards', NULL, NULL, NULL, NULL, NULL, 479, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (494, false, NULL, NULL, 1, 'Tasks', 'tasks', NULL, NULL, '/user', 'Tasks', 'TA', '/case-management/tasks', NULL, NULL, NULL, NULL, NULL, 479, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (495, false, NULL, NULL, 0, 'RegisterDevice', 'RegisterDevice', NULL, NULL, '/user', 'Register Device', 'TA', '/try-out/register-device', NULL, NULL, NULL, NULL, NULL, 480, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (496, false, NULL, NULL, 2, 'SubmitDeviceInfo', 'SubmitDeviceInfo', NULL, NULL, '/user', 'Submit Device Info', 'SD', '/try-out/submit-device-info', NULL, NULL, NULL, NULL, NULL, 480, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (497, false, NULL, NULL, 3, 'QueryDeviceProfile', 'QueryDeviceProfile', NULL, NULL, '/user', 'Query Device Profile', 'QD', '/try-out/query-device-profile', NULL, NULL, NULL, NULL, NULL, 480, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (498, false, NULL, NULL, 4, 'ScorePaymentRequest', 'ScorePaymentRequest', NULL, NULL, '/user', 'Score Payment Request', 'SP', '/try-out/score-payment-request', NULL, NULL, NULL, NULL, NULL, 480, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (501, false, NULL, NULL, 0, 'userManagement', 'userManagement', NULL, NULL, '/user', 'User Management', 'UM', '/admin/user-management', NULL, NULL, NULL, NULL, NULL, 482, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (502, false, NULL, NULL, 1, 'activityLog', 'activityLog', NULL, NULL, '/user', 'Activity Log', 'AL', '/admin/activity-log', NULL, NULL, NULL, NULL, NULL, 482, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (507, false, NULL, NULL, 5, 'TransactionDB', 'TransactionDB', NULL, NULL, '/user', 'Transaction DB', 'TD', '/analytics/transaction-dashboard', NULL, NULL, NULL, NULL, NULL, 478, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (508, false, NULL, NULL, 6, 'VPADB', 'VPADB', NULL, NULL, '/user', 'VPA DB', 'VD', '/analytics/vpa-dashboard', NULL, NULL, NULL, NULL, NULL, 478, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (509, false, NULL, NULL, 7, 'TrasactionProfile', 'TrasactionProfile', NULL, NULL, '/user', 'Trasaction Profile', 'TP', '/analytics/transaction-profile-dashboard', NULL, NULL, NULL, NULL, NULL, 478, 1);

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (554, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 478, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (555, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 479, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (558, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 481, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (559, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 482, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (560, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 482, 4);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (565, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 487, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (572, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 494, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (577, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 498, 3);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (578, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 498, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (579, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 499, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (580, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 500, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (581, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 501, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (583, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 503, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (584, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 504, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (585, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 505, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (1, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 479, 5);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (2, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 494, 5);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (3, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 503, 5);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (4, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 505, 5);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (6, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 498, 5);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (586, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 506, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (7, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 506, 5);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (588, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 508, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (587, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 507, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (589, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 509, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (556, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 480, 1);
