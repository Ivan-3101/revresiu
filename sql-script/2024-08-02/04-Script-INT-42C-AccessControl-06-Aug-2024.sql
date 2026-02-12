INSERT INTO ui.rolemenuaccessmap(
	 badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid)
	select true, true, true, true, true, true, null, null, true, null, null, 480  ,10 , t.itenantid, o.iorgid from ui.orgs o left join ui.tenants t on o.iorgid=t.iorgid 
     where o.iorgid=4;

INSERT INTO ui.rolemenuaccessmap(
	 badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid)
	select true, true, true, true, true, true, null, null, true, null, null, 575  ,10, t.itenantid, o.iorgid from ui.orgs o left join ui.tenants t on o.iorgid=t.iorgid 
     where o.iorgid=4;

INSERT INTO ui.rolemenuaccessmap(
	 badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid)
	select true, true, true, true, true, true, null, null, true, null, null, 573  ,10, t.itenantid, o.iorgid from ui.orgs o left join ui.tenants t on o.iorgid=t.iorgid 
     where o.iorgid=4;

INSERT INTO ui.rolemenuaccessmap(
	 badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid)
	select true, true, true, true, true, true, null, null, true, null, null, 574  ,10, t.itenantid, o.iorgid from ui.orgs o left join ui.tenants t on o.iorgid=t.iorgid 
     where o.iorgid=4;

INSERT INTO ui.rolemenuaccessmap(
	 badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid)
	select true, true, true, true, true, true, null, null, true, null, null, 576  ,10, t.itenantid, o.iorgid from ui.orgs o left join ui.tenants t on o.iorgid=t.iorgid 
     where o.iorgid=4;

INSERT INTO ui.rolemenuaccessmap(
	 badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid)
	select true, true, true, true, true, true, null, null, true, null, null, 577  ,10, t.itenantid, o.iorgid from ui.orgs o left join ui.tenants t on o.iorgid=t.iorgid 
     where o.iorgid=4;
