
--------------42c

---risk analyst
--try out menu access
INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    480 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);

--remove access to user mgmt
delete from ui.rolemenuaccessmap where itenantid in (7,6,20,24) and iroleid=5 and imenuid = 501;

--add decision, approve decision , approve edit/delete decision
INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    583 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);

INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    584 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);

INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    597 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);

INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    598 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);


-- approve edit obs
INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    600 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);

--edit, del,view , approve metadata/custom agg

INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    585 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);


INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    586 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);


INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    587 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);


INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    588 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);


INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    593 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);


INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    594 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);


INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    595 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);


INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    596 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);




---mis

--graph ana
INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    579 AS imenuid, 
    2 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);

--case mgmt , reports

INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    479 AS imenuid, 
    2 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (24);

INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    536 AS imenuid, 
    2 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (24);

------------risk analyst
-- approve decision, approve edit decision, approve delete decision
INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    584 AS imenuid, 
    10 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);

INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    597 AS imenuid, 
    10 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);

INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    598 AS imenuid, 
    10 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);

---approve edit obs
INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    600 AS imenuid, 
    10 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);

--approve customm aggre, approve metadata
INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    587 AS imenuid, 
    10 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);

INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    596 AS imenuid, 
    10 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (7,6,20,24);

-----Admin for 20,24

INSERT INTO ui.roledesc (
iroleid, dtentrystamp, vcrolename, istatus, itenantid, iorgid) VALUES (
'1'::integer, '2025-04-25 15:21:04.786463+05:30'::timestamp with time zone, 'Admin'::character varying, '1'::integer, '20'::integer, '4'::integer)
 returning iroleid,itenantid;
INSERT INTO ui.roledesc (
iroleid, dtentrystamp, vcrolename, istatus, itenantid, iorgid) VALUES (
'1'::integer, '2025-04-25 15:21:04.786463+05:30'::timestamp with time zone, 'Admin'::character varying, '1'::integer, '24'::integer, '4'::integer)
 returning iroleid,itenantid;

 
delete from ui.rolemenuaccessmap where itenantid in (6, 7, 20, 24) and iroleid=1;
--admin

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 478, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 479, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 480, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 481, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 482, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 507, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 508, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 509, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 510, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 579, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 503, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 505, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 494, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 578, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 572, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 536, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 573, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 574, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 575, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 501, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 577, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 576, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 513, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 514, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 518, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 519, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 520, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 589, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 590, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 591, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 592, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 521, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 528, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 522, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 499, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 547, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 554, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 561, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 511, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 515, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 524, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 525, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 526, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 527, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 563, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 564, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 565, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 566, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 567, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 569, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 570, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 571, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 568, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 531, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 532, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 533, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 537, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 538, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 539, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 534, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 535, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 540, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 541, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 583, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 584, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 597, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 598, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 529, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 530, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 548, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 549, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 550, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 551, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 552, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 553, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 555, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 556, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 557, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 558, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 559, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 560, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 600, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 585, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 586, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 587, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 588, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 593, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 594, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 595, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid) SELECT (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap), true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 596, 1, itenantid, iorgid FROM ui.tenants where itenantid in (7,6,20,24);
