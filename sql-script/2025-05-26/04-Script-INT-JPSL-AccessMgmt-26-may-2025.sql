-- Access to Admin Modules, user mgmt,email sch for Risk Supervisor (Role ID 14)
INSERT INTO ui.rolemenuaccessmap (
    irolemenumapid,
    badd,
    bapprove,
    bdelete,
    bedit,
    bpublish,
    bview,
    dtapproverstamp,
    dtentrystamp,
    istatus,
    iapproveruserid,
    ientryuserid,
    imenuid,
    iroleid,
    itenantid,
    iorgid
)
SELECT 
    COALESCE((SELECT MAX(irolemenumapid) FROM ui.rolemenuaccessmap), 0) + ROW_NUMBER() OVER () AS irolemenumapid,
    TRUE AS badd,
    false AS bapprove,
    TRUE AS bdelete,
    TRUE AS bedit,
    TRUE AS bpublish,
    TRUE AS bview,
    NULL AS dtapproverstamp,
    null AS dtentrystamp,
    TRUE AS istatus,
    NULL AS iapproveruserid,
    null AS ientryuserid, 
    imenuid,
    14 AS iroleid,
    14 AS itenantid,
    10 AS iorgid
FROM (
    VALUES (501), (576), (577)
) AS menus(imenuid);

---access to submenus

delete from ui.rolemenuaccessmap where itenantid= 14 and iroleid=14 and imenuid in (513,514,518,519,520);

-- Grant Full Access to Admin Modules for Risk Supervisor (Role ID 14)
INSERT INTO ui.rolemenuaccessmap (
    irolemenumapid,
    badd,
    bapprove,
    bdelete,
    bedit,
    bpublish,
    bview,
    dtapproverstamp,
    dtentrystamp,
    istatus,
    iapproveruserid,
    ientryuserid,
    imenuid,
    iroleid,
    itenantid,
    iorgid
)
SELECT 
    COALESCE((SELECT MAX(irolemenumapid) FROM ui.rolemenuaccessmap), 0) + ROW_NUMBER() OVER () AS irolemenumapid,
    TRUE AS badd,
    TRUE AS bapprove,
    TRUE AS bdelete,
    TRUE AS bedit,
    TRUE AS bpublish,
    TRUE AS bview,
    NULL AS dtapproverstamp,
    null AS dtentrystamp,
    TRUE AS istatus,
    NULL AS iapproveruserid,
    null AS ientryuserid, 
    imenuid,
    14 AS iroleid,
    14 AS itenantid,
    10 AS iorgid
FROM (
    VALUES (513), (514), (518)
) AS menus(imenuid);


--------------------
delete from ui.rolemenuaccessmap where itenantid= 14 and iroleid=15;

-- Grant Full Access to File Upload (Menu ID 581) for Operational Analyst (Role ID 15)
INSERT INTO ui.rolemenuaccessmap (
    irolemenumapid,
    badd,
    bapprove,
    bdelete,
    bedit,
    bpublish,
    bview,
    dtapproverstamp,
    dtentrystamp,
    istatus,
    iapproveruserid,
    ientryuserid,
    imenuid,
    iroleid,
    itenantid,
    iorgid
)
SELECT 
    COALESCE((SELECT MAX(irolemenumapid) FROM ui.rolemenuaccessmap), 0) + ROW_NUMBER() OVER () AS irolemenumapid,
    TRUE AS badd,
    TRUE AS bapprove,
    TRUE AS bdelete,
    TRUE AS bedit,
    TRUE AS bpublish,
    TRUE AS bview,
    NULL AS dtapproverstamp,
    null AS dtentrystamp,
    TRUE AS istatus,
    NULL AS iapproveruserid,
    null AS ientryuserid, 
    581 AS imenuid,
    15 AS iroleid,
    14 AS itenantid, 
    10 AS iorgid;

INSERT INTO ui.rolemenuaccessmap (
    irolemenumapid,
    badd,
    bapprove,
    bdelete,
    bedit,
    bpublish,
    bview,
    dtapproverstamp,
    dtentrystamp,
    istatus,
    iapproveruserid,
    ientryuserid,
    imenuid,
    iroleid,
    itenantid,
    iorgid
)
SELECT 
    COALESCE((SELECT MAX(irolemenumapid) FROM ui.rolemenuaccessmap), 0) + ROW_NUMBER() OVER () AS irolemenumapid,
    TRUE AS badd,
    TRUE AS bapprove,
    TRUE AS bdelete,
    TRUE AS bedit,
    TRUE AS bpublish,
    TRUE AS bview,
    NULL AS dtapproverstamp,
    null AS dtentrystamp,
    TRUE AS istatus,
    NULL AS iapproveruserid,
    null AS ientryuserid, 
    514 AS imenuid,
    15 AS iroleid,
    14 AS itenantid, 
    10 AS iorgid;

