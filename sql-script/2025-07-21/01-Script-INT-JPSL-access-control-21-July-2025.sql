

delete from ui.rolemenuaccessmap where imenuid =579 and itenantid = 14;

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
    1 AS iroleid,
    t.itenantid,
    t.iorgid
FROM
    ui.tenants t
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
    579 AS imenuid,
    13 AS iroleid,
    t.itenantid,
    t.iorgid
FROM
    ui.tenants t
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
    579 AS imenuid,
    14 AS iroleid,
    t.itenantid,
    t.iorgid
FROM
    ui.tenants t
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
    579 AS imenuid,
    16 AS iroleid,
    t.itenantid,
    t.iorgid
FROM
    ui.tenants t
WHERE
    t.itenantid  in (14);