INSERT INTO ui.perspectivequery(
    iperspectivequeryid, vcquery, vctablename)
VALUES (19,'SELECT l.ilivemessageid, lt.vcmsgid, r.iruleid, r.vcrulename, l.bpassed, l.dscore, l.dinfo, l.vcremark, l.dtcreateddatetime
from transactions.LiveDecisionDetails l, masters.Rules r, transactions.livetrans lt
where  l.ilivemessageid = :iLiveMessageID and r.iRuleID=l.iRuleID and l.ilivemessageid = lt.ilivemessageid
order by dscore desc', 'decisiondetailsforlivetrans');


INSERT INTO ui.perspectivequeryparameters(
    iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)
VALUES (23, 1, 'iLiveMessageID', 'Integer', (select iperspectivequeryid from ui.perspectivequery where vctablename='decisiondetailsforlivetrans'));