INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
482::integer, '5'::integer, '9'::integer, '6'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
(select imenuid from ui.menustructuredesc where vcaction = 'FileUpload')::integer, '5'::integer, '9'::integer, '6'::integer)
 returning irolemenumapid,itenantid;
 