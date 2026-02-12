INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
(select imenuid from ui.menustructuredesc where vcaction = 'FileUpload')::integer, '1'::integer, '10'::integer, '7'::integer)
 returning irolemenumapid,itenantid;
