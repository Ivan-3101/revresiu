UPDATE ui.workflowmasters SET
is_manual_creation = true::boolean WHERE
workflowid = 4 AND itenantid = 16;

DELETE FROM ui.rolemenuaccessmap
    WHERE itenantid IN (8,16,17,21,22,23) and imenuid in ((select imenuid from ui.menustructuredesc where vcmenuname = 'Admin'),(select imenuid from ui.menustructuredesc where vcmenuname = 'Admin Reports')) and iroleid in (10);

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) from ui.rolemenuaccessmap )+1::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, (select imenuid from ui.menustructuredesc where vcmenuname = 'Admin Reports')::integer, '10'::integer, '8'::integer, '5'::integer)
 returning irolemenumapid,itenantid;


INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) from ui.rolemenuaccessmap )+1::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, (select imenuid from ui.menustructuredesc where vcmenuname = 'Admin Reports')::integer, '10'::integer, '16'::integer, '5'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) from ui.rolemenuaccessmap )+1::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, (select imenuid from ui.menustructuredesc where vcmenuname = 'Admin Reports')::integer, '10'::integer, '17'::integer, '5'::integer)
 returning irolemenumapid,itenantid;


INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) from ui.rolemenuaccessmap )+1::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, (select imenuid from ui.menustructuredesc where vcmenuname = 'Admin Reports')::integer, '10'::integer, '21'::integer, '5'::integer)
 returning irolemenumapid,itenantid;


INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) from ui.rolemenuaccessmap )+1::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, (select imenuid from ui.menustructuredesc where vcmenuname = 'Admin Reports')::integer, '10'::integer, '22'::integer, '5'::integer)
 returning irolemenumapid,itenantid;


INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) from ui.rolemenuaccessmap )+1::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, (select imenuid from ui.menustructuredesc where vcmenuname = 'Admin Reports')::integer, '10'::integer, '23'::integer, '5'::integer)
 returning irolemenumapid,itenantid;



INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) from ui.rolemenuaccessmap )+1::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, (select imenuid from ui.menustructuredesc where vcmenuname = 'Admin')::integer, '10'::integer, '8'::integer, '5'::integer)
 returning irolemenumapid,itenantid;


INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) from ui.rolemenuaccessmap )+1::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, (select imenuid from ui.menustructuredesc where vcmenuname = 'Admin')::integer, '10'::integer, '16'::integer, '5'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) from ui.rolemenuaccessmap )+1::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, (select imenuid from ui.menustructuredesc where vcmenuname = 'Admin')::integer, '10'::integer, '17'::integer, '5'::integer)
 returning irolemenumapid,itenantid;


INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) from ui.rolemenuaccessmap )+1::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, (select imenuid from ui.menustructuredesc where vcmenuname = 'Admin')::integer, '10'::integer, '21'::integer, '5'::integer)
 returning irolemenumapid,itenantid;


INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) from ui.rolemenuaccessmap )+1::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, (select imenuid from ui.menustructuredesc where vcmenuname = 'Admin')::integer, '10'::integer, '22'::integer, '5'::integer)
 returning irolemenumapid,itenantid;


INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) from ui.rolemenuaccessmap )+1::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, (select imenuid from ui.menustructuredesc where vcmenuname = 'Admin')::integer, '10'::integer, '23'::integer, '5'::integer)
 returning irolemenumapid,itenantid;
