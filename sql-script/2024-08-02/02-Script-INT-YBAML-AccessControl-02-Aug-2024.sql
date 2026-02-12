INSERT INTO ui.rolemenuaccessmap(
	 badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid)
	select true, true, true, true, true, true, null, null, true, null, null, 503  ,5 , t.itenantid, o.iorgid from ui.orgs o left join ui.tenants t on o.iorgid=t.iorgid 
     where o.iorgid=5;

INSERT INTO ui.rolemenuaccessmap(
	 badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid)
	select true, true, true, true, true, true, null, null, true, null, null, 510  , 8, t.itenantid, o.iorgid from ui.orgs o left join ui.tenants t on o.iorgid=t.iorgid 
     where o.iorgid=5;

INSERT INTO ui.rolemenuaccessmap(
	 badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid)
	select true, true, true, true, true, true, null, null, true, null, null, 478  , 8, t.itenantid, o.iorgid from ui.orgs o left join ui.tenants t on o.iorgid=t.iorgid 
     where o.iorgid=5;


INSERT INTO ui.rolemenuaccessmap(
	 badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid)
	select true, true, true, true, true, true, null, null, true, null, null, 536  , 8, t.itenantid, o.iorgid from ui.orgs o left join ui.tenants t on o.iorgid=t.iorgid 
     where o.iorgid=5;
