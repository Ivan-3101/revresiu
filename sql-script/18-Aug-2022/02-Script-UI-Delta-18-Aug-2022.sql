UPDATE ui.perspectivequery
	SET  vcquery='SELECT  l.dscore, l.dinfo, l.vcremark, r.vcrulename
from transactions.LiveDecisionDetails l, masters.Rules r, transactions.livetrans lt
where  lt.vcmsgid = :vcMsgID and r.iRuleID=l.iRuleID and l.ilivemessageid = lt.ilivemessageid
order by l.dinfo desc'
	WHERE iperspectivequeryid=2;

UPDATE ui.dashboardquery
	SET  bparametersrequired=false, vcfilterparametersjson=null, vcdashboardquery='SELECT X.* FROM   (VALUES (''Payer'', ''Payer''),(''Payee'', ''Payee''), (''Both'', ''Both'')) AS X ("label", "value")'
	WHERE idashboardqueryid=25;

UPDATE ui.dashboardfilters
	SET vcdashboardfilterdisplayname='Level'
	WHERE idashboardfilterid=18;

UPDATE ui.dashboardfilters
	SET vcdashboardfilterdisplayname='Address'
	WHERE idashboardfilterid=13;