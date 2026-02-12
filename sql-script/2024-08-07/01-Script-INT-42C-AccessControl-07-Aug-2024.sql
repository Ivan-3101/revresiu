INSERT INTO ui.rolemenuaccessmap(
	 badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid)
	select true, true, true, true, true, true, null , null, true, null, null, 581  ,10, t.itenantid, o.iorgid from ui.orgs o left join ui.tenants t on o.iorgid=t.iorgid 
     where o.iorgid=4;