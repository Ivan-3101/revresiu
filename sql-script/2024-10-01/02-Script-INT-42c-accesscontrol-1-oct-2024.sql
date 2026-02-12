INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap)::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where vcaction ='Case')::integer , '2'::integer, '24'::integer, '4'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap):: integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where vcaction ='Reports'):: integer, '2'::integer, '24'::integer, '4'::integer)
 returning irolemenumapid,itenantid;

