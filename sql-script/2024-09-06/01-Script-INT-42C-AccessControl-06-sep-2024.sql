INSERT INTO ui.roledesc (iroleid, dtapproverstamp, dtentrystamp, vcrolename, iapproveruserid, ientryuserid, istatus, imenustructuredesc, itenantid, iorgid) SELECT 2, NULL, '2022-12-21 21:52:14.445', 'MIS', NULL, NULL, 1, NULL, itenantid, iorgid FROM ui.tenants t where t.itenantid in (6, 7);


INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap)::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where vcaction ='Case')::integer , '2'::integer, '6'::integer, '4'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap)::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where vcaction ='Case')::integer , '2'::integer, '7'::integer, '4'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap)::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where vcaction ='Case')::integer , '2'::integer, '20'::integer, '4'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap):: integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where vcaction ='Reports'):: integer, '2'::integer, '6'::integer, '4'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where vcaction ='Reports')::integer, '2'::integer, '7'::integer, '4'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Reports')::integer, '2'::integer, '20'::integer, '4'::integer)
 returning irolemenumapid,itenantid;


---

INSERT INTO ui.rolemenuaccessmap ( badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid,itenantid, iorgid) SELECT true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 478, 2, itenantid, iorgid FROM ui.tenants where itenantid != 0 and itenantid in (6, 7);
INSERT INTO ui.rolemenuaccessmap ( badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid,itenantid, iorgid) SELECT true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 508, 2, itenantid, iorgid FROM ui.tenants where itenantid != 0 and itenantid in (6, 7);
INSERT INTO ui.rolemenuaccessmap ( badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid,itenantid, iorgid) SELECT true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 507, 2, itenantid, iorgid FROM ui.tenants where itenantid != 0 and itenantid in (6, 7);
INSERT INTO ui.rolemenuaccessmap ( badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid,itenantid, iorgid) SELECT true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 509, 2, itenantid, iorgid FROM ui.tenants where itenantid != 0 and itenantid in (6, 7);
INSERT INTO ui.rolemenuaccessmap ( badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid,itenantid, iorgid) SELECT true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 510, 2, itenantid, iorgid FROM ui.tenants where itenantid != 0 and itenantid in (6, 7);
INSERT INTO ui.rolemenuaccessmap ( badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid,itenantid, iorgid) SELECT true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 514, 2, itenantid, iorgid FROM ui.tenants where itenantid != 0 and itenantid in (6, 7);