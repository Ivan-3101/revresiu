--------------pinelabs

---risk admin
--auto allocation user mapping
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
    572 AS imenuid, 
    10 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);

---try out , run /ana sim , rule builder
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
    10 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);

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
    573 AS imenuid, 
    10 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);

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
    574 AS imenuid, 
    10 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);

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
    575 AS imenuid, 
    10 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);

---------mis 
--graph analyzer
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
    t.itenantid  in (27);

---case mgmt, tasks , reports
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
    t.itenantid  in (27);

INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    false AS badd, 
    false AS bapprove, 
    false AS bdelete, 
    false AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    494 AS imenuid, 
    2 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);

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
    t.itenantid  in (27);

---risk ana
--auto allocation user mapping, process bulk ticket
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
    572 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);

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
    503 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);

---try out , run /ana sim , rule builder
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
    t.itenantid  in (27);

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
    573 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);

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
    574 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);

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
    575 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);

----admin repo, email sch, file up
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
    577 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);

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
    576 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);

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
    581 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);

---add,view,edit,del email sc

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
    589 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);
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
    590 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);
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
    591 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);
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
    592 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);

---add,edit, approve add,edit user
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
    513 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);

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
    518 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);

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
    519 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);

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
    520 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (27);





    ----------------------------------


    ----pinelabs	
--add decision
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
    1 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--add custom aggregation
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
    1 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--delete custom aggregation
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
    1 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--approve custom aggregation
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
    1 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--view custom aggregation
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
    1 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--add email schedular
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
    589 AS imenuid, 
    1 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--view email schedular
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
    590 AS imenuid, 
    1 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--edit email schedular
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
    591 AS imenuid, 
    1 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--delete email schedular
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
    592 AS imenuid, 
    1 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--approve add decision
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
    1 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--approve edit decision
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
    1 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--approve delete decision
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
    1 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--approve edit observation
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
    1 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--metadata /add
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
    1 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);


---metadats/view
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
    1 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--metadata/delete
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
    1 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--metadata approve
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
    1 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

----
--add decision
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
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--add custom aggregation
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
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--delete custom aggregation
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
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--approve custom aggregation
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
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--view custom aggregation
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
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--add email schedular
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
    589 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--view email schedular
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
    590 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--edit email schedular
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
    591 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--delete email schedular
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
    592 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--approve add decision
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
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--approve edit decision
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
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--approve delete decision
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
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--approve edit observation
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
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--metadata /add
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
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);


---metadats/view
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
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--metadata/delete
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
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--metadata approve
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
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

----
	
--add decision
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
    10 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--add custom aggregation
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
    10 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--delete custom aggregation
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
    10 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--approve custom aggregation
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
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--view custom aggregation
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
    10 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--add email schedular
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
    589 AS imenuid, 
    10 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--view email schedular
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
    590 AS imenuid, 
    10 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--edit email schedular
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
    591 AS imenuid, 
    10 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--delete email schedular
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
    592 AS imenuid, 
    10 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--approve add decision
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
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--approve edit decision
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
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--approve delete decision
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
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--approve edit observation
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
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--metadata /add
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
    10 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);


---metadats/view
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
    10 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--metadata/delete
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
    10 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

--metadata approve
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
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);


--------------------setu

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
    602 AS imenuid, 
    1 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);


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
    602 AS imenuid, 
    10 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

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
    602 AS imenuid, 
    2 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);

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
    602 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (27);