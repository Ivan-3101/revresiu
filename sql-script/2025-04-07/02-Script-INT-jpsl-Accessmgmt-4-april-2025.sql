	
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
    t.itenantid  in (14);

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
    t.itenantid  in (14);

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
    t.itenantid  in (14);

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
    t.itenantid  in (14);

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
    t.itenantid  in (14);

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
    t.itenantid  in (14);

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
    t.itenantid  in (14);

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
    t.itenantid  in (14);

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
    t.itenantid  in (14);

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
    t.itenantid  in (14);

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
    t.itenantid  in (14);

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
    t.itenantid  in (14);

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
    t.itenantid  in (14);

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
    t.itenantid  in (14);


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
    t.itenantid  in (14);

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
    t.itenantid  in (14);

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
    t.itenantid  in (14);

----

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
    13 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (14);

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
    13 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (14);


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
    13 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (14);


--------
	
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
    14 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (14);

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
    14 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (14);

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
    14 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (14);

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
    14 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (14);

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
    14 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (14);

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
    14 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (14);

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
    14 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (14);

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
    14 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (14);

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
    14 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (14);


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
    14 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (14);

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
    14 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (14);

---------



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
    16 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (14);


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
    16 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (14);

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
    16 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (14);


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
    16 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (14);

