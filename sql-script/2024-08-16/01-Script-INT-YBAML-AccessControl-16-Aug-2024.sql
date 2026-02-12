INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
(select imenuid from ui.menustructuredesc where vcaction = 'FileUpload')::integer, '5'::integer, '8'::integer, '5'::integer)
 returning irolemenumapid,itenantid;



 INSERT INTO ui.rolemenuaccessmap(
	 badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid)
	select true, true, true, true, true, true, null, null, true, null, null, 479  , 8, t.itenantid, o.iorgid from ui.orgs o left join ui.tenants t on o.iorgid=t.iorgid 
     where o.iorgid=5;

INSERT INTO ui.rolemenuaccessmap(
	 badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid)
	select true, true, true, true, true, true, null, null, true, null, null, 507  ,5 , t.itenantid, o.iorgid from ui.orgs o left join ui.tenants t on o.iorgid=t.iorgid 
     where o.iorgid=5;
