---risk analyst graph
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
    t.itenantid  in (12);

---revoke access to auto allo, process bulk ticket to risk ana
delete from ui.rolemenuaccessmap where itenantid = 12  and iroleid=1 and imenuid in (503)

---approve access to masters
UPDATE ui.rolemenuaccessmap SET
bapprove = true::boolean WHERE
 iroleid=2 and imenuid = 481 AND itenantid = 12;



------------------mis
--graph an
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
    4 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (12);


-----audit(to be conf)

--view metadata/custom agg


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
    false AS bpublish, 
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
    t.itenantid  in (12);


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
    false AS bpublish, 
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
    t.itenantid  in (12);

---risk analyst , admin

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
    482 AS imenuid, 
    2 AS iroleid, 
    t.itenantid, 
    t.iorgid
FROM 
    ui.tenants t 
WHERE 
    t.itenantid  in (12);