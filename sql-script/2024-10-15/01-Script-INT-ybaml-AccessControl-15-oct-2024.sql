INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Admin')::integer, '5'::integer, '17'::integer, '5'::integer)
 returning irolemenumapid,itenantid;
INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Admin')::integer, '5'::integer, '21'::integer, '5'::integer)
 returning irolemenumapid,itenantid;
INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Admin')::integer, '5'::integer, '23'::integer, '5'::integer)
 returning irolemenumapid,itenantid;
INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Admin')::integer, '5'::integer, '8'::integer, '5'::integer)
 returning irolemenumapid,itenantid;
INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Admin')::integer, '5'::integer, '16'::integer, '5'::integer)
 returning irolemenumapid,itenantid;
INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Admin')::integer, '5'::integer, '22'::integer, '5'::integer)
 returning irolemenumapid,itenantid;

--removing access of admin reports to risk analyst
delete from ui.rolemenuaccessmap where iroleid=5 and imenuid= (select imenuid from ui.menustructuredesc where  vcaction ='AdminReports') and itenantid in (17, 21, 23,8,16,22)
