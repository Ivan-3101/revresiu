INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
(select max(irolemenumapid)+1 from ui.rolemenuaccessmap)::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '575'::integer, '10'::integer, '8'::integer, '5'::integer)
 returning irolemenumapid,itenantid;


INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
(select max(irolemenumapid)+1 from ui.rolemenuaccessmap)::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '575'::integer, '10'::integer, '16'::integer, '5'::integer)
 returning irolemenumapid,itenantid;


INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
(select max(irolemenumapid)+1 from ui.rolemenuaccessmap)::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '575'::integer, '10'::integer, '17'::integer, '5'::integer)
 returning irolemenumapid,itenantid;