INSERT INTO ui.rolemenuaccessmap (
    irolemenumapid,
    badd,
    bapprove,
    bdelete,
    bedit,
    bpublish,
    bview,
    dtapproverstamp,
    dtentrystamp,
    istatus,
    iapproveruserid,
    ientryuserid,
    imenuid,
    iroleid,
    itenantid,
    iorgid
)
SELECT 
    COALESCE((SELECT MAX(irolemenumapid) FROM ui.rolemenuaccessmap), 0) + ROW_NUMBER() OVER () AS irolemenumapid,
    TRUE AS badd,
    TRUE AS bapprove,
    TRUE AS bdelete,
    TRUE AS bedit,
    TRUE AS bpublish,
    TRUE AS bview,
    NULL AS dtapproverstamp,
    null AS dtentrystamp,
    TRUE AS istatus,
    NULL AS iapproveruserid,
    null AS ientryuserid, 
    482 AS imenuid,
    15 AS iroleid,
    14 AS itenantid, 
    10 AS iorgid;

INSERT INTO ui.rolemenuaccessmap (
    irolemenumapid,
    badd,
    bapprove,
    bdelete,
    bedit,
    bpublish,
    bview,
    dtapproverstamp,
    dtentrystamp,
    istatus,
    iapproveruserid,
    ientryuserid,
    imenuid,
    iroleid,
    itenantid,
    iorgid
)
SELECT 
    COALESCE((SELECT MAX(irolemenumapid) FROM ui.rolemenuaccessmap), 0) + ROW_NUMBER() OVER () AS irolemenumapid,
    false AS badd,
    false AS bapprove,
    false AS bdelete,
    false AS bedit,
    false AS bpublish,
    TRUE AS bview,
    NULL AS dtapproverstamp,
    null AS dtentrystamp,
    TRUE AS istatus,
    NULL AS iapproveruserid,
    null AS ientryuserid, 
    481 AS imenuid,
    15 AS iroleid,
    14 AS itenantid, 
    10 AS iorgid;

INSERT INTO ui.rolemenuaccessmap (
    irolemenumapid,
    badd,
    bapprove,
    bdelete,
    bedit,
    bpublish,
    bview,
    dtapproverstamp,
    dtentrystamp,
    istatus,
    iapproveruserid,
    ientryuserid,
    imenuid,
    iroleid,
    itenantid,
    iorgid
)
SELECT 
    COALESCE((SELECT MAX(irolemenumapid) FROM ui.rolemenuaccessmap), 0) + ROW_NUMBER() OVER () AS irolemenumapid,
    false AS badd,
    false AS bapprove,
    false AS bdelete,
    false AS bedit,
    false AS bpublish,
    TRUE AS bview,
    NULL AS dtapproverstamp,
    null AS dtentrystamp,
    TRUE AS istatus,
    NULL AS iapproveruserid,
    null AS ientryuserid, 
    499 AS imenuid,
    15 AS iroleid,
    14 AS itenantid, 
    10 AS iorgid;
-----------UAM role

delete from ui.rolemenuaccessmap where itenantid= 14 and iroleid=16 and imenuid in (519, 520, 525, 526, 527, 529, 530, 538, 539, 540, 533, 535,551,552,558,559, 566,567,568,587,588,584,597,598,600,594,596);

INSERT INTO ui.rolemenuaccessmap (
    irolemenumapid,
    badd,
    bapprove,
    bdelete,
    bedit,
    bpublish,
    bview,
    dtentrystamp,
    istatus,
    imenuid,
    iroleid,
    itenantid,
    iorgid
)
SELECT 
    COALESCE((SELECT MAX(irolemenumapid) FROM ui.rolemenuaccessmap), 0) + ROW_NUMBER() OVER () AS irolemenumapid,
    true AS badd,
    TRUE AS bapprove,
    true AS bdelete,
    true AS bedit,
    true AS bpublish,
    true AS bview,
    null AS dtentrystamp,
    TRUE AS istatus,
    imenuid,
    16 AS iroleid,
    14 AS itenantid, 
    10 AS iorgid
FROM (
    VALUES
    (519), (520), (525), (526), (527), (529), (530), (533), (535),
    (538), (539), (540), (551), (552), (558), (559), (566),
    (567), (568), (584), (587), (588), (596), (597), (598), (600), (594),(596)
) AS menus(imenuid);


update ui.rolemenuaccessmap  set bedit = false where itenantid= 14 and iroleid=16 and imenuid in  (
499,
501,
521,
522,
528,
547,
554,
561,
576
);


-------jpsl 

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
    t.itenantid  in (14);

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