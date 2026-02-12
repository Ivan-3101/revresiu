
INSERT INTO ui.rolemenuaccessmap ( badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid)
SELECT true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 577, iroleid, 
itenantid, iorgid FROM ui.roledesc where iorgid = 9 and vcrolename in ('Risk Analyst', 'Risk Supervisor');



INSERT INTO ui.rolemenuaccessmap ( badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid)
SELECT true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 503, iroleid, 
itenantid, iorgid FROM ui.roledesc where iorgid = 9 and vcrolename in ('Risk Analyst');


UPDATE ui.dashboard
	SET  imenustructuredesc=580
	WHERE vcdashboardname = 'Access Management Report' ;



UPDATE ui.rolemenuaccessmap
	SET  imenuid = 580 where 
	iroleid in (3, 6) and 
	imenuid = 577;


UPDATE ui.dashboardquery
set imenustructuredesc = 580
where idashboardqueryid = 121 and itenantid in (12, 13); 
